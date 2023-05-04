#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <stdlib.h>
/* #include <xmmintrin.h> */

#define VECTOR_FUNC(name) float name(const float *a, const float *b, const size_t n)

typedef VECTOR_FUNC(vector_func_t);

VECTOR_FUNC(mul_vectors_asm)
{
    float res;

    __asm__ volatile(       
        "movq %1, %%rsi\n"
        "movq %2, %%rdi\n"
        "movq %3, %%rcx\n"
        "shrq $2, %%rcx\n"
        "addq $1, %%rcx\n"
        "xorps %%xmm7, %%xmm7\n"
        "calc:\n"
        "movaps (%%rdi), %%xmm0\n"
        "movaps (%%rsi), %%xmm1\n"
        "mulps %%xmm1, %%xmm0\n"
        "haddps %%xmm0, %%xmm0\n"
        "haddps %%xmm0, %%xmm0\n"
        "addss %%xmm0, %%xmm7\n"
        "addq $16, %%rsi\n"
        "addq $16, %%rdi\n"
        "loop calc\n"
        "movss %%xmm7, %0\n"
        : "=m" (res)
        : "g" (a), "g" (b), "g" (n)
        : "xmm0", "xmm1", "xmm7"
    );

    return res;
}

VECTOR_FUNC(mul_vectors)
{
    float res = 0;

    for (size_t i = 0; i < n; i++)
        res += *a++ * *b++;

    return res;
}

float *create_array(const size_t n)
{
    float *arr = malloc(n * sizeof(float));

    if (!arr)
    {
        perror("allocate");
        exit(1);
    }

    for (size_t i = 0; i < n; i++)
        arr[i] = rand();

    return arr;
}

void show_time_result(const char *name, const size_t iter, vector_func_t *f) {
    size_t size = 1024;

    float *a = create_array(size);
    float *b = create_array(size);

    float sum = 0;
    clock_t start = clock();
    
    for (size_t i = 0; i < iter; i++)
        sum += f(a, b, size);

    clock_t end = clock() - start;
    printf("%-10s: %10lu us\n", name, ((unsigned long) end * 1000000) / CLOCKS_PER_SEC);

    free(a);
    free(b);
}

int main(void)
{
    float a[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    float b[] = { 1, 1, 1, 1, 1, 1, 1, 1, 1 };

    printf("%f\n%f\n", mul_vectors(a, b, 9), mul_vectors_asm(a, b, 9));

    size_t iter = 1e6;
    show_time_result("C", iter, mul_vectors);
    show_time_result("ASM", iter, mul_vectors_asm);

    return 0;
}
