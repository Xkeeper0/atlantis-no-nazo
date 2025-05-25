MACRO Door a1, a2, a3, a4
	.db a1, a2, a3, a4
ENDM

MACRO Item a1, a2, a3, a4
	.db a1, a2, a3, a4
ENDM

MACRO FireballSpawnerPos a1, a2
	.db a1, a2
ENDM

MACRO BigWord a1, a2
	.db a1, a2
ENDM

; 8 columns * 2 rows per block (16 bytes)
MACRO Block t0, b0, t1, b1, t2, b2, t3, b3, t4, b4, t5, b5, t6, b6, t7, b7
	.db t0, b0, t1, b1, t2, b2, t3, b3, t4, b4, t5, b5, t6, b6, t7, b7
ENDM

MACRO MusicSeg b1, w2, b3, b4, b5, b6
	.db b1
	.dw w2
	.db b3, b4, b5, b6
ENDM

; 2 bits per tile * 8 tiles
MACRO ColumnAttribs t1, t2, t3, t4, t5, t6, t7, t8
	.db (t1 << 6) | (t2 << 4) | (t3 << 2) | (t4)
	.db (t5 << 6) | (t6 << 4) | (t7 << 2) | (t8)
ENDM

; 2 bits per tile * 8 tiles
MACRO ColumnSolidity t1, t2, t3, t4, t5, t6, t7, t8
	.db (t1 << 6) | (t2 << 4) | (t3 << 2) | (t4)
	.db (t5 << 6) | (t6 << 4) | (t7 << 2) | (t8)
ENDM

