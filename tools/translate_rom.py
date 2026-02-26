with open("./roms/test.ch8", "rb") as f:
    data = f.read()
    print("rom_data:")
    for i in range(0, len(data), 8):
        chunk = data[i:i+8]
        hex_vals = ", ".join([f"0x{b:02X}" for b in chunk])
        print(f"    .db {hex_vals}")