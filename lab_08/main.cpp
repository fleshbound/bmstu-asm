#include <cmath>
#include <ctime>
#include <iostream>

#define ITERATIONS 1005000

using namespace std;

void print_time(clock_t sum_time, const char *name)
{
    cout << endl << name;

    double t = ((double) sum_time) / CLOCKS_PER_SEC * 1000000LLU;
    
    /* cout << "\nSUM: " << t << "sec" << endl; */
    cout << "\naverage: " << t / ITERATIONS << " us" << endl;
}

template <typename T>
T add(T a, T b)
{
    T result = 0;
    clock_t start_time, sum_time = 0;

    for (int i = 0; i < ITERATIONS; i++)
    {
        start_time = clock();
        result = a + b;
        sum_time += clock() - start_time;
    }

    print_time(sum_time, "        SUM");
    return result;
}

template <typename T>
T mul(T a, T b)
{
    T result = 0;
    clock_t start_time, sum_time = 0;

    for (int i = 0; i < ITERATIONS; i++)
    {
        start_time = clock();
        result = a * b;
        sum_time += clock() - start_time;
    }

    print_time(sum_time, "        MUL");
    return result;
}

template <typename T>
T sub(T a, T b)
{
    T result = 0;
    clock_t start_time, sum_time = 0;

    for (int i = 0; i < ITERATIONS; i++)
    {
        start_time = clock();
        result = a - b;
        sum_time += clock() - start_time;
    }

    print_time(sum_time, "        SUB");
    return result;
}

template <typename T>
T div(T a, T b)
{
    T result = 0;
    clock_t start_time, sum_time = 0;

    for (int i = 0; i < ITERATIONS; i++)
    {
        start_time = clock();
        result = a / b;
        sum_time += clock() - start_time;
    }

    print_time(sum_time, "        DIV");
    return result;
}

#ifdef FPU
template <typename T>
T fpu_add(T a, T b)
{
    T result = 0;
    clock_t start_time, sum_time = 0;

    for (int i = 0; i < ITERATIONS; i++)
    {
        start_time = clock();
        
        __asm__ (
            "fld %1\n"
            "fld %2\n"
            "faddp\n"
            "fstp %0\n"
            : "=m" (result)
            : "m" (a), "m" (b)
        );

        sum_time += clock() - start_time;
    }

    print_time(sum_time, "      FPU ADD");
    return result;
}

template <typename T>
T fpu_sub(T a, T b)
{
    T result = 0;
    clock_t start_time, sum_time = 0;

    for (int i = 0; i < ITERATIONS; i++)
    {
        start_time = clock();
        
        __asm__ (
            "fld %1\n"
            "fld %2\n"
            "fsubp\n"
            "fstp %0\n"
            : "=m" (result)
            : "m" (a), "m" (b)
        );

        sum_time += clock() - start_time;
    }

    print_time(sum_time, "      FPU SUB");
    return result;
}

template <typename T>
T fpu_mul(T a, T b)
{
    T result = 0;
    clock_t start_time, sum_time = 0;

    for (int i = 0; i < ITERATIONS; i++)
    {
        start_time = clock();
        
        __asm__ (
            "fld %1\n"
            "fld %2\n"
            "fmulp\n"
            "fstp %0\n"
            : "=m" (result)
            : "m" (a), "m" (b)
        );

        sum_time += clock() - start_time;
    }

    print_time(sum_time, "      FPU MUL");
    return result;
}

template <typename T>
T fpu_div(T a, T b)
{
    T result = 0;
    clock_t start_time, sum_time = 0;

    for (int i = 0; i < ITERATIONS; i++)
    {
        start_time = clock();
        
        __asm__ (
            "fld %1\n"
            "fld %2\n"
            "fdivp\n"
            "fstp %0\n"
            : "=m" (result)
            : "m" (a), "m" (b)
        );

        sum_time += clock() - start_time;
    }

    print_time(sum_time, "      FPU DIV");
    return result;
}

#endif // FPU

template <typename T>
void show_time_result(T a, T b)
{
#ifdef FPU
    cout << "========FPU=========";
    fpu_add(a, b);
    fpu_sub(a, b);
    fpu_mul(a, b);
    fpu_div(a, b);
    cout << endl;
#else
    cout << "========CPP=========";
    add(a, b);
    sub(a, b);
    mul(a, b);
    div(a, b);
#endif // FPU
}

int main()
{
    float f1 = 13.37f, f2 = 14.37f;
    cout << "\n===FLOAT (32-BIT)===" << endl;
    show_time_result(f1, f2);

    double d1 = 12.34, d2 = 56.78;
    cout << "\n===DOUBLE (64-BIT)==" << endl;
    show_time_result(d1, d2);

    return 0;
}
