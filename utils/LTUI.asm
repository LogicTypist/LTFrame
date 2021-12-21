%ifndef R2TERM
    %error "R2TERM library missing."
%endif

LTUI_boot:
    mov 
    call Tm_output_str
.data:
    dw 0x10B0, 0x20F0, "BOOT            ", 0

LTUI_shutdown:
    mov r0, 0
    send r0, 0x1000
    send r0, 0x200F
    send r0, 0x30
    hlt
    jmp boot