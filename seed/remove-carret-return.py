import sys

if len(sys.argv) != 2:
	print("pass the filename as an argument in the command line", file=sys.stderr)
	sys.exit(0)

with open(sys.argv[1], "r") as file:
	content = file.read().replace("\r", "").replace("﻿", "")
with open(sys.argv[1], "w") as file:
	content = file.write(content)

