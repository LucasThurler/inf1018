/*
int add2 (struct X *x) {
  if (x == NULL) return 0;
  else return x->val + add2(x->next);
}
*/

.text
.globl  add2
add2:

    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp

    /* callee-saved */
    movq    %r12, -8(%rbp)

    # if x == NULL
    cmpq    $0, %rdi
    je      base

    # else return 
    # salva x->val antes do call add2
    movl    0(%rdi), %r12d  # r12d = x->val

    # add2(x->next)
    movq    8(%rdi), %rdi   # rdi = x->next
    call add2               # eax = add2(x->next)

    # x->val + add2(x->next)
    addl    %r12d, %eax
    jmp     FIM

base:
    movl    $0, %eax

FIM:
    movq    -8(%rbp), %r12
    leave
    ret

