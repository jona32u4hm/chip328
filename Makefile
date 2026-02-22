# Project Settings
TARGET   = main
MCU      = atmega328p
PROGRAMMER = arduino
PORT     = /dev/ttyUSB0
BAUD     = 57600

# Directories
SRC_DIR  = src
BUILD_DIR = build

# Files
SRC      = $(SRC_DIR)/$(TARGET).asm
HEX      = $(BUILD_DIR)/$(TARGET).hex

# Tools
ASM      = avra
FLASH    = avrdude

all: $(HEX)

# Assembly Rule
# AVRA outputs files in the same directory as the source by default, 
# so result is moved to the build directory.
$(HEX): $(SRC)
	@mkdir -p $(BUILD_DIR)
	$(ASM) -fI -o $(TARGET).hex $(SRC)
	@mv $(SRC_DIR)/$(TARGET).hex $(BUILD_DIR)/
	@mv $(SRC_DIR)/$(TARGET).obj $(BUILD_DIR)/ 2>/dev/null || true
	@mv $(SRC_DIR)/$(TARGET).cof $(BUILD_DIR)/ 2>/dev/null || true
	@mv $(SRC_DIR)/$(TARGET).eep.hex $(BUILD_DIR)/ 2>/dev/null || true

# Flash to Hardware
flash: $(HEX)
	$(FLASH) -p $(MCU) -c $(PROGRAMMER) -P $(PORT) -b $(BAUD) -U flash:w:$(HEX):i

# Cleanup
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all flash clean
