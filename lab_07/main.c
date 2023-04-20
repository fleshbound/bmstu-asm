#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define N 100

void my_strcpy(const int len, const char *test_str, const char *test_copy)
{
        
}

int asm_strlen(const char *string)
{
    int len = 0;

    __asm__ (
        ".intel_syntax noprefix\n\t"
        "mov ecx, -1\n\t"
        "lea rdi, [%1]\n\t"
        "xor al, al\n\t"
        "repne scasb\n\t"
        "not ecx\n\t"
        "dec ecx\n\t"
        "mov %0, ecx\n\t"
        : "=r" (len)
        : "r" (string)
        : "rdi", "ecx", "al"
    );

    return len;
}

int main(void)
{
    setbuf(stdout, NULL);

    char test_str[] = "Hi, I'm Test String.";
    printf("TASK 1\nCURRENT STRING: '%s'\n", test_str);
    printf("C LENGTH: %zu\n", strlen(test_str));
    
    int len = asm_strlen(test_str);
    printf("ASM LENGTH: %d\n", len);

    char test_copy[N];
    my_strcpy(len, test_str, test_copy);
    printf("TASK 2\nORIGINAL: '%s'\nCOPY: '%s'\n", test_str, test_copy);

    return EXIT_SUCCESS;
}
