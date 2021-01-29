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