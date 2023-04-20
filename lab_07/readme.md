### Компиляция

`nasm -g -f elf32 strcpy.s -o strcpy.o -l test.list`
`gcc -g -m32 -masm=intel main.c -o app.exe strcpy.o`

### Получение дизассемблированного файла

`objdump -D -S main.o > main.d`
