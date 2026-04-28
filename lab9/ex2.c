#include <stdio.h>

int fat (int n);

int main(void) {
    int n;
    int result;

    n = 5;
    result = fat(n);
    printf("fat(%d) = %d\n", n, result);

    return 0;
}