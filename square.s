; FUNCTION: Square
; PURPOSE: Take an integer as input and return the square.
;
section .text

extern printf
extern exit

global _start
global square

_start:
 push 10 
 call square
 add esp, 8

 push eax
 push number 
 push str
 call printf

 push 42
 call exit

square:
 push ebp 
 mov ebp, esp 

 mov ebx, [ebp + 8] 
 mov eax, [ebp + 8]
 cdq
 imul ebx
 
 mov esp, ebp 
 pop ebp 
 ret 

section .data
  number: equ 10 
  str: db "The square of %d is %d", 0xa



