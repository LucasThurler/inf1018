/*
struct X {
  int val1; // offset 0
  int val2; // offset 4
};

int f(int i, int v);

void boo (struct X *px, int n, int val) {
  while (n--) {
    px->val2 = f(px->val1, val);
    px++;
  }
} */

.text
.globl  boo
boo:

    pushq %rbp
    movq  %rsp, %rbp
    subq  $32, %rsp

    /* callee-saved */
    movq  %rbx, -8(%rbp)
    movq  %r12, -16(%rbp)
    movq  %r13, -24(%rbp)

    # copiar os parametros
    movq  %rdi, %rbx      # rbx = px  valor original
    movl  %esi, %r12d     # r12d = n  valor original
    movl  %edx, %r13d     # r13d = val valor original

    /* “mas eu já usei %esi antes…”
    Depois que você fez:

    movl %esi, %r12d

    👉 %esi ficou livre pra ser usado como quiser 
    Regra de ouro
    caller-saved (%edi, %esi, %eax...) → descartáveis
    callee-saved (%rbx, %r12...) → guardam estado
    */

LOOP:
    # while (n--)
    cmpl  $0, %r12d
    je    FIM

    subl  $1, %r12d

    # f(px->val1, val)
    movl  0(%rbx), %edi   # px->val1
    movl  %r13d,   %esi   # val
    call  f

    # resultado em eax -> salva em val2
    movl  %eax,   4(%rbx)
    addq  $8,     %rbx    # px++

    jmp LOOP

FIM:
    movq  -8(%rbp), %rbx
    movq  -16(%rbp), %r12
    movq  -24(%rbp), %r13

    leave
    ret