%ifndef R2TERM
    %error "R2TERM library missing."
%endif

LTUI_boot:
    mov r10, [DEFAULT_TEXT_COLOR_INVERTED]
    send [ADDR_R2TERM], r10

    mov r10, .data
    call Tm_output_str

    mov r10, [DEFAULT_TEXT_COLOR]
    send [ADDR_R2TERM], r10
    ret
.data:
    dw 0x10B0, "BOOT            ", 0

LTUI_shutdown:
    mov r10, [DEFAULT_TEXT_COLOR_INVERTED]
    send [ADDR_R2TERM], r10
    
    mov r10, .data
    call Tm_output_str

    mov r10, [DEFAULT_TEXT_COLOR]
    send [ADDR_R2TERM], r10
    ret
.data:
    dw 0x10B0, 0x20F0, "SHUTDOWN        ", 0