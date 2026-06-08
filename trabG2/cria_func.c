#include <string.h>
#include "cria_func.h"

void cria_func(void* f, DescParam params[], int n, unsigned char codigo[]) {
    int i = 0;

    /* prologo */
    codigo[i++] = 0x55;        /* push %rbp      */
    codigo[i++] = 0x48;        /* mov %rsp, %rbp */
    codigo[i++] = 0x89;
    codigo[i++] = 0xe5;

    /* registradores de argumento em ordem: edi, esi, edx */
    unsigned char regs_int[] = {0xbf, 0xbe, 0xba};  /* mov $x, %edi/esi/edx */

    for (int p = 0; p < n; p++) {
        if (params[p].orig_val == FIX) {
            /* mov $constante, %edi/%esi/%edx */
            codigo[i++] = regs_int[p];
            memcpy(&codigo[i], &params[p].valor.v_int, 4);
            i += 4;
        }
        /* PARAM: argumento ja esta no registrador certo, nao faz nada */
    }

    /* carrega endereco de f em %rax via movabs */
    codigo[i++] = 0x48;        /* movabs $f, %rax */
    codigo[i++] = 0xb8;
    memcpy(&codigo[i], &f, 8);
    i += 8;

    /* call indireto */
    codigo[i++] = 0xff;        /* call *%rax */
    codigo[i++] = 0xd0;

    /* epilogo */
    codigo[i++] = 0xc9;        /* leave */
    codigo[i++] = 0xc3;        /* ret   */
}
