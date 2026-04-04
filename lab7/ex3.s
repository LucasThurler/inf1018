/*
// escrever um programa que imprima os quadrados dos numeros de 1 a 10
// nao podemos utilizar um array de inteiros globais!
// o exercicio pede para utilizar uma variável local inteira para obter os
// valores dos numeros de 1 a 10

int main() {
    int i; 
    //vamo usar while pq eu vou ter q converter essa budega pra assembly depois
    while (i <= 10) {
        printf("%d\n", i * i);
        i++;
    }
    return 0;
}
*/

.data
Sf:  .string "%d\n"    /* string de formato para printf */

.text
.globl  main
main:

/********************************************************/
/* mantenha este trecho aqui e nao mexa - prologo !!!   */
  pushq   %rbp
  movq    %rsp, %rbp
  subq    $16, %rsp
  movq    %rbx, -8(%rbp)  /* guarda rbx */
/********************************************************/
#int i;
  movl $1, %ebx     # callee-saved pra int i, ebx = i = 1

#while (1 <= 10)
L1:
  cmpl  $10, %ebx   # if (ebx > 10) ?
  jg  L2          /* goto L2 */

# printf("%d\n", i*i)
  movl  %ebx, %eax  # eax = i
  imull %eax, %eax  # eax = i * i


/*************************************************************/
/* este trecho imprime o valor de %eax (estraga %eax)  */
  movq    $Sf, %rdi    /* primeiro parametro (ponteiro)*/
  movl    %eax, %esi   /* segundo parametro  (inteiro) */
  movl  $0, %eax
  call  printf       /* chama a funcao da biblioteca */
/*************************************************************/
  
  # i++
  addl $1, %ebx     # ebx++
  jmp L1            # continua rodando o loop

L2:
/*************************************************************/
/* este trecho imprime o \n (estraga %eax)                  */
  movl  $0, %eax
  call  printf       /* chama a funcao da biblioteca */
/*************************************************************/

/***************************************************************/
/* mantenha este trecho aqui e nao mexa - finalizacao!!!!      */
  movq  $0, %rax  /* rax = 0  (valor de retorno) */
  movq    -8(%rbp), %rbx  /* recupera rbx */
  leave
  ret      
/***************************************************************/