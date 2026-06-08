/* Lucas Thurler Gonçalves 221224 3WA */

#include <string.h>
#include "cria_func.h"

void cria_func(void* f, DescParam params[], int n, unsigned char codigo[]) {
    int i = 0;

    /* tabela de mov reg->reg 64 bits (PTR_PAR)
     * mov_ptr[origem][destino] = bytes
     * registradores: 0=%rdi, 1=%rsi, 2=%rdx */
    unsigned char mov_ptr[3][3][3] = {
        /* de %rdi: */
        {{0,0,0}, {0x48,0x89,0xfe}, {0x48,0x89,0xfa}},
        /* de %rsi: */
        {{0x48,0x89,0xf7}, {0,0,0}, {0x48,0x89,0xf2}},
        /* de %rdx: */
        {{0x48,0x89,0xd7}, {0x48,0x89,0xd6}, {0,0,0}}
    };

    /* tabela de mov reg->reg 32 bits (INT_PAR)
     * registradores: 0=%edi, 1=%esi, 2=%edx */
    unsigned char mov_int[3][3][2] = {
        /* de %edi: */
        {{0,0}, {0x89,0xfe}, {0x89,0xfa}},
        /* de %esi: */
        {{0x89,0xf7}, {0,0}, {0x89,0xf2}},
        /* de %edx: */
        {{0x89,0xd7}, {0x89,0xd6}, {0,0}}
    };

    /* prologo */
    codigo[i++] = 0x55;        /* push %rbp      */
    codigo[i++] = 0x48;        /* mov %rsp, %rbp */
    codigo[i++] = 0x89;
    codigo[i++] = 0xe5;

    /* --- passo 1: reposicionar PARAMs de tras para frente ---
     * PARAMs chegam em %rdi, %rsi, %rdx (posicoes 0, 1, 2)
     * mas podem precisar ir para posicoes diferentes em f
     * ex: params[0]=FIX, params[1]=PARAM -> o PARAM chegou
     * em %rdi mas precisa ir para %rsi
     * solucao: percorrer de tras para frente para nao perder valores */
    for (int p = n - 1; p >= 0; p--) {
        if (params[p].orig_val == PARAM) {
            /* conta quantos PARAMs existem antes de p */
            int param_pos = 0;
            for (int k = 0; k < p; k++)
                if (params[k].orig_val == PARAM)
                    param_pos++;

            /* param_pos = registrador onde chegou
             * p          = registrador onde f espera */
            if (param_pos != p) {
                if (params[p].tipo_val == PTR_PAR) {
                    codigo[i++] = mov_ptr[param_pos][p][0];
                    codigo[i++] = mov_ptr[param_pos][p][1];
                    codigo[i++] = mov_ptr[param_pos][p][2];
                } else {
                    codigo[i++] = mov_int[param_pos][p][0];
                    codigo[i++] = mov_int[param_pos][p][1];
                }
            }
        }
    }

    /* --- passo 2: emitir FIX e IND --- */
    for (int p = 0; p < n; p++) {

        if (params[p].orig_val == FIX) {

            if (params[p].tipo_val == INT_PAR) {
                /* mov $constante, %edi/%esi/%edx */
                unsigned char op[] = {0xbf, 0xbe, 0xba};
                codigo[i++] = op[p];
                memcpy(&codigo[i], &params[p].valor.v_int, 4);
                i += 4;

            } else { /* PTR_PAR */
                /* movabs $ponteiro, %rdi/%rsi/%rdx */
                unsigned char op[] = {0xbf, 0xbe, 0xba};
                codigo[i++] = 0x48;
                codigo[i++] = op[p];
                memcpy(&codigo[i], &params[p].valor.v_ptr, 8);
                i += 8;
            }

        } else if (params[p].orig_val == IND) {

            /* movabs $endereco_var, %rax */
            codigo[i++] = 0x48;
            codigo[i++] = 0xb8;
            memcpy(&codigo[i], &params[p].valor.v_ptr, 8);
            i += 8;

            if (params[p].tipo_val == INT_PAR) {
                /* mov (%rax), %edi/%esi/%edx */
                unsigned char op[] = {0x38, 0x30, 0x10};
                codigo[i++] = 0x8b;
                codigo[i++] = op[p];
            } else { /* PTR_PAR */
                /* mov (%rax), %rdi/%rsi/%rdx */
                unsigned char op[] = {0x38, 0x30, 0x10};
                codigo[i++] = 0x48;
                codigo[i++] = 0x8b;
                codigo[i++] = op[p];
            }
        }
    }

    /* movabs $f, %rax */
    codigo[i++] = 0x48;
    codigo[i++] = 0xb8;
    memcpy(&codigo[i], &f, 8);
    i += 8;

    /* call *%rax */
    codigo[i++] = 0xff;
    codigo[i++] = 0xd0;

    /* epilogo */
    codigo[i++] = 0xc9;        /* leave */
    codigo[i++] = 0xc3;        /* ret   */
}

