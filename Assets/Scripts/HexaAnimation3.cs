using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HexaAnimation3 : MonoBehaviour
{
    
    private Animator animator;

    private void Start()
    {
        
        animator = GetComponent<Animator>();
    }

    
    public void PlayAnimation()
    {
        StartCoroutine(CouroutineAnimation());
    }
    IEnumerator CouroutineAnimation()
    {
        animator.SetBool("isFly", true);
        yield return new WaitForSeconds(2f);
        animator.SetBool("isFly", false);
        animator.SetBool("isExit", true);
    }


}
