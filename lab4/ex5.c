#include <stdio.h>

void dump (void *p, int n) {
  unsigned char *p1 = p;
  while (n--) {
    printf("%d ", *p1);
    p1++;
  }
}

int main() {
    signed char sc = -1;
    unsigned int ui = sc;

    printf("valor de ui: %u -> na memória: ",ui);
    dump(&ui, sizeof(ui));

}