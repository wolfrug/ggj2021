using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UIShaderAnimator : MonoBehaviour {
    public float easeFloat = 0f;
    public string floatName = "_FadeAmount";
    public string keyWord = "FADE_ON";
    public Vector2 fromToFloat = new Vector2 (0f, 1f);
    public bool disableKeywordWhenFinished = false;

    [Tooltip ("If there is anyone in this group, all effects are applied to all of them.")]
    public UIShaderAnimator[] shaderAnimatorGroup;
    private Material shaderMat;
    // Start is called before the first frame update
    void Start () {
        shaderMat = GetComponent<Image> ().material;
    }

    public void GenericEffect (float time = 2f) {
        easeFloat = 0f;
        if (disableKeywordWhenFinished) {
            EnableKeyWord (true);
            //LeanTween.value (gameObject, UpdateGeneric, fromToFloat.x, fromToFloat.y, time).setEase (LeanTweenType.easeInOutQuad).setOnComplete (() => EnableKeyWord (false));
        } else {
            //LeanTween.value (gameObject, UpdateGeneric, fromToFloat.x, fromToFloat.y, time).setEase (LeanTweenType.easeInOutQuad);
        };
        foreach (UIShaderAnimator animator in shaderAnimatorGroup) {
            animator.GenericEffect (time);
        }
    }
    void UpdateGeneric (float value, float ratio) {
        easeFloat = value;
        shaderMat.SetFloat (floatName, value);
    }

    void EnableKeyWord (bool enable = true) {
        if (enable) {
            shaderMat.EnableKeyword (keyWord);
        } else {
            shaderMat.DisableKeyword (keyWord);
        }
    }
    public void PixelizeIn (float time = 2f) {
        easeFloat = 0f;
        //LeanTween.value (gameObject, UpdatePixelize, 0f, 512f, time).setEase (LeanTweenType.easeInOutQuad);
        foreach (UIShaderAnimator animator in shaderAnimatorGroup) {
            animator.PixelizeIn (time);
        }
    }
    public void PixelizeOut (float time = 2f) {
        easeFloat = 0f;
        //LeanTween.value (gameObject, UpdatePixelize, 512f, 0f, time).setEase (LeanTweenType.easeInOutQuad);
        foreach (UIShaderAnimator animator in shaderAnimatorGroup) {
            animator.PixelizeOut (time);
        }
    }
    public void FadeIn (float time = 2f) {
        easeFloat = 0f;
        float startValue = shaderMat.GetFloat ("_FadeAmount");
        //LeanTween.value (gameObject, UpdateFade, startValue, 0f, time).setEase (LeanTweenType.easeInOutQuad);
        foreach (UIShaderAnimator animator in shaderAnimatorGroup) {
            animator.FadeIn (time);
        }
    }
    public void FadeOut (float time = 2f) {
        easeFloat = 0f;
        float startValue = shaderMat.GetFloat ("_FadeAmount");
        //LeanTween.value (gameObject, UpdateFade, startValue, 1f, time).setEase (LeanTweenType.easeInOutQuad);
        foreach (UIShaderAnimator animator in shaderAnimatorGroup) {
            animator.FadeOut (time);
        }
    }
    void UpdatePixelize (float value, float ratio) {
        easeFloat = value;
        shaderMat.SetFloat ("_PixelateSize", value);
    }
    void UpdateFade (float value, float ratio) {
        easeFloat = value;
        shaderMat.SetFloat ("_FadeAmount", value);
    }

    // Update is called once per frame
    void Update () {

    }
}