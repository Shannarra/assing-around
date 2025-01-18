set -e

# Give it a MASSIVE buffer so you never run out of memory,
# especially since "numbers" does nested loops and whatnot
fasm -m 100_000 $1.asm
chmod +x $1
# Run the example and forward all arguments to it
./$1 $@ 
