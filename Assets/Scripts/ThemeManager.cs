using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ThemeManager : MonoBehaviour
{
    public GameObject background1, background2;
   
    public void theme1()
    {
       
            background1.SetActive(true);
            background2.SetActive(false);
        

    }
    public void theme2()
    {
        
            background1.SetActive(false);
            background2.SetActive(true);
        
    }
}
