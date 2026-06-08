/* int novonum(void) {
  int minhalocal;
  printf("numero: ");
  scanf("%d",&minhalocal);
  return minhalocal;
} */

.data
    fmt_in: .string "%d"
    fmt_out: .string "numero: "

.text
.globl novonum
novonum:

    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp          # espaço para minhalocal (int = 4 bytes)

    /* printf("numero: "); */
    movq    $fmt_out, %rdi     # primeiro arg: format string
    movl    $0, %eax           # 0 args em xmm
    call    printf

    /* scanf("%d",&minhalocal); */
    movq    $fmt_in, %rdi       # 1º arg: "%d"
    leaq    -4(%rbp), %rsi      # 2º arg: endereço de minhalocal
    movl    $0, %eax
    call    scanf

    /* return minhalocal; */
    movl  -4(%rbp), %eax     # retorna o valor lido

    /* epílogo */
    leave
    ret