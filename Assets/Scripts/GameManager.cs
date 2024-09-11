using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using DG.Tweening;
using System.Collections;
using TMPro;

public class GameManager : MonoBehaviour
{
    public Material block, selected_block;
    public GameObject GamePanel, WinPanel, LosePanel, PausePanel,ReturnPanel,HarmerItem,MoveItem,ReturnItem;
    public Transform arrow;
    public Text  textStar, levelText1, textStar2, levelText2, levelText3, levelText4,xstar;
    public TextMeshProUGUI maxValueText, sliderValueText;
    public AudioSource src;
    public AudioClip sfx1;
    public Slider slider;
    public Scrollbar scrollbar1;
    public float incrementAmount; 
    public float sliderIncreaseTime;
    private Coroutine smoothIncreaseCoroutine;
    private int levelNo,currentSceneIndex;
    public float starValue = 0, targetValue;
    private bool win;
    public float FillSpeed = 0.5f, rotationAngle = 180f, RotationZNow;
    void Awake()
    {
        levelNo = SceneManager.GetActiveScene().buildIndex-1;
        SetSliderMaxValue();
        levelText1.text = "Level " + levelNo.ToString();
        levelText2.text = "Lv." + levelNo.ToString();
        levelText3.text = "Lv." + levelNo.ToString();
        levelText4.text = "Lv." + levelNo.ToString();
    }
    void Start()
    {

        GamePanel.SetActive(true);
        Application.targetFrameRate = 90;
        


    }

    private void Update()
    {
        float rotationZ = arrow.eulerAngles.z;

        if (0f < rotationZ&&rotationZ<30f)
        {
            xstar.text = "x3";
        }
        if (30f < rotationZ && rotationZ < 90f)
        {
            xstar.text = "x2";
        }
        if (300f < rotationZ && rotationZ < 330f)
        {
            xstar.text = "x5";
        }
        if (330f < rotationZ && rotationZ < 370f)
        {
            xstar.text = "x4";
        }
    }
   



    private void SetSliderMaxValue()
    {
        int maxSliderValue = 100 + (levelNo - 1) * 10;
        slider.maxValue = maxSliderValue;

        maxValueText.text = slider.maxValue.ToString();
    }
    public void Win()
    {
        if (!win)
        {
            win = true;
            Invoke("InvokeWinGame", 1);
            
        }
    }
    public void Lose()
    {
        if (!win)
        {
            Invoke("InvokeLoseGame", 1);
        }
    }
    private void InvokeWinGame()
    {
       
        src.clip = sfx1;
        src.Play();
        WinPanel.SetActive(true);
        WinPanel.transform.DOScale(new Vector3(1, 1, 1), .5f);
        MoveArrow();
    }
    private void InvokeLoseGame()
    {
        
        
        LosePanel.SetActive(true);
        LosePanel.transform.DOScale(new Vector3(1, 1, 1), .5f);
    }

    public void Next()
    {

        PlayerPrefs.SetInt("Level", ++levelNo);
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex+1);
    }
    public void Home()
    {
        currentSceneIndex = SceneManager.GetActiveScene().buildIndex;
        PlayerPrefs.SetInt("SavedScene", currentSceneIndex);
        SceneManager.LoadScene("StartScreen");
        
    }
    public void PlayAgain()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
    }
    public void PlayAgainAll()
    {
        SceneManager.LoadScene("Level1");
    }
    public void Setting()
    {
        PausePanel.SetActive(true);
    }
    public void Return()
    {
        ReturnPanel.SetActive(true);
        PausePanel.SetActive(false);
    }
    public void CloseReturn()
    {
        ReturnPanel.SetActive(false);
    }
    public void CloseBtn()
    {
        LosePanel.SetActive(false);
    }
    public void CloseBtnSet()
    {
        PausePanel.SetActive(false);
    }
    public void Harmer()
    {
        HarmerItem.SetActive(true);
    }
    public void CloseHarmer()
    {
        HarmerItem.SetActive(false);
    }
   public void MoveItem1()
    {
        MoveItem.SetActive(true);
    }
    public void CloseMove()
    {
        MoveItem.SetActive(false);
    }
    public void ReturnItem1()
    {
        ReturnItem.SetActive(true);
    }
    public void CloseReturn1()
    {
        ReturnItem.SetActive(false);
    }
    public void MoveArrow()
    {
        float currentRotation =40f;
        float targetRotation = currentRotation + rotationAngle;
        Tween rotationTween = arrow.DORotate(new Vector3(0, 0, targetRotation), 0.4f);
        rotationTween.SetEase(Ease.Linear);
        rotationTween.SetLoops(-1, LoopType.Yoyo);
       
    }
    public void IncreaseStar()
    {
       
        
        starValue++;

        FindObjectOfType<SaveDataStar>().IncreaseDataStar();
        StartCoroutine(IncreaseStar1(starValue));
       
        
    }
    IEnumerator IncreaseStar1(float starValue)
    {
        
        
        yield return new WaitForSeconds(1.8f);
        textStar.text = starValue.ToString();
        textStar2.text = starValue.ToString();
        


    }
    public void IncreaseLevelSlider()
    {
        if (smoothIncreaseCoroutine != null)
            StopCoroutine(smoothIncreaseCoroutine);
        targetValue=targetValue+incrementAmount;
        smoothIncreaseCoroutine = StartCoroutine(SmoothIncreaseSlider(targetValue));
    }
    IEnumerator SmoothIncreaseSlider(float targetValue)
    {
        yield return new WaitForSeconds(0.5f);
        float timer = 0f;
        float startValue = slider.value;
       
        while (timer < sliderIncreaseTime)
        {
            timer += Time.deltaTime;
            slider.value = Mathf.Lerp(startValue, targetValue, timer / sliderIncreaseTime);
            int value = (int)slider.value;
            sliderValueText.text = value.ToString();
            yield return null;
        }
        slider.value = targetValue;
        if (slider.value == slider.maxValue)
            Win();
        // Reset the coroutine reference
        smoothIncreaseCoroutine = null;
    }
    public void ButtonStar()
    {
        float rotationZ = arrow.eulerAngles.z;
        if (0f < rotationZ && rotationZ < 30f)
        {
            FindObjectOfType<SaveDataStar>().IncreaseDataStar3();
            Debug.Log("3");
        }
        if (30f < rotationZ && rotationZ < 90f)
        {
            FindObjectOfType<SaveDataStar>().IncreaseDataStar2();
            Debug.Log("2");
        }
        if (300f < rotationZ && rotationZ < 330f)
        {
            FindObjectOfType<SaveDataStar>().IncreaseDataStar5();
            Debug.Log("5");
        }
        if (330f < rotationZ && rotationZ < 370f)
        {
            FindObjectOfType<SaveDataStar>().IncreaseDataStar4();
            Debug.Log("4");
        }
    }
}
