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
.include "src/RAM.asm"

.equ CHIP8_FREQ = 600 

.cseg
.org 0x0000
    rjmp setup       ; Jump over the Interrupt Vector Table

.cseg
.org 0x001c       ; This is the Timer1 Compare Match A vector
    reti

.cseg
.org 0x001e       ; This is the Timer1 Compare Match B vector
    reti

.cseg 
.org 0x0034
setup:
    ;set stack to top of WRAM:
    ldi r16, LOW(RAMEND)
    out SPL, r16
    ldi r16, HIGH(RAMEND)
    out SPH, r16
setup_timer:

    ldi r16,  0
    sts TCCR1A, r16

    ;aprox 600Hz -> 26666 clock cycles 
    ldi r16, high(16000000/CHIP8_FREQ - 1)
    sts OCR1AH, r16
    ldi r16, low(16000000/CHIP8_FREQ - 1)
    sts OCR1AL, r16

    ; Configure TCCR1B:
    ; Bit 3 (WGM12) = 1  -> CTC Mode
    ; Bit 0 (CS10)  = 1  -> Prescaler = 1
    ldi r16, (1 << CS10)
    sts TCCR1B, r16

    ldi r16, (1 << OCIE1A)
    sts TIMSK1, r16
    sei


    sbi DDRB, 5

loop:
    sbi PINB, 5
    sleep ;cpu stops and waits for timer to wake it up at the chip8 frecuency

    cbi PINB, 5
    sleep ;cpu stops and waits for timer to wake it up at the chip8 frecuency
    ; FETCH

    ; DECODE

    ; EXECUTE

    rjmp loop      