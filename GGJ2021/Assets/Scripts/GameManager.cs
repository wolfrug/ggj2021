using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.SceneManagement;

[System.Serializable]
public class GameStateEvent : UnityEvent<GameState> { }

public enum GameStates {
    NONE = 0000,
    INIT = 1000,
    LATE_INIT = 1100,
    GAME = 2000,
    NARRATIVE = 3000,
    INVENTORY = 4000,
    DEFEAT = 5000,
    WIN = 6000,
    PAUSE = 7000,

}

[System.Serializable]
public class GameState {
    public GameStates state;
    public GameStateEvent evtStart;
    public GameStates nextState;
}

public class GameManager : MonoBehaviour {
    public static GameManager instance;
    public GameState[] gameStates;
    [SerializeField]
    private GameState currentState;

    public float lateInitWait = 0.1f;
    private Dictionary<GameStates, GameState> gameStateDict = new Dictionary<GameStates, GameState> { };
    // Start is called before the first frame update
    private BasicAgent player;
    public GenericClickToMove mover;
    public InventoryController playerInventory;

    public Transform respawnLocation;

    private List<WanderingSpirit> allSpirits = new List<WanderingSpirit> { };

    void Awake () {
        if (instance == null) {
            instance = this;
        } else {
            Destroy (gameObject);
        }
        foreach (GameState states in gameStates) {
            gameStateDict.Add (states.state, states);
        }
    }
    void Start () {
        currentState = gameStateDict[GameStates.INIT];
        gameStateDict[currentState.state].evtStart.Invoke (currentState);
    }
    public void Init () {
        NextState ();
    }

    public List<WanderingSpirit> Spirits {
        get {
            if (allSpirits.Count == 0) {
                allSpirits.AddRange (FindObjectsOfType<WanderingSpirit> ());
            }
            return allSpirits;
        }
    }

    void Late_Init () {
        if (currentState.state == GameStates.LATE_INIT) {
            Debug.Log ("Late initialization");
            currentState.evtStart.Invoke (currentState);
        };
    }
    public void NextState () {
        if (currentState.nextState != GameStates.NONE) {
            currentState = gameStateDict[currentState.nextState];
            if (currentState.state == GameStates.LATE_INIT) { // late init inits a bit late and only works thru nextstate
                Invoke ("Late_Init", lateInitWait);
                return;
            }
            gameStateDict[currentState.state].evtStart.Invoke (currentState);
            Debug.Log ("Changed states to " + currentState.state);
        }
    }
    public void SetState (GameStates state) {
        GameState = state;
    }
    public GameStates GameState {
        get {
            if (currentState != null) {
                return currentState.state;
            } else {
                return GameStates.NONE;
            }
        }
        set {
            currentState = gameStateDict[value];
            currentState.evtStart.Invoke (currentState);
        }
    }

    void WinGame () {
        GameState = GameStates.WIN;
        Debug.Log ("Victory!!");
        //SceneManager.LoadScene("WinScene");
    }
    public void Defeat () {

        currentState = gameStateDict[GameStates.DEFEAT];
        currentState.evtStart.Invoke (currentState);
    }

    public void Respawn () {
        player.navMeshAgent.Warp (respawnLocation.position);
        foreach (WanderingSpirit spirit in Spirits) {
            if (spirit.randomWanderCenter != null) {
                spirit.transform.position = spirit.randomWanderCenter.position;
            } else { // place them in zero I dunno man
                spirit.transform.position = Vector3.zero;
            }
            spirit.SetFollowTarget (null);
        }
        SurvivalManager.instance.ResetMeters ();
        SetState (GameStates.GAME);
    }

    public void Restart () {
        Time.timeScale = 1f;
        SceneManager.LoadScene (SceneManager.GetActiveScene ().name, LoadSceneMode.Single);
    }

    public void DualLoadScenes () {
        SceneManager.LoadScene ("ManagersScene", LoadSceneMode.Additive);
        SceneManager.LoadScene ("SA_Demo", LoadSceneMode.Additive);
    }

    public void BackToMenu () {
        Time.timeScale = 1f;
        SceneManager.LoadScene ("MainMenu");
    }

    public void SaveGame (int slot) {
        Debug.Log ("Saving in slot " + slot);
        ES3AutoSaveMgr.Current.settings.path = "GGJ2021_RatPack_" + slot.ToString () + ".es3";
        ES3AutoSaveMgr.Current.Save ();
    }
    public void LoadGame (int slot) {
        Debug.Log ("Loading from slot " + slot);
        ES3AutoSaveMgr.Current.settings.path = "GGJ2021_RatPack_" + slot.ToString () + ".es3";
        ES3AutoSaveMgr.Current.Load ();
    }
    public void Pause () {
        GameState oldState = currentState;
        GameState pauseState = gameStateDict[GameStates.PAUSE];
        GameState = GameStates.PAUSE;
        pauseState.evtStart.Invoke (gameStateDict[GameStates.PAUSE]);
        StartCoroutine (PauseWaiter (oldState.state));
        Time.timeScale = 0f;
    }
    public void UnPause () {
        GameState = GameStates.NONE;
        Time.timeScale = 1f;
    }
    IEnumerator PauseWaiter (GameStates continueState) {
        yield return new WaitUntil (() => GameState != GameStates.PAUSE);
        GameState = continueState;
    }

    public void InitInventoryEvents () {
        Debug.Log ("Attempting to init inventory events");
        playerInventory = InventoryController.GetInventoryOfType (InventoryType.PLAYER, null, false);
        foreach (InventoryController lootableInventory in InventoryController.GetAllInventories (InventoryType.NONE, null, false)) {
            Debug.Log ("Adding events to " + InventoryController.GetAllInventories ().Count + " inventories");
            lootableInventory.inventoryOpenedEvent.AddListener (OpenInventory);
            lootableInventory.inventoryClosedEvent.AddListener (CloseInventory);
        }
        // Also init looking for player lol

    }
    void OpenInventory (InventoryController otherInventory) {
        SetState (GameStates.INVENTORY);
        Debug.Log ("Inventory opened " + otherInventory.gameObject);
        if (otherInventory.type == InventoryType.LOOTABLE || otherInventory.type == InventoryType.CRAFTING) { // auto-open player inventory when opening lootable container
            playerInventory.Visible = true;
        }
    }
    void CloseInventory (InventoryController otherInventory) {
        SetState (gameStateDict[GameStates.INVENTORY].nextState);
        //  Debug.Log ("Inventory closed " + otherInventory.gameObject);
        if (otherInventory.type == InventoryType.LOOTABLE) {
            playerInventory.Visible = false;
        }
        if (otherInventory.type == InventoryType.PLAYER) {
            InventoryController.CloseAllInventories (InventoryType.LOOTABLE);
            InventoryController.CloseAllInventories (InventoryType.CRAFTING);
        }
    }

    public void OpenJournal () {
        if (!InkWriter.main.writerVisible) {
            InkWriter.main.GoToKnot ("OpenJournalExt");
        }
    }

    public void StopPlayerMovement (bool stop) { // completly halt player movement
        if (player != null) {
            player.navMeshAgent.isStopped = stop;
        }
        mover.Activate (!stop);
    }
    public void StopPlayerClickToMove (bool stop) { // halt only the ability to give new move commands
        mover.Activate (!stop);
    }

    public void Ink_CheckHasItem (object[] inputVariables) {
        // variable 0 -> m_id of item looked for
        // variable 1 -> ink variable name to set value to (-1 does not have, 0+ has with count)

        string inkVariableName = (string) inputVariables[1];
        string m_id = (string) inputVariables[0];
        ItemData data = InventoryController.GetDataByID (m_id);
        if (data == null) {
            Debug.LogWarning ("No such item with ID" + m_id);
            InkWriter.main.story.variablesState[(inkVariableName)] = -1;
            return;
        }
        int returnVariable = playerInventory.CountItem (data);
        InkWriter.main.story.variablesState[(inkVariableName)] = returnVariable;
    }
    public void Ink_ConsumeItem (object[] inputVariables) {
        //variable 0 -> m_id of item looked for
        //variable 1 -> integer of number of items to consume
        // note -> it's up to the inkist to check that there is enough before committing, there is no confirmation!
        int amount = (int) inputVariables[1];
        string m_id = (string) inputVariables[0];
        ItemData data = InventoryController.GetDataByID (m_id);
        if (data == null) {
            Debug.LogWarning ("No such item with ID" + m_id);
            return;
        }
        int returnVariable = playerInventory.CountItem (data);
        if (!playerInventory.DestroyItemAmount (data, amount)) {
            Debug.LogWarning ("Failed to destroy the required amount of item " + m_id + "(" + m_id + ")");
        }
    }

    public BasicAgent Player {
        get {
            if (player == null) {
                player = GameObject.FindGameObjectWithTag ("Player").GetComponent<BasicAgent> ();
                mover.targetAgent = player.navMeshAgent;
            };
            return player;
        }
    }

}