/*
struct X {
  int val;        // offset 0
  struct X *next; // offset 8
};

int add (struct X *x) {
  int a = 0;
  for (; x != NULL; x = x->next)
    a += x->val;
  return a;
} */

.text
.globl  add
add:
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp

    # callee-saved
    movq    %rbx, -8(%rbp)

    # int a = 0
    movl    $0, %ebx

loop:
    # x = NULL  break
    cmpq    $0, %rdi
    je      fora_loop

    # a += x->val;
    movl    0(%rdi), %eax   # to pegando o conteúdo da memoria em rdi, por isso o zero
    # vendo a struct, to acessando os 4 bytes do endereço %rdi + 0
    addl    %eax, %ebx

    # x = x->next
    movq    8(%rdi), %rdi

    jmp loop

fora_loop:
    # retorna a
    movl    %ebx, %eax

    # restaura callee-saved
    movq -8(%rbp), %rbx
    leave
    ret
