using UnityEngine;

public class TapToContinue : MonoBehaviour
{
    // Update is called once per frame
    public GameObject ContinuePanel;
    void Update()
    {
        
        if (Input.touchCount > 0)
        {
            
            if (Input.GetTouch(0).phase == TouchPhase.Began)
            {
                ContinuePanel.SetActive(false);
            }
        }

        // Cũng kiểm tra cảm ứng từ chuột trên máy tính
        if (Input.GetMouseButtonDown(0))
        {
            ContinuePanel.SetActive(false);
        }
    }
}