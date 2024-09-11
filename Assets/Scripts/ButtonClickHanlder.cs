using UnityEngine;
using UnityEngine.UI;

public class ButtonClickHandler : MonoBehaviour
{
    public TilesHolderSpawner tilesHolderSpawner;
    public float number3;
    private bool condition;

    private void Update()
    {

        if (number3 == 0)
        {
            condition = false;
        }else if (number3>0) { 
            condition = true; 
        }
        FindObjectOfType<ShopManager>().number13 = number3;
        number3 = PlayerPrefs.GetFloat("number3");
    }
    public void OnButtonClick()
    {
        if (condition)
        {
            number3 = number3 - 1;
            PlayerPrefs.SetFloat("number3", number3);
            tilesHolderSpawner.DestroySpawnedObjects();
        }
    }
}