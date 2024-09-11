using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class SaveDataStar : MonoBehaviour
{
    public float TotalStarValue;
    public Text textStar,textStar2,textStar3,textStar4,textStarRank;
  
    void Start()
    {
        TotalStarValue = PlayerPrefs.GetFloat("Star");
        textStar.text = TotalStarValue.ToString();
        textStar2.text = TotalStarValue.ToString();
        textStar3.text = TotalStarValue.ToString();
        textStar4.text = TotalStarValue.ToString();
        textStarRank.text = TotalStarValue.ToString();
    }
    public void IncreaseDataStar()
    {
        TotalStarValue++;
        PlayerPrefs.SetFloat("Star", TotalStarValue);
       
    }
    public void IncreaseDataStar2()
    {
        TotalStarValue = TotalStarValue + 2;
        PlayerPrefs.SetFloat("Star", TotalStarValue);

    }
    public void IncreaseDataStar3()
    {
        TotalStarValue = TotalStarValue + 3;
        PlayerPrefs.SetFloat("Star", TotalStarValue);

    }
    public void IncreaseDataStar4()
    {
        TotalStarValue = TotalStarValue + 4;
        PlayerPrefs.SetFloat("Star", TotalStarValue);

    }
    public void IncreaseDataStar5()
    {
        TotalStarValue = TotalStarValue + 5;
        PlayerPrefs.SetFloat("Star", TotalStarValue);

    }
    



}
