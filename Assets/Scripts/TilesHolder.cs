using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.SceneManagement;


public class TilesHolder : MonoBehaviour
{
 
    public int maxTiles;
    [HideInInspector] public List<Tile> tiles;
    public List<GameObject> tilesPrefabs;
    public Transform spawnPoint;
    private float yIncVal;
    private int totalTilesCount;
    private int firstColorTilesCount;
    private int secondColorTilesCount;
    private bool selectingObject = false;
    private int count1, count2;


    public Vector3 boxSize = new Vector3(1f, 1f, 1f);
    public LayerMask layerMask;
    [HideInInspector] public Collider[] colliders;
    [HideInInspector] public Transform groundTile;
    [HideInInspector] public bool isTilesMatched;
    private void Start()
    {
        totalTilesCount = maxTiles;
        firstColorTilesCount = Random.Range(0, totalTilesCount);
        SpawnTiles(firstColorTilesCount);
        secondColorTilesCount = totalTilesCount - firstColorTilesCount;
        SpawnTiles(secondColorTilesCount);
        this.enabled = false;
      
    }
    private void Update()
    {
        

        colliders = Physics.OverlapBox(transform.position, boxSize / 2f, Quaternion.identity, layerMask);
        colliders = FilterOutSelfColliders(colliders);
       
            
        
    }
    

    Collider[] FilterOutSelfColliders(Collider[] colliders)
    {
        // Filter out all colliders attached to the current GameObject
        return colliders.Where(c => c.transform != transform).ToArray();
    }

    private void SpawnTiles(int tilesToSpawn)
    {
        if (tilesToSpawn == 0)
            return;

        GameObject tilePrefab = tilesPrefabs[Random.Range(0, tilesPrefabs.Count)];

        for (int i = 0; i < tilesToSpawn; i++)
        {
            GameObject tile = Instantiate(tilePrefab, spawnPoint.position, Quaternion.identity, transform);
            tiles.Add(tile.GetComponent<Tile>());
            IncreaseYSpawnPointYPos();
        }
    }

    public void IncreaseYSpawnPointYPos()
    {
        yIncVal += 0.1f;
        spawnPoint.localPosition = new Vector3(spawnPoint.localPosition.x, yIncVal, spawnPoint.localPosition.z);
    }

    public void DecreaseYSpawnPointYPos()
    {
        yIncVal -= .1f;
        spawnPoint.localPosition = new Vector3(spawnPoint.localPosition.x, yIncVal, spawnPoint.localPosition.z);
    }

    public int GetListSize()
    {
        return tiles.Count;
    }
  

    public void ThrowTiles(TilesHolder matchedTileHolder)
    {
        StartCoroutine(CoroutineThrowTiles(matchedTileHolder));
       
    }

    IEnumerator CoroutineThrowTiles(TilesHolder matchedTileHolder)
    {
        
        for (int i = tiles.Count - 1; i >= 0; i--)
        {
          if (tiles[i].colorId == matchedTileHolder.tiles[matchedTileHolder.tiles.Count - 1].colorId )
            {
                // Set other tileholder ColorId to My Color Id
                tiles[i].GotoTarget(matchedTileHolder);
                tiles[i].transform.parent = matchedTileHolder.transform;
                tiles.RemoveAt(i);
                Debug.Log("C"+tiles.Count);
                if (tiles.Count == 0)
                {
                    groundTile.tag = "GroundTile";
                    GameManager gameManager = FindObjectOfType<GameManager>();
                    groundTile.GetComponent<MeshRenderer>().material = gameManager.block;
                    gameObject.SetActive(false);
                    Destroy(gameObject, 1);
                    enabled = false;
                    yield return null;

                }
                DecreaseYSpawnPointYPos();
                yield return new WaitForSeconds(.05f);
            }
            else
            {
                break;
            }
        }
        

    }
    private int matchedCount;
       // Function to check if all tiles have the same index
    public void CheckLimitReached()
    {
        if (tiles.Count < 10)
        {
            return;
        }
       
        int firstIndex = tiles[tiles.Count - 1].colorId;
        bool sameIndex = true;
        matchedCount = 0;

        for (int i = tiles.Count - 1; i >= 0; i--)
        {
            if (tiles[i].colorId != firstIndex)
            {
                sameIndex = false;
                break;
            }

            matchedCount++;
        }

        if (matchedCount >= 10)
        {
            FindObjectOfType<GameManager>().incrementAmount = matchedCount;
            isTilesMatched = true;
            StartCoroutine(DestroyTilesCoroutine());
            if (tiles[tiles.Count - 1].colorId == 3)
            {
                FindObjectOfType<HexaAnimation3>().PlayAnimation();
            }
            if (tiles[tiles.Count - 1].colorId == 0)
            {
                FindObjectOfType<HexaAnimation1>().PlayAnimation();
            }
            if (tiles[tiles.Count - 1].colorId == 1)
            {
                FindObjectOfType<HexaAnimation2>().PlayAnimation();
            }
            if (tiles[tiles.Count - 1].colorId == 2)
            {
                FindObjectOfType<HexaAnimation4>().PlayAnimation();
            }
            if (tiles[tiles.Count - 1].colorId == 4)
            {
                FindObjectOfType<HexaAnimation5>().PlayAnimation();
            }
            if (tiles[tiles.Count - 1].colorId == 5)
            {
                FindObjectOfType<HexaAnimation6>().PlayAnimation();
            }
            if (sameIndex)
            {
                Destroy(gameObject, 1f);
                groundTile.tag = "GroundTile";

                GameManager gameManager = FindObjectOfType<GameManager>();
                groundTile.GetComponent<MeshRenderer>().material = gameManager.block;
            }
            
        }
        else
        {
            Debug.Log("NotSameColor");
        }
    }
    private IEnumerator DestroyTilesCoroutine()
    {
        for (int i = tiles.Count - 1; i >= 0; i--)
        {
            matchedCount--;
            tiles[i].PlayDestroyAnim();
          
            tiles.RemoveAt(i);
            DecreaseYSpawnPointYPos();

            if (matchedCount == 0)
                break;
            yield return new WaitForSeconds(0.05f);
        }

        FindObjectOfType<GameManager>().IncreaseLevelSlider();
        FindObjectOfType<GameManager>().IncreaseStar();
        FindObjectOfType<StarAnimation>().PlayAnimation();
      
    }
}

