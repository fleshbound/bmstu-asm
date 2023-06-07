#include <stdio.h>

void print_array(int *const arr, const size_t len)
{
    for (size_t i = 0; i < len; i++)
        printf("%d%s", arr[i], (i == len - 1) ? "\n" : " ");
}

long scalar_mult(int *a1, int *a2, long length)
{
	long result = 0;
	int tmp;
	
	__asm volatile(
	    "eor x1, x1, x1\n"
	    "eor x2, x2, x2\n"
    	"mov x3, #4\n"
	
    "l1_start:\n"
	    "cmp x2, %3\n"
    	"bgt l1_end\n"

        "mov x0, %1\n"
        "mul x4, x2, x3\n"
        "add x0, x0, x4\n"
        "ld1 {v0.4s}, [x0]\n"
        
        "mov x0, %2\n"
        "mul x4, x2, x3\n"
        "add x0, x0, x4\n"
        "ld1 {v1.4s}, [x0]\n"
        
        "mul v2.4s, v1.4s, v0.4s\n"
        "addv s3, v2.4s\n"
        "st1 {v3.s}[0], [%4]\n"
        "ldr x0, [%4]\n" 
        
        "add x1, x1, x0\n"
        "add x2, x2, #4\n"	
        "b l1_start\n"
        
    "l1_end:\n"	
        "mov x0, %3\n"
        "add x0, x0, #4\n"
        
	"l2_start:\n"
        "cmp x2, x0\n"
        "bge l2_end\n"
        
        "mov x5, %1\n"
        "mul x4, x2, x3\n"
        "add x5, x5, x4\n"
        "ldr w6, [x5]\n"
        
        "mov x5, %2\n"
        "mul x4, x2, x3\n"
        "add x5, x5, x4\n"
        "ldr w7, [x5]\n"
        
        "mul w6, w6, w7\n"
        "add x1, x1, x6\n"
        "add x2, x2, #1\n"
        "b l2_start\n"	
        
    "l2_end:\n"
        "mov %0, x1\n"
	: "=r"(result)
	: "r"(a1), "r"(a2), "r"(length - 4), "r"(&tmp) 
	: "x0", "x1", "x2", "x4", "x3", "x5", "x6", "w0", "w6", "w7", "v0", "v1", "v2", "s3"
	);

	return result;
}

long mystrlen(char *str)
{
    long result;
    __asm(
        "mov x0, %1\n"
        "eor x2, x2, x2\n"
        
    "start:\n"
        "ldr x1, [x0]\n"
        "lsl x1, x1, #56\n"
        "cmp x1, #0\n"
        "beq end\n"
        "add x2, x2, 1\n"
        "add x0, x0, 1\n"
        "b start\n"

    "end:\n"
        "mov %0, x2\n"
        : "=r"(result)
        : "r"(str)
        : "x0", "x1", "x2"
    );
    return result;
}

int main()
{
	char b[] = "Primite labu pzh";
	printf("string: \"%s\"\nmystrlen: %ld\n", b, mystrlen(b));
	
	int arr1[] = { 1, 1, 1, 1, 1 };
	int arr2[] = { 1, 5, 1, 1, 1 };

    printf("\narr1: ");
    print_array(arr1, sizeof(arr1) / sizeof(int));
    printf("arr2: ");
    print_array(arr2, sizeof(arr2) / sizeof(int));
    printf("scalar mult: %ld\n", scalar_mult(arr1, arr2, sizeof(arr1) / sizeof(int)));
}
