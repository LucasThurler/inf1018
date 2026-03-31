/*
int nums[] = {10, -21, -30, 45};
int main() {
  int i, *p;
  //for (i = 0, p = nums; i != 4; i++, p++)
  i = 0
  p = nums
  while(i != 4){
    i++
    p++
    if ((*p % 2) == 0)
      printf("%d\n", *p);
  }
  return 0;
}
*/

.data

#int nums[] = {10, -21, -30, 45};
nums:  .int  10, -21, -30, 45
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
  movl  $0, %ebx  /* ebx = 0; mantendo i em %ebx */

# p = nums
  movq  $nums, %r12  /* r12 = &nums mantendo o endereço de nums em %r12 */

# while(i != 4){
L1:
  cmpl  $4, %ebx  /* if (ebx == 4) ? */
  je  L2          /* goto L2 */

# carrega *p e testa paridade com bit menos significativo
  movl  (%r12), %eax    /* eax = *p */
  movl  %eax, %edx      /* guarda valor original para possivel printf */
  andl  $1, %eax        /* eax = (*p & 1) */
  jne   Lskip_print     /* se bit 0 = 1, número é impar */

/*************************************************************/
/* este trecho imprime o valor de %edx (estraga %eax)        */
  movq    $Sf, %rdi    /* primeiro parametro (ponteiro)*/
  movl    %edx, %esi   /* segundo parametro  (inteiro) */
  call  printf       /* chama a funcao da biblioteca */
/*************************************************************/

Lskip_print:

#   i++
  addl  $1, %ebx  /* ebx += 1; */

#   p++
  addq  $4, %r12  /* r12 += 4; */

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