#define _USE_MATH_DEFINES

#include <cmath>
#include <iostream>

using namespace std;

double fpu_sin_pi()
{
    double result = 0.;

    __asm__ (
        "fldpi\n"
        "fsin\n"
        "fst %0\n"
        : "=m" (result)
    );

    return result;
}

double fpu_sin_half_pi()
{
    double result = 0.;
    double div = 2.;

    __asm__ (
        "fldpi\n"
        "fld %1\n"
        "fdivp\n"
        "fsin\n"
        "fst %0\n"
        : "=m" (result)
        : "m" (div)
    );

    return result;
}

int main()
{
    cout << "\n\n========SIN========" << endl;
    
    cout << "--------CPP--------" << endl;
    printf("PI:         %.20f\n", sin(M_PI));
    printf("PI/2:       %.20f\n", sin(M_PI / 2));
    
    cout << "--------FPU--------" << endl;
    printf("PI:         %.20f\n", fpu_sin_pi());
    printf("PI/2:       %.20f\n", fpu_sin_half_pi());

    return 0;
}
