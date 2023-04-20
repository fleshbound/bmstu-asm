
main.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <asm_strlen>:
#include <stdio.h>
#include <string.h>

int asm_strlen(const char *string)
{
   0:	f3 0f 1e fa          	endbr64 
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    int len = 0;
   c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)

    __asm__ (
  13:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  17:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  1c:	48 8d 3a             	lea    (%rdx),%rdi
  1f:	30 c0                	xor    %al,%al
  21:	f2 ae                	repnz scas %es:(%rdi),%al
  23:	f7 d1                	not    %ecx
  25:	ff c9                	dec    %ecx
  27:	89 ca                	mov    %ecx,%edx
  29:	89 55 fc             	mov    %edx,-0x4(%rbp)
        : "=r" (len)
        : "r" (string)
        : "rdi", "ecx", "al"
    );

    return len;
  2c:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
  2f:	5d                   	pop    %rbp
  30:	c3                   	ret    

0000000000000031 <main>:

int main(void)
{
  31:	f3 0f 1e fa          	endbr64 
  35:	55                   	push   %rbp
  36:	48 89 e5             	mov    %rsp,%rbp
  39:	48 83 ec 20          	sub    $0x20,%rsp
  3d:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  44:	00 00 
  46:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  4a:	31 c0                	xor    %eax,%eax
    setbuf(stdout, NULL);
  4c:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 53 <main+0x22>
  53:	be 00 00 00 00       	mov    $0x0,%esi
  58:	48 89 c7             	mov    %rax,%rdi
  5b:	e8 00 00 00 00       	call   60 <main+0x2f>

    char test_str[] = "Hi, I'm Test String.";
  60:	48 b8 48 69 2c 20 49 	movabs $0x206d2749202c6948,%rax
  67:	27 6d 20 
  6a:	48 ba 54 65 73 74 20 	movabs $0x7274532074736554,%rdx
  71:	53 74 72 
  74:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  78:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  7c:	c7 45 f0 69 6e 67 2e 	movl   $0x2e676e69,-0x10(%rbp)
  83:	c6 45 f4 00          	movb   $0x0,-0xc(%rbp)
    printf("Current test string: '%s'\n", test_str);
  87:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
  8b:	48 89 c6             	mov    %rax,%rsi
  8e:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 95 <main+0x64>
  95:	48 89 c7             	mov    %rax,%rdi
  98:	b8 00 00 00 00       	mov    $0x0,%eax
  9d:	e8 00 00 00 00       	call   a2 <main+0x71>
    printf("Actual string length: %zu\n", strlen(test_str));
  a2:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
  a6:	48 89 c7             	mov    %rax,%rdi
  a9:	e8 00 00 00 00       	call   ae <main+0x7d>
  ae:	48 89 c6             	mov    %rax,%rsi
  b1:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # b8 <main+0x87>
  b8:	48 89 c7             	mov    %rax,%rdi
  bb:	b8 00 00 00 00       	mov    $0x0,%eax
  c0:	e8 00 00 00 00       	call   c5 <main+0x94>
    printf("ASM string length: %d\n", asm_strlen(test_str));
  c5:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
  c9:	48 89 c7             	mov    %rax,%rdi
  cc:	e8 00 00 00 00       	call   d1 <main+0xa0>
  d1:	89 c6                	mov    %eax,%esi
  d3:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # da <main+0xa9>
  da:	48 89 c7             	mov    %rax,%rdi
  dd:	b8 00 00 00 00       	mov    $0x0,%eax
  e2:	e8 00 00 00 00       	call   e7 <main+0xb6>
  e7:	b8 00 00 00 00       	mov    $0x0,%eax

}
  ec:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  f0:	64 48 2b 14 25 28 00 	sub    %fs:0x28,%rdx
  f7:	00 00 
  f9:	74 05                	je     100 <main+0xcf>
  fb:	e8 00 00 00 00       	call   100 <main+0xcf>
 100:	c9                   	leave  
 101:	c3                   	ret    

Disassembly of section .rodata:

0000000000000000 <.rodata>:
   0:	43 75 72             	rex.XB jne 75 <main+0x44>
   3:	72 65                	jb     6a <main+0x39>
   5:	6e                   	outsb  %ds:(%rsi),(%dx)
   6:	74 20                	je     28 <.rodata+0x28>
   8:	74 65                	je     6f <main+0x3e>
   a:	73 74                	jae    80 <main+0x4f>
   c:	20 73 74             	and    %dh,0x74(%rbx)
   f:	72 69                	jb     7a <main+0x49>
  11:	6e                   	outsb  %ds:(%rsi),(%dx)
  12:	67 3a 20             	cmp    (%eax),%ah
  15:	27                   	(bad)  
  16:	25 73 27 0a 00       	and    $0xa2773,%eax
  1b:	41 63 74 75 61       	movsxd 0x61(%r13,%rsi,2),%esi
  20:	6c                   	insb   (%dx),%es:(%rdi)
  21:	20 73 74             	and    %dh,0x74(%rbx)
  24:	72 69                	jb     8f <main+0x5e>
  26:	6e                   	outsb  %ds:(%rsi),(%dx)
  27:	67 20 6c 65 6e       	and    %ch,0x6e(%ebp,%eiz,2)
  2c:	67 74 68             	addr32 je 97 <main+0x66>
  2f:	3a 20                	cmp    (%rax),%ah
  31:	25 7a 75 0a 00       	and    $0xa757a,%eax
  36:	41 53                	push   %r11
  38:	4d 20 73 74          	rex.WRB and %r14b,0x74(%r11)
  3c:	72 69                	jb     a7 <main+0x76>
  3e:	6e                   	outsb  %ds:(%rsi),(%dx)
  3f:	67 20 6c 65 6e       	and    %ch,0x6e(%ebp,%eiz,2)
  44:	67 74 68             	addr32 je af <main+0x7e>
  47:	3a 20                	cmp    (%rax),%ah
  49:	25                   	.byte 0x25
  4a:	64 0a 00             	or     %fs:(%rax),%al

Disassembly of section .debug_info:

0000000000000000 <.debug_info>:
{
   0:	46 03 00             	rex.RX add (%rax),%r8d
   3:	00 05 00 01 08 00    	add    %al,0x80100(%rip)        # 80109 <main+0x800d8>
   9:	00 00                	add    %al,(%rax)
   b:	00 0b                	add    %cl,(%rbx)
    int len = 0;
   d:	00 00                	add    %al,(%rax)
   f:	00 00                	add    %al,(%rax)
  11:	1d 00 00 00 00       	sbb    $0x0,%eax
	...
    __asm__ (
  22:	02 01                	add    (%rcx),%al
	...
    return len;
  2c:	00 00                	add    %al,(%rax)
  2e:	04 00                	add    $0x0,%al
}
  30:	00 00                	add    %al,(%rax)
{
  32:	00 02                	add    %al,(%rdx)
  34:	d1 17                	rcll   (%rdi)
  36:	3a 00                	cmp    (%rax),%al
  38:	00 00                	add    %al,(%rax)
  3a:	02 08                	add    (%rax),%cl
  3c:	07                   	(bad)  
  3d:	00 00                	add    %al,(%rax)
  3f:	00 00                	add    %al,(%rax)
  41:	02 04 07             	add    (%rdi,%rax,1),%al
  44:	00 00                	add    %al,(%rax)
  46:	00 00                	add    %al,(%rax)
  48:	0c 08                	or     $0x8,%al
  4a:	02 01                	add    (%rcx),%al
    setbuf(stdout, NULL);
  4c:	08 00                	or     %al,(%rax)
  4e:	00 00                	add    %al,(%rax)
  50:	00 02                	add    %al,(%rdx)
  52:	02 07                	add    (%rdi),%al
  54:	00 00                	add    %al,(%rax)
  56:	00 00                	add    %al,(%rax)
  58:	02 01                	add    (%rcx),%al
  5a:	06                   	(bad)  
  5b:	00 00                	add    %al,(%rax)
  5d:	00 00                	add    %al,(%rax)
  5f:	02 02                	add    (%rdx),%al
    char test_str[] = "Hi, I'm Test String.";
  61:	05 00 00 00 00       	add    $0x0,%eax
  66:	0d 04 05 69 6e       	or     $0x6e690504,%eax
  6b:	74 00                	je     6d <.debug_info+0x6d>
  6d:	02 08                	add    (%rax),%cl
  6f:	05 00 00 00 00       	add    $0x0,%eax
  74:	04 00                	add    $0x0,%al
  76:	00 00                	add    %al,(%rax)
  78:	00 03                	add    %al,(%rbx)
  7a:	98                   	cwtl   
  7b:	19 6d 00             	sbb    %ebp,0x0(%rbp)
  7e:	00 00                	add    %al,(%rax)
  80:	04 00                	add    $0x0,%al
  82:	00 00                	add    %al,(%rax)
  84:	00 03                	add    %al,(%rbx)
  86:	99                   	cltd   
    printf("Current test string: '%s'\n", test_str);
  87:	1b 6d 00             	sbb    0x0(%rbp),%ebp
  8a:	00 00                	add    %al,(%rax)
  8c:	03 96 00 00 00 09    	add    0x9000000(%rsi),%edx
  92:	8c 00                	mov    %es,(%rax)
  94:	00 00                	add    %al,(%rax)
  96:	02 01                	add    (%rcx),%al
  98:	06                   	(bad)  
  99:	00 00                	add    %al,(%rax)
  9b:	00 00                	add    %al,(%rax)
  9d:	0e                   	(bad)  
  9e:	96                   	xchg   %eax,%esi
  9f:	00 00                	add    %al,(%rax)
  a1:	00 0f                	add    %cl,(%rdi)
    printf("Actual string length: %zu\n", strlen(test_str));
  a3:	00 00                	add    %al,(%rax)
  a5:	00 00                	add    %al,(%rax)
  a7:	d8 04 31             	fadds  (%rcx,%rsi,1)
  aa:	08 0c 02             	or     %cl,(%rdx,%rax,1)
  ad:	00 00                	add    %al,(%rax)
  af:	01 00                	add    %eax,(%rax)
  b1:	00 00                	add    %al,(%rax)
  b3:	00 33                	add    %dh,(%rbx)
  b5:	07                   	(bad)  
  b6:	66 00 00             	data16 add %al,(%rax)
  b9:	00 00                	add    %al,(%rax)
  bb:	01 00                	add    %eax,(%rax)
  bd:	00 00                	add    %al,(%rax)
  bf:	00 36                	add    %dh,(%rsi)
  c1:	09 8c 00 00 00 08 01 	or     %ecx,0x1080000(%rax,%rax,1)
    printf("ASM string length: %d\n", asm_strlen(test_str));
  c8:	00 00                	add    %al,(%rax)
  ca:	00 00                	add    %al,(%rax)
  cc:	37                   	(bad)  
  cd:	09 8c 00 00 00 10 01 	or     %ecx,0x1100000(%rax,%rax,1)
  d4:	00 00                	add    %al,(%rax)
  d6:	00 00                	add    %al,(%rax)
  d8:	38 09                	cmp    %cl,(%rcx)
  da:	8c 00                	mov    %es,(%rax)
  dc:	00 00                	add    %al,(%rax)
  de:	18 01                	sbb    %al,(%rcx)
  e0:	00 00                	add    %al,(%rax)
  e2:	00 00                	add    %al,(%rax)
  e4:	39 09                	cmp    %ecx,(%rcx)
  e6:	8c 00                	mov    %es,(%rax)
  e8:	00 00                	add    %al,(%rax)
  ea:	20 01                	and    %al,(%rcx)
}
  ec:	00 00                	add    %al,(%rax)
  ee:	00 00                	add    %al,(%rax)
  f0:	3a 09                	cmp    (%rcx),%cl
  f2:	8c 00                	mov    %es,(%rax)
  f4:	00 00                	add    %al,(%rax)
  f6:	28 01                	sub    %al,(%rcx)
  f8:	00 00                	add    %al,(%rax)
  fa:	00 00                	add    %al,(%rax)
  fc:	3b 09                	cmp    (%rcx),%ecx
  fe:	8c 00                	mov    %es,(%rax)
 100:	00 00                	add    %al,(%rax)
 102:	30 01                	xor    %al,(%rcx)
 104:	00 00                	add    %al,(%rax)
 106:	00 00                	add    %al,(%rax)
 108:	3c 09                	cmp    $0x9,%al
 10a:	8c 00                	mov    %es,(%rax)
 10c:	00 00                	add    %al,(%rax)
 10e:	38 01                	cmp    %al,(%rcx)
 110:	00 00                	add    %al,(%rax)
 112:	00 00                	add    %al,(%rax)
 114:	3d 09 8c 00 00       	cmp    $0x8c09,%eax
 119:	00 40 01             	add    %al,0x1(%rax)
 11c:	00 00                	add    %al,(%rax)
 11e:	00 00                	add    %al,(%rax)
 120:	40 09 8c 00 00 00 48 	rex or %ecx,0x1480000(%rax,%rax,1)
 127:	01 
 128:	00 00                	add    %al,(%rax)
 12a:	00 00                	add    %al,(%rax)
 12c:	41 09 8c 00 00 00 50 	or     %ecx,0x1500000(%r8,%rax,1)
 133:	01 
 134:	00 00                	add    %al,(%rax)
 136:	00 00                	add    %al,(%rax)
 138:	42 09 8c 00 00 00 58 	or     %ecx,0x1580000(%rax,%r8,1)
 13f:	01 
 140:	00 00                	add    %al,(%rax)
 142:	00 00                	add    %al,(%rax)
 144:	44 16                	rex.R (bad) 
 146:	25 02 00 00 60       	and    $0x60000002,%eax
 14b:	01 00                	add    %eax,(%rax)
 14d:	00 00                	add    %al,(%rax)
 14f:	00 46 14             	add    %al,0x14(%rsi)
 152:	2a 02                	sub    (%rdx),%al
 154:	00 00                	add    %al,(%rax)
 156:	68 01 00 00 00       	push   $0x1
 15b:	00 48 07             	add    %cl,0x7(%rax)
 15e:	66 00 00             	data16 add %al,(%rax)
 161:	00 70 01             	add    %dh,0x1(%rax)
 164:	00 00                	add    %al,(%rax)
 166:	00 00                	add    %al,(%rax)
 168:	49 07                	rex.WB (bad) 
 16a:	66 00 00             	data16 add %al,(%rax)
 16d:	00 74 01 00          	add    %dh,0x0(%rcx,%rax,1)
 171:	00 00                	add    %al,(%rax)
 173:	00 4a 0b             	add    %cl,0xb(%rdx)
 176:	74 00                	je     178 <.debug_info+0x178>
 178:	00 00                	add    %al,(%rax)
 17a:	78 01                	js     17d <.debug_info+0x17d>
 17c:	00 00                	add    %al,(%rax)
 17e:	00 00                	add    %al,(%rax)
 180:	4d 12 51 00          	rex.WRB adc 0x0(%r9),%r10b
 184:	00 00                	add    %al,(%rax)
 186:	80 01 00             	addb   $0x0,(%rcx)
 189:	00 00                	add    %al,(%rax)
 18b:	00 4e 0f             	add    %cl,0xf(%rsi)
 18e:	58                   	pop    %rax
 18f:	00 00                	add    %al,(%rax)
 191:	00 82 01 00 00 00    	add    %al,0x1(%rdx)
 197:	00 4f 08             	add    %cl,0x8(%rdi)
 19a:	2f                   	(bad)  
 19b:	02 00                	add    (%rax),%al
 19d:	00 83 01 00 00 00    	add    %al,0x1(%rbx)
 1a3:	00 51 0f             	add    %dl,0xf(%rcx)
 1a6:	3f                   	(bad)  
 1a7:	02 00                	add    (%rax),%al
 1a9:	00 88 01 00 00 00    	add    %cl,0x1(%rax)
 1af:	00 59 0d             	add    %bl,0xd(%rcx)
 1b2:	80 00 00             	addb   $0x0,(%rax)
 1b5:	00 90 01 00 00 00    	add    %dl,0x1(%rax)
 1bb:	00 5b 17             	add    %bl,0x17(%rbx)
 1be:	49 02 00             	rex.WB add (%r8),%al
 1c1:	00 98 01 00 00 00    	add    %bl,0x1(%rax)
 1c7:	00 5c 19 53          	add    %bl,0x53(%rcx,%rbx,1)
 1cb:	02 00                	add    (%rax),%al
 1cd:	00 a0 01 00 00 00    	add    %ah,0x1(%rax)
 1d3:	00 5d 14             	add    %bl,0x14(%rbp)
 1d6:	2a 02                	sub    (%rdx),%al
 1d8:	00 00                	add    %al,(%rax)
 1da:	a8 01                	test   $0x1,%al
 1dc:	00 00                	add    %al,(%rax)
 1de:	00 00                	add    %al,(%rax)
 1e0:	5e                   	pop    %rsi
 1e1:	09 48 00             	or     %ecx,0x0(%rax)
 1e4:	00 00                	add    %al,(%rax)
 1e6:	b0 01                	mov    $0x1,%al
 1e8:	00 00                	add    %al,(%rax)
 1ea:	00 00                	add    %al,(%rax)
 1ec:	5f                   	pop    %rdi
 1ed:	0a 2e                	or     (%rsi),%ch
 1ef:	00 00                	add    %al,(%rax)
 1f1:	00 b8 01 00 00 00    	add    %bh,0x1(%rax)
 1f7:	00 60 07             	add    %ah,0x7(%rax)
 1fa:	66 00 00             	data16 add %al,(%rax)
 1fd:	00 c0                	add    %al,%al
 1ff:	01 00                	add    %eax,(%rax)
 201:	00 00                	add    %al,(%rax)
 203:	00 62 08             	add    %ah,0x8(%rdx)
 206:	58                   	pop    %rax
 207:	02 00                	add    (%rax),%al
 209:	00 c4                	add    %al,%ah
 20b:	00 04 00             	add    %al,(%rax,%rax,1)
 20e:	00 00                	add    %al,(%rax)
 210:	00 05 07 19 a2 00    	add    %al,0xa21907(%rip)        # a21b1d <main+0xa21aec>
 216:	00 00                	add    %al,(%rax)
 218:	10 00                	adc    %al,(%rax)
 21a:	00 00                	add    %al,(%rax)
 21c:	00 04 2b             	add    %al,(%rbx,%rbp,1)
 21f:	0e                   	(bad)  
 220:	06                   	(bad)  
 221:	00 00                	add    %al,(%rax)
 223:	00 00                	add    %al,(%rax)
 225:	03 20                	add    (%rax),%esp
 227:	02 00                	add    (%rax),%al
 229:	00 03                	add    %al,(%rbx)
 22b:	a2 00 00 00 07 96 00 	movabs %al,0x9607000000
 232:	00 00 
 234:	3f                   	(bad)  
 235:	02 00                	add    (%rax),%al
 237:	00 08                	add    %cl,(%rax)
 239:	3a 00                	cmp    (%rax),%al
 23b:	00 00                	add    %al,(%rax)
 23d:	00 00                	add    %al,(%rax)
 23f:	03 18                	add    (%rax),%ebx
 241:	02 00                	add    (%rax),%al
 243:	00 06                	add    %al,(%rsi)
 245:	00 00                	add    %al,(%rax)
 247:	00 00                	add    %al,(%rax)
 249:	03 44 02 00          	add    0x0(%rdx,%rax,1),%eax
 24d:	00 06                	add    %al,(%rsi)
 24f:	00 00                	add    %al,(%rax)
 251:	00 00                	add    %al,(%rax)
 253:	03 4e 02             	add    0x2(%rsi),%ecx
 256:	00 00                	add    %al,(%rax)
 258:	07                   	(bad)  
 259:	96                   	xchg   %eax,%esi
 25a:	00 00                	add    %al,(%rax)
 25c:	00 68 02             	add    %ch,0x2(%rax)
 25f:	00 00                	add    %al,(%rax)
 261:	08 3a                	or     %bh,(%rdx)
 263:	00 00                	add    %al,(%rax)
 265:	00 13                	add    %dl,(%rbx)
 267:	00 03                	add    %al,(%rbx)
 269:	0c 02                	or     $0x2,%al
 26b:	00 00                	add    %al,(%rax)
 26d:	09 68 02             	or     %ebp,0x2(%rax)
 270:	00 00                	add    %al,(%rax)
 272:	11 00                	adc    %eax,(%rax)
 274:	00 00                	add    %al,(%rax)
 276:	00 07                	add    %al,(%rdi)
 278:	90                   	nop
 279:	0e                   	(bad)  
 27a:	68 02 00 00 03       	push   $0x3000002
 27f:	9d                   	popf   
 280:	00 00                	add    %al,(%rax)
 282:	00 0a                	add    %cl,(%rdx)
 284:	00 00                	add    %al,(%rax)
 286:	00 00                	add    %al,(%rax)
 288:	06                   	(bad)  
 289:	97                   	xchg   %eax,%edi
 28a:	01 0f                	add    %ecx,(%rdi)
 28c:	2e 00 00             	cs add %al,(%rax)
 28f:	00 9a 02 00 00 05    	add    %bl,0x5000002(%rdx)
 295:	7e 02                	jle    299 <.debug_info+0x299>
 297:	00 00                	add    %al,(%rax)
 299:	00 0a                	add    %cl,(%rdx)
 29b:	00 00                	add    %al,(%rax)
 29d:	00 00                	add    %al,(%rax)
 29f:	07                   	(bad)  
 2a0:	64 01 0c 66          	add    %ecx,%fs:(%rsi,%riz,2)
 2a4:	00 00                	add    %al,(%rax)
 2a6:	00 b2 02 00 00 05    	add    %dh,0x5000002(%rdx)
 2ac:	7e 02                	jle    2b0 <.debug_info+0x2b0>
 2ae:	00 00                	add    %al,(%rax)
 2b0:	12 00                	adc    (%rax),%al
 2b2:	13 00                	adc    (%rax),%eax
 2b4:	00 00                	add    %al,(%rax)
 2b6:	00 07                	add    %al,(%rdi)
 2b8:	48 01 0d ca 02 00 00 	add    %rcx,0x2ca(%rip)        # 589 <main+0x558>
 2bf:	05 6d 02 00 00       	add    $0x26d,%eax
 2c4:	05 91 00 00 00       	add    $0x91,%eax
 2c9:	00 14 00             	add    %dl,(%rax,%rax,1)
 2cc:	00 00                	add    %al,(%rax)
 2ce:	00 01                	add    %al,(%rcx)
 2d0:	19 05 66 00 00 00    	sbb    %eax,0x66(%rip)        # 33c <.debug_info+0x33c>
	...
 2de:	d1 00                	roll   (%rax)
 2e0:	00 00                	add    %al,(%rax)
 2e2:	00 00                	add    %al,(%rax)
 2e4:	00 00                	add    %al,(%rax)
 2e6:	01 9c fc 02 00 00 15 	add    %ebx,0x15000002(%rsp,%rdi,8)
 2ed:	00 00                	add    %al,(%rax)
 2ef:	00 00                	add    %al,(%rax)
 2f1:	01 1d 0a fc 02 00    	add    %ebx,0x2fc0a(%rip)        # 2ff01 <main+0x2fed0>
 2f7:	00 02                	add    %al,(%rdx)
 2f9:	91                   	xchg   %eax,%ecx
 2fa:	50                   	push   %rax
 2fb:	00 07                	add    %al,(%rdi)
 2fd:	96                   	xchg   %eax,%esi
 2fe:	00 00                	add    %al,(%rax)
 300:	00 0c 03             	add    %cl,(%rbx,%rax,1)
 303:	00 00                	add    %al,(%rax)
 305:	08 3a                	or     %bh,(%rdx)
 307:	00 00                	add    %al,(%rax)
 309:	00 14 00             	add    %dl,(%rax,%rax,1)
 30c:	16                   	(bad)  
 30d:	00 00                	add    %al,(%rax)
 30f:	00 00                	add    %al,(%rax)
 311:	01 04 05 66 00 00 00 	add    %eax,0x66(,%rax,1)
	...
 320:	31 00                	xor    %eax,(%rax)
 322:	00 00                	add    %al,(%rax)
 324:	00 00                	add    %al,(%rax)
 326:	00 00                	add    %al,(%rax)
 328:	01 9c 17 00 00 00 00 	add    %ebx,0x0(%rdi,%rdx,1)
 32f:	01 04 1c             	add    %eax,(%rsp,%rbx,1)
 332:	7e 02                	jle    336 <.debug_info+0x336>
 334:	00 00                	add    %al,(%rax)
 336:	02 91 58 18 6c 65    	add    0x656c1858(%rcx),%dl
 33c:	6e                   	outsb  %ds:(%rsi),(%dx)
 33d:	00 01                	add    %al,(%rcx)
 33f:	06                   	(bad)  
 340:	09 66 00             	or     %esp,0x0(%rsi)
 343:	00 00                	add    %al,(%rax)
 345:	02                   	.byte 0x2
 346:	91                   	xchg   %eax,%ecx
 347:	6c                   	insb   (%dx),%es:(%rdi)
	...

Disassembly of section .debug_abbrev:

0000000000000000 <.debug_abbrev>:
{
   0:	01 0d 00 03 0e 3a    	add    %ecx,0x3a0e0300(%rip)        # 3a0e0306 <main+0x3a0e02d5>
   6:	21 04 3b             	and    %eax,(%rbx,%rdi,1)
   9:	0b 39                	or     (%rcx),%edi
   b:	0b 49 13             	or     0x13(%rcx),%ecx
    int len = 0;
   e:	38 0b                	cmp    %cl,(%rbx)
  10:	00 00                	add    %al,(%rax)
  12:	02 24 00             	add    (%rax,%rax,1),%ah
    __asm__ (
  15:	0b 0b                	or     (%rbx),%ecx
  17:	3e 0b 03             	ds or  (%rbx),%eax
  1a:	0e                   	(bad)  
  1b:	00 00                	add    %al,(%rax)
  1d:	03 0f                	add    (%rdi),%ecx
  1f:	00 0b                	add    %cl,(%rbx)
  21:	21 08                	and    %ecx,(%rax)
  23:	49 13 00             	adc    (%r8),%rax
  26:	00 04 16             	add    %al,(%rsi,%rdx,1)
  29:	00 03                	add    %al,(%rbx)
  2b:	0e                   	(bad)  
    return len;
  2c:	3a 0b                	cmp    (%rbx),%cl
  2e:	3b 0b                	cmp    (%rbx),%ecx
}
  30:	39 0b                	cmp    %ecx,(%rbx)
{
  32:	49 13 00             	adc    (%r8),%rax
  35:	00 05 05 00 49 13    	add    %al,0x13490005(%rip)        # 13490040 <main+0x1349000f>
  3b:	00 00                	add    %al,(%rax)
  3d:	06                   	(bad)  
  3e:	13 00                	adc    (%rax),%eax
  40:	03 0e                	add    (%rsi),%ecx
  42:	3c 19                	cmp    $0x19,%al
  44:	00 00                	add    %al,(%rax)
  46:	07                   	(bad)  
  47:	01 01                	add    %eax,(%rcx)
  49:	49 13 01             	adc    (%r9),%rax
    setbuf(stdout, NULL);
  4c:	13 00                	adc    (%rax),%eax
  4e:	00 08                	add    %cl,(%rax)
  50:	21 00                	and    %eax,(%rax)
  52:	49 13 2f             	adc    (%r15),%rbp
  55:	0b 00                	or     (%rax),%eax
  57:	00 09                	add    %cl,(%rcx)
  59:	37                   	(bad)  
  5a:	00 49 13             	add    %cl,0x13(%rcx)
  5d:	00 00                	add    %al,(%rax)
  5f:	0a 2e                	or     (%rsi),%ch
    char test_str[] = "Hi, I'm Test String.";
  61:	01 3f                	add    %edi,(%rdi)
  63:	19 03                	sbb    %eax,(%rbx)
  65:	0e                   	(bad)  
  66:	3a 0b                	cmp    (%rbx),%cl
  68:	3b 05 39 0b 27 19    	cmp    0x19270b39(%rip),%eax        # 19270ba7 <main+0x19270b76>
  6e:	49 13 3c 19          	adc    (%r9,%rbx,1),%rdi
  72:	01 13                	add    %edx,(%rbx)
  74:	00 00                	add    %al,(%rax)
  76:	0b 11                	or     (%rcx),%edx
  78:	01 25 0e 13 0b 03    	add    %esp,0x30b130e(%rip)        # 30b138c <main+0x30b135b>
  7e:	1f                   	(bad)  
  7f:	1b 1f                	sbb    (%rdi),%ebx
  81:	11 01                	adc    %eax,(%rcx)
  83:	12 07                	adc    (%rdi),%al
  85:	10 17                	adc    %dl,(%rdi)
    printf("Current test string: '%s'\n", test_str);
  87:	00 00                	add    %al,(%rax)
  89:	0c 0f                	or     $0xf,%al
  8b:	00 0b                	add    %cl,(%rbx)
  8d:	0b 00                	or     (%rax),%eax
  8f:	00 0d 24 00 0b 0b    	add    %cl,0xb0b0024(%rip)        # b0b00b9 <main+0xb0b0088>
  95:	3e 0b 03             	ds or  (%rbx),%eax
  98:	08 00                	or     %al,(%rax)
  9a:	00 0e                	add    %cl,(%rsi)
  9c:	26 00 49 13          	es add %cl,0x13(%rcx)
  a0:	00 00                	add    %al,(%rax)
    printf("Actual string length: %zu\n", strlen(test_str));
  a2:	0f 13 01             	movlps %xmm0,(%rcx)
  a5:	03 0e                	add    (%rsi),%ecx
  a7:	0b 0b                	or     (%rbx),%ecx
  a9:	3a 0b                	cmp    (%rbx),%cl
  ab:	3b 0b                	cmp    (%rbx),%ecx
  ad:	39 0b                	cmp    %ecx,(%rbx)
  af:	01 13                	add    %edx,(%rbx)
  b1:	00 00                	add    %al,(%rax)
  b3:	10 16                	adc    %dl,(%rsi)
  b5:	00 03                	add    %al,(%rbx)
  b7:	0e                   	(bad)  
  b8:	3a 0b                	cmp    (%rbx),%cl
  ba:	3b 0b                	cmp    (%rbx),%ecx
  bc:	39 0b                	cmp    %ecx,(%rbx)
  be:	00 00                	add    %al,(%rax)
  c0:	11 34 00             	adc    %esi,(%rax,%rax,1)
  c3:	03 0e                	add    (%rsi),%ecx
    printf("ASM string length: %d\n", asm_strlen(test_str));
  c5:	3a 0b                	cmp    (%rbx),%cl
  c7:	3b 0b                	cmp    (%rbx),%ecx
  c9:	39 0b                	cmp    %ecx,(%rbx)
  cb:	49 13 3f             	adc    (%r15),%rdi
  ce:	19 3c 19             	sbb    %edi,(%rcx,%rbx,1)
  d1:	00 00                	add    %al,(%rax)
  d3:	12 18                	adc    (%rax),%bl
  d5:	00 00                	add    %al,(%rax)
  d7:	00 13                	add    %dl,(%rbx)
  d9:	2e 01 3f             	cs add %edi,(%rdi)
  dc:	19 03                	sbb    %eax,(%rbx)
  de:	0e                   	(bad)  
  df:	3a 0b                	cmp    (%rbx),%cl
  e1:	3b 05 39 0b 27 19    	cmp    0x19270b39(%rip),%eax        # 19270c20 <main+0x19270bef>
  e7:	3c 19                	cmp    $0x19,%al
  e9:	01 13                	add    %edx,(%rbx)
  eb:	00 00                	add    %al,(%rax)
}
  ed:	14 2e                	adc    $0x2e,%al
  ef:	01 3f                	add    %edi,(%rdi)
  f1:	19 03                	sbb    %eax,(%rbx)
  f3:	0e                   	(bad)  
  f4:	3a 0b                	cmp    (%rbx),%cl
  f6:	3b 0b                	cmp    (%rbx),%ecx
  f8:	39 0b                	cmp    %ecx,(%rbx)
  fa:	27                   	(bad)  
  fb:	19 49 13             	sbb    %ecx,0x13(%rcx)
  fe:	11 01                	adc    %eax,(%rcx)
 100:	12 07                	adc    (%rdi),%al
 102:	40 18 7c 19 01       	sbb    %dil,0x1(%rcx,%rbx,1)
 107:	13 00                	adc    (%rax),%eax
 109:	00 15 34 00 03 0e    	add    %dl,0xe030034(%rip)        # e030143 <main+0xe030112>
 10f:	3a 0b                	cmp    (%rbx),%cl
 111:	3b 0b                	cmp    (%rbx),%ecx
 113:	39 0b                	cmp    %ecx,(%rbx)
 115:	49 13 02             	adc    (%r10),%rax
 118:	18 00                	sbb    %al,(%rax)
 11a:	00 16                	add    %dl,(%rsi)
 11c:	2e 01 3f             	cs add %edi,(%rdi)
 11f:	19 03                	sbb    %eax,(%rbx)
 121:	0e                   	(bad)  
 122:	3a 0b                	cmp    (%rbx),%cl
 124:	3b 0b                	cmp    (%rbx),%ecx
 126:	39 0b                	cmp    %ecx,(%rbx)
 128:	27                   	(bad)  
 129:	19 49 13             	sbb    %ecx,0x13(%rcx)
 12c:	11 01                	adc    %eax,(%rcx)
 12e:	12 07                	adc    (%rdi),%al
 130:	40 18 7a 19          	sbb    %dil,0x19(%rdx)
 134:	00 00                	add    %al,(%rax)
 136:	17                   	(bad)  
 137:	05 00 03 0e 3a       	add    $0x3a0e0300,%eax
 13c:	0b 3b                	or     (%rbx),%edi
 13e:	0b 39                	or     (%rcx),%edi
 140:	0b 49 13             	or     0x13(%rcx),%ecx
 143:	02 18                	add    (%rax),%bl
 145:	00 00                	add    %al,(%rax)
 147:	18 34 00             	sbb    %dh,(%rax,%rax,1)
 14a:	03 08                	add    (%rax),%ecx
 14c:	3a 0b                	cmp    (%rbx),%cl
 14e:	3b 0b                	cmp    (%rbx),%ecx
 150:	39 0b                	cmp    %ecx,(%rbx)
 152:	49 13 02             	adc    (%r10),%rax
 155:	18 00                	sbb    %al,(%rax)
	...

Disassembly of section .debug_aranges:

0000000000000000 <.debug_aranges>:
{
   0:	2c 00                	sub    $0x0,%al
   2:	00 00                	add    %al,(%rax)
   4:	02 00                	add    (%rax),%al
   6:	00 00                	add    %al,(%rax)
   8:	00 00                	add    %al,(%rax)
   a:	08 00                	or     %al,(%rax)
	...
    __asm__ (
  18:	02 01                	add    (%rcx),%al
	...

Disassembly of section .debug_line:

0000000000000000 <.debug_line>:
{
   0:	9a                   	(bad)  
   1:	00 00                	add    %al,(%rax)
   3:	00 05 00 08 00 58    	add    %al,0x58000800(%rip)        # 58000809 <main+0x580007d8>
   9:	00 00                	add    %al,(%rax)
   b:	00 01                	add    %al,(%rcx)
    int len = 0;
   d:	01 01                	add    %eax,(%rcx)
   f:	fb                   	sti    
  10:	0e                   	(bad)  
  11:	0d 00 01 01 01       	or     $0x1010100,%eax
    __asm__ (
  16:	01 00                	add    %eax,(%rax)
  18:	00 00                	add    %al,(%rax)
  1a:	01 00                	add    %eax,(%rax)
  1c:	00 01                	add    %al,(%rcx)
  1e:	01 01                	add    %eax,(%rcx)
  20:	1f                   	(bad)  
  21:	05 00 00 00 00       	add    $0x0,%eax
	...
{
  36:	02 01                	add    (%rcx),%al
  38:	1f                   	(bad)  
  39:	02 0f                	add    (%rdi),%cl
  3b:	08 00                	or     %al,(%rax)
	...
  49:	00 01                	add    %al,(%rcx)
  4b:	00 00                	add    %al,(%rax)
    setbuf(stdout, NULL);
  4d:	00 00                	add    %al,(%rax)
  4f:	02 00                	add    (%rax),%al
  51:	00 00                	add    %al,(%rax)
  53:	00 03                	add    %al,(%rbx)
  55:	00 00                	add    %al,(%rax)
  57:	00 00                	add    %al,(%rax)
  59:	03 00                	add    (%rax),%eax
  5b:	00 00                	add    %al,(%rax)
  5d:	00 04 00             	add    %al,(%rax,%rax,1)
    char test_str[] = "Hi, I'm Test String.";
  60:	00 00                	add    %al,(%rax)
  62:	00 04 05 01 00 09 02 	add    %al,0x2090001(,%rax,1)
	...
  71:	16                   	(bad)  
  72:	05 09 bb 05 05       	add    $0x505bb09,%eax
  77:	76 05                	jbe    7e <.debug_line+0x7e>
  79:	0c 03                	or     $0x3,%al
  7b:	0e                   	(bad)  
  7c:	08 82 05 01 3d 31    	or     %al,0x313d0105(%rdx)
  82:	ba 05 05 e5 05       	mov    $0x5e50505,%edx
    printf("Current test string: '%s'\n", test_str);
  87:	0a 08                	or     (%rax),%cl
  89:	3e 05 05 02 27 13    	ds add $0x13270205,%eax
  8f:	08 9f 02 23 13 05    	or     %bl,0x5132302(%rdi)
  95:	01 02                	add    %eax,(%rdx)
  97:	27                   	(bad)  
  98:	14 02                	adc    $0x2,%al
  9a:	16                   	(bad)  
  9b:	00 01                	add    %al,(%rcx)
  9d:	01                   	.byte 0x1

Disassembly of section .debug_str:

0000000000000000 <.debug_str>:
{
   0:	5f                   	pop    %rdi
   1:	49                   	rex.WB
   2:	4f 5f                	rex.WRXB pop %r15
   4:	62 75 66 5f 65       	(bad)
   9:	6e                   	outsb  %ds:(%rsi),(%dx)
   a:	64 00 5f 6f          	add    %bl,%fs:0x6f(%rdi)
    int len = 0;
   e:	6c                   	insb   (%dx),%es:(%rdi)
   f:	64 5f                	fs pop %rdi
  11:	6f                   	outsl  %ds:(%rsi),(%dx)
  12:	66 66 73 65          	data16 data16 jae 7b <.debug_str+0x7b>
    __asm__ (
  16:	74 00                	je     18 <.debug_str+0x18>
  18:	5f                   	pop    %rdi
  19:	49                   	rex.WB
  1a:	4f 5f                	rex.WRXB pop %r15
  1c:	73 61                	jae    7f <.debug_str+0x7f>
  1e:	76 65                	jbe    85 <.debug_str+0x85>
  20:	5f                   	pop    %rdi
  21:	65 6e                	outsb  %gs:(%rsi),(%dx)
  23:	64 00 73 68          	add    %dh,%fs:0x68(%rbx)
  27:	6f                   	outsl  %ds:(%rsi),(%dx)
  28:	72 74                	jb     9e <.debug_str+0x9e>
  2a:	20 69 6e             	and    %ch,0x6e(%rcx)
    return len;
  2d:	74 00                	je     2f <.debug_str+0x2f>
}
  2f:	73 69                	jae    9a <.debug_str+0x9a>
{
  31:	7a 65                	jp     98 <.debug_str+0x98>
  33:	5f                   	pop    %rdi
  34:	74 00                	je     36 <.debug_str+0x36>
  36:	5f                   	pop    %rdi
  37:	6f                   	outsl  %ds:(%rsi),(%dx)
  38:	66 66 73 65          	data16 data16 jae a1 <.debug_str+0xa1>
  3c:	74 00                	je     3e <.debug_str+0x3e>
  3e:	5f                   	pop    %rdi
  3f:	49                   	rex.WB
  40:	4f 5f                	rex.WRXB pop %r15
  42:	77 72                	ja     b6 <.debug_str+0xb6>
  44:	69 74 65 5f 70 74 72 	imul   $0x727470,0x5f(%rbp,%riz,2),%esi
  4b:	00 
    setbuf(stdout, NULL);
  4c:	5f                   	pop    %rdi
  4d:	66 6c                	data16 insb (%dx),%es:(%rdi)
  4f:	61                   	(bad)  
  50:	67 73 00             	addr32 jae 53 <.debug_str+0x53>
  53:	61                   	(bad)  
  54:	73 6d                	jae    c3 <.debug_str+0xc3>
  56:	5f                   	pop    %rdi
  57:	73 74                	jae    cd <.debug_str+0xcd>
  59:	72 6c                	jb     c7 <.debug_str+0xc7>
  5b:	65 6e                	outsb  %gs:(%rsi),(%dx)
  5d:	00 5f 49             	add    %bl,0x49(%rdi)
    char test_str[] = "Hi, I'm Test String.";
  60:	4f 5f                	rex.WRXB pop %r15
  62:	62 75 66 5f 62       	(bad)
  67:	61                   	(bad)  
  68:	73 65                	jae    cf <.debug_str+0xcf>
  6a:	00 5f 6d             	add    %bl,0x6d(%rdi)
  6d:	61                   	(bad)  
  6e:	72 6b                	jb     db <.debug_str+0xdb>
  70:	65 72 73             	gs jb  e6 <.debug_str+0xe6>
  73:	00 5f 49             	add    %bl,0x49(%rdi)
  76:	4f 5f                	rex.WRXB pop %r15
  78:	72 65                	jb     df <.debug_str+0xdf>
  7a:	61                   	(bad)  
  7b:	64 5f                	fs pop %rdi
  7d:	65 6e                	outsb  %gs:(%rsi),(%dx)
  7f:	64 00 5f 66          	add    %bl,%fs:0x66(%rdi)
  83:	72 65                	jb     ea <.debug_str+0xea>
  85:	65 72 65             	gs jb  ed <.debug_str+0xed>
    printf("Current test string: '%s'\n", test_str);
  88:	73 5f                	jae    e9 <.debug_str+0xe9>
  8a:	62 75 66 00 47       	(bad)
  8f:	4e 55                	rex.WRX push %rbp
  91:	20 43 31             	and    %al,0x31(%rbx)
  94:	37                   	(bad)  
  95:	20 31                	and    %dh,(%rcx)
  97:	31 2e                	xor    %ebp,(%rsi)
  99:	33 2e                	xor    (%rsi),%ebp
  9b:	30 20                	xor    %ah,(%rax)
  9d:	2d 6d 61 73 6d       	sub    $0x6d73616d,%eax
    printf("Actual string length: %zu\n", strlen(test_str));
  a2:	3d 69 6e 74 65       	cmp    $0x65746e69,%eax
  a7:	6c                   	insb   (%dx),%es:(%rdi)
  a8:	20 2d 6d 74 75 6e    	and    %ch,0x6e75746d(%rip)        # 6e75751b <main+0x6e7574ea>
  ae:	65 3d 67 65 6e 65    	gs cmp $0x656e6567,%eax
  b4:	72 69                	jb     11f <.debug_str+0x11f>
  b6:	63 20                	movsxd (%rax),%esp
  b8:	2d 6d 61 72 63       	sub    $0x6372616d,%eax
  bd:	68 3d 78 38 36       	push   $0x3638783d
  c2:	2d 36 34 20 2d       	sub    $0x2d203436,%eax
    printf("ASM string length: %d\n", asm_strlen(test_str));
  c7:	67 20 2d 66 61 73 79 	and    %ch,0x79736166(%eip)        # 79736234 <main+0x79736203>
  ce:	6e                   	outsb  %ds:(%rsi),(%dx)
  cf:	63 68 72             	movsxd 0x72(%rax),%ebp
  d2:	6f                   	outsl  %ds:(%rsi),(%dx)
  d3:	6e                   	outsb  %ds:(%rsi),(%dx)
  d4:	6f                   	outsl  %ds:(%rsi),(%dx)
  d5:	75 73                	jne    14a <.debug_str+0x14a>
  d7:	2d 75 6e 77 69       	sub    $0x69776e75,%eax
  dc:	6e                   	outsb  %ds:(%rsi),(%dx)
  dd:	64 2d 74 61 62 6c    	fs sub $0x6c626174,%eax
  e3:	65 73 20             	gs jae 106 <.debug_str+0x106>
  e6:	2d 66 73 74 61       	sub    $0x61747366,%eax
  eb:	63 6b 2d             	movsxd 0x2d(%rbx),%ebp
}
  ee:	70 72                	jo     162 <.debug_str+0x162>
  f0:	6f                   	outsl  %ds:(%rsi),(%dx)
  f1:	74 65                	je     158 <.debug_str+0x158>
  f3:	63 74 6f 72          	movsxd 0x72(%rdi,%rbp,2),%esi
  f7:	2d 73 74 72 6f       	sub    $0x6f727473,%eax
  fc:	6e                   	outsb  %ds:(%rsi),(%dx)
  fd:	67 20 2d 66 73 74 61 	and    %ch,0x61747366(%eip)        # 6174746a <main+0x61747439>
 104:	63 6b 2d             	movsxd 0x2d(%rbx),%ebp
 107:	63 6c 61 73          	movsxd 0x73(%rcx,%riz,2),%ebp
 10b:	68 2d 70 72 6f       	push   $0x6f72702d
 110:	74 65                	je     177 <.debug_str+0x177>
 112:	63 74 69 6f          	movsxd 0x6f(%rcx,%rbp,2),%esi
 116:	6e                   	outsb  %ds:(%rsi),(%dx)
 117:	20 2d 66 63 66 2d    	and    %ch,0x2d666366(%rip)        # 2d666483 <main+0x2d666452>
 11d:	70 72                	jo     191 <.debug_str+0x191>
 11f:	6f                   	outsl  %ds:(%rsi),(%dx)
 120:	74 65                	je     187 <.debug_str+0x187>
 122:	63 74 69 6f          	movsxd 0x6f(%rcx,%rbp,2),%esi
 126:	6e                   	outsb  %ds:(%rsi),(%dx)
 127:	00 73 65             	add    %dh,0x65(%rbx)
 12a:	74 62                	je     18e <.debug_str+0x18e>
 12c:	75 66                	jne    194 <.debug_str+0x194>
 12e:	00 5f 6c             	add    %bl,0x6c(%rdi)
 131:	6f                   	outsl  %ds:(%rsi),(%dx)
 132:	63 6b 00             	movsxd 0x0(%rbx),%ebp
 135:	6c                   	insb   (%dx),%es:(%rdi)
 136:	6f                   	outsl  %ds:(%rsi),(%dx)
 137:	6e                   	outsb  %ds:(%rsi),(%dx)
 138:	67 20 69 6e          	and    %ch,0x6e(%ecx)
 13c:	74 00                	je     13e <.debug_str+0x13e>
 13e:	73 74                	jae    1b4 <.debug_str+0x1b4>
 140:	72 69                	jb     1ab <.debug_str+0x1ab>
 142:	6e                   	outsb  %ds:(%rsi),(%dx)
 143:	67 00 70 72          	add    %dh,0x72(%eax)
 147:	69 6e 74 66 00 5f 63 	imul   $0x635f0066,0x74(%rsi),%ebp
 14e:	75 72                	jne    1c2 <.debug_str+0x1c2>
 150:	5f                   	pop    %rdi
 151:	63 6f 6c             	movsxd 0x6c(%rdi),%ebp
 154:	75 6d                	jne    1c3 <.debug_str+0x1c3>
 156:	6e                   	outsb  %ds:(%rsi),(%dx)
 157:	00 5f 49             	add    %bl,0x49(%rdi)
 15a:	4f 5f                	rex.WRXB pop %r15
 15c:	46                   	rex.RX
 15d:	49                   	rex.WB
 15e:	4c                   	rex.WR
 15f:	45 00 74 65 73       	add    %r14b,0x73(%r13,%riz,2)
 164:	74 5f                	je     1c5 <.debug_str+0x1c5>
 166:	73 74                	jae    1dc <.debug_str+0x1dc>
 168:	72 00                	jb     16a <.debug_str+0x16a>
 16a:	75 6e                	jne    1da <.debug_str+0x1da>
 16c:	73 69                	jae    1d7 <.debug_str+0x1d7>
 16e:	67 6e                	outsb  %ds:(%esi),(%dx)
 170:	65 64 20 63 68       	gs and %ah,%fs:0x68(%rbx)
 175:	61                   	(bad)  
 176:	72 00                	jb     178 <.debug_str+0x178>
 178:	73 69                	jae    1e3 <.debug_str+0x1e3>
 17a:	67 6e                	outsb  %ds:(%esi),(%dx)
 17c:	65 64 20 63 68       	gs and %ah,%fs:0x68(%rbx)
 181:	61                   	(bad)  
 182:	72 00                	jb     184 <.debug_str+0x184>
 184:	5f                   	pop    %rdi
 185:	63 6f 64             	movsxd 0x64(%rdi),%ebp
 188:	65 63 76 74          	movsxd %gs:0x74(%rsi),%esi
 18c:	00 75 6e             	add    %dh,0x6e(%rbp)
 18f:	73 69                	jae    1fa <.debug_str+0x1fa>
 191:	67 6e                	outsb  %ds:(%esi),(%dx)
 193:	65 64 20 69 6e       	gs and %ch,%fs:0x6e(%rcx)
 198:	74 00                	je     19a <.debug_str+0x19a>
 19a:	5f                   	pop    %rdi
 19b:	49                   	rex.WB
 19c:	4f 5f                	rex.WRXB pop %r15
 19e:	6d                   	insl   (%dx),%es:(%rdi)
 19f:	61                   	(bad)  
 1a0:	72 6b                	jb     20d <.debug_str+0x20d>
 1a2:	65 72 00             	gs jb  1a5 <.debug_str+0x1a5>
 1a5:	5f                   	pop    %rdi
 1a6:	73 68                	jae    210 <.debug_str+0x210>
 1a8:	6f                   	outsl  %ds:(%rsi),(%dx)
 1a9:	72 74                	jb     21f <.debug_str+0x21f>
 1ab:	62 75 66 00 5f 49 4f 	vmaxsh 0x9e(%rcx),%xmm19,%xmm9
 1b2:	5f                   	pop    %rdi
 1b3:	77 72                	ja     227 <.debug_str+0x227>
 1b5:	69 74 65 5f 62 61 73 	imul   $0x65736162,0x5f(%rbp,%riz,2),%esi
 1bc:	65 
 1bd:	00 5f 75             	add    %bl,0x75(%rdi)
 1c0:	6e                   	outsb  %ds:(%rsi),(%dx)
 1c1:	75 73                	jne    236 <.debug_str+0x236>
 1c3:	65 64 32 00          	gs xor %fs:(%rax),%al
 1c7:	5f                   	pop    %rdi
 1c8:	49                   	rex.WB
 1c9:	4f 5f                	rex.WRXB pop %r15
 1cb:	72 65                	jb     232 <.debug_str+0x232>
 1cd:	61                   	(bad)  
 1ce:	64 5f                	fs pop %rdi
 1d0:	70 74                	jo     246 <.debug_str+0x246>
 1d2:	72 00                	jb     1d4 <.debug_str+0x1d4>
 1d4:	73 68                	jae    23e <.debug_str+0x23e>
 1d6:	6f                   	outsl  %ds:(%rsi),(%dx)
 1d7:	72 74                	jb     24d <.debug_str+0x24d>
 1d9:	20 75 6e             	and    %dh,0x6e(%rbp)
 1dc:	73 69                	jae    247 <.debug_str+0x247>
 1de:	67 6e                	outsb  %ds:(%esi),(%dx)
 1e0:	65 64 20 69 6e       	gs and %ch,%fs:0x6e(%rcx)
 1e5:	74 00                	je     1e7 <.debug_str+0x1e7>
 1e7:	63 68 61             	movsxd 0x61(%rax),%ebp
 1ea:	72 00                	jb     1ec <.debug_str+0x1ec>
 1ec:	6d                   	insl   (%dx),%es:(%rdi)
 1ed:	61                   	(bad)  
 1ee:	69 6e 00 73 74 72 6c 	imul   $0x6c727473,0x0(%rsi),%ebp
 1f5:	65 6e                	outsb  %gs:(%rsi),(%dx)
 1f7:	00 5f 77             	add    %bl,0x77(%rdi)
 1fa:	69 64 65 5f 64 61 74 	imul   $0x61746164,0x5f(%rbp,%riz,2),%esp
 201:	61 
 202:	00 5f 66             	add    %bl,0x66(%rdi)
 205:	72 65                	jb     26c <.debug_str+0x26c>
 207:	65 72 65             	gs jb  26f <.debug_str+0x26f>
 20a:	73 5f                	jae    26b <.debug_str+0x26b>
 20c:	6c                   	insb   (%dx),%es:(%rdi)
 20d:	69 73 74 00 5f 5f 70 	imul   $0x705f5f00,0x74(%rbx),%esi
 214:	61                   	(bad)  
 215:	64 35 00 5f 49 4f    	fs xor $0x4f495f00,%eax
 21b:	5f                   	pop    %rdi
 21c:	63 6f 64             	movsxd 0x64(%rdi),%ebp
 21f:	65 63 76 74          	movsxd %gs:0x74(%rsi),%esi
 223:	00 6c 6f 6e          	add    %ch,0x6e(%rdi,%rbp,2)
 227:	67 20 75 6e          	and    %dh,0x6e(%ebp)
 22b:	73 69                	jae    296 <.debug_str+0x296>
 22d:	67 6e                	outsb  %ds:(%esi),(%dx)
 22f:	65 64 20 69 6e       	gs and %ch,%fs:0x6e(%rcx)
 234:	74 00                	je     236 <.debug_str+0x236>
 236:	5f                   	pop    %rdi
 237:	49                   	rex.WB
 238:	4f 5f                	rex.WRXB pop %r15
 23a:	77 72                	ja     2ae <.debug_str+0x2ae>
 23c:	69 74 65 5f 65 6e 64 	imul   $0x646e65,0x5f(%rbp,%riz,2),%esi
 243:	00 
 244:	5f                   	pop    %rdi
 245:	5f                   	pop    %rdi
 246:	6f                   	outsl  %ds:(%rsi),(%dx)
 247:	66 66 36 34 5f       	data16 data16 ss xor $0x5f,%al
 24c:	74 00                	je     24e <.debug_str+0x24e>
 24e:	5f                   	pop    %rdi
 24f:	5f                   	pop    %rdi
 250:	6f                   	outsl  %ds:(%rsi),(%dx)
 251:	66 66 5f             	data16 pop %di
 254:	74 00                	je     256 <.debug_str+0x256>
 256:	5f                   	pop    %rdi
 257:	63 68 61             	movsxd 0x61(%rax),%ebp
 25a:	69 6e 00 5f 49 4f 5f 	imul   $0x5f4f495f,0x0(%rsi),%ebp
 261:	77 69                	ja     2cc <.debug_str+0x2cc>
 263:	64 65 5f             	fs gs pop %rdi
 266:	64 61                	fs (bad) 
 268:	74 61                	je     2cb <.debug_str+0x2cb>
 26a:	00 5f 49             	add    %bl,0x49(%rdi)
 26d:	4f 5f                	rex.WRXB pop %r15
 26f:	62 61                	(bad)  
 271:	63 6b 75             	movsxd 0x75(%rbx),%ebp
 274:	70 5f                	jo     2d5 <main+0x2a4>
 276:	62 61                	(bad)  
 278:	73 65                	jae    2df <main+0x2ae>
 27a:	00 5f 66             	add    %bl,0x66(%rdi)
 27d:	6c                   	insb   (%dx),%es:(%rdi)
 27e:	61                   	(bad)  
 27f:	67 73 32             	addr32 jae 2b4 <.debug_str+0x2b4>
 282:	00 5f 6d             	add    %bl,0x6d(%rdi)
 285:	6f                   	outsl  %ds:(%rsi),(%dx)
 286:	64 65 00 5f 49       	fs add %bl,%gs:0x49(%rdi)
 28b:	4f 5f                	rex.WRXB pop %r15
 28d:	72 65                	jb     2f4 <main+0x2c3>
 28f:	61                   	(bad)  
 290:	64 5f                	fs pop %rdi
 292:	62 61                	(bad)  
 294:	73 65                	jae    2fb <main+0x2ca>
 296:	00 5f 76             	add    %bl,0x76(%rdi)
 299:	74 61                	je     2fc <main+0x2cb>
 29b:	62                   	(bad)  
 29c:	6c                   	insb   (%dx),%es:(%rdi)
 29d:	65 5f                	gs pop %rdi
 29f:	6f                   	outsl  %ds:(%rsi),(%dx)
 2a0:	66 66 73 65          	data16 data16 jae 309 <main+0x2d8>
 2a4:	74 00                	je     2a6 <.debug_str+0x2a6>
 2a6:	5f                   	pop    %rdi
 2a7:	49                   	rex.WB
 2a8:	4f 5f                	rex.WRXB pop %r15
 2aa:	73 61                	jae    30d <main+0x2dc>
 2ac:	76 65                	jbe    313 <main+0x2e2>
 2ae:	5f                   	pop    %rdi
 2af:	62 61                	(bad)  
 2b1:	73 65                	jae    318 <main+0x2e7>
 2b3:	00 5f 66             	add    %bl,0x66(%rdi)
 2b6:	69 6c 65 6e 6f 00 46 	imul   $0x4946006f,0x6e(%rbp,%riz,2),%ebp
 2bd:	49 
 2be:	4c                   	rex.WR
 2bf:	45 00 73 74          	add    %r14b,0x74(%r11)
 2c3:	64 6f                	outsl  %fs:(%rsi),(%dx)
 2c5:	75 74                	jne    33b <main+0x30a>
 2c7:	00 5f 49             	add    %bl,0x49(%rdi)
 2ca:	4f 5f                	rex.WRXB pop %r15
 2cc:	6c                   	insb   (%dx),%es:(%rdi)
 2cd:	6f                   	outsl  %ds:(%rsi),(%dx)
 2ce:	63 6b 5f             	movsxd 0x5f(%rbx),%ebp
 2d1:	74 00                	je     2d3 <main+0x2a2>

Disassembly of section .debug_line_str:

0000000000000000 <.debug_line_str>:
{
   0:	6d                   	insl   (%dx),%es:(%rdi)
   1:	61                   	(bad)  
   2:	69 6e 2e 63 00 2f 68 	imul   $0x682f0063,0x2e(%rsi),%ebp
   9:	6f                   	outsl  %ds:(%rsi),(%dx)
   a:	6d                   	insl   (%dx),%es:(%rdi)
   b:	65 2f                	gs (bad) 
    int len = 0;
   d:	73 68                	jae    77 <.debug_line_str+0x77>
   f:	65 67 6c             	gs insb (%dx),%es:(%edi)
  12:	61                   	(bad)  
    __asm__ (
  13:	72 2f                	jb     44 <.debug_line_str+0x44>
  15:	32 30                	xor    (%rax),%dh
  17:	32 33                	xor    (%rbx),%dh
  19:	2f                   	(bad)  
  1a:	6c                   	insb   (%dx),%es:(%rdi)
  1b:	61                   	(bad)  
  1c:	62                   	(bad)  
  1d:	5f                   	pop    %rdi
  1e:	30 37                	xor    %dh,(%rdi)
  20:	00 2f                	add    %ch,(%rdi)
  22:	68 6f 6d 65 2f       	push   $0x2f656d6f
  27:	73 68                	jae    91 <.debug_line_str+0x91>
  29:	65 67 6c             	gs insb (%dx),%es:(%edi)
    return len;
  2c:	61                   	(bad)  
  2d:	72 2f                	jb     5e <.debug_line_str+0x5e>
}
  2f:	32 30                	xor    (%rax),%dh
{
  31:	32 33                	xor    (%rbx),%dh
  33:	2f                   	(bad)  
  34:	6c                   	insb   (%dx),%es:(%rdi)
  35:	61                   	(bad)  
  36:	62                   	(bad)  
  37:	5f                   	pop    %rdi
  38:	30 37                	xor    %dh,(%rdi)
  3a:	00 2f                	add    %ch,(%rdi)
  3c:	75 73                	jne    b1 <.debug_line_str+0xb1>
  3e:	72 2f                	jb     6f <.debug_line_str+0x6f>
  40:	6c                   	insb   (%dx),%es:(%rdi)
  41:	69 62 2f 67 63 63 2f 	imul   $0x2f636367,0x2f(%rdx),%esp
  48:	78 38                	js     82 <.debug_line_str+0x82>
  4a:	36 5f                	ss pop %rdi
    setbuf(stdout, NULL);
  4c:	36 34 2d             	ss xor $0x2d,%al
  4f:	6c                   	insb   (%dx),%es:(%rdi)
  50:	69 6e 75 78 2d 67 6e 	imul   $0x6e672d78,0x75(%rsi),%ebp
  57:	75 2f                	jne    88 <.debug_line_str+0x88>
  59:	31 31                	xor    %esi,(%rcx)
  5b:	2f                   	(bad)  
  5c:	69 6e 63 6c 75 64 65 	imul   $0x6564756c,0x63(%rsi),%ebp
    char test_str[] = "Hi, I'm Test String.";
  63:	00 2f                	add    %ch,(%rdi)
  65:	75 73                	jne    da <.debug_line_str+0xda>
  67:	72 2f                	jb     98 <.debug_line_str+0x98>
  69:	69 6e 63 6c 75 64 65 	imul   $0x6564756c,0x63(%rsi),%ebp
  70:	2f                   	(bad)  
  71:	78 38                	js     ab <.debug_line_str+0xab>
  73:	36 5f                	ss pop %rdi
  75:	36 34 2d             	ss xor $0x2d,%al
  78:	6c                   	insb   (%dx),%es:(%rdi)
  79:	69 6e 75 78 2d 67 6e 	imul   $0x6e672d78,0x75(%rsi),%ebp
  80:	75 2f                	jne    b1 <.debug_line_str+0xb1>
  82:	62                   	(bad)  
  83:	69 74 73 00 2f 75 73 	imul   $0x7273752f,0x0(%rbx,%rsi,2),%esi
  8a:	72 
    printf("Current test string: '%s'\n", test_str);
  8b:	2f                   	(bad)  
  8c:	69 6e 63 6c 75 64 65 	imul   $0x6564756c,0x63(%rsi),%ebp
  93:	2f                   	(bad)  
  94:	78 38                	js     ce <.debug_line_str+0xce>
  96:	36 5f                	ss pop %rdi
  98:	36 34 2d             	ss xor $0x2d,%al
  9b:	6c                   	insb   (%dx),%es:(%rdi)
  9c:	69 6e 75 78 2d 67 6e 	imul   $0x6e672d78,0x75(%rsi),%ebp
    printf("Actual string length: %zu\n", strlen(test_str));
  a3:	75 2f                	jne    d4 <.debug_line_str+0xd4>
  a5:	62                   	(bad)  
  a6:	69 74 73 2f 74 79 70 	imul   $0x65707974,0x2f(%rbx,%rsi,2),%esi
  ad:	65 
  ae:	73 00                	jae    b0 <.debug_line_str+0xb0>
  b0:	2f                   	(bad)  
  b1:	75 73                	jne    126 <main+0xf5>
  b3:	72 2f                	jb     e4 <.debug_line_str+0xe4>
  b5:	69 6e 63 6c 75 64 65 	imul   $0x6564756c,0x63(%rsi),%ebp
  bc:	00 6d 61             	add    %ch,0x61(%rbp)
  bf:	69 6e 2e 63 00 6d 61 	imul   $0x616d0063,0x2e(%rsi),%ebp
    printf("ASM string length: %d\n", asm_strlen(test_str));
  c6:	69 6e 2e 63 00 73 74 	imul   $0x74730063,0x2e(%rsi),%ebp
  cd:	64 64 65 66 2e 68 00 	fs fs gs cs pushw $0x7400
  d4:	74 
  d5:	79 70                	jns    147 <main+0x116>
  d7:	65 73 2e             	gs jae 108 <main+0xd7>
  da:	68 00 73 74 72       	push   $0x72747300
  df:	75 63                	jne    144 <main+0x113>
  e1:	74 5f                	je     142 <main+0x111>
  e3:	46                   	rex.RX
  e4:	49                   	rex.WB
  e5:	4c                   	rex.WR
  e6:	45                   	rex.RB
  e7:	2e 68 00 46 49 4c    	cs push $0x4c494600
}
  ed:	45                   	rex.RB
  ee:	2e 68 00 73 74 72    	cs push $0x72747300
  f4:	69 6e 67 2e 68 00 73 	imul   $0x7300682e,0x67(%rsi),%ebp
  fb:	74 64                	je     161 <main+0x130>
  fd:	69                   	.byte 0x69
  fe:	6f                   	outsl  %ds:(%rsi),(%dx)
  ff:	2e                   	cs
 100:	68                   	.byte 0x68
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
{
   0:	00 47 43             	add    %al,0x43(%rdi)
   3:	43 3a 20             	rex.XB cmp (%r8),%spl
   6:	28 55 62             	sub    %dl,0x62(%rbp)
   9:	75 6e                	jne    79 <main+0x48>
   b:	74 75                	je     82 <main+0x51>
    int len = 0;
   d:	20 31                	and    %dh,(%rcx)
   f:	31 2e                	xor    %ebp,(%rsi)
  11:	33 2e                	xor    (%rsi),%ebp
    __asm__ (
  13:	30 2d 31 75 62 75    	xor    %ch,0x75627531(%rip)        # 7562754a <main+0x75627519>
  19:	6e                   	outsb  %ds:(%rsi),(%dx)
  1a:	74 75                	je     91 <main+0x60>
  1c:	31 7e 32             	xor    %edi,0x32(%rsi)
  1f:	32 2e                	xor    (%rsi),%ch
  21:	30 34 29             	xor    %dh,(%rcx,%rbp,1)
  24:	20 31                	and    %dh,(%rcx)
  26:	31 2e                	xor    %ebp,(%rsi)
  28:	33 2e                	xor    (%rsi),%ebp
  2a:	30 00                	xor    %al,(%rax)

Disassembly of section .note.gnu.property:

0000000000000000 <.note.gnu.property>:
   0:	04 00                	add    $0x0,%al
   2:	00 00                	add    %al,(%rax)
   4:	10 00                	adc    %al,(%rax)
   6:	00 00                	add    %al,(%rax)
   8:	05 00 00 00 47       	add    $0x47000000,%eax
   d:	4e 55                	rex.WRX push %rbp
   f:	00 02                	add    %al,(%rdx)
  11:	00 00                	add    %al,(%rax)
  13:	c0 04 00 00          	rolb   $0x0,(%rax,%rax,1)
  17:	00 03                	add    %al,(%rbx)
  19:	00 00                	add    %al,(%rax)
  1b:	00 00                	add    %al,(%rax)
  1d:	00 00                	add    %al,(%rax)
	...

Disassembly of section .eh_frame:

0000000000000000 <.eh_frame>:
   0:	14 00                	adc    $0x0,%al
   2:	00 00                	add    %al,(%rax)
   4:	00 00                	add    %al,(%rax)
   6:	00 00                	add    %al,(%rax)
   8:	01 7a 52             	add    %edi,0x52(%rdx)
   b:	00 01                	add    %al,(%rcx)
   d:	78 10                	js     1f <.eh_frame+0x1f>
   f:	01 1b                	add    %ebx,(%rbx)
  11:	0c 07                	or     $0x7,%al
  13:	08 90 01 00 00 1c    	or     %dl,0x1c000001(%rax)
  19:	00 00                	add    %al,(%rax)
  1b:	00 1c 00             	add    %bl,(%rax,%rax,1)
  1e:	00 00                	add    %al,(%rax)
  20:	00 00                	add    %al,(%rax)
  22:	00 00                	add    %al,(%rax)
  24:	31 00                	xor    %eax,(%rax)
  26:	00 00                	add    %al,(%rax)
  28:	00 45 0e             	add    %al,0xe(%rbp)
  2b:	10 86 02 43 0d 06    	adc    %al,0x60d4302(%rsi)
  31:	68 0c 07 08 00       	push   $0x8070c
  36:	00 00                	add    %al,(%rax)
  38:	1c 00                	sbb    $0x0,%al
  3a:	00 00                	add    %al,(%rax)
  3c:	3c 00                	cmp    $0x0,%al
  3e:	00 00                	add    %al,(%rax)
  40:	00 00                	add    %al,(%rax)
  42:	00 00                	add    %al,(%rax)
  44:	d1 00                	roll   (%rax)
  46:	00 00                	add    %al,(%rax)
  48:	00 45 0e             	add    %al,0xe(%rbp)
  4b:	10 86 02 43 0d 06    	adc    %al,0x60d4302(%rsi)
  51:	02 c8                	add    %al,%cl
  53:	0c 07                	or     $0x7,%al
  55:	08 00                	or     %al,(%rax)
	...
