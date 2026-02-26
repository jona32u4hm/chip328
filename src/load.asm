load_rom:
    ; 1. Point Z to the ROM in FLASH
    ldi r30, low(rom_data)  
    ldi r31, high(rom_data) 

    ; 2. Point X to the ROM start in SRAM (0x200)
    ;0x200 into CHIP8 RAM 
    ldi r26, low(0x0200)
    ldi r27, high(0x0200)

    ldi r20, high(rom_data_end - rom_data) ; High byte of counter (if ROM > 255 bytes)
    ldi r21, low(rom_data_end - rom_data) ; Low byte of counter

copy_loop:
    lpm r16, Z+       ; Load from Flash into r16, then increment Z
    st  X+, r16       ; Store r16 into SRAM, then increment X
    sbiw r24, 1       ; dec counter
    brne copy_loop    ; repeat if not done
    ret