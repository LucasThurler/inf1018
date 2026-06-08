.text
.globl testa_mov
testa_mov:
    pushq   %rbp
    movq    %rsp, %rbp

    movq    $0x1122334455667788, %rax   # endereco ficticio de 64 bits

    call    *%rax

    leave
    ret
