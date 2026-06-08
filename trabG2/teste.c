#include <stdio.h>
#include <string.h>
#include "cria_func.h"

typedef int (*func_ptr_0)(void);
typedef int (*func_ptr_1)(int);
typedef int (*func_ptr_2)(int, int);
typedef int (*func_ptr_3)(int, int, int);
typedef int (*func_ptr_ptr1)(void*, size_t);

int soma_um(int x) { return x + 1; }
int mult(int x, int y) { return x * y; }
int soma3(int x, int y, int z) { return x + y + z; }

int main(void) {
    DescParam params[3];
    unsigned char codigo[500];

    /* --- Teste 1: PARAM --- */
    func_ptr_1 f1;
    params[0].tipo_val = INT_PAR; params[0].orig_val = PARAM;
    cria_func(soma_um, params, 1, codigo);
    f1 = (func_ptr_1) codigo;
    printf("=== Teste 1: PARAM ===\n");
    printf("soma_um(4)  esperado 5,  obtido %d\n", f1(4));
    printf("soma_um(10) esperado 11, obtido %d\n", f1(10));
    printf("soma_um(0)  esperado 1,  obtido %d\n", f1(0));

    /* --- Teste 2: PARAM + FIX --- */
    func_ptr_1 f2;
    params[0].tipo_val = INT_PAR; params[0].orig_val = PARAM;
    params[1].tipo_val = INT_PAR; params[1].orig_val = FIX;
    params[1].valor.v_int = 10;
    cria_func(mult, params, 2, codigo);
    f2 = (func_ptr_1) codigo;
    printf("\n=== Teste 2: PARAM + FIX ===\n");
    printf("mult(3,10) esperado 30, obtido %d\n", f2(3));
    printf("mult(7,10) esperado 70, obtido %d\n", f2(7));

    /* --- Teste 3: FIX + FIX --- */
    func_ptr_0 f3;
    params[0].tipo_val = INT_PAR; params[0].orig_val = FIX; params[0].valor.v_int = 6;
    params[1].tipo_val = INT_PAR; params[1].orig_val = FIX; params[1].valor.v_int = 7;
    cria_func(mult, params, 2, codigo);
    f3 = (func_ptr_0) codigo;
    printf("\n=== Teste 3: FIX + FIX ===\n");
    printf("mult(6,7) esperado 42, obtido %d\n", f3());

    /* --- Teste 4: IND + FIX --- */
    func_ptr_0 f4;
    int var = 5;
    params[0].tipo_val = INT_PAR; params[0].orig_val = IND; params[0].valor.v_ptr = &var;
    params[1].tipo_val = INT_PAR; params[1].orig_val = FIX; params[1].valor.v_int = 3;
    cria_func(mult, params, 2, codigo);
    f4 = (func_ptr_0) codigo;
    printf("\n=== Teste 4: IND + FIX ===\n");
    var = 5; printf("var=5: mult(5,3) esperado 15, obtido %d\n", f4());
    var = 8; printf("var=8: mult(8,3) esperado 24, obtido %d\n", f4());

    /* --- Teste 5: IND + IND --- */
    func_ptr_0 f5;
    int a = 4, b = 9;
    params[0].tipo_val = INT_PAR; params[0].orig_val = IND; params[0].valor.v_ptr = &a;
    params[1].tipo_val = INT_PAR; params[1].orig_val = IND; params[1].valor.v_ptr = &b;
    cria_func(mult, params, 2, codigo);
    f5 = (func_ptr_0) codigo;
    printf("\n=== Teste 5: IND + IND ===\n");
    a = 4; b = 9; printf("a=4,b=9: mult(4,9) esperado 36, obtido %d\n", f5());
    a = 3; b = 7; printf("a=3,b=7: mult(3,7) esperado 21, obtido %d\n", f5());

    /* --- Teste 6: PTR_PAR FIX + PARAM + PARAM (memcmp) --- */
    func_ptr_ptr1 f6;
    char fixa[] = "quero saber se a outra string e um prefixo dessa";
    params[0].tipo_val = PTR_PAR; params[0].orig_val = FIX; params[0].valor.v_ptr = fixa;
    params[1].tipo_val = PTR_PAR; params[1].orig_val = PARAM;
    params[2].tipo_val = INT_PAR; params[2].orig_val = PARAM;
    cria_func(memcmp, params, 3, codigo);
    f6 = (func_ptr_ptr1) codigo;
    printf("\n=== Teste 6: PTR_PAR FIX + PARAM + PARAM (memcmp) ===\n");
    char s1[] = "quero saber";
    char s2[] = "outro texto";
    printf("'%s' prefixo de 11? %s\n", s1, f6(s1, 11) == 0 ? "SIM" : "NAO");
    printf("'%s' prefixo de 11? %s\n", s2, f6(s2, 11) == 0 ? "SIM" : "NAO");

    /* --- Teste 7: 3 PARAMs --- */
    func_ptr_3 f7;
    params[0].tipo_val = INT_PAR; params[0].orig_val = PARAM;
    params[1].tipo_val = INT_PAR; params[1].orig_val = PARAM;
    params[2].tipo_val = INT_PAR; params[2].orig_val = PARAM;
    cria_func(soma3, params, 3, codigo);
    f7 = (func_ptr_3) codigo;
    printf("\n=== Teste 7: 3 PARAMs ===\n");
    printf("soma3(1,2,3) esperado 6,  obtido %d\n", f7(1, 2, 3));
    printf("soma3(4,5,6) esperado 15, obtido %d\n", f7(4, 5, 6));

    /* --- Teste 8: PARAM + FIX(100) + PARAM --- */
    func_ptr_2 f8;
    params[0].tipo_val = INT_PAR; params[0].orig_val = PARAM;
    params[1].tipo_val = INT_PAR; params[1].orig_val = FIX; params[1].valor.v_int = 100;
    params[2].tipo_val = INT_PAR; params[2].orig_val = PARAM;
    cria_func(soma3, params, 3, codigo);
    f8 = (func_ptr_2) codigo;
    printf("\n=== Teste 8: PARAM + FIX(100) + PARAM ===\n");
    printf("soma3(1,100,2) esperado 103, obtido %d\n", f8(1, 2));
    printf("soma3(3,100,4) esperado 107, obtido %d\n", f8(3, 4));

    /* --- Teste 9: FIX(50) + PARAM + PARAM --- */
    func_ptr_2 f9;
    params[0].tipo_val = INT_PAR; params[0].orig_val = FIX; params[0].valor.v_int = 50;
    params[1].tipo_val = INT_PAR; params[1].orig_val = PARAM;
    params[2].tipo_val = INT_PAR; params[2].orig_val = PARAM;
    cria_func(soma3, params, 3, codigo);
    f9 = (func_ptr_2) codigo;
    printf("\n=== Teste 9: FIX(50) + PARAM + PARAM ===\n");
    printf("soma3(50,1,2) esperado 53, obtido %d\n", f9(1, 2));
    printf("soma3(50,3,4) esperado 57, obtido %d\n", f9(3, 4));

    /* --- Teste 10: PTR_PAR IND + PARAM + PARAM (memcmp) --- */
    func_ptr_ptr1 f10;
    char str_a[] = "hello world";
    char str_b[] = "hello there";
    char *ptr_str = str_a;
    params[0].tipo_val = PTR_PAR; params[0].orig_val = IND; params[0].valor.v_ptr = &ptr_str;
    params[1].tipo_val = PTR_PAR; params[1].orig_val = PARAM;
    params[2].tipo_val = INT_PAR; params[2].orig_val = PARAM;
    cria_func(memcmp, params, 3, codigo);
    f10 = (func_ptr_ptr1) codigo;
    printf("\n=== Teste 10: PTR_PAR IND + PARAM + PARAM (memcmp) ===\n");
    ptr_str = str_a;
    printf("ptr=str_a: memcmp(str_a,str_b,5)  esperado 0,   obtido %d\n", f10(str_b, 5));
    ptr_str = str_b;
    printf("ptr=str_b: memcmp(str_b,str_b,5)  esperado 0,   obtido %d\n", f10(str_b, 5));
    ptr_str = str_a;
    printf("ptr=str_a: memcmp(str_a,str_b,11) esperado !=0, obtido %d\n", f10(str_b, 11));

    return 0;
}

