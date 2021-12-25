;Terminal(R2TERM) related functions library.
;prefix = Tm

;declare that R2TERM library included.
%define R2TERM

;configure address of R2TERM.
%define R2TERM_ADDRESS 0

ADDR_R2TERM:
	dw R2TERM_ADDRESS
DEFAULT_TEXT_COLOR:
	dw 0x200F
DEFAULT_TEXT_COLOR_INVERTED:
	dw 0x20F0

R2TERM_boot:
	mov r10, [DEFAULT_TEXT_COLOR]
	xor r10, 0x00FF
	mov [DEFAULT_TEXT_COLOR_INVERTED], r10
	call Tm_clear_scr
	ret


;Description of function.
;Required parameter(s) when calling this function:
	;r  =
;Register(s) used internally:
	;r  =
;Return value(s) when function exits:
	;r  =

;r10 = remaining characters counter
;r11 = terminal address
Tm_clear_scr:
	push r10
	push r11
	mov r10, 48
	mov r11, [ADDR_R2TERM]
	send r11, [DEFAULT_TEXT_COLOR]
	send r11, 0x1000
	.loop:
		send r11, 0x20		;0x20 = " "
		send r11, 0x20
		send r11, 0x20
		send r11, 0x20
		sub r10, 1
		jnz .loop
	.exit:
		pop r11
		pop r10
		ret

;Output to terminal a data stream that ends with 0.
;Required parameter(s) when calling this function:
	;r10  = starting address of string to output.
	
;Register(s) used internally:
	;r11 = terminal address.
	;r12  = temporarily store a character from r10 address
	;	   to check if character is 0.
;Return value(s) when function exits:
	;none.
Tm_output_str:
	push r11
	push r12
	mov r11, [ADDR_R2TERM]
	mov r12, [r10]
	jz .exit
	.loop:
		send r11, r12
		add r10, 1
		mov r12, [r10]
		jnz .loop
	.exit:
		pop r12
		pop r11
		ret

;Receive input from terminal and save a string that ends with 0.
;no blinking.
;Required parameter(s) when calling this function:
	;r10 = starting address of string data space.
	;r11 = max string size = space size - 1 (1 cell for 0 : end of string)
	;r12 = terminal position (format = 0x10YX)
;Register(s) used internally:
	;r10 = A pointer that stores address of cell going to be written in next input.
	;r11 = terminal address
	;r12 = terminal cursor
	;r13 = temporarily store a character from terminal.
;Return value(s) when function exits:
	;r10 = Received string length.
Tm_input_str:
	push r13
	add r11, r10
	mov [.starting_addr], r10
	mov [.end_addr], r11
	mov r11, [ADDR_R2TERM]
	send r11, r12
	send r11, 0x7F
	.wait_loop:
		wait r13
		js .wait_loop
		cmp r13, [ADDR_R2TERM]
		jne error_handler
		bump r11
	.bump_loop:
		recv r3, r10
		jnc .bump_loop

	.exit:
		pop r13
		ret
	.starting_addr:			;store starting address of string data space
		dw 0
	.end_addr:			;store max string length
		dw 0

;Receive a character from terminal and return that.
;no echo, no cursor.
;Required parameter(s) when calling this function:
	;none
;Register(s) used internally:
	;r10 = store a character from terminal.
	;r11 = terminal address
;Return value(s) when function exits:
	;r10 = Received character.
Tm_input_char:
	.wait_loop:
		wait r10
		js .wait_loop
		cmp r13, [ADDR_R2TERM]
		jne error_handler
		bump r11
	.bump_loop:
		recv r10, r11
		jnc .bump_loop
		ret
