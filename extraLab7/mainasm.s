.data
Sf: .string "%d\n"  /* string de formatação para printf */

.extern dados

.text
.globl  main
main:

/**********************************************************/
/* mantenha este trecho aqui - prologo !!! */
pushq %rbp
movq %rsp , %rbp
subq $16 , %rsp
movq %rbx , -8(%rbp )
movq %r12 , -16(%rbp )
/**********************************************************/

movl $0,     %ebx   /* ebx = int max = 0 */
leaq dados(%rip), %r12   /* r12 = &dados endereço da base do array */
movl $0,     %ecx   /* ecx = int i = 0 */

LOOP:

    cmpl $3, %ecx
    jge fora_loop   /* se ecx >= 3 -> break while */

    /* if p->cc (se apontar pra 0) */
    movzbl  (%r12), %eax    /* eax = p->cc zero extend pq tá no offset 0 */
    # cc é char dentro da struct por a conversao zbl
    cmpl    $0,     %eax
    je  continua

    /* p->ci > max */
    movl  4(%r12), %eax     /* eax = p-ci 4 extend */
    cmpl  %ebx,    %eax     /* eax <= max */
    jle continua

    movl  %eax,    %ebx     /* ebx = max = p->ci */

continua:

    addl $1, %ecx   /* i++ */
    addq $8, %r12   /* p++ */ 
    jmp  LOOP

fora_loop:

    leaq Sf(%rip), %rdi /* endereço da string "%d\n" (PIE-safe) */
    movl %ebx, %esi     /* max */
    movl $0, %eax       /* obrigatório p/ printf */
    call printf

/**********************************************************/
/* mantenha este trecho aqui - finalizacao !!!! */
movq $0 , %rax # rax = 0 ( valor de retorno )
movq -8(%rbp ) , %rbx
movq -16(%rbp ) , %r12
leave
ret
/**********************************************************/
