#include <stdio.h>
#define N 4096

int main(int argc, char *argv[])
{
    double X[N], Y[N], Z[N], alpha;
    alpha = 2.0; 
    for (int i = 0; i < N; ++i){
        X[i] = i;
        Y[i] = i;
    }

    for (int i = 0; i < N; ++i){
        Z[i] = alpha * X[i] + Y[i];
    }


    for (int i = 0; i < N; ++i){
        printf("%f\n", Z[i]);
    }

    return 0;
}
