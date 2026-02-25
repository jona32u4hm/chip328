
.cseg
timer_increment:
    push r16
    in   r16, SREG      ; Read the Status Register (flags)
    push r16            ; Save flags to the stack
    lds r16, DivTimer
    ;reset semaphore 
    andi r16, ~(1<<7)
    ;inc div timer
    inc r16
    cpi  r16, CHIP8_FREQ/60 ;if period not done, continue and store after the jump
    brsh period_done
    rjmp isr_done

period_done:


    ;dec delay and sound timers
    lds r16, SoundTimer
    tst r16
    breq skip_sound_timer
    dec r16
    sts SoundTimer, r16

skip_sound_timer:

    lds r16, DelayTimer
    tst r16
    breq skip_delay_timer
    dec r16
    sts DelayTimer, r16

skip_delay_timer:


    clr  r16 ;to store a 0 in DivTimer
isr_done:
    sts  DivTimer, r16
    pop r16
    out  SREG, r16      ; Restore Status Register
    pop  r16            ; Restore r16 to its original state
    reti