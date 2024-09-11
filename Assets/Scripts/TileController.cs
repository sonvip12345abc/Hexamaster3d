using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using System.Collections;
using System.Collections.Generic;
using DG.Tweening.Core.Easing;

public class TileController : MonoBehaviour
{
    private Vector3 mOffset;
    private float mZCoord;
    public Transform targetPos;
    private Vector3 initialPos;
    public bool isMouseDown;
    public Vector3 pos;
    private List<Vector3> positions = new List<Vector3>();
    private bool selectingObject = false;





    private Material block, selected_block;
   /* private ObjectSelector objectSelector;*/
    private void Start()
    {
        GameManager gameManager = FindObjectOfType<GameManager>();
        selected_block = gameManager.selected_block;
        block = gameManager.block;
        initialPos = transform.position;
    }

  /*  private void Position1()
    {

        ObjectSelector objectSelector = FindObjectOfType<ObjectSelector>();
        objectPosition = objectSelector.objectPosition;

    }*/

    private void Update()
    {
    }
   
    void OnMouseDown()
    {
        isMouseDown = true;
        mZCoord = Camera.main.WorldToScreenPoint(
        gameObject.transform.position).z;

        // Store offset = gameobject world pos - mouse world pos
        mOffset = gameObject.transform.position - GetMouseAsWorldPoint();
    }

        private Vector3 GetMouseAsWorldPoint()
    {
        // Pixel coordinates of mouse (x,y)
        Vector3 mousePoint = Input.mousePosition;

        // z coordinate of game object on screen
        mousePoint.z = mZCoord;

        // Convert it to world points
        return Camera.main.ScreenToWorldPoint(mousePoint);
    }

    void OnMouseDrag()
    {
        
        if (!isMouseDown)
            return;

        transform.position = new Vector3(GetMouseAsWorldPoint().x + mOffset.x, 2.6f, GetMouseAsWorldPoint().z + mOffset.z);
       
    }

    private void OnMouseUp()
    {
        isMouseDown = false;
        if (targetPos == null)
        {
            transform.position = initialPos;
            return;
        }

        foreach (TileController tileController in FindObjectsOfType<TileController>())
        {
            if (tileController != this)
            {
                Destroy(tileController);
            }
        }

        pos = targetPos.position;
        pos.y += 0.01f;
        transform.position = pos;
        targetPos.tag = "Untagged";
        GetComponent<TilesHolder>().enabled = true;
        GetComponent<TilesHolder>().groundTile = targetPos;
       
      
        Debug.Log("postition now" + targetPos);
        gameObject.layer = 15;
        Invoke(nameof(InvokeCallTilesHolder),0.1f);
        FindObjectOfType<TilesHolderSpawner>().DecreaseTileHolderCount();
        /* Position1();*/
    }



     
    private void InvokeCallTilesHolder()
    {
        FindObjectOfType<TilesHolderChecker>().CheckOneTilesHolder(GetComponent<TilesHolder>());
        Destroy(this);
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("GroundTile") && isMouseDown )
        {
            
            targetPos = other.transform;
            other.GetComponent<MeshRenderer>().material = selected_block;
           
        }

    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("GroundTile") )
        {
            targetPos = null;
            other.GetComponent<MeshRenderer>().material = block;
        }
    }
    
}
