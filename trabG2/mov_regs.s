.text
.globl mov_regs
mov_regs:
    pushq   %rbp
    movq    %rsp, %rbp

    # movs entre registradores de argumento (64 bits)
    movq    %rdi, %rsi    # 1o param -> 2o
    movq    %rdi, %rdx    # 1o param -> 3o
    movq    %rsi, %rdi    # 2o param -> 1o
    movq    %rsi, %rdx    # 2o param -> 3o
    movq    %rdx, %rdi    # 3o param -> 1o
    movq    %rdx, %rsi    # 3o param -> 2o

    # movs entre registradores de argumento (32 bits)
    movl    %edi, %esi    # 1o param -> 2o
    movl    %edi, %edx    # 1o param -> 3o
    movl    %esi, %edi    # 2o param -> 1o
    movl    %esi, %edx    # 2o param -> 3o
    movl    %edx, %edi    # 3o param -> 1o
    movl    %edx, %esi    # 3o param -> 2o

    leave
    ret
