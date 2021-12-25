;LogicTypist's Frame 0.1a
;This Assembly code is written for assist making R216 programs.
;Written by LogicTypist.

_Model "R216K2A"
_Model "R216K4A"
_Model "R216K8B"

%define BUILD_YEAR  = 2021
%define BUILD_MONTH = 12
%define BUILD_DAY   = 21



%include "common"

;Configurations
;---------------------------
%define MODEL           "R216K2A"
%define MEMSIZE         2048


;postboot, preshutdown sequence configuration part.
;define your sequence's label here.
;you can define maximum 8 boot sequences each postboot and preshutdown sequence.
%define POSTBOOT_0      R2TERM_boot
%define POSTBOOT_1      LTUI_boot

%define PRESHUTDOWN_0   LTUI_shutdown
;---------------------------

;This "core.asm" must be included for proper working.
core:
%include "core.asm"

hwlib:
%include "peripherals/r2term.asm"

;addons part.
;include your addon's body here.
;---------------------------
addons:
%include "utils/LTUI.asm"
;---------------------------

MAIN:
%include "apps/MainApp.asm"


endPoint: