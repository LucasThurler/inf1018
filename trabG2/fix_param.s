# simula um parametro FIX: passa a constante 10 em %edi antes de chamar f
.text
.globl fix_param
fix_param:
    pushq   %rbp
    movq    %rsp, %rbp

    movl    $10, %edi       # parametro fixo (constante) -> %edi

    movq    $0x1122334455667788, %rax   # endereco de f
    call    *%rax

    leave
    ret
