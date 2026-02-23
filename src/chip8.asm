;chip8 interpreter for ATmega328P
;written by Jonatan HidalgoMorales in 2026

;--------MEMORY MAP:--------
;0x000-0x1FF CHIP8 Interpreter RAM:
;   0x000 - 0x01F -> 32 Registers
;   0x020 - 0x05F -> 64 I/O Registers
;   0x060 - 0x0FF -> 160 Ext I/O Regs
;   0x100 - 0x1FF -> 
;0x200-0x799 - Program ROM (copy necessary for games that modify their own code) 
;                                               and work RAM (up to 2KB limit for ATmega328P)
;0x7A0-0x8FF Virtual stack, timers, stack pointer, Fonts, and hardware stack
;
;--------REGISTERS:--------
; V0-15 -> r0-15
; PC    -> r18-19
; I     -> r26-27 X
;
.include "m328Pdef.inc"

.org 0x0000
    rjmp setup       ; Jump over the Interrupt Vector Table
.org 0x0034
setup:
    ;set stack to top of WRAM:
    ldi r16, LOW(RAMEND)
    out SPL, r16
    ldi r16, HIGH(RAMEND)
    out SPH, r16
loop:

    ; FETCH

    ; DECODE

    ; EXECUTE
    
    rjmp loop      