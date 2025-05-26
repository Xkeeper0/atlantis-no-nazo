# Atlantis no Nazo ("Mystery of Atlantis") disassembly

A disassembly of one of the more infamous flavors of _kusoge_.

This is a work-in-progress, but this disassembly builds a 1:1 copy of the ROM,
and allows shifting ROM data around (there should be no hard-coded addresses).

Special thanks to [りなお(rinao)](https://web.archive.org/web/20030607155301/http://refam.virtualave.net/atlantis/index.html) (archived page),
which has a mostly-commented partial disassembly (as well as many other notes).

See also:
* [TCRF page for this game](https://tcrf.net/The_Mystery_of_Atlantis)

Original game code and assets © Sunsoft.


### Notes

This also builds the "sample" release of the ROM. There are very few meaningful differences.
Most appear to be unprogrammed EPROM space or other uninitialized memory.

You can specifically build the sample version by defining the `-dSAMPLE` build flag.

----

## Building

Run `build.bat` or `build.sh`. It should spit out a copy of the ROM in the `bin/` folder.

This disassembly is designed to be built with a custom version of **asm6f**, which is
included in the `tools` directory. (The changes disable using "zero page" opcodes
when possible; see below.)

While it is compatible with normal builds, it will not build 1:1 ROMs. The disassembly
would need to have _every single zero-page address_ prepended with `a:`, and I am _tired_.


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
