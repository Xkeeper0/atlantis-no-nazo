The linux build of asm6f here is built from this commit:
https://github.com/freem/asm6f/blob/fc71233242b79dad144077abbe0e4cb6f7b95026/asm6f.c

asm6f_zp was built with the following changes:
    all "absolute = 0" -> "absolute = 1".

this forces use of absolute addressing where possible,
making building this game a little easier,
since it always uses absolute if possible
