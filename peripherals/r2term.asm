;Terminal(R2TERM) related functions library.
;prefix = Tm

 %define R2TERM

;Description of function.
;Required parameter(s) when calling this function:
	;r  =
;Registers used internally:
	;r  =
;Return value(s) when function exits:
	;r  =

;r0 = remaining characters counter
;r10 = terminal address
Tm_clear_scr:
	push r0
	
	mov r0, 48
	send r10, 0x1000
	.loop:
	send r10, 0x20		;0x20 = " "
	send r10, 0x20
	send r10, 0x20
	send r10, 0x20
	sub r0, 1
	jnz .loop
	
	pop r0
	ret

;Output to terminal a data stream that ends with 0.
;Required parameter(s) when calling this function:
	;r0  = starting address of string to output.
	;r10 = terminal address.
;Registers used internally:
	;r1  = temporarily store character from r0 address
	;	   to check if character is 0.
;Return value(s) when function exits:
	;r0	 = return the original parameter.
Tm_output_str:
	push r0
	push r1
	mov r1, [r0]
	jz .exit
	.loop:
		send r10, r1
		add r0, 1
		mov r1, [r0]
		jnz .loop
	.exit:
		pop r1
		pop r0
		ret