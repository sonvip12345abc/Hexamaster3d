using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ShopManager : MonoBehaviour
{
    public TextMeshProUGUI coinText1,coinText2,coinText3,coinText4;
    public Text number1, number2, number3;
    public float number11=1,number12=1, number13=1;
    private float totalcoin;
    public GameObject button1, button2, button3;
    private bool condition1=true;
    private void Update()
    {
        if (totalcoin < 0)
        {
            totalcoin = 0;

        }
        if (totalcoin == 0)
        {
            
            condition1 = false;
        }else if (totalcoin > 0) { condition1 = true; }
        number11 = PlayerPrefs.GetFloat("number1");
        number12 = PlayerPrefs.GetFloat("number2");
        number13 = PlayerPrefs.GetFloat("number3");
        totalcoin = PlayerPrefs.GetFloat("Coin");
        coinText1.text=totalcoin.ToString();
        coinText2.text = totalcoin.ToString();
        coinText3.text = totalcoin.ToString();
        coinText4.text = totalcoin.ToString();
        number1.text=number11.ToString();
        number2.text = number12.ToString();
        number3.text = number13.ToString();
        if (number11 > 0)
        {
            button1.SetActive(false);
        }
        else if(number11==0)
        {
            button1.SetActive(true);
        }
        if (number12 > 0)
        {
            button2.SetActive(false);
        }
        else if (number12 == 0)
        {
            button2.SetActive(true);
        }
        if (number13 > 0)
        {
            button3.SetActive(false);
        }
        else if (number13 == 0)
        {
            button3.SetActive(true);
        }

    }

    public void BuyCoin1()
    {
        totalcoin = totalcoin + 2100;
        PlayerPrefs.SetFloat("Coin", totalcoin);
    }
    public void BuyCoin2()
    {
        totalcoin = totalcoin + 4200;
        PlayerPrefs.SetFloat("Coin", totalcoin);
    }
    public void BuyCoin3()
    {
        totalcoin = totalcoin + 8400;
        PlayerPrefs.SetFloat("Coin", totalcoin);

    }
    public void BuyCoin4()
    {
        totalcoin = totalcoin + 18375;
        PlayerPrefs.SetFloat("Coin", totalcoin);
    }
    public void BuyCoin5()
    {
        totalcoin = totalcoin + 36750;
        PlayerPrefs.SetFloat("Coin", totalcoin);
    }
    public void BuyCoin6()
    {
        totalcoin = totalcoin + 1050;
        PlayerPrefs.SetFloat("Coin", totalcoin);

    }
    public void BuyCoin7()
    {
        totalcoin = totalcoin + 3150;
        PlayerPrefs.SetFloat("Coin", totalcoin);
    }
    public void BuyCoin8()
    {
        totalcoin = totalcoin + 7350;
        PlayerPrefs.SetFloat("Coin", totalcoin);
    }
    public void BuyCoin9()
    {
        totalcoin = totalcoin + 13650;
        PlayerPrefs.SetFloat("Coin", totalcoin);
    }
    public void BuyCoin10()
    {
        totalcoin = totalcoin + 26250;
        PlayerPrefs.SetFloat("Coin", totalcoin);
    }
    public void BuyCoin11()
    {
        totalcoin = totalcoin + 52500;
        PlayerPrefs.SetFloat("Coin", totalcoin);
    }
    public void BuyHamerItem()
    {
        totalcoin = totalcoin - 400;
        if (totalcoin < 0)
        {
            totalcoin = 0;
          
        }
        PlayerPrefs.SetFloat("Coin", totalcoin);
        if (condition1==true) { number11 = number11 + 1; }
      
        PlayerPrefs.SetFloat("number1", number11);

    }
    public void BuyMoveItem()
    {
      
        totalcoin = totalcoin - 500;
        if (totalcoin < 500)
        {
            totalcoin = 0;

        }
        PlayerPrefs.SetFloat("Coin", totalcoin);
        if (condition1) { number12 = number12 + 1; }
        
        PlayerPrefs.SetFloat("number2", number12);

    }
    
    
    public void BuyReturnItem()
    {
       
        totalcoin = totalcoin - 300;
        if (totalcoin < 0)
        {
            totalcoin = 0;

        }
        PlayerPrefs.SetFloat("Coin", totalcoin);
        if (condition1) { number13 = number13 + 1; }
        
        PlayerPrefs.SetFloat("number3", number13);
    }
}
