.data
nums: .int 3, -5, 7, 8, -2
s1:   .string "%d\n"

.text
.globl main
main:
/* prologo */
    pushq %rbp
    movq  %rsp, %rbp
    subq  $16, %rsp
    movq  %rbx, -8(%rbp)
    movq  %r12, -16(%rbp)
    
    movl  $0, %ebx            # i = 0
    movq  $nums, %r12         # p = nums

LOOP:
    cmpl  $5, %ebx
    jge   fim

    # chamando filtro(*p, LIM)
    movl  (%r12), %edi        # x = *p primeiro argumento
    movl  $1, %esi            # LIM = 1 segundo argumento
    call filtro

    # chamando printf("%d\n", resultado)
    movl  %eax, %esi          # *p = eax = retorno da funcao filtro
    movq  $s1, %rdi           # primeiro argumento = format string
    call  printf

    addl  $1, %ebx        # i++
    addq  $4, %r12        # p++   (int = 4 bytes)
    jmp   LOOP


fim:
/* finalizacao */
    movq -8(%rbp), %rbx
    movq -16(%rbp), %r12
    movl $0, %eax         # return 0 da main()
    leave
    ret