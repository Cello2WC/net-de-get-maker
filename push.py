import struct
import subprocess
import argparse

parser = argparse.ArgumentParser(
                    prog='push.py',
                    description='adds a net-de-get minigame to the reon database')

parser.add_argument('filename')           # positional argument
parser.add_argument('dbuser')             # positional argument
parser.add_argument('dbpass')             # positional argument

args = parser.parse_args()


game_binary = ""
with open("bin/%s" % args.filename, "rb") as game_bin:
	game_binary = game_bin.read()

genre = game_binary[7]
with open("bin/%s.title" % args.filename, "wb") as title:
	t = game_binary[15:36]
	title.write(t[:t.find(b"\x00")])
with open("bin/%s.description" % args.filename, "wb") as description:
	d = game_binary[36:68]
	description.write(d[:d.find(b"\x00")])
	
subprocess.run(["cp", "./bin/%s" % args.filename, "/var/lib/mysql/tmp/"])
subprocess.run(["cp", "./bin/%s.title" % args.filename, "/var/lib/mysql/tmp/"])
subprocess.run(["cp", "./bin/%s.description" % args.filename, "/var/lib/mysql/tmp/"])

# get these from elsewhere i guess...?
level_react = 0
level_smart = 0
level_sense = 0
level_hidden = 0
price = 0

subprocess.run(["mysql", "-u", args.dbuser, "--password=%s" % args.dbpass, "-e", "INSERT INTO bmvj_games VALUES(0, %d, %d, %d, %d, %d, LOAD_FILE('/var/lib/mysql/tmp/%s.title'), LOAD_FILE('/var/lib/mysql/tmp/%s.description'), %d, LOAD_FILE('/var/lib/mysql/tmp/%s'));" % (genre, level_react, level_smart, level_sense, level_hidden, args.filename, args.filename, price, args.filename), "db"])
