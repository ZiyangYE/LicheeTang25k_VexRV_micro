def swap_endianness(data):
    swapped_data = bytearray()
    for i in range(0, len(data), 4):
        chunk = data[i:i+4]
        swapped_chunk = chunk[::-1]
        swapped_data.extend(swapped_chunk)
    return swapped_data

def convert_byte_to_hex(byte_file, hex_file):
    with open(byte_file, 'rb') as f_in:
        with open(hex_file, 'w') as f_out:
            byte_data = f_in.read()
            swapped_data = swap_endianness(byte_data)
            hex_data = swapped_data.hex()

            formatted_hex_data = '\n'.join(hex_data[i:i+8] for i in range(0, len(hex_data), 8))

            f_out.write(formatted_hex_data)

convert_byte_to_hex('Hello_world.bin', 'Hello_world.hex')
