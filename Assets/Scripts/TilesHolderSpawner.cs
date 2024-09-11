using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;
using UnityEngine.PlayerLoop;

public class TilesHolderSpawner : MonoBehaviour
{
    public static TilesHolderSpawner instance;
    public List<Transform> spawnPoints;
    public GameObject tilesHolderPrefab;
    private GameObject selectedObject;
    private int spawTilesHolCount;
    private bool selectObject;
    [HideInInspector] public Transform groundTile;
    public GameObject MovePanel, GamePanel;
    public GameObject[] gameObjectsArray;
    public float number2;


    private void Start()
    {
        SpawnTileHolders();
        Invoke(nameof(AddTileControllers), 0.1f);
    }
   

    private void AddTileControllers()
    {
        foreach (TilesHolder tilesHolder in FindObjectsOfType<TilesHolder>())
        {
            if (!tilesHolder.enabled)
                tilesHolder.gameObject.AddComponent<TileController>();
        }
    }
    private void Update()
    {
        if (number2 == 0)
        {
            selectObject = false;
            MovePanel.SetActive(false);
            GamePanel.SetActive(true);
        }
        FindObjectOfType<ShopManager>().number12 = number2;
        number2 = PlayerPrefs.GetFloat("number2");
        if (selectObject)
        {
            if (Input.GetMouseButtonDown(0))
            {
                RaycastHit hit;
                Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
                if (Physics.Raycast(ray, out hit))
                {
                    TilesHolder tilesHolder = hit.collider.GetComponent<TilesHolder>();
                    if (tilesHolder != null && tilesHolder.enabled)
                    {

                       
                        for (int i = 0; i < gameObjectsArray.Length; i++)
                        {
                            if (gameObjectsArray[i].CompareTag("Untagged"))
                            {
                               
                                gameObjectsArray[i].tag = "GroundTile";
                                GameManager gameManager = FindObjectOfType<GameManager>();
                                gameObjectsArray[i].GetComponent<MeshRenderer>().material = gameManager.block;
                            }
                        }
                        
                        selectObject = false;
                        tilesHolder.gameObject.AddComponent<TileController>();
                        
                    }
                    IncreaseTile();
                    GamePanel.SetActive(true);
                    MovePanel.SetActive(false);
                    number2 = number2 - 1;
                    PlayerPrefs.SetFloat("number2", number2);
                }
            }
        }
        
    }
    
    public void ActiveObject()
    {
        selectObject = true;
        MovePanel.SetActive(true);
        GamePanel.SetActive(false);
    }
    public void Close()
    {
        selectObject = false;
        GamePanel.SetActive(true);
        MovePanel.SetActive(false);
    }
   /* private void HandleObjectSelection()
    {
        if (selectedObject != null)
        {
            selectedObject.AddComponent<TileController>();
           

        }
        selectObject = false;
    }*/
    public void DecreaseTileHolderCount()
    {
        spawTilesHolCount--;
        if (spawTilesHolCount == 0)
        {
            SpawnTileHolders();
        }
    }
    public void IncreaseTile()
    {
        spawTilesHolCount++;
    }
    private void SpawnTileHolders()
    {
        foreach (Transform spaPoint in spawnPoints)
        {
            GameObject obj = Instantiate(tilesHolderPrefab, spaPoint.position, Quaternion.identity);
            obj.name = "Name " + Time.timeScale + Random.Range(0, 100);
            spawTilesHolCount++;
            
            /*obj.transform.DORotate(new Vector3(0f, 360f, 0f), 1f, RotateMode.FastBeyond360);*/
            /* if (obj != null)
             {
                 CheckActive j = obj.GetComponent<CheckActive>();
                 tileControllers.Add(j);
             }*/
        }
    }



    
    private void DestroyObjectsAtSpawnPoint(Transform spawnPoint)
    {
        Collider[] colliders = Physics.OverlapSphere(spawnPoint.position, 0.75f);

        foreach (Collider collider in colliders)
        {
            Destroy(collider.gameObject);
        }
    }
  
    public void DestroySpawnedObjects()
    {
        foreach (Transform spaPoint in spawnPoints)
        {
         
            DestroyObjectsAtSpawnPoint(spaPoint);
        }
        
        SpawnTileHolders();
        Invoke(nameof(AddTileControllers), 0.1f);
        if (spawTilesHolCount == 6)
        {
            spawTilesHolCount=spawTilesHolCount - 3;
        }
        if (spawTilesHolCount == 5)
        {
            spawTilesHolCount = spawTilesHolCount - 2;
        }
        if (spawTilesHolCount == 4)
        {
            spawTilesHolCount = spawTilesHolCount - 1;
        }
    }
}
