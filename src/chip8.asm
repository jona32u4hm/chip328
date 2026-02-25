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

.equ CHIP8_FREQ = 600 

.cseg
.org 0x0000
    rjmp setup       ; Jump over the Interrupt Vector Table

.cseg
.org 0x0016       ; This is the Timer1 Compare Match A vector
    jmp timer_increment


.cseg 
.org 0x0034
setup:
    sbi DDRB, 5        ; Data Direction Register B: bit 5 = 1 (Output)
    ;set stack to top of WRAM:
    ldi r16, LOW(RAMEND)
    out SPL, r16
    ldi r16, HIGH(RAMEND)
    out SPH, r16
setup_timer:

    ;aprox 600Hz -> 26666 clock cycles 
    ldi r16, high(16000000/CHIP8_FREQ - 1)
    sts OCR1AH, r16
    ldi r16, low(16000000/CHIP8_FREQ - 1)
    sts OCR1AL, r16

    ; Configure TCCR1B:
    ; Bit 3 (WGM12) = 1  -> CTC Mode
    ; Bit 0 (CS10)  = 1  -> Prescaler = 1
    ldi r16,  0
    sts TCCR1A, r16
    ldi r16, (1 << CS10)
    sts TCCR1B, r16 

    ;Enable interrupt:
    ldi r16, (1 << OCIE1A) 
    sts TIMSK1, r16
    sei



loop:
    sleep ;cpu stops and waits for timer to wake it up at the chip8 frecuency
    lds r16, DivTimer
    sbrs r16, 7 ;if bit set skip the jump  --+
    rjmp loop   ;if not, wait for interrupt  |
    ldi r16, (1<<7) ;clear flag            <-+
    sts DivTimer, r16




    ; FETCH

    ; DECODE

    ; EXECUTE

    rjmp loop      









.include "src/RAM.asm"
.include "src/interrupts.asm"