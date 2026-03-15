// a) implementar em C a operacao switch_byte que troca as duas
// "metades" de um byte. Por exemplo, se sua funcao receber
// como parametro o valor 0xAB, ela deve retornar o valor 0xBA.

#include <stdio.h>

unsigned char switch_byte(unsigned char x) {
    return (x >> 4) | (x << 4);
    // o operador >> desloca os bits de x para a direita,
    // o operador << desloca os bits de x para a esquerda,
    // o operador | faz a operacao OR bit a bit 
    // entre os dois resultados, juntando os bits resultantes
}

unsigned char rotate_left(unsigned char x, int n) {
    return (x << n) | (x >> (8 - n));
}

//Assim como um "left shift" (<<), 
// ela desloca seu operando "n" bits para a esquerda. 
// Porém, ao invés de preencher as posições livres à direita 
// com zeros, ela as preenche com os "n" bits removidos 
// pelo deslocamento.
//Considere, por exemplo, o valor 0x61 (0110 0001).

// um "rotate left" de 1 bit resulta no valor 0xc2 (1100 0010)
// um "rotate left" de 2 bits resulta no valor 0x85 (1000 0101)
// um "rotate left" de 7 bits resulta no valor 0xb0 (1011 0000)
// Incorpore à sua função main testes para a função rotate_left, 
// experimentando alguns valores diferentes para o deslocamento.

// Obs: você pode assumir que o valor do deslocamento será 
// sempre um valor inteiro maior que 0 e menor que 8.

int main() {
    unsigned char x = 0xab;
    unsigned char y = switch_byte(x);
    printf("%02x\n", y);

    x = 0x61;
    y = rotate_left(x, 1);
    printf("%02x\n", y);
    y = rotate_left(x, 2);
    printf("%02x\n", y);
    y = rotate_left(x, 7);
    printf("%02x\n", y);
    y = rotate_left(x, 0);
    printf("%02x\n", y);
    y = rotate_left(x, 8);
    printf("%02x\n", y);
    // faz sentido devolver 61 nesses dois ultimos pois
    // o deslocamento é 0 ou 8, ou seja, o byte é rotacionado
    // 0 ou 8 vezes, o que resulta no mesmo byte inicial

    return 0;
}