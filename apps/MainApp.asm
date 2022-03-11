
TEST:
	mov r10, .data
	call Tm_output_str
	jmp shutdown
	.data:
		dw 0x1011, "Hello World!", 0