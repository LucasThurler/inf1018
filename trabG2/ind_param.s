# simula um parametro IND: le o valor corrente de uma variavel
# cujo endereco esta em %rax, e passa para %edi
.text
.globl ind_param
ind_param:
    pushq   %rbp
    movq    %rsp, %rbp

    movq    $0x1122334455667788, %rax   # endereco da variavel (ficticio)
    movl    (%rax), %edi                # le o valor corrente da variavel -> %edi

    movq    $0x1122334455667788, %rax   # endereco de f (ficticio)
    call    *%rax

    leave
    ret
