using DG.Tweening;
using UnityEngine;

public class Tile : MonoBehaviour
{
    public int colorId;

    public void GotoTarget(TilesHolder tilesHolder)
    {
        // Move To Other Tile Stack
        transform.DOLocalJump(tilesHolder.spawnPoint.localPosition, 1f, 1, 0.25f);
        transform.DOLocalRotate(new Vector3(180, 0, 0), 0.2f);

        tilesHolder.IncreaseYSpawnPointYPos();
        tilesHolder.tiles.Add(this);
     
    }

    public void PlayDestroyAnim()
    {
        transform.DOScale(Vector3.zero,0.05f)
    .OnComplete(() => Destroy(gameObject));
    }
}
