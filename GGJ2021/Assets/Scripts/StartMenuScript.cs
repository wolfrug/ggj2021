using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class StartMenuScript : MonoBehaviour {
    // Start is called before the first frame update[NaughtyAttributes.Button]

    public GameObject resetButton;
    public string sceneToLoadOnStart = "Main2DScene";

    void Start () {
        if (ES3.KeyExists ("GGJ2021_HasSaved") && resetButton != null) {
            resetButton.SetActive (true);
        } else if (resetButton != null) {
            resetButton.SetActive (false);
        }
    }

    public void ToMainMenu () {
        SceneManager.LoadScene ("MainMenu");
    }
    public void StartGame () {
        StartCoroutine (UnloadSelf ());
    }
    IEnumerator UnloadSelf () {
        yield return new WaitForSeconds (0.9f);
        AsyncOperation load2 = SceneManager.LoadSceneAsync ("ManagersScene", LoadSceneMode.Additive);
        yield return load2;
        AsyncOperation load = SceneManager.LoadSceneAsync (sceneToLoadOnStart, LoadSceneMode.Additive); // load heavy scene first
        yield return load;
        // Game manager init
        yield return new WaitForSeconds (0.5f);
        GameManager.instance.Init ();
        // unload self
        SceneManager.UnloadSceneAsync ("MainMenu");
    }
    public void ResetAll () {
        ES3.DeleteKey ("GGJ2021_HasSaved");
        StartCoroutine (UnloadSelf ());
    }
    public void Quit () {
        Application.Quit ();
    }
}