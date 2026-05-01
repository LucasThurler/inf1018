/* 
int f(int x);

void map2 (int* um, int * outro, int n) {
  int i;
  for (i=0; i<n; i++)
    *(outro+i) = f(*(um+i));  <--->  isso aqui é o mesmo que  outro[i] = f(um[i]);
} */

/* Dicionario

    um = ponteiro (endereco do array)
    um + i = endereco do elemento i
    *(um + i) = valor do elemento i
    verdade... a gente ja fez isso antes
    (%rdi, %rax, 4) = um[i]

    Dicionário
    Reg     Var

    rdi     um
    rsi     outro
    edx     n
    ecx     i
    eax     resultado
 */

.text
.globl  map2
map2:

  pushq   %rbp
  movq    %rsp, %rbp
  subq    $32, %rsp

  movl    $0, %ecx    # int i = 0

LOOP:
  # for (i=0; i<n; i++)
  # traduzindo pra while i < n
  # i >= n
  cmpl    %edx, %ecx
  jge     fora_loop

  /* guarda os caller-saved */
  movq    %rdi, -8(%rbp)
  movq    %rsi, -16(%rbp)
  movl    %edx, -20(%rbp)
  movl    %ecx, -24(%rbp)

  movl    (%rdi, %rcx, 4), %eax   # eax = um[i]
  movl    %eax, %edi              # edi = um[i]
  call f    # chamei a funcao e agora eax = f(um[i]);

  /* restaura os caller-saved */
  movq    -8(%rbp), %rdi
  movq    -16(%rbp), %rsi
  movl    -20(%rbp), %edx
  movl    -24(%rbp), %ecx

  movl %eax, (%rsi, %rcx, 4)   # outro[i] = eax

  addl    $1, %ecx
  jmp     LOOP

fora_loop:
  leave
  ret

