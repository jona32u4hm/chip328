;----------------memorymap of RAM for chip328----------------

.dseg
.org 0x100
FrameBuffer: .byte 256

.dseg
.org 0x200
WRAM: ;this is where the game and variables are stored up to the 2KB limit



.dseg
.org 0x7A0
;CHIP8 STACK:
VirtualStack: .byte 16*2 ;stack grows upward in memory (sp inc when push)
DelayTimer: .byte 1
SoundTimer: .byte 1
DivTimer: .byte 1 ;Bit 7 is used as semaphore flag for cpu wake, high when waiting for interrupt
StackPointer: .byte 1
FontRAM: .byte 16*5 ;16 characters 5 bytes each

;Hardware stack at the top of WRAM
;----------------end of RAM----------------