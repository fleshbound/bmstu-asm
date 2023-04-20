#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define N 100

void _my_strcpy(const size_t len, const char *src, const char *dst);

size_t asm_strlen(const char *string)
{
    size_t len = 0;

    __asm__ (
        ".intel_syntax noprefix\n\t"
        "mov %%ecx, -1\n\t"
        "lea %%edi, [%1]\n\t"
        "xor %%al, %%al\n\t"
        "repne scasb\n\t"
        "not %%ecx\n\t"
        "dec %%ecx\n\t"
        "mov %0, %%ecx\n\t"
        : "=r" (len)
        : "r" (string)
        : "%edi", "%ecx", "%al"
    );

    return len;
}

void print_result(const char *msg, const char *orig, const char *copy)
{
    printf("%s", msg);
    printf("SRC ADDR  : %p\nDEST ADDR : %p\n", orig, copy);
}

void proc_task2(const char *str)
{
    printf("\nTASK 2\n");

    size_t len = asm_strlen(str);

    char before[N] = "_______________________________________", 
         *middle = before + 2, *after = middle + 2;

    printf("\nARRAY ADDR: %p\n", before);
    printf("CURR ARRAY: '%s'\n", before);

    _my_strcpy(len, before, before);
    print_result("\n", before, before);
    printf("CURR ARRAY: '%s'\n", before);

    _my_strcpy(len, str, middle);
    print_result("\n", str, middle);
    printf("CURR ARRAY: '%s'\n", before);
    
    _my_strcpy(len, middle, before);
    print_result("\n", middle, before);
    printf("CURR ARRAY: '%s'\n", before);

    _my_strcpy(len, before, after);
    print_result("\n", before, after);
    printf("CURR ARRAY: '%s'\n", before);
}

void proc_task1(const char *str)
{
    printf("\nTASK 1\n");
    printf("C LENGTH  : %zu\n", strlen(str));
    printf("ASM LENGTH: %zu\n", asm_strlen(str));
}

int main(void)
{
    setbuf(stdout, NULL);

    char str[] = "abcdefghijklmnopqrstuvwxyz";
    printf("STR ADDR  : %p\nCURR STR  : '%s'\n", str, str);

    proc_task1(str);
    proc_task2(str);

    return EXIT_SUCCESS;
}
