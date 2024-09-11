using DG.Tweening.Core.Easing;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HarmerItem : MonoBehaviour
{
    private bool selectingObject = false;
    private GameObject selectedObject;
    public Vector3 objectPosition;
    public Vector3 clickedObjectPosition;
    [HideInInspector] public Transform groundTile;
    public GameObject GamePanel, HarmerItemPanel,closeBtn;
    private int count;
    public GameObject[] gameObjectsArray;
    public float number1;


    void Start()
    {
      
    }

    
    private void Update()
    {
        if (number1 == 0)
        {
            selectingObject = false;
            HarmerItemPanel.SetActive(false);
            GamePanel.SetActive(true);
        }
        FindObjectOfType<ShopManager>().number11=number1;
        number1 = PlayerPrefs.GetFloat("number1");
        if (selectingObject)
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
                            if (gameObjectsArray[i].CompareTag("Untagged")){
                                Vector3 modifiedPosition = gameObjectsArray[i].transform.position - new Vector3(0.05f, 0.05f, 0.05f);
                                Vector3 targetPosition = hit.collider.gameObject.transform.position;
                                Vector3 originalPosition = gameObjectsArray[i].transform.position + new Vector3(0.05f, 0.05f, 0.05f);

                                if (modifiedPosition.x < targetPosition.x && targetPosition.x <= originalPosition.x &&
                                    modifiedPosition.y < targetPosition.y && targetPosition.y <= originalPosition.y &&
                                    modifiedPosition.z < targetPosition.z && targetPosition.z <= originalPosition.z)
                                {
                                    
                                    gameObjectsArray[i].tag = "GroundTile";
                                    GameManager gameManager = FindObjectOfType<GameManager>();
                                    gameObjectsArray[i].GetComponent<MeshRenderer>().material = gameManager.block;
                                   
                                }



                            } 
                        }
                      /*  groundTile.tag = "GroundTile";


                        GameManager gameManager = FindObjectOfType<GameManager>();
                        groundTile.GetComponent<MeshRenderer>().material = gameManager.block;*/
                        selectingObject = false;
                        tilesHolder.enabled= false;
                        Destroy(tilesHolder.gameObject);  // Phá hủy GameObject chứa TilesHolder
                    }
                   
                    
                    GamePanel.SetActive(true);
                    HarmerItemPanel.SetActive(false);
                    number1 = number1 -1;
                    PlayerPrefs.SetFloat("number1", number1);
                }
            }

        }
       
    }

   
    public void ActivateObjectSelection()
    {
        HarmerItemPanel.SetActive(true);
        GamePanel.SetActive(false);
        selectingObject = true;
    }
  
    // Phương thức để xử lý việc chọn đối tượng và phá hủy
    /*private void HandleObjectSelection(Vector3 objectPosition)
    {
        if (selectedObject != null)
        {
            Destroy(selectedObject);
            Debug.Log("Vị trí của đối tượng bị phá hủy: " + objectPosition);
           
        }
        selectingObject = false;
       
    }*/
    public void CLose()
    {
        HarmerItemPanel.SetActive(false);
        GamePanel.SetActive(true);
        selectingObject = false;
    }
}
