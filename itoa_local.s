; itoa.s
; PURPOSE: to convert an integer into a null terminated ascii string
; works for several bases but doesn't handle negative input
; 
; This is a fork of itoa designed to use a temporary local variable instead
; of a global variable for the intermediate result before reversing.
;
; Programmed by Jeremiah Biard
; last modified on 9/22/2013

section .text

extern printf
extern exit

global itoa
global _start

_start:

 xor edi, edi

main_loop:
 
 cmp dword [array + 4 * edi], 0		; check to see if we've reached the end of our input test array
 je end_main_loop

 push dword [array + 4 * edi]		; push our test array element
 push number
 call itoa
 
 add esp, 8

 push dword [array + 4 * edi]
 push result
 push number 
 push output  
 call printf

 add esp, 16
 
 inc edi 
 jmp main_loop

end_main_loop:

 push 42
 call exit

itoa:

 ; TODO change 

 %define arg1 [ebp + 8]
 %define base [ebp + 12]
 %define temp_result [esp - 4]

 enter 36, 0 				; set up the stack frame, reserving
					; 33 bytes for a string large enough to
					; hold any int + 3 bytes for alignment
					; though I'm not sure it's needed...

 push edi				; save the main array index 

 mov eax, arg1				; put our argument in eax 
 mov ebx, base				; the chosen base

 cld
 xor esi, esi
 mov edi, temp_result 

loop_start:

 cmp eax, 0				; check to see if our number is zero
 je end_loop

 cdq
 div ebx 
 
 push eax 				; stosb will clobber our quotient if we don't
					; push it onto the stack

 mov byte al, [chars + edx]	
 stosb

 pop eax
  
 inc esi
 jmp loop_start

end_loop:

 mov edi, result 

 mov ecx, esi
 dec esi

reverse:
 mov byte al, temp_result + esi
 stosb
 dec esi
 loop reverse

end_reverse:
 mov byte [edi], 0 	; null terminate the result string

 pop edi		; restore our main array index

 leave 
 ret 
 	
section .rodata
 chars: db "0123456789abcdefghijklmnopqrstuv"
 output: db "%d = %s in base %d.", 0xa, 0x0

section .data
 array: dd 2, 8, 10, 16, 32, 0 				; define an array of integers
 number: equ 2503

section .bss
 result: resb 33
 ; temp_result: resb 33
