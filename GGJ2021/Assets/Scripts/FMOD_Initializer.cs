using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FMOD_Initializer : MonoBehaviour {
    // Start is called before the first frame update
    IEnumerator Start () {
        yield return new WaitForSeconds (1f);
        yield return new WaitUntil (() => FMODUnity.RuntimeManager.HasBankLoaded ("Master"));
        Debug.Log ("Master Bank Loaded");
        UnityEngine.SceneManagement.SceneManager.LoadScene ("MainMenu", UnityEngine.SceneManagement.LoadSceneMode.Single);
    }
}