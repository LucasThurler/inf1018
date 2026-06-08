.text
.globl ind_param2
ind_param2:
    pushq   %rbp
    movq    %rsp, %rbp

    movq    $0x1122334455667788, %rax
    movl    (%rax), %edi                # 1o parametro IND

    movq    $0x1122334455667788, %rax
    movl    (%rax), %esi                # 2o parametro IND

    movq    $0x1122334455667788, %rax
    movl    (%rax), %edx                # 3o parametro IND

    movq    $0x1122334455667788, %rax
    call    *%rax

    leave
    ret
