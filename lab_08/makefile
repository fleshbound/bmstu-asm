.PHONY: app_fpu app_cpp

app_cpp:
	g++ main.cpp -mno-80387 -m80387 -O0 -o app_cpp.exe

app_fpu:
	g++ main.cpp -masm=intel -DFPU=1 -O0 -g -o app_fpu.exe

app_sin:
	g++ main_sin.cpp -masm=intel -o app_sin.exe

math: app_cpp app_fpu app_sin

run:
	./app_cpp.exe
	./app_fpu.exe
	./app_sin.exe

all: math

asm:
	g++ -S main.cpp -masm=intel -DFPU -O0 -o asm/math.s
	g++ -S main.cpp -mno-80387 -m80387 -O0 -o asm/math_cpp.s
	g++ -S main_sin.cpp -masm=intel -o asm/sin.s

dasm:
	g++ -c main.cpp -masm=intel -DFPU -O0 -o out/math.o
	g++ -c main.cpp -mno-80387 -m80387 -O0 -o out/math_cpp.o
	g++ -c main_sin.cpp -masm=intel -o out/sin.o


clean:
	rm -rf out/* asm/* dasm/* *.exe
