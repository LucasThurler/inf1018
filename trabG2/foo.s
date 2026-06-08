# int foo(int x) { return x; }
.text
.globl foo
foo:
    pushq   %rbp
    movq    %rsp, %rbp

    # return x  (x chegou em %edi, valor de retorno vai em %eax)
    movl    %edi, %eax

    leave
    ret
