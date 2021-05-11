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

MACRO Block a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, aa, ab, ac, ad, ae, af
	.db a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, aa, ab, ac, ad, ae, af
ENDM

MACRO MusicSeg b1, w2, b3, b4, b5, b6
	.db b1
	.dw w2
	.db b3, b4, b5, b6
ENDM

