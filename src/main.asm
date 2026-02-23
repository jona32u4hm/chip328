.device ATmega328P

.org 0x0000
    rjmp setup       ; Jump over the Interrupt Vector Table
.org 0x0034
setup:

loop:

    rjmp loop          
