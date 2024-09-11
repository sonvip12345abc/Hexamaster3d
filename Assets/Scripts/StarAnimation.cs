using UnityEngine;
using System.Collections;

public class StarAnimation : MonoBehaviour
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
        yield return new WaitForSeconds(0.82f);
        animator.SetBool("isMove", true);
        animator.SetBool("isStar", true);
        yield return new WaitForSeconds(1f);
        animator.SetBool("isStar", false);
        animator.SetBool("isExit", true);
    }
     
}