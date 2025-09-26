using UnityEngine;

public class burst_particles : MonoBehaviour
{
    public ParticleSystem ps;

    public void HIT(int count)
    {
        ps.Emit(count);
    }
}
