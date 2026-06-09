
import struct
import argparse

parser = argparse.ArgumentParser(
                    prog='push.py',
                    description='trims net-de-get minigame to size')

parser.add_argument('filename')           # positional argument

args = parser.parse_args()

game_data = b""
with open("bin/%s" % args.filename, "rb") as game_bin:
	
	# get game size in blocks
	game_bin.seek(0x4005)
	game_size = struct.unpack('b', game_bin.read(1))[0]
	
	# read that much data
	game_bin.seek(0x4000)
	game_data = game_bin.read(game_size*0x2000)
	
	# trim out trailing zeroes
	game_data = bytearray(game_data).rstrip(b"\x00")[:-1]
	
	# inject checksum
	# checksum = (sum(game_data) - (0x3B + 0xB3)) % 0x10000
	# game_data = game_data[:0x6D] + checksum.to_bytes(2, 'little') + game_data[0x6F:]
	
	
with open("bin/%s" % args.filename, "wb") as game_bin:
	game_bin.write(game_data)