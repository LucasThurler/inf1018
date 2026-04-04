#include <stdio.h>

// escrever um programa que imprima os quadrados dos numeros de 1 a 10
// nao podemos utilizar um array de inteiros globais!
// o exercicio pede para utilizar uma variável local inteira para obter os
// valores dos numeros de 1 a 10

int main() {
    int i; 
    //vamo usar while pq eu vou ter q converter essa budega pra assembly depois
    while (i <= 10) {
        printf("%d\n", i * i);
        i++;
    }
    return 0;
}