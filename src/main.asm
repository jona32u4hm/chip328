.device ATmega328P
.equ PORTB = 0x05    ; Data Register for Port B
.equ DDRB  = 0x04    ; Data Direction Register for Port B
.equ LED_PIN = 5     ; Arduino Nano onboard LED is PB5

.org 0x0000
    rjmp setup       ; Jump over the Interrupt Vector Table
.org 0x0034
setup:

loop:

    rjmp loop          ; Repeat forever
