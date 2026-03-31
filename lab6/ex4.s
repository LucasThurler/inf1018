/*
int nums[] = {10, -21, -30, 45};
int main() {
  int i, *p;
  //for (i = 0, p = nums; i != 4; i++, p++)
  i = 0
  p = nums
  while(i != 4){
    printf("%d\n", *p);
    i++
    p++
  }
  return 0;
}
*/

.data

#int nums[] = {10, -21, -30, 45};
nums:  .byte  10, -21, -30, 45
Sf:  .string "%d\n"    # string de formato para printf

.text
.globl  main
main:

/********************************************************/
/* mantenha este trecho aqui e nao mexa - prologo !!!   */
  pushq   %rbp
  movq    %rsp, %rbp
  subq    $16, %rsp
  movq    %rbx, -8(%rbp)
  movq    %r12, -16(%rbp)
/********************************************************/

# i = 0
  movl  $0, %ebx  /* ebx = 0; */

# p = nums
  movq  $nums, %r12  /* r12 = &nums */

# while(i != 4){
L1:
  cmpl  $4, %ebx  /* if (ebx == 4) ? */
  je  L2          /* goto L2 */

#   printf("%d\n", *p);
  movsbl  (%r12), %edx    /* eax = *r12 */
  movl %edx, %eax

/*************************************************************/
/* este trecho imprime o valor de %eax (estraga %eax)  */
  movq    $Sf, %rdi    /* primeiro parametro (ponteiro)*/
  movl    %eax, %esi   /* segundo parametro  (inteiro) */
  call  printf       /* chama a funcao da biblioteca */
/*************************************************************/

#   i++
  addl  $1, %ebx  /* ebx += 1; */

#   p++
  addq  $1, %r12  /* r12 += 1; pois agora é um array de bytes e nao de int*/

#   }
  jmp  L1         /* goto L1; */

L2: 
#   return 0; 
/***************************************************************/
/* mantenha este trecho aqui e nao mexa - finalizacao!!!!      */
  movq  $0, %rax  /* rax = 0  (valor de retorno) */
  movq  -8(%rbp), %rbx
  movq  -16(%rbp), %r12
  leave
  ret      
/***************************************************************/