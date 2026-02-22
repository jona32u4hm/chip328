;chip8 interpreter for ATmega328P
;written by Jonatan HidalgoMorales in 2026

;--------MEMORY MAP:--------
;0x000-0x1FF CHIP8 Interpreter RAM:
;   0x000 - 0x01F -> 32 Registers
;   0x020 - 0x05F -> 64 I/O Registers
;   0x060 - 0x0FF -> 160 Ext I/O Regs
;   0x100 - 0x1FF -> FONTS, STACK, and Other variables
;0x200-0x8FF - Program ROM (copy necessary for rare games that modify their own code) 
;                                               and work RAM (up to 2KB limit for ATmega328P)

.dseg
.org 0x100



;--------REGISTERS--------
; V0-15 -> r16-31
; PC
; I
;

; Delay timer
; Sound timer

