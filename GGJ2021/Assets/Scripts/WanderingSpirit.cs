using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum SpiritType {
    NONE = 0000,
    HOSTILE = 1000,
}
public class WanderingSpirit : MonoBehaviour {
    public BasicAgent targetAgent;
    public SpiritType type;
    public DamageType damageType = DamageType.NONE;
    public float damageAmount = -0.01f;
    public float damageTime = 5f;

    [Tooltip ("Only relevant for non-aura damage types")]
    public float damageInterval = 5f;
    private float lastDamageTime = 0f;
    public Transform currentFollowTarget;
    public float followDistance = 20f;
    public bool randomWander = true;
    public float randomWanderDistance = 5f;
    public Transform randomWanderCenter;
    public Vector2 randomWanderWaitTime = new Vector2 (0f, 5f);
    public float damagePerSecond;
    public bool followPlayer = true;
    private float randomWanderWaitTimeLeft = 0f;
    //private BasicAgent player;

    // Start is called before the first frame update
    void Start () {
        if (followPlayer) {
            SetFollowTarget (GameManager.instance.Player.transform);
        }
    }

    public void SetFollowTarget (Transform target) {
        currentFollowTarget = target;
    }
    public void SetWanderCenter (Transform center) {
        randomWanderCenter = center;
    }

    public void StartAuraDamage () {
        string selfName = type.ToString () + gameObject.name; // if you name a number of critters the same thing, the aura won't stack!
        if (!SurvivalManager.instance.HasPermanentEffect (selfName)) {
            SurvivalManager.instance.StartPermanentEffect (damageType, damageAmount, damageTime, selfName);
        };
    }
    public void StopAuraDamage () {
        string selfName = type.ToString () + gameObject.name;
        SurvivalManager.instance.StopPermanentEffect (selfName);
    }

    public void DoSingleDamage () {
        if (lastDamageTime < damageInterval + Time.time) {
            SurvivalManager.instance.SpawnHealthEffect (damageType, damageAmount, damageTime);
            lastDamageTime = Time.time;
        }
    }

    public void SetForgetPlayer (float time) { // forgets the player (or any follow target) for x seconds
        SetFollowTarget (null);
        if (followPlayer) {
            CancelInvoke ("FollowPlayer");
            Invoke ("FollowPlayer", time);
        }
    }
    void FollowPlayer () {
        SetFollowTarget (GameManager.instance.Player.transform);
    }

    // Update is called once per frame
    void Update () {
        if (randomWander && (currentFollowTarget == null || Vector3.Distance (currentFollowTarget.position, transform.position) > followDistance)) {
            if (randomWanderWaitTimeLeft <= 0f) {
                if (randomWanderCenter == null) {
                    randomWanderCenter = transform;
                }
                Vector3 randomPos = ((Vector3) Random.insideUnitCircle * randomWanderDistance) + (Vector3) randomWanderCenter.position;
                targetAgent.navMeshAgent.SetDestination (randomPos);
                randomWanderWaitTimeLeft = Random.Range (randomWanderWaitTime.x, randomWanderWaitTime.y);
            } else {
                randomWanderWaitTimeLeft -= Time.deltaTime;
            }
        } else if (currentFollowTarget != null && Vector3.Distance (currentFollowTarget.position, transform.position) <= followDistance) {
            targetAgent.navMeshAgent.SetDestination (currentFollowTarget.position);
        }
    }
}