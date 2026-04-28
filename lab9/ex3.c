#include <stdio.h>

void foo (int a[], int n);

int main(void) {
    int a[] = {1,2,3,4,5};

    foo(a, 5);  // só chama

    // imprime o array modificado
    for (int i = 0; i < 5; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");

    return 0;
}