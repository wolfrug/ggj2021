﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GenericHealthBar : MonoBehaviour {
    public Image healthBar;
    public float healthPercentage = 1f;
    public Vector2 minMaxHealth = new Vector2 (0f, 1f);
    public float currentHealth = 1f;
    // Start is called before the first frame update
    void Start () {

    }

    // Update is called once per frame
    void Update () {
        if (currentHealth > minMaxHealth.x && currentHealth > 0f) {
            healthPercentage = Mathf.Lerp (0f, 1f, currentHealth / minMaxHealth.y);
        } else {
            healthPercentage = 0f;
        }
        healthBar.fillAmount = healthPercentage;
    }
}