using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using DG.Tweening;
using System.Collections;
using UnityEngine.InputSystem;



public class StartManager : MonoBehaviour
{
    public GameObject SettingPanel, StartPanel,LoginPanel,PiggyPanel,ComingsonPanel,DailyPanel,WeeklyPanel,QuestPanel, Home1, RankScreen,Rank1,ShopScreen,Shop1,ThemeScreen,Theme,PigImage,AdsImage,DailyImage;
    public InputField inputField;
    public Text resultext,TextStar;
  
    public float CurrentStarValue,AllStarValue;
    private int sceneToContinue;

    private void Start()
    {
        Application.targetFrameRate = 90;
    }



    public void Seting()
    {
        SettingPanel.SetActive(true);
       
    }
    public void Close()
    {
        SettingPanel.SetActive(false);
        
    }
    public void Edit()
    {
        LoginPanel.SetActive(true);
        SettingPanel.SetActive(false);
    }
    public void CLoseEdit()
    {
        LoginPanel.SetActive(false);
        SettingPanel.SetActive(true);
    }
    public void Input()
    {
        string input = inputField.text;
        resultext.text = input;
    }
    public void Piggy()
    {
      
        PiggyPanel.SetActive(true);
        PigImage.transform.localScale = Vector3.zero; // Bắt đầu từ kích thước không
        PigImage.transform.DOScale(Vector3.one, 1f).SetEase(Ease.OutBack); // Tăng kích thước từ 0 đến 1 trong 1 giây
      
    }
    public void ClosePiggy()
    {
     
        PiggyPanel.SetActive(false);
    }
    public void ComingSoon()
    {
        ComingsonPanel.SetActive(true);
    }
    public void CloseComingSoon()
    {
        ComingsonPanel.SetActive(false);
    }
    public void Daily()
    {
        DailyPanel.SetActive(true);
        DailyImage.transform.localScale = Vector3.zero; // Bắt đầu từ kích thước không
        DailyImage.transform.DOScale(Vector3.one, 1f).SetEase(Ease.OutBack); // Tăng kích thước từ 0 đến 1 trong 1 giây
    }
    public void CloseDaily()
    {
 DailyPanel.SetActive(false);
    }
    public void Weekly()
    {
        WeeklyPanel.SetActive(true);
    }
    public void CloseWeekly()
    {
        WeeklyPanel.SetActive(false);
    }
  
    public void Quest()
    {
        QuestPanel.SetActive(true);
    }
    public void HomeOn()
    {
        Home1.SetActive(true);
        RankScreen.SetActive(false);
        Rank1.SetActive(false);
        Shop1.SetActive(false);
        ShopScreen.SetActive(false);
        Theme.SetActive(false);
        ThemeScreen.SetActive(false);
    }
    public void RankOn()
    {
        Home1.SetActive(false);
        RankScreen.SetActive(true);
        Rank1.SetActive(true);
        Shop1.SetActive(false);
        ShopScreen.SetActive(false);
        Theme.SetActive(false);
        ThemeScreen.SetActive(false);

    }
    public void ShopOn()
    {
        Home1.SetActive(false);
        ShopScreen.SetActive(true);
        Rank1.SetActive(false);
        Shop1.SetActive(true);
        RankScreen.SetActive(false);
        Theme.SetActive(false);
        ThemeScreen.SetActive(false);
    }
    public void ThemeOn()
    {
        Home1.SetActive(false);
        ShopScreen.SetActive(false);
        Rank1.SetActive(false);
        Shop1.SetActive(false);
        RankScreen.SetActive(false);
        Theme.SetActive(true);
        ThemeScreen.SetActive(true);
    }
    public void LoadStart()
    {
        sceneToContinue = PlayerPrefs.GetInt("SavedScene");
        if (sceneToContinue != 0 && sceneToContinue!=1)
            SceneManager.LoadScene(sceneToContinue);
        else
            SceneManager.LoadScene("Level1");
    }
}
