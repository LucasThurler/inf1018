/*
Traduza agora para assembly o programa abaixo, lembrando o que foi visto em 
sala sobre o cálculo do endereço de cada elemento de um array:

  end(a[i]) = end(a) + i * sizeof(T),  onde T é o tipo dos elementos de a

Você deve, agora, traduzir a operação de indexação do array usada no código C 
(o que envolve calcular os endereços dos elementos do array, conforme acima).

#include <stdio.h>

int nums[4] = {65, -105, 111, 34};

int main (void) {
  int i;
  int s = 0;

  //for (i=0;i<4;i++)
  //  s = s+nums[i];
  while(i<4)
      s = s+nums[i];
      i++

  printf ("soma = %d\n", s);

  return 0;
}
*/

.data
nums:   .int 65, -105, 111, 34
Sf:     .string "soma = %d\n"

.text
.globl main
main:

/**********************************************************/
/* mantenha este trecho aqui - prologo !!! */
pushq   %rbp
movq    %rsp , %rbp
subq    $16 , %rsp
movq    %rbx , -8(%rbp )
movq    %r12 , -16(%rbp )
/**********************************************************/


movl  $0, %ebx  /* int i = ebx = 0 */
movq  $nums, %r12 /* r12 = &nums endereço base da array */
/* nosso registrador de retorno vai ser o acumulador da soma int s; */
movl $0, %eax   # s = 0

LOOP:

  cmpl  $4, %ebx  /* condiçao pra sair do loop */
  jge   fora_loop /* se ebx >= 4, break */

  
  /* i → multiplica → soma com base */
  /* %rcx → registrador auxiliar pra calculo do endereço de nums[i] */
  /* um registrador guardando um endereço de memória... tamo literalmente fazendo
  a formula de um ponteiro */

  movslq %ebx, %rcx   # rcx = i (64 bits)
  imulq  $4, %rcx     # rcx = i*4
  addq   %r12, %rcx   # rcx = base + i*4

  movl  (%rcx),   %edx  /* edx = temp = nums[i] tamo pegando o conteúdo de nums[i] */
  addl  %edx,   %eax  /* s += nums[i] */

  addl  $1, %ebx      /* i++ */
  jmp   LOOP

fora_loop:
/*************************************************************/
/* este trecho imprime o \n (estraga %eax)                  */
  movl %eax, %esi     # s → segundo argumento
  movq $Sf, %rdi      # endereço da string
  call printf
/*************************************************************/

/**********************************************************/
/* mantenha este trecho aqui - finalizacao !!!! */
  movl $0 , % eax # eax = 0 ( valor de retorno )
  movq -8(% rbp ) , % rbx
  movq -16(% rbp ) , % r12
  leave
  ret
/**********************************************************/