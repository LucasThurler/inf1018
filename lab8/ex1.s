.data
s1: .string "ls -ls"

.text
.extern system
.globl main
main:
    /* prologo */
    pushq %rbp
    movq  %rsp, %rbp
    subq $16, %rsp

    leaq    s1(%rip), %rdi
    call system

    # return 0
    movl    $0, %eax

    /* finalizacao */
    leave
    ret