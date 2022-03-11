boot:
;initialize registers
    mov r0, 0
    mov r1, 0
    mov r2, 0
    mov r3, 0
    mov r4, 0
    mov r5, 0
    mov r6, 0
    mov r7, 0
    mov r8, 0
    mov r9, 0
    mov r10, 0
    mov r11, 0
    mov r12, 0
    mov r13, 0
;initialize stack pointer. It depends on defined memsize(MEMSIZE - 1).
    mov sp, MEMSIZE
    sub sp, 1
    


    mov r10, postboot_list
    cmp r10, postboot_list_end
    je .postbootEnd
    .postbootLoop:
        mov r11, [r10]
        jz .skip
        push r10
        call r11
        pop r10
        .skip:
        add r10, 1
        cmp r10, postboot_list_end
        jne .postbootLoop
    .postbootEnd:
    jmp MAIN

shutdown:
    mov r10, preshutdown_list
    cmp r10, preshutdown_list_end
    je .preshutdownEnd
    .preshutdownLoop:
        mov r11, [r10]
        jz .skip
        push r10
        call r11
        pop r10
        .skip:
        add r10, 1
        cmp r10, preshutdown_list_end
        jne .preshutdownLoop
    .preshutdownEnd:
    hlt
    jmp boot

permanantShutdown:
    hlt
    jmp permanantShutdown

pause:				;press any key to continue
	push r10
	.wait_loop:
		wait r10
		js .wait_loop
		bump r10
    pop r10
	ret

error_handler:
    jmp shutdown

;data region for LTFrame core.
firstboot:
    dw 1

machine_state:
    dw 0            ;0 = boot or shutdown
                    ;1 = running MainApp
                    ;2 = 
                    
lastboot_state:
    dw 0            ;0 = Lastboot completed successfully.
                    ;1 = Lastboot terminated unexpectedly.
                    ;2 = 
lastshutdown_state:
    dw 0


postboot_list:
%ifdef POSTBOOT_0
    dw POSTBOOT_0
%endif
%ifdef POSTBOOT_1
    dw POSTBOOT_1
%endif
%ifdef POSTBOOT_2
    dw POSTBOOT_2
%endif
%ifdef POSTBOOT_3
    dw POSTBOOT_3
%endif
%ifdef POSTBOOT_4
    dw POSTBOOT_4
%endif
%ifdef POSTBOOT_5
    dw POSTBOOT_5
%endif
%ifdef POSTBOOT_6
    dw POSTBOOT_6
%endif
%ifdef POSTBOOT_7
    dw POSTBOOT_7
%endif
postboot_list_end:

preshutdown_list:
%ifdef PRESHUTDOWN_0
    dw PRESHUTDOWN_0
%endif
%ifdef PRESHUTDOWN_1
    dw PRESHUTDOWN_1
%endif
%ifdef PRESHUTDOWN_2
    dw PRESHUTDOWN_2
%endif
%ifdef PRESHUTDOWN_3
    dw PRESHUTDOWN_3
%endif
%ifdef PRESHUTDOWN_4
    dw PRESHUTDOWN_4
%endif
%ifdef PRESHUTDOWN_5
    dw PRESHUTDOWN_5
%endif
%ifdef PRESHUTDOWN_6
    dw PRESHUTDOWN_6
%endif
%ifdef PRESHUTDOWN_7
    dw PRESHUTDOWN_7
%endif
preshutdown_list_end: