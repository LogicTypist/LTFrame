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
%define POSTBOOT_0      0
%define POSTBOOT_1      0
%define POSTBOOT_2      0
%define POSTBOOT_3      0

%define PRESHUTDOWN_0   0
%define PRESHUTDOWN_1   0
%define PRESHUTDOWN_2   0
%define PRESHUTDOWN_3   0
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