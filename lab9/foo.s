/* void foo (int a[], int n) {
  int i;
  int s = 0;
  for (i=0; i<n; i++) {
    s += a[i];
    if (a[i] == 0) {
      a[i] = s;
      s = 0;
    }
  }
} */

.text
.globl  foo
foo:

# calculo do ponteiro para indexação do array
# a + i   →   endereço = base + i * sizeof(int)
# vamos precisar de (%rdi, %rax, 4)
# a[i] == valor armazenado na posicao i
# a == ponteiro que aponta para o primeiro elemento
# a + i == ponteiro que aponta para i

    /* prologo */
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp

    /* salva callee-saved*/
    movq    %r12, -8(%rbp) # nosso temp para valores de retorno

    # s = 0
    movl    $0, %r12d
    # i = 0
    movl    $0, %eax

FOR:
    # if (i >= n) break
    cmpl    %esi, %eax
    jge     FIM

    # s += a[i]
    movl    (%rdi, %rax, 4), %edx
    movl    %edx, %r12d

    # if (a[i] == 0)
    cmpl    $0, %edx
    jne     CONT

    # a[i] = s
    movl    %r12d, %edx
    # s = 0
    movl    $0, %r12d

CONT:
    addl    $1, %eax
    jmp     FOR

FIM:
    #restaurando
    movq    -8(%rbp), %r12
    leave
    ret