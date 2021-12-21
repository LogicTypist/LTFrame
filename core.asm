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
    


    mov r10, postBoot
    .postBootLoop:
        mov r11, [r10]
        jz .postBootSeqEnd
        call r11
        add r10, 1
        jmp .postBootLoop
    .postBootSeqEnd:
    jmp MAIN

shutdown:
    mov r10, preShutdown
    .preShutdownLoop:
        mov r11, [r10]
        jz .preShutdownSeqEnd
        call r11
        add r10, 1
        jmp .preShutdownLoop
    .preShutdownSeqEnd:
    hlt
    jmp boot

permanantShutdown:
    hlt
    jmp permanantShutdown



postBoot:
%ifdef POSTBOOT_0
    dw POSTBOOT_0
%else
    dw 0
%endif
%ifdef POSTBOOT_1
    dw POSTBOOT_1
%else
    dw 0
%endif
%ifdef POSTBOOT_2
    dw POSTBOOT_2
%else
    dw 0
%endif
%ifdef POSTBOOT_3
    dw POSTBOOT_3
%else
    dw 0
%endif

preShutdown:
%ifdef PRESHUTDOWN_0
    dw PRESHUTDOWN_0
%else
    dw 0
%endif
%ifdef PRESHUTDOWN_1
    dw PRESHUTDOWN_1
%else
    dw 0
%endif
%ifdef PRESHUTDOWN_2
    dw PRESHUTDOWN_2
%else
    dw 0
%endif
%ifdef PRESHUTDOWN_3
    dw PRESHUTDOWN_3
%else
    dw 0
%endif