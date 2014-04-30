; PURPOSE: 	A program to illustrate how functions work
;		this program will copmute the value of
;		2 ^ 3 +  5 ^ 2
;

extern printf

section .text
global _start
_start:
 push 3		; second arg
 push 2		; first arg
 call power	; call function
 add esp, 8	; move stack pointer back

 push eax

 push 2		; second arg
 push 5		; first arg
 call power	; duh
 add esp, 8	; move sp back

 pop ebx

 add eax, ebx

 push eax
 push str
 call printf

 mov ebx, 42	; save answer in ebx
 mov eax, 1
 int 0x80

; PURPOSE: 	This function is used to compute the
;		value of a number raised to a power.
;
; INPUT:	First arg - the base number
;		Second arg - the power to raise it to
;
; OUTPUT: 	Will give the result as a return value
;
; NOTES		The power must be one or greater
;
; VARIABLES:
;		ebx - holds the base number
;		ecx - holds the power
;
;		[ebp - 4] - holds the current result
;
;		eax is used for temporary storage
global power
power:
 push ebp	; save old base pointer
 mov ebp, esp	; make stack pointer the base pointer
 sub esp, 4	; get room for local storage

 mov ebx, [ebp + 8] ; put first arg in ebx
 mov ecx, [ebp + 12] ; put second arg in ecx

 mov [ebp - 4], ebx ; store current result

power_loop_start:
 cmp ecx, 1	; if power is 1, we are finished
 je end_power
 mov eax, [ebp - 4] ; move current result into eax
 cdq
 imul ebx	; multiply current result by base number
 mov [ebp - 4], eax	; store current result
 dec ecx	; decrease the power
 jmp power_loop_start ; run the next power

end_power:
 mov eax, [ebp - 4] 	; return value goes in eax
 mov esp, ebp	; restore stack pointer
 pop ebp 	; restore the base pointer
 ret

	


section .data
; Everything in the main program is stored in registers,
; so the data section doesn't have anything.

str: db "The answer is %d.", 0xa
