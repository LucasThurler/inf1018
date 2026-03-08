#include <ctype.h>
#include <stdio.h>

//modificando a funcao para aceitar bases maiores que 10,
//usando letras para representar os digitos maiores que 9
int string2num (char *s, int base) {
  int a = 0;
  int digit;

  for (; *s; s++){
    if (isdigit(*s)) {
            digit = *s - '0';
        } else {
            digit = tolower(*s) - 'a' + 10;
        }
        a = a * base + digit;
    }
  return a;
}

int main (void) {
    printf("%d\n", string2num("1a", 16));
    printf("%d\n", string2num("a09b", 16));
    printf("%d\n", string2num("z09b", 36));
    return 0;
}

//A função foi modificada para aceitar bases maiores que 10 usando as letras a-z 
// como dígitos extras. Assim, a representa 10, b representa 11, ..., e 
// z representa 35. Portanto, a maior base possível com esse esquema é a base 36.