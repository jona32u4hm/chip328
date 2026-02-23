;----------------memorymap of RAM for chip328----------------

.dseg
.org 0x100
;CHIP8 STACK:
VirtualStack: .byte 16*2 ;stack grows upward in memory (sp inc when push)
DelayTimer: .byte 1
SoundTimer: .byte 1
StackPointer: .byte 1
FontRAM: .byte 16*5 ;16 characters 5 bytes each

.org 0x200
WRAM: ;this is where the game and variables are stored up to the 2KB limit





.org 0x7FF
HardwareStack: ;this is the end of the hardware AVR stack which grows downward to lower memory addresses
.org 0x800
FrameBuffer: .byte 256

;----------------end of RAM----------------