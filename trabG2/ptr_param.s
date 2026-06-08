# simula parametros PTR_PAR para os 3 casos: PARAM, FIX e IND
.text
.globl ptr_param
ptr_param:
    pushq   %rbp
    movq    %rsp, %rbp

    # PTR_PAR + FIX: move endereco fixo (64 bits) para %rdi
    movq    $0x1122334455667788, %rdi

    # PTR_PAR + FIX: move endereco fixo (64 bits) para %rsi
    movq    $0x1122334455667788, %rsi

    # PTR_PAR + FIX: move endereco fixo (64 bits) para %rdx
    movq    $0x1122334455667788, %rdx

    # PTR_PAR + IND: carrega ponteiro em %rax, le endereco -> %rdi
    movq    $0x1122334455667788, %rax
    movq    (%rax), %rdi

    # PTR_PAR + IND: carrega ponteiro em %rax, le endereco -> %rsi
    movq    $0x1122334455667788, %rax
    movq    (%rax), %rsi

    # PTR_PAR + IND: carrega ponteiro em %rax, le endereco -> %rdx
    movq    $0x1122334455667788, %rax
    movq    (%rax), %rdx

    movq    $0x1122334455667788, %rax
    call    *%rax

    leave
    ret
