using UnityEngine;


public class BackgrounData : MonoBehaviour
{
    private int backgroundnum;
    public GameObject Bg1, Bg2,Bg1Using,BtnBg1NotUsing, Bg2Using, BtnBg2NotUsing;
    private void Start()
    {
        backgroundnum = PlayerPrefs.GetInt("bg");
        Debug.Log(backgroundnum);
        if (backgroundnum == 1)
        {
            Bg1.SetActive(true);
            Bg2.SetActive(false);
            Bg1Using.SetActive(true);
            BtnBg2NotUsing.SetActive(true);
            Bg2Using.SetActive(false);
            BtnBg1NotUsing.SetActive(false);
        }
        if (backgroundnum == 2)
        {
            Bg1.SetActive(false);
            Bg2.SetActive(true);
            Bg2Using.SetActive(true);
            BtnBg1NotUsing.SetActive(true);
            Bg1Using.SetActive(false);
            BtnBg2NotUsing.SetActive(false);
        }
    }
    public void ChooseBg1()
    {
        PlayerPrefs.SetInt("bg", 1);
        Bg1Using.SetActive(true);
        BtnBg2NotUsing.SetActive(true);
        Bg2Using.SetActive(false);
        BtnBg1NotUsing.SetActive(false);


    }
    public void ChooseBg2()
    {
        PlayerPrefs.SetInt("bg", 2);
        Bg2Using.SetActive(true);
        BtnBg1NotUsing.SetActive(true);
        Bg1Using.SetActive(false);
        BtnBg2NotUsing.SetActive(false);


    }

}
