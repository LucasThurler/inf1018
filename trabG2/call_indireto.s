# chama a funcao cujo endereco esta em %rdi, passando %esi como argumento
# simula o que o wrapper fara: call *%rax
.text
.globl wrapper
wrapper:
    pushq   %rbp
    movq    %rsp, %rbp

    movq    %rdi, %rax    # endereco de f vai para %rax
    movl    %esi, %edi    # 1o argumento real vai para %edi
    call    *%rax         # call indireto

    leave
    ret
