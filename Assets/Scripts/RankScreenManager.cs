using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RankScreenManager : MonoBehaviour
{
    public GameObject ScrollAreaAll, ScrollAreaMonthly, AllOn, AllOff, MonthlyOn, MonthlyOff;
    private void Start()
    {
        
    }
    public void AllOn1()
    {
        AllOff.SetActive(false);
        AllOn.SetActive(true);
        MonthlyOn.SetActive(false);
        MonthlyOff.SetActive(true);
        ScrollAreaAll.SetActive(true);
        ScrollAreaMonthly.SetActive(false);
       
    }
    public void MonthlyOn1()
    {
        AllOff.SetActive(true);
        AllOn.SetActive(false);
        MonthlyOn.SetActive(true);
        MonthlyOff.SetActive(false);
        ScrollAreaAll.SetActive(false);
        ScrollAreaMonthly.SetActive(true);

    }
}
