using UnityEngine;

[RequireComponent(typeof(Rigidbody2D))]
public class move : MonoBehaviour
{
    public float Speed;
    public float SpeedRando;
    public float YVals;
    public float XRange;

    Rigidbody2D rb;

    void Awake()
    {
        Speed += Random.Range(-SpeedRando, SpeedRando);
        TryGetComponent(out rb);
    }

    void Update()
    {
        if (transform.position.y >= YVals || transform.position.y <= -YVals)
        {
            transform.position = new Vector3(Random.Range(-XRange, XRange), -YVals, 0f);
        }

        rb.linearVelocityY = Speed;
    }
}
