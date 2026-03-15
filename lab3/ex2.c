// A função deve retornar 0 se o número de bits '1' for par, 
// e um valor diferente de 0 se o número de bits '1' for ímpar.

// Atenção: sua função NÃO PODE usar o operador % para testar 
// se um número é par ou ímpar!

// Teste sua função odd_ones com diferentes valores de entrada, 
// não esquecendo de verificar se os resultados obtidos estão 
// corretos! Por exemplo, 
// teste os valores 0x01010101 (número par de bits 1) e 
// 0x01030101 (número ímpar de bits 1):

#include <stdio.h>

int odd_ones(unsigned int x) {
  int count = 0;
  while (x) {
    // se o bit menos significativo de x for 1
    count += x & 1; // incremmenta o count com + 1
    x >>= 1; // desloca x pra direita
  }
    return count & 1; // retorna 1 se count for impar, 
    // 0 se for par
}
int main() {
  printf("%x tem numero %s de bits\n",0x01010101,odd_ones(0x01010101) ? "impar":"par");
  printf("%x tem numero %s de bits\n",0x01030101,odd_ones(0x01030101) ? "impar":"par");
  // testando com outros valores
  printf("%x tem numero %s de bits\n",0x00000000,odd_ones(0x00000000) ? "impar":"par");
  printf("%x tem numero %s de bits\n",0xffffffff,odd_ones(0xffffffff) ? "impar":"par");
  // cada f tem 4 bits 1, entao 8*4 = 32 bits 1, que é par
  return 0;
}