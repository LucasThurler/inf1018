/*int fat (int n) {
  if (n==0) return 1;
  else return n*fat(n-1);
}*/

/*
rip aponta para a próxima instrução a ser executada
rsp aponta para o topo da pilha
rbp aponta para base do RA corrente
*/

.text
.globl  fat
fat:

  /* Prólogo */
  pushq   %rbp
  movq    %rsp, %rbp
  subq    $16, %rsp

  /* calle-saved */
  movq    %r12, -8(%rbp)

  /* começou */
  
  /* if (n == 0) */
  cmpl    $0, %edi
  jne     ELSE

  movl    $1, %eax
  jmp     RETORNA

  /* yo me voy a fazer o else agora */
  /* else return n*fat(n-1); */

  ELSE:
    # temp = n
    movl    %edi, %r12d

    # temp -= 1
    subl    $1, %r12d

    movl    %edi, -12(%rbp) # salvei n pois edi vai ser destruído pelo call fat
    movl    %r12d, %edi     # edi = n-1
    call fat
    
    movl    -12(%rbp), %edi  # restaura o caller-saved
    imull   %edi, %eax      # agora dá pra fazer n * fat(n-1)

  RETORNA:
    movq    -8(%rbp), %r12  # restaura callee-saved
    movq    %rbp, %rsp
    popq    %rbp
    /* apenas finalizações */
    ret