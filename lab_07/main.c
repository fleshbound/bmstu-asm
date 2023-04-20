#include <stdio.h>
#include <string.h>

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
    printf("Current test string: '%s'\n", test_str);
    printf("Actual string length: %zu\n", strlen(test_str));
    printf("ASM string length: %d\n", asm_strlen(test_str));

}
