#include <stdio.h>
#include "cria_func.h"

typedef int (*func_ptr_1)(int);
typedef int (*func_ptr_0)(void);

int soma_um(int x) {
    return x + 1;
}

int mult(int x, int y) {
    return x * y;
}

int main(void) {
    DescParam params[2];
    unsigned char codigo[500];

    /* --- Teste 1: 1 parametro PARAM --- */
    func_ptr_1 f1;
    params[0].tipo_val = INT_PAR;
    params[0].orig_val = PARAM;

    cria_func(soma_um, params, 1, codigo);
    f1 = (func_ptr_1) codigo;

    printf("=== Teste 1: PARAM ===\n");
    printf("soma_um(4)  esperado 5,  obtido %d\n", f1(4));
    printf("soma_um(10) esperado 11, obtido %d\n", f1(10));
    printf("soma_um(0)  esperado 1,  obtido %d\n", f1(0));

    /* --- Teste 2: 1 parametro FIX (mult com y=10 fixo) --- */
    func_ptr_1 f2;
    params[0].tipo_val = INT_PAR;
    params[0].orig_val = PARAM;
    params[1].tipo_val = INT_PAR;
    params[1].orig_val = FIX;
    params[1].valor.v_int = 10;

    cria_func(mult, params, 2, codigo);
    f2 = (func_ptr_1) codigo;

    printf("\n=== Teste 2: PARAM + FIX ===\n");
    printf("mult(3, 10)  esperado 30, obtido %d\n", f2(3));
    printf("mult(7, 10)  esperado 70, obtido %d\n", f2(7));
    printf("mult(1, 10)  esperado 10, obtido %d\n", f2(1));

    /* --- Teste 3: ambos FIX --- */
    func_ptr_0 f3;
    params[0].tipo_val = INT_PAR;
    params[0].orig_val = FIX;
    params[0].valor.v_int = 6;
    params[1].tipo_val = INT_PAR;
    params[1].orig_val = FIX;
    params[1].valor.v_int = 7;

    cria_func(mult, params, 2, codigo);
    f3 = (func_ptr_0) codigo;

    printf("\n=== Teste 3: FIX + FIX ===\n");
    printf("mult(6, 7)  esperado 42, obtido %d\n", f3());

    return 0;
}
