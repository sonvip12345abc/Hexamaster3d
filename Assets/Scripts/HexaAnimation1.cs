using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HexaAnimation1 : MonoBehaviour
{
    // Thêm Animator component vào GameObject
    private Animator animator;

    private void Start()
    {
        // Lấy Animator component từ GameObject
        animator = GetComponent<Animator>();
    }

    // Hàm để chơi animation
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
