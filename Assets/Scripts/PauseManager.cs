using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using DG.Tweening;
using System.Collections;
public class PauseManager : MonoBehaviour
{
    private int musicnum,soundnum;
    public GameObject VibrateBtn1, VibrateBtn2, MusicBtn1, MusicBtn2, SoundBtn1, SoundBtn2, BackgroundSound,ClickSound;
    private void Update()
    {
        soundnum = PlayerPrefs.GetInt("sound");
        musicnum = PlayerPrefs.GetInt("music");
        if(musicnum == 0)
        {
            BackgroundSound.SetActive(false);
            MusicBtn2.SetActive(true);
            MusicBtn2.transform.DOScale(new Vector3(1, 1, 1), .5f);
            MusicBtn1.SetActive(false);
           
        }
        if (musicnum == 1)
        {
            MusicBtn1.SetActive(true);
            MusicBtn1.transform.DOScale(new Vector3(1, 1, 1), .5f);
            MusicBtn2.SetActive(false);
            BackgroundSound.SetActive(true);
        }
        musicnum = PlayerPrefs.GetInt("music");
        if (soundnum == 0)
        {
            SoundBtn2.SetActive(true);
            SoundBtn2.transform.DOScale(new Vector3(1, 1, 1), .5f);
            SoundBtn1.SetActive(true);
            ClickSound.SetActive(false);

        }
        if (soundnum == 1)
        {
            SoundBtn1.SetActive(true);
            SoundBtn1.transform.DOScale(new Vector3(1, 1, 1), .5f);
            SoundBtn2.SetActive(false);
            ClickSound.SetActive(true);
        }
    }
    public void VibrateOn()
    {
       

        VibrateBtn1.SetActive(true);
        VibrateBtn1.transform.DOScale(new Vector3(1, 1, 1), .5f);
        VibrateBtn2.SetActive(false);
    }
    public void VibrateOff()
    {


        VibrateBtn2.SetActive(true);
        VibrateBtn2.transform.DOScale(new Vector3(1, 1, 1), .5f);
        VibrateBtn1.SetActive(false);
    }
    public void MusicOn()
    {

        PlayerPrefs.SetInt("music", 1);
       
    }
    public void MusicOff()
    {
        PlayerPrefs.SetInt("music", 0);
       

    }
    public void SoundOn()
    {

        PlayerPrefs.SetInt("sound", 1);
       
    }
    public void SoundOff()
    {

        PlayerPrefs.SetInt("sound", 0);
        
    }

}
