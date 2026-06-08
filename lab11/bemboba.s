/* int bemboba (int num) {
  int local[4];
  int *a;
  int i;

  for (i=0,a=local;i<4;i++) {
    *a = num;
    a++;
  }
  return addl (local, 4);
} */

/* Dicionario */
/* 
    num   → %ebx    (callee-saved, int)
    a     → %r12    (callee-saved, ponteiro 64 bits)
    i     → %r13d   (callee-saved, int)
    local → -40(%rbp) ate -28(%rbp)  (na pilha) 
*/

.text
.globl bemboba
bemboba:

    pushq   %rbp
    movq    %rsp, %rbp
    subq    $48, %rsp   # 24 bytes callee-saved + 16 bytes local[4] + 8 alinhamento

    /* salva callee-saved */
    movq  %rbx, -8(%rbp)     # salva %rbx
    movq  %r12, -16(%rbp)    # salva %r12
    movq  %r13, -24(%rbp)    # salva %r13

    /* inicializacoes */
    movl  %edi, %ebx         # num = parametro recebido
    leaq  -40(%rbp), %r12    # a = &local[0]
    movl  $0, %r13d          # i = 0

LOOP:
    /* i < 4 */
    cmpl  $4, %r13d
    jge   FIM

    /* *a = num */
    movl  %ebx, (%r12)       # escreve num no endereco apontado por a

    /* a++ */
    addq  $4, %r12           # avanca ponteiro pro proximo int

    /* i++ */
    addl  $1, %r13d
    jmp   LOOP

FIM:
    /* return addl(local, 4) */
    leaq  -40(%rbp), %rdi    # 1o arg: &local[0]
    movl  $4, %esi           # 2o arg: 4
    call  addl

    /* restaura callee-saved */
    movq  -8(%rbp), %rbx
    movq  -16(%rbp), %r12
    movq  -24(%rbp), %r13

    /* epilogo */
    leave
    ret
