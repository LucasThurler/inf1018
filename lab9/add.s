/*
int add (int a, int b, int c) {
  return a+b+c;
}
*/

.text
.globl  add
add:

    /* Prologo */
    pushq   %rbp                 #base do RA (Registro de ativação)
    movq    %rsp,   %rbp         #prepara o acesso ao RA
    subq    $16,    %rsp
    movq    %r13,   -8(%rsp)     #callee-saved
    # vamos usar o r13 como temp para valor de retorno da soma

    # return a+b+c
    movl    %edi,   %r13d   # temp a
    addl    %esi,   %r13d   # temp += b
    addl    %edx,   %r13d   # temp += c
    movl    %r13d,  %eax    # return temp

    /* Finalizando! */
    movq    -8(%rsp), %r13  #restaura valor do registrador callee-saved
    leave
    ret