.data
Sf: .string "%d\n"  /* string de formatação para printf */

.extern dados

.text
.globl  main
main:

    /**********************************************************/
    /* mantenha este trecho aqui - prologo !!! */
    pushq % rbp
    movq % rsp , % rbp
    subq $16 , % rsp
    movq % rbx , -8(% rbp )
    movq % r12 , -16(% rbp )
    /**********************************************************/

    movq $dados, %rbx    /* rbx = &dados endereço da base do array */
    

    /**********************************************************/
    /* seu codigo aqui */
    /**********************************************************/


    /**********************************************************/
    /* mantenha este trecho aqui - finalizacao !!!! */
    movq $0 , % rax // rax = 0 ( valor de retorno )
    movq -8(% rbp ) , % rbx
    movq -16(% rbp ) , % r12
    leave
    ret
    /**********************************************************/
