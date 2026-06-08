# memcmp(fixa, candidata, n)
# params[0] = PTR_PAR FIX   -> %rdi = fixa  (fixo)
# params[1] = PTR_PAR PARAM -> %rsi = candidata (veio em %rdi da nova func)
# params[2] = INT_PAR PARAM -> %rdx = n (veio em %rsi da nova func)
# PROBLEMA: ao setar %rdi com FIX, perdemos o valor que veio em %rdi!
.text
.globl debug_memcmp
debug_memcmp:
    pushq   %rbp
    movq    %rsp, %rbp

    # PARAMs chegam em: %rdi=candidata, %rsi=n
    # precisamos reposicionar ANTES de aplicar FIX:
    movq    %rdi, %rsi    # candidata -> %rsi (2o arg de memcmp)
    movq    %rsi, %rdx    # n -> %rdx (3o arg de memcmp)  <- ERRADO! ja sobrescrevemos %rsi

    movq    $0x1122334455667788, %rdi   # fixa -> %rdi

    movq    $0x1122334455667788, %rax
    call    *%rax

    leave
    ret
