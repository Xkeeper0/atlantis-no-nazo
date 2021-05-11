# Atlantis no Nazo ("Mystery of Atlantis") disassembly

A disassembly of one of the more infamous flavors of _kusoge_.

You should probably go find something else to look at, because this game is not good.


----

## Building

Run `build.bat`. It should spit out a copy of the ROM in the `bin/` folder.

This disassembly is designed to be built with a custom copy of **asm6f**, which is
included in the `tools` directory.


### This game is not very good

In this game, none of the instructions that support zero-page addressing have that
addressing mode used. Every opcode that would be usable with zero-page addressing
instead uses absolute (full) addressing. Unfortunately, asm6f does not support
forcing absolute addressing, and even if it did, there would be far too many instances
of it to fix everywhere.

A custom build of **asm6f** is included that has had support for zero-page opcodes
removed. The original version, which still supports ZP addressing, is included as
**asm6fzp.exe**. However, for the time being, the game is unplayable due to
unidentified / labeled pointers.
