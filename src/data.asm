
.include "src/music-data.asm"

IFNDEF REMOVE_MAYBE_UNUSED_DATA
	.include "src/unused-unknown.asm"
ENDIF

ZoneDoorTable:
	; zone-1   x    y   to id
	; x = tile position across entire zone
	; y = tile position * 4
	Door   0, $30, $20,   0 ;
	Door   0, $92, $30, $12 ;		; 1
	Door   5,  $C, $28,   4 ;		; 2
	Door   5, $1C, $28, $59 ;		; 3
	Door   7,  $A, $18, $1D ;		; 4
	Door   7, $CB, $34, $42 ;		; 5
	Door  15,  $C, $30,   8 ;		; 6
	Door  15, $F3, $30, $1A ;		; 7
	Door  18,   8, $34,   6 ;		; 8
	Door  18, $88, $34, $1F ;		; 9
	Door  32,   5, $20, $59 ;		; $A
	Door  32, $F2, $28, $25 ;		; $B
	Door  68,   5, $20,  $C ;		; $C
	Door  68, $F2, $28, $38 ;		; $D
	Door  81,  $D, $28, $7E ;		; $E
	Door  81, $9A, $28, $4C ;		; $F
	Door   0, $17, $3C,  $A ;		; $10
	Door   1, $79, $10, $14 ;		; $11
	Door   1, $11, $38,   1 ;		; $12
	Door   1, $D7, $14, $AD ;		; $13
	Door   2, $22, $30, $11 ;		; $14
	Door   2, $A7, $30, $49 ;		; $15
	Door   2, $58, $3C,   3 ;		; $16
	Door  11,   8, $30, $43 ;		; $17
	Door  11, $77, $30, $1B ;		; $18
	Door  11, $38, $30, $B0 ;		; $19
	Door  12,  $C, $14,   7 ;		; $1A
	Door  12, $AB, $24, $18 ;		; $1B
	Door   6, $1A, $2C, $A5 ;		; $1C
	Door   6, $A5, $2C,   4 ;		; $1D
	Door   7, $A0, $34, $A4 ;		; $1E
	Door  20, $1A, $1C,   9 ;		; $1F
	Door  20,   9, $1C, $8F ;		; $20
	Door  20, $19, $2C, $71 ;		; $21
	Door  26, $18, $30, $70 ;		; $22
	Door  26, $AD, $30, $48 ;		; $23
	Door  26, $AF, $30, $B4 ;		; $24
	Door  33,  $D, $20, $59 ;		; $25
	Door  33, $72, $28, $28 ;		; $26
	Door  33, $47, $18, $2C ;		; $27
	Door  35, $38, $34, $26 ;		; $28
	Door  35, $14, $14, $2C ;		; $29
	Door  36, $7B, $34, $B6 ;		; $2A
	Door  36, $7D, $30, $57 ;		; $2B
	Door  36, $13, $10, $59 ;		; $2C
	Door  49,   8, $38, $5A ;		; $2D
	Door  49,   8, $10, $77 ;		; $2E
	Door  49, $76, $18, $59 ;		; $2F
	Door  55, $72, $20, $59 ;		; $30
	Door  55, $4D, $28, $53 ;		; $31
	Door  55, $4A, $28, $6A ;		; $32
	Door  55,  $D, $28, $8B ;		; $33
	Door  59, $78, $34, $AE ;		; $34
	Door  59,   8, $2C, $9F ;		; $35
	Door  59,  $F, $3C, $BD ;		; $36
	Door  59, $12, $24, $59 ;		; $37
	Door  69,  $B, $10,  $D ;		; $38
	Door  69,  $C, $38, $98 ;		; $39
	Door  72, $8F, $30, $3C ;		; $3A
	Door  72,   8, $10, $99 ;		; $3B
	Door  73,  $D, $28, $3A ;		; $3C
	Door  73, $8A, $28, $5E ;		; $3D
	Door  89,  $C, $30, $85 ;		; $3E
	Door  89, $1C, $30, $46 ;		; $3F
	Door  91, $18, $30, $A8 ;		; $40
	Door  91, $A6, $30, $7B ;		; $41
	Door   9, $1A, $2C,   5 ;		; $42
	Door   9, $9E, $2C, $17 ;		; $43
	Door  24,  $C, $30,  $A ;		; $44
	Door  24, $12, $30, $67 ;		; $45
	Door  86,   8, $34, $3F ;		; $46
	Door  86, $60, $14, $BF ;		; $47
	Door  28,  $D, $28, $23 ;		; $48
	Door   3, $1E, $28, $15 ;		; $49
	Door  42, $16, $10, $9D ;		; $4A
	Door  76,   8, $1C, $59 ;		; $4B
	Door  80, $25,   8,  $F ;		; $4C
	Door  84, $18, $20, $C1 ;		; $4D
	Door  17, $18, $14, $C4 ;		; $4E
	Door  42, $79, $18, $92 ;		; $4F
	Door  76, $BE, $30, $81 ;		; $50
	Door  80, $22, $38, $55 ;		; $51
	Door  84, $92, $28, $7D ;		; $52
	Door  61, $20, $28, $31 ;		; $53
	Door  61, $21, $28, $89 ;		; $54
	Door  79, $3E, $28, $51 ;		; $55
	Door  96, $45, $28, $D7 ;		; $56
	Door  38, $12, $14, $2B ;		; $57
	Door  38, $14, $34, $91 ;		; $58
	Door  41, $17, $10, $CA ;		; $59
	Door  50, $21, $20, $2D ;		; $5A
	Door  93, $1D, $2C, $D6 ;		; $5B
	Door  64, $39, $20, $6F ;		; $5C
	Door  97, $65, $2C, $7C ;		; $5D
	Door  74,  $A, $18, $3D ;		; $5E
	Door  94,  $D, $28, $88 ;		; $5F
	Door  31, $52, $20, $59 ;		; $60
	Door  74,  $A, $28, $4B ;		; $61
	Door  50, $5E, $2C, $30 ;		; $62
	Door  97, $1A, $28, $72 ;		; $63
	Door  64,  $F, $2C, $9E ;		; $64
	Door  94, $40, $30, $85 ;		; $65
	Door  31,  $D, $28,  $A ;		; $66
	Door   3, $CC, $30, $45 ;		; $67
	Door  79,   8, $28, $75 ;		; $68
	Door  96, $19, $2C, $D0 ;		; $69
	Door  56, $A5, $10, $32 ;		; $6A
	Door  56, $1E, $28, $BA ;		; $6B
	Door  44,  $D, $28, $79 ;		; $6C
	Door  44, $74, $20, $93 ;		; $6D
	Door  66, $1A, $20,  $C ;		; $6E
	Door  66, $65, $10, $5C ;		; $6F
	Door  22,   8, $28, $22 ;		; $70
	Door  22, $9F, $28, $21 ;		; $71
	Door  98, $E4,  $C, $63 ;		; $72
	Door  98, $92, $30, $78 ;		; $73
	Door  78,  $D, $18, $82 ;		; $74
	Door  78, $B3, $20, $68 ;		; $75
	Door  51,  $D, $28, $30 ;		; $76
	Door  51, $6A, $20, $59 ;		; $77
	Door  99,   8, $30, $73 ;		; $78
	Door  45, $46, $2C, $6C ;		; $79
	Door  45, $11, $2C, $2F ;		; $7A
	Door  95,   9, $20, $59 ;		; $7B
	Door  95, $85, $34, $5D ;		; $7C
	Door  82,   8, $24, $52 ;		; $7D
	Door  82, $2B, $14,   0 ;		; $7E
	Door  46,  $D, $28, $77 ;		; $7F
	Door  46, $73, $30, $B8 ;		; $80
	Door  77, $1D, $38, $50 ;		; $81
	Door  77, $25, $28, $74 ;		; $82
	Door  83,  $D, $28, $7E ;		; $83
	Door  83, $3A, $20, $D1 ;		; $84
	Door  92,  $C, $10, $59 ;		; $85
	Door  92,  $A, $2C, $7B ;		; $86
	Door  90,  $B, $10, $E5 ;		; $87
	Door  90,  $B, $2C, $5F ;		; $88
	Door  62,  $E, $10, $54 ;		; $89
	Door  62,  $B, $30, $37 ;		; $8A
	Door  75,   9, $30, $33 ;		; $8B
	Door  75,  $F, $3C, $4B ;		; $8C
	Door  23,  $D, $28, $25 ;		; $8D
	Door  23, $33, $38, $A7 ;		; $8E
	Door  23, $5A, $20, $59 ;		; $8F
	Door  48, $22, $28, $2F ;		; $90
	Door  48,  $D, $28, $58 ;		; $91
	Door  43,  $D, $20, $4F ;		; $92
	Door  43, $82, $28, $6D ;		; $93
	Door  65,   8, $20, $A0 ;		; $94
	Door  65,  $F, $20, $CD ;		; $95
	Door  10,   9, $28, $C2 ;		; $96
	Door  58, $28, $30, $B3 ;		; $97
	Door  71,   8, $28, $47 ;		; $98
	Door  71, $95, $30, $3B ;		; $99
	Door  29, $19, $20, $B5 ;		; $9A
	Door  29, $7F, $2C, $60 ;		; $9B
	Door  39,   8, $30, $B7 ;		; $9C
	Door  39, $77, $30, $4A ;		; $9D
	Door  60, $1E, $28, $64 ;		; $9E
	Door  60, $62, $28, $35 ;		; $9F
	Door  70,  $D, $28, $94 ;		; $A0
	Door  70, $62, $28, $98 ;		; $A1
	Door  54, $1A, $28, $D1 ;		; $A2
	Door  52, $19, $20, $C7 ;		; $A3
	Door  14,  $C, $30, $1E ;		; $A4
	Door   3, $68, $28, $1C ;		; $A5
	Door   4, $12, $18, $D8 ;		; $A6
	Door  34, $10, $38, $8E ;		; $A7
	Door  88, $75, $2C, $40 ;		; $A8
	Door  21,  $F, $38, $CC ;		; $A9
	Door  40,  $D, $28, $DF ;		; $AA
	Door  30,   8, $30, $CB ;		; $AB
	Door  16,   9, $30, $C5 ;		; $AC
	Door   8,   8, $30, $13 ;		; $AD
	Door  63,  $E, $30, $34 ;		; $AE
	Door  53,  $D, $38, $C6 ;		; $AF
	Door  13, $21, $34, $19 ;		; $B0
	Door  19,  $D, $28, $E6 ;		; $B1
	Door  25,  $D, $28, $DD ;		; $B2
	Door  25, $82, $28, $60 ;		; $B3
	Door  27,   8, $30, $24 ;		; $B4
	Door  27, $5D, $20, $9A ;		; $B5
	Door  37, $19, $30, $2A ;		; $B6
	Door  37, $5E, $30, $9C ;		; $B7
	Door  47, $1E, $28, $80 ;		; $B8
	Door  47, $60, $28, $C8 ;		; $B9
	Door  57,   8, $20, $6B ;		; $BA
	Door  57, $48, $20, $37 ;		; $BB
	Door  67, $37, $24, $98 ;		; $BC
	Door  67,   8, $20, $36 ;		; $BD
	Door  87, $14, $20, $DE ;		; $BE
	Door  85, $1E, $30, $47 ;		; $BF
	Door  85, $6E, $30,  $C ;		; $C0
	Door  88, $1E, $2C, $4D ;		; $C1
	Door   0, $9F, $30, $96 ;		; $C2
	Door   8,  $F, $30,   4 ;		; $C3
	Door  15, $F5, $30, $4E ;		; $C4
	Door  18, $82, $24, $AC ;		; $C5
	Door  50, $40, $30, $AF ;		; $C6
	Door  42, $27, $28, $A3 ;		; $C7
	Door  44, $12, $28, $B9 ;		; $C8
	Door  28, $6D, $30, $60 ;		; $C9
	Door  28, $6E, $30, $59 ;		; $CA
	Door  28, $6F, $30, $AB ;		; $CB
	Door  12, $18, $24, $A9 ;		; $CC
	Door  79, $30, $14, $95 ;		; $CD
	Door  71,   8, $30, $77 ;		; $CE
	Door  82,  $F, $24, $85 ;		; $CF
	Door  99,   8, $1C, $59 ;		; $D0
	Door  58, $50, $30, $A2 ;		; $D1
	Door  58, $58, $30,  $C ;		; $D2
	Door  49, $2C, $24, $97 ;		; $D3
	Door  19, $3A, $28,   4 ;		; $D4
	Door   4, $17, $14, $8F ;		; $D5
	Door  40,  $E, $28, $5B ;		; $D6
	Door  93, $3F, $2C, $56 ;		; $D7
	Door   1, $D5, $10, $A6 ;		; $D8
	Door   5,  $B, $30, $60 ;		; $D9
	Door   6, $AD, $24, $2C ;		; $DA
	Door  10,  $D, $3C, $77 ;		; $DB
	Door  12, $84, $34, $92 ;		; $DC
	Door  17, $18, $24, $B2 ;		; $DD
	Door  18, $70, $14, $BE ;		; $DE
	Door  24, $13, $30, $AA ;		; $DF
	Door  26, $EF, $2C, $30 ;		; $E0
	Door  31,  $E, $28, $2C ;		; $E1
	Door  32,   2, $20, $59 ;		; $E2
	Door  43,  $A, $20, $59 ;		; $E3
	Door  45, $1B, $2C, $2F ;		; $E4
	Door  51, $11, $3C, $87 ;		; $E5
	Door   7, $ED, $2C, $B1 ;		; $E6
	Door  17, $18, $34,   3 ;		; $E7
	Door  99, $6F, $30, $E9 ;		; $E8
	Door  19, $23, $2C, $E8 ;		; $E9
	Door  93, $39, $20, $37 ;		; $EA
	Door   3, $94, $10, $EC ;		; $EB
	Door   9, $9F, $2C, $EB ;		; $EC
	Door  88, $48, $3C,  $C ;		; $ED
	Door 255,   0,   0,   0 ;		; $EE
IFDEF SAMPLE
	Door 255,	 0, $FF,   0 ;		; $EF
ELSE
	Door 255,	 0, $F7,   0 ;		; $EF
ENDIF

ZoneDoorFlagsTable:
	DoorFlag  DoorFlags_Hidden
	DoorFlag  DoorFlags_Open		; 1
	DoorFlag  DoorFlags_Open		; 2
	DoorFlag  DoorFlags_Closed		; 3
	DoorFlag  DoorFlags_Closed		; 4
	DoorFlag  DoorFlags_Open		; 5
	DoorFlag  DoorFlags_Open		; 6
	DoorFlag  DoorFlags_Open		; 7
	DoorFlag  DoorFlags_Open		; 8
	DoorFlag  DoorFlags_Open		; 9
	DoorFlag  DoorFlags_Open		; $A
	DoorFlag  DoorFlags_Open		; $B
	DoorFlag  DoorFlags_Open		; $C
	DoorFlag  DoorFlags_Open		; $D
	DoorFlag  DoorFlags_Open		; $E
	DoorFlag  DoorFlags_Open		; $F
	DoorFlag  DoorFlags_Invisible	; $10
	DoorFlag  DoorFlags_Open		; $11
	DoorFlag  DoorFlags_Open		; $12
	DoorFlag  DoorFlags_Open		; $13
	DoorFlag  DoorFlags_Open		; $14
	DoorFlag  DoorFlags_Open		; $15
	DoorFlag  DoorFlags_Invisible	; $16
	DoorFlag  DoorFlags_Open		; $17
	DoorFlag  DoorFlags_Closed		; $18
	DoorFlag  DoorFlags_Hidden		; $19
	DoorFlag  DoorFlags_Open		; $1A
	DoorFlag  DoorFlags_Open		; $1B
	DoorFlag  DoorFlags_Open		; $1C
	DoorFlag  DoorFlags_Open		; $1D
	DoorFlag  DoorFlags_Hidden		; $1E
	DoorFlag  DoorFlags_Closed		; $1F
	DoorFlag  DoorFlags_Invisible	; $20
	DoorFlag  DoorFlags_Closed		; $21
	DoorFlag  DoorFlags_Open		; $22
	DoorFlag  DoorFlags_Closed		; $23
	DoorFlag  DoorFlags_Closed		; $24
	DoorFlag  DoorFlags_Open		; $25
	DoorFlag  DoorFlags_Open		; $26
	DoorFlag  DoorFlags_Invisible	; $27
	DoorFlag  DoorFlags_Open		; $28
	DoorFlag  DoorFlags_Open		; $29
	DoorFlag  DoorFlags_Open		; $2A
	DoorFlag  DoorFlags_Hidden		; $2B
	DoorFlag  DoorFlags_Open		; $2C
	DoorFlag  DoorFlags_Closed		; $2D
	DoorFlag  DoorFlags_Closed		; $2E
	DoorFlag  DoorFlags_Open		; $2F
	DoorFlag  DoorFlags_Open		; $30
	DoorFlag  DoorFlags_Hidden		; $31
	DoorFlag  DoorFlags_Closed		; $32
	DoorFlag  DoorFlags_Open		; $33
	DoorFlag  DoorFlags_Closed		; $34
	DoorFlag  DoorFlags_Open		; $35
	DoorFlag  DoorFlags_Invisible	; $36
	DoorFlag  DoorFlags_Closed		; $37
	DoorFlag  DoorFlags_Open		; $38
	DoorFlag  DoorFlags_Open		; $39
	DoorFlag  DoorFlags_Open		; $3A
	DoorFlag  DoorFlags_Open		; $3B
	DoorFlag  DoorFlags_Open		; $3C
	DoorFlag  DoorFlags_Open		; $3D
	DoorFlag  DoorFlags_Open		; $3E
	DoorFlag  DoorFlags_Open		; $3F
	DoorFlag  DoorFlags_Open		; $40
	DoorFlag  DoorFlags_Open		; $41
	DoorFlag  DoorFlags_Open		; $42
	DoorFlag  DoorFlags_Open		; $43
	DoorFlag  DoorFlags_Open		; $44
	DoorFlag  DoorFlags_Open		; $45
	DoorFlag  DoorFlags_Open		; $46
	DoorFlag  DoorFlags_Closed		; $47
	DoorFlag  DoorFlags_Open		; $48
	DoorFlag  DoorFlags_Open		; $49
	DoorFlag  DoorFlags_Open		; $4A
	DoorFlag  DoorFlags_Closed		; $4B
	DoorFlag  DoorFlags_Open		; $4C
	DoorFlag  DoorFlags_Open		; $4D
	DoorFlag  DoorFlags_Open		; $4E
	DoorFlag  DoorFlags_Open		; $4F
	DoorFlag  DoorFlags_Open		; $50
	DoorFlag  DoorFlags_Open		; $51
	DoorFlag  DoorFlags_Open		; $52
	DoorFlag  DoorFlags_Open		; $53
	DoorFlag  DoorFlags_Closed		; $54
	DoorFlag  DoorFlags_Open		; $55
	DoorFlag  DoorFlags_Open		; $56
	DoorFlag  DoorFlags_Open		; $57
	DoorFlag  DoorFlags_Open		; $58
	DoorFlag  DoorFlags_Open		; $59
	DoorFlag  DoorFlags_Open		; $5A
	DoorFlag  DoorFlags_Open		; $5B
	DoorFlag  DoorFlags_Open		; $5C
	DoorFlag  DoorFlags_Open		; $5D
	DoorFlag  DoorFlags_Open		; $5E
	DoorFlag  DoorFlags_Open		; $5F
	DoorFlag  DoorFlags_Closed		; $60
	DoorFlag  DoorFlags_Open		; $61
	DoorFlag  DoorFlags_Open		; $62
	DoorFlag  DoorFlags_Open		; $63
	DoorFlag  DoorFlags_Open		; $64
	DoorFlag  DoorFlags_Open		; $65
	DoorFlag  DoorFlags_Open		; $66
	DoorFlag  DoorFlags_Open		; $67
	DoorFlag  DoorFlags_Open		; $68
	DoorFlag  DoorFlags_Open		; $69
	DoorFlag  DoorFlags_Open		; $6A
	DoorFlag  DoorFlags_Open		; $6B
	DoorFlag  DoorFlags_Open		; $6C
	DoorFlag  DoorFlags_Open		; $6D
	DoorFlag  DoorFlags_Open		; $6E
	DoorFlag  DoorFlags_Open		; $6F
	DoorFlag  DoorFlags_Open		; $70
	DoorFlag  DoorFlags_Open		; $71
	DoorFlag  DoorFlags_Open		; $72
	DoorFlag  DoorFlags_Hidden		; $73
	DoorFlag  DoorFlags_Open		; $74
	DoorFlag  DoorFlags_Open		; $75
	DoorFlag  DoorFlags_Open		; $76
	DoorFlag  DoorFlags_Closed		; $77
	DoorFlag  DoorFlags_Closed		; $78
	DoorFlag  DoorFlags_Open		; $79
	DoorFlag  DoorFlags_Open		; $7A
	DoorFlag  DoorFlags_Closed		; $7B
	DoorFlag  DoorFlags_Open		; $7C
	DoorFlag  DoorFlags_Open		; $7D
	DoorFlag  DoorFlags_Open		; $7E
	DoorFlag  DoorFlags_Open		; $7F
	DoorFlag  DoorFlags_Open		; $80
	DoorFlag  DoorFlags_Open		; $81
	DoorFlag  DoorFlags_Open		; $82
	DoorFlag  DoorFlags_Open		; $83
	DoorFlag  DoorFlags_Closed		; $84
	DoorFlag  DoorFlags_Hidden		; $85
	DoorFlag  DoorFlags_Hidden		; $86
	DoorFlag  DoorFlags_Open		; $87
	DoorFlag  DoorFlags_Open		; $88
	DoorFlag  DoorFlags_Open		; $89
	DoorFlag  DoorFlags_Hidden		; $8A
	DoorFlag  DoorFlags_Open		; $8B
	DoorFlag  DoorFlags_Invisible	; $8C
	DoorFlag  DoorFlags_Open		; $8D
	DoorFlag  DoorFlags_Hidden		; $8E
	DoorFlag  DoorFlags_Open		; $8F
	DoorFlag  DoorFlags_Open		; $90
	DoorFlag  DoorFlags_Open		; $91
	DoorFlag  DoorFlags_Open		; $92
	DoorFlag  DoorFlags_Open		; $93
	DoorFlag  DoorFlags_Open		; $94
	DoorFlag  DoorFlags_Open		; $95
	DoorFlag  DoorFlags_Open		; $96
	DoorFlag  DoorFlags_Open		; $97
	DoorFlag  DoorFlags_Closed		; $98
	DoorFlag  DoorFlags_Open		; $99
	DoorFlag  DoorFlags_Open		; $9A
	DoorFlag  DoorFlags_Open		; $9B
	DoorFlag  DoorFlags_Open		; $9C
	DoorFlag  DoorFlags_Open		; $9D
	DoorFlag  DoorFlags_Open		; $9E
	DoorFlag  DoorFlags_Open		; $9F
	DoorFlag  DoorFlags_Open		; $A0
	DoorFlag  DoorFlags_Open		; $A1
	DoorFlag  DoorFlags_Open		; $A2
	DoorFlag  DoorFlags_Open		; $A3
	DoorFlag  DoorFlags_Open		; $A4
	DoorFlag  DoorFlags_Open		; $A5
	DoorFlag  DoorFlags_Open		; $A6
	DoorFlag  DoorFlags_Open		; $A7
	DoorFlag  DoorFlags_Open		; $A8
	DoorFlag  DoorFlags_Open		; $A9
	DoorFlag  DoorFlags_Open		; $AA
	DoorFlag  DoorFlags_Open		; $AB
	DoorFlag  DoorFlags_Open		; $AC
	DoorFlag  DoorFlags_Open		; $AD
	DoorFlag  DoorFlags_Open		; $AE
	DoorFlag  DoorFlags_Open		; $AF
	DoorFlag  DoorFlags_Open		; $B0
	DoorFlag  DoorFlags_Open		; $B1
	DoorFlag  DoorFlags_Open		; $B2
	DoorFlag  DoorFlags_Open		; $B3
	DoorFlag  DoorFlags_Open		; $B4
	DoorFlag  DoorFlags_Open		; $B5
	DoorFlag  DoorFlags_Open		; $B6
	DoorFlag  DoorFlags_Open		; $B7
	DoorFlag  DoorFlags_Open		; $B8
	DoorFlag  DoorFlags_Open		; $B9
	DoorFlag  DoorFlags_Open		; $BA
	DoorFlag  DoorFlags_Open		; $BB
	DoorFlag  DoorFlags_Open		; $BC
	DoorFlag  DoorFlags_Open		; $BD
	DoorFlag  DoorFlags_Open		; $BE
	DoorFlag  DoorFlags_Open		; $BF
	DoorFlag  DoorFlags_Open		; $C0
	DoorFlag  DoorFlags_Open		; $C1
	DoorFlag  DoorFlags_Closed		; $C2
	DoorFlag  DoorFlags_Open		; $C3
	DoorFlag  DoorFlags_Hidden		; $C4
	DoorFlag  DoorFlags_Hidden		; $C5
	DoorFlag  DoorFlags_Hidden		; $C6
	DoorFlag  DoorFlags_Hidden		; $C7
	DoorFlag  DoorFlags_Open		; $C8
	DoorFlag  DoorFlags_Closed		; $C9
	DoorFlag  DoorFlags_Closed		; $CA
	DoorFlag  DoorFlags_Closed		; $CB
	DoorFlag  DoorFlags_Hidden		; $CC
	DoorFlag  DoorFlags_Open		; $CD
	DoorFlag  DoorFlags_Closed		; $CE
	DoorFlag  DoorFlags_Invisible	; $CF
	DoorFlag  DoorFlags_Closed		; $D0
	DoorFlag  DoorFlags_Invisible	; $D1
	DoorFlag  DoorFlags_Open		; $D2
	DoorFlag  DoorFlags_Hidden		; $D3
	DoorFlag  DoorFlags_Open		; $D4
	DoorFlag  DoorFlags_Hidden		; $D5
	DoorFlag  DoorFlags_Hidden		; $D6
	DoorFlag  DoorFlags_Hidden		; $D7
	DoorFlag  DoorFlags_Hidden		; $D8
	DoorFlag  DoorFlags_Hidden		; $D9
	DoorFlag  DoorFlags_Invisible	; $DA
	DoorFlag  DoorFlags_Invisible	; $DB
	DoorFlag  DoorFlags_Hidden		; $DC
	DoorFlag  DoorFlags_Hidden		; $DD
	DoorFlag  DoorFlags_Hidden		; $DE
	DoorFlag  DoorFlags_Hidden		; $DF
	DoorFlag  DoorFlags_Invisible	; $E0
	DoorFlag  DoorFlags_Hidden		; $E1
	DoorFlag  DoorFlags_Closed		; $E2
	DoorFlag  DoorFlags_Closed		; $E3
	DoorFlag  DoorFlags_Hidden		; $E4
	DoorFlag  DoorFlags_Invisible	; $E5
	DoorFlag  DoorFlags_Open		; $E6
	DoorFlag  DoorFlags_Hidden		; $E7
	DoorFlag  DoorFlags_Closed		; $E8
	DoorFlag  DoorFlags_Hidden		; $E9
	DoorFlag  DoorFlags_Hidden		; $EA
	DoorFlag  DoorFlags_Hidden		; $EB
	DoorFlag  DoorFlags_Hidden		; $EC
	DoorFlag  DoorFlags_Invisible	; $ED
	DoorFlag  DoorFlags_Open		; $EE
	DoorFlag  DoorFlags_Open		; $EF


ZoneItemTable:
	Item   5, $19, $70, $31 ;		; 0
	Item   5,  $F, $70, $21 ;		; 1
	Item   7, $D7, $70,   5 ;		; 2
	Item   7, $A5, $6C, $11 ;		; 3
	Item  15, $1A, $70,   5 ;		; 4
	Item  15, $81, $70, $21 ;		; 5
	Item  18, $20, $74, $32 ;		; 6
	Item  18, $66, $74, $12 ;		; 7
	Item  18, $78, $54, $31 ;		; 8
	Item  32, $27, $50,   1 ;		; 9
	Item  32, $BA, $60, $31 ;		; $A
	Item  32, $B4, $50, $22 ;		; $B
	Item  68, $90, $70, $41 ;		; $C
	Item  81, $1D, $53, $41 ;		; $D
	Item  81, $9F, $68, $41 ;		; $E
	Item  65,   8, $58, $21 ;		; $F
	Item   1, $28, $78, $31 ;		; $10
	Item   1, $7A, $78, $21 ;		; $11
	Item   1, $8F, $54, $41 ;		; $12
	Item   2, $18, $70, $31 ;		; $13
	Item   2, $A7, $68, $21 ;		; $14
	Item   3, $6C, $70, $21 ;		; $15
	Item   3, $90, $68, $31 ;		; $16
	Item   4, $14, $70, $51 ;		; $17
	Item   4, $1F, $64,   2 ;		; $18
	Item   6, $9D, $74, $31 ;		; $19
	Item   6, $4C, $74, $41 ;		; $1A
	Item   8,  $C, $60, $52 ;		; $1B
	Item   9, $34, $70, $31 ;		; $1C
	Item   9, $60, $64, $41 ;		; $1D
	Item   9, $98, $6C, $31 ;		; $1E
	Item  10,  $B, $74, $45 ;		; $1F
	Item  10,  $D, $70, $45 ;		; $20
	Item  11, $46, $60, $23 ;		; $21
	Item  11, $32, $68, $12 ;		; $22
	Item  12, $A7, $74, $32 ;		; $23
	Item  12, $70, $74, $21 ;		; $24
	Item  12, $18, $64, $31 ;		; $25
	Item  13, $2F, $6C, $32 ;		; $26
	Item  13, $18, $6C, $31 ;		; $27
	Item  14,  $C, $60, $52 ;		; $28
	Item  16,   8, $70, $52 ;		; $29
	Item  17, $10, $74, $41 ;		; $2A
	Item  20, $33, $6C, $35 ;		; $2B
	Item  20,   8, $6C,   4 ;		; $2C
	Item  21,   8, $54, $45 ;		; $2D
	Item  21,  $F, $54, $45 ;		; $2E
	Item  22, $28, $68, $11 ;		; $2F
	Item  23, $4B, $70, $11 ;		; $30
	Item  23, $32, $68, $21 ;		; $31
	Item  24, $17, $70, $45 ;		; $32
	Item  24,   8, $70, $45 ;		; $33
	Item  26, $56, $6C, $31 ;		; $34
	Item  26, $73, $50, $31 ;		; $35
	Item  26, $EC, $50, $31 ;		; $36
	Item  27, $48, $70, $33 ;		; $37
	Item  27, $5A, $70, $31 ;		; $38
	Item  28, $5E, $70, $51 ;		; $39
	Item  28, $77, $60,   3 ;		; $3A
	Item  29, $36, $70, $15 ;		; $3B
	Item  29, $79, $60, $15 ;		; $3C
	Item  30,  $E, $70, $51 ;		; $3D
	Item  31, $35, $74, $15 ;		; $3E
	Item  31, $1A, $74, $12 ;		; $3F
	Item  33, $32, $6C, $31 ;		; $40
	Item  33, $49, $70, $31 ;		; $41
	Item  33, $66, $70, $31 ;		; $42
	Item  34,  $A, $5C, $51 ;		; $43
	Item  34, $15, $5C, $21 ;		; $44
	Item  35, $10, $64, $41 ;		; $45
	Item  35, $36, $74, $31 ;		; $46
	Item  36,   8, $74,   4 ;		; $47
	Item  36, $3E, $74, $31 ;		; $48
	Item  36, $77, $74, $41 ;		; $49
	Item  37, $46, $70, $21 ;		; $4A
	Item  37, $1D, $70, $41 ;		; $4B
	Item  38,  $D, $54, $45 ;		; $4C
	Item  39, $27, $68, $42 ;		; $4D
	Item  40,  $F, $68, $51 ;		; $4E
	Item  42, $23, $70, $41 ;		; $4F
	Item  42, $5E, $74, $35 ;		; $50
	Item  42, $7D, $70, $25 ;		; $51
	Item  43, $2E, $68, $31 ;		; $52
	Item  43, $44, $70, $31 ;		; $53
	Item  43, $75, $68, $31 ;		; $54
	Item  44, $53, $50, $34 ;		; $55
	Item  44, $1B, $50,   4 ;		; $56
	Item  45, $20, $6C, $34 ;		; $57
	Item  46, $41, $70, $24 ;		; $58
	Item  46, $56, $70, $11 ;		; $59
	Item  47, $44, $70, $31 ;		; $5A
	Item  47, $2A, $68, $22 ;		; $5B
	Item  48, $20, $68, $52 ;		; $5C
	Item  49, $57, $64, $11 ;		; $5D
	Item  49, $1A, $58, $23 ;		; $5E
	Item  49,  $A, $78, $24 ;		; $5F
	Item  50, $46, $6C, $31 ;		; $60
	Item  51, $4D, $64, $25 ;		; $61
	Item  51, $22, $68, $31 ;		; $62
	Item  52, $1C, $50, $52 ;		; $63
	Item  53, $15, $74, $25 ;		; $64
	Item  53, $25, $74, $61 ;		; $65
	Item  54, $18, $68, $52 ;		; $66
	Item  55, $50, $70, $22 ;		; $67
	Item  55, $4B, $4C, $12 ;		; $68
	Item  55, $34, $70, $22 ;		; $69
	Item  55, $32, $60, $31 ;		; $6A
	Item  56, $82, $50, $21 ;		; $6B
	Item  56, $2A, $50, $15 ;		; $6C
	Item  57, $1B, $68, $15 ;		; $6D
	Item  57, $22, $68, $15 ;		; $6E
	Item  57, $29, $70, $11 ;		; $6F
	Item  38, $16, $54, $51 ;		; $70
	Item  58, $30, $70, $22 ;		; $71
	Item  58, $38, $70,   5 ;		; $72
	Item  58, $40, $70,   3 ;		; $73
	Item  58, $48, $70, $33 ;		; $74
	Item  59, $26, $70, $13 ;		; $75
	Item  59, $7F, $74, $25 ;		; $76
	Item  59, $68, $6C, $34 ;		; $77
	Item  60, $50, $68, $31 ;		; $78
	Item  61, $31, $68, $23 ;		; $79
	Item  62,   8, $74, $52 ;		; $7A
	Item  63, $16, $60, $41 ;		; $7B
	Item  63, $20, $70, $61 ;		; $7C
	Item  64, $31, $60, $32 ;		; $7D
	Item  64, $3E, $50, $42 ;		; $7E
	Item  66, $43, $50, $45 ;		; $7F
	Item  66, $20, $68, $32 ;		; $80
	Item  67, $28, $68, $41 ;		; $81
	Item  67, $1B, $74, $32 ;		; $82
	Item  70, $29, $70, $45 ;		; $83
	Item  71, $20, $50, $31 ;		; $84
	Item  71, $52, $50, $12 ;		; $85
	Item  71, $8A, $60, $15 ;		; $86
	Item  72, $1F, $50, $12 ;		; $87
	Item  72, $48, $54, $31 ;		; $88
	Item  72, $7D, $70, $21 ;		; $89
	Item  73, $5A, $70, $21 ;		; $8A
	Item  73, $70, $70, $22 ;		; $8B
	Item  75,   8, $6C, $52 ;		; $8C
	Item  76, $4F, $60, $45 ;		; $8D
	Item  76, $58, $70, $32 ;		; $8E
	Item  77, $23, $60, $45 ;		; $8F
	Item  78, $1B, $64, $32 ;		; $90
	Item  78, $B3, $70, $42 ;		; $91
	Item  79, $17, $54, $34 ;		; $92
	Item  79, $2C, $58, $45 ;		; $93
	Item  79, $3C, $78, $43 ;		; $94
	Item  82, $44, $6C, $41 ;		; $95
	Item  82, $1C, $74, $45 ;		; $96
	Item  83, $11, $70,   4 ;		; $97
	Item  85, $52, $70, $45 ;		; $98
	Item  85, $32, $70, $35 ;		; $99
	Item  86, $68, $64, $24 ;		; $9A
	Item  86, $29, $54, $45 ;		; $9B
	Item  87,   8, $60, $52 ;		; $9C
	Item  88, $3F, $70, $45 ;		; $9D
	Item  88, $5C, $70, $42 ;		; $9E
	Item  89,  $B, $70, $52 ;		; $9F
	Item  90,  $E, $70, $52 ;		; $A0
	Item  90,   8, $74, $51 ;		; $A1
	Item  91, $49, $50, $31 ;		; $A2
	Item  91, $50, $70, $21 ;		; $A3
	Item  91, $90, $70, $13 ;		; $A4
	Item  92,  $D, $6C, $53 ;		; $A5
	Item  93, $37, $6C, $53 ;		; $A6
	Item  94, $4F, $70, $41 ;		; $A7
	Item  94, $28, $70, $31 ;		; $A8
	Item  95, $5B, $6C, $21 ;		; $A9
	Item  95, $30, $6C, $45 ;		; $AA
	Item  95, $87, $74, $32 ;		; $AB
	Item  97, $5D, $68, $45 ;		; $AC
	Item  98, $EB, $6C, $23 ;		; $AD
	Item  98, $61, $6C, $43 ;		; $AE
	Item  98, $8F, $6C, $11 ;		; $AF
	Item   0, $5D, $70, $21 ;		; $B0
	Item  16,  $F, $70,   5 ;		; $B1
	Item  17, $13, $74, $35 ;		; $B2
	Item  17, $11, $64, $25 ;		; $B3
	Item  18, $10, $54, $21 ;		; $B4
	Item  27, $5F, $70, $35 ;		; $B5
	Item  27, $1A, $68, $31 ;		; $B6
	Item  47, $54, $70, $25 ;		; $B7
	Item  50, $1B, $50, $25 ;		; $B8
	Item  25, $42, $70, $35 ;		; $B9
	Item  25, $51, $70, $21 ;		; $BA
	Item  63,   8, $70,   5 ;		; $BB
	Item  70, $36, $6C, $35 ;		; $BC
	Item  78,  $F, $70, $35 ;		; $BD
	Item  84, $18, $58, $41 ;		; $BE
	Item  84, $1F, $60, $15 ;		; $BF
	Item  84, $88, $60, $15 ;		; $C0
	Item  38,  $E, $74, $25 ;		; $C1
	Item  86, $56, $64, $25 ;		; $C2
	Item  87, $16, $70, $35 ;		; $C3
	Item  87,  $B, $70, $35 ;		; $C4
	Item  91, $68, $70, $35 ;		; $C5
	Item  94, $3D, $50, $31 ;		; $C6
	Item   0, $1A, $6C, $25 ;		; $C7
	Item   4, $17, $54, $82 ;		; $C8
	Item   3, $6D, $5A, $80 ;		; $C9
	Item   5, $15, $61, $81 ;		; $CA
	Item  24,  $F, $60, $85 ;		; $CB
	Item   8,  $A, $50, $83 ;		; $CC
	Item  14,  $C, $24, $86 ;		; $CD
	Item  17, $1E, $6F, $80 ;		; $CE
	Item  87,   8, $57, $87 ;		; $CF
	Item  28, $73, $50, $86 ;		; $D0
	Item  31, $4A, $56, $82 ;		; $D1
	Item   9, $39, $54, $87 ;		; $D2
	Item  21,   8, $78, $81 ;		; $D3
	Item  34,  $F, $50, $85 ;		; $D4
	Item  56,  $D, $5B, $80 ;		; $D5
	Item  37, $40, $70, $80 ;		; $D6
	Item 119, $3A, $70, $84 ;		; $D7
	Item  43, $13, $70, $86 ;		; $D8
	Item  46, $4B, $67, $80 ;		; $D9
	Item  49, $33, $4F, $83 ;		; $DA
	Item  51, $3C, $54, $85 ;		; $DB
	Item  52, $17, $60, $81 ;		; $DC
	Item  53, $11, $58, $87 ;		; $DD
	Item  61, $34, $5F, $82 ;		; $DE
	Item  63,   9, $4E, $81 ;		; $DF
	Item 119, $20, $54, $86 ;		; $E0
	Item  65,  $B, $50, $84 ;		; $E1
	Item  65,  $C, $50, $86 ;		; $E2
	Item  54, $18, $5F, $86 ;		; $E3
	Item  67, $27, $74, $80 ;		; $E4
	Item 119, $44, $60, $83 ;		; $E5
	Item  74,  $C, $4E, $84 ;		; $E6
	Item  76, $A3, $53, $85 ;		; $E7
	Item 119, $7C, $54, $82 ;		; $E8
	Item  79, $17, $62, $80 ;		; $E9
	Item 119, $67, $54, $84 ;		; $EA
	Item  86, $63, $62, $81 ;		; $EB
	Item 119, $1C, $60, $83 ;		; $EC
	Item 119, $32, $50, $87 ;		; $ED
	Item  97, $66, $53, $86 ;		; $EE

IFDEF SAMPLE
	; possibly uninit garbage
	.BYTE $FF
	.BYTE $FF
	.BYTE   0
	.BYTE $FF
ELSE
	.BYTE $FF
	.BYTE $BF
	.BYTE   2
	.BYTE $FF
ENDIF

ColumnTiles:
	; column metatiles
	.byte    0,   0,   0,   0,   0,   0,   0,   0     ;   0
	.byte    0,   0,   0,   0, $42,   0,   0,   0     ;   1
	.byte    0,   0, $7B,   0, $43, $B7,   0, $47     ;   2
	.byte    0,   0, $8B,   0,   0, $C7,   0, $49     ;   3
	.byte    0,   0,   0,   0,   0, $57,   0,   0     ;   4
	.byte    0,   0,   0, $CD,   0, $58,   0,   0     ;   5
	.byte    0,   0,   0, $CE,   0, $59,   0, $67     ;   6
	.byte    0,   0,   0, $CF,   0,   0,   0, $69     ;   7
	.byte    0,   0,   0, $90,   0,   0, $72,   0     ;   8
	.byte    0,   0,   0, $91,   0, $A5,   0,   0     ;   9
	.byte    0,   0,   0, $DC,   0, $A6,   0,   0     ;  $A
	.byte    0,   0,   0,   0,   0, $A7,   0,   0     ;  $B
	.byte    0,   0,   4, $17,   4, $15,   4, $15     ;  $C
	.byte    0,   0,   4, $15,   4, $15,   4, $15     ;  $D
	.byte    0,   0,   4,   6,   4, $15,   4, $15     ;  $E
	.byte    4, $15,   4, $15,   4, $15,   4, $15     ;  $F
	.byte  $20, $30, $40, $50,   4, $15,   4, $15     ; $10
	.byte    0, $20, $31, $41,   4, $15,   4, $15     ; $11
	.byte    0,   0, $20, $51,   4, $15,   4, $15     ; $12
	.byte    0,   0,   0,   0,   4, $15,   4, $15     ; $13
	.byte    0, $17,   4, $17,   4, $15,   4, $15     ; $14
	.byte    4, $15,   4, $15,   4, $15,   4, $15     ; $15
	.byte    0, $16,   4, $16,   4, $15,   4, $15     ; $16
	.byte    0,   0,   0,   0,   4, $17,   4, $17     ; $17
	.byte    0,   0,   0,   0,   4, $16,   4, $16     ; $18
	.byte    0,   0, $22, $32,   4,   5,   4,   5     ; $19
	.byte    0,   0, $23, $33,   4, $15,   4, $15     ; $1A
	.byte    0,   0,   0, $20,   4, $15,   4, $15     ; $1B
	.byte    4, $17,   4, $17,   4, $15,   4, $15     ; $1C
	.byte    4, $16,   4, $16,   4, $15,   4, $15     ; $1D
	.byte    4, $17,   4, $17,   4, $17,   4, $17     ; $1E
	.byte    4, $16,   4, $16,   4, $16,   4, $16     ; $1F
	.byte  $3B,   8, $2B, $3B, $3B, $3B, $3B, $3B     ; $20
	.byte  $3B,   8, $2B, $3B, $3B,   8, $2B, $3B     ; $21
	.byte  $3B,   8, $2B, $3B, $3B,   8,   8,   8     ; $22
	.byte  $3B,   8,   8,   8,   8,   8,   8,   8     ; $23
	.byte    8,   8,   8,   8,   8,   8, $2B, $3B     ; $24
	.byte    8,   8, $2B, $3B, $3B,   8, $2B, $3B     ; $25
	.byte  $3B,   8,   8,   8,   8,   8, $2B, $3B     ; $26
	.byte  $3B, $3B, $3B, $3B, $3B,   8, $2B, $3B     ; $27
	.byte  $3B,   8, $46, $3B, $3B, $3B, $46, $3B     ; $28
	.byte    9,  $B, $10, $11, $12,   0,   0,   0     ; $29
	.byte    0,   0,   0,   0,  $A, $3C, $3C, $3C     ; $2A
	.byte    0, $45, $34, $44,  $A, $3C, $3C, $3C     ; $2B
	.byte    8,   0,   0,   0,  $A, $3C, $3C, $3C     ; $2C
	.byte    8, $24, $34, $44,  $A, $3C, $3C, $3C     ; $2D
	.byte  $34, $34, $34, $44,  $A, $3C, $3C, $3C     ; $2E
	.byte    0,   0, $26, $36,  $A, $3C, $3C, $3C     ; $2F
	.byte    0,   0, $27, $37,  $A, $3C, $3C, $3C     ; $30
	.byte    0,   0,   0,   0,   8,   0,   0,   0     ; $31
	.byte    0,   0,   0,   0,   8, $24, $34, $34     ; $32
	.byte    8,   0,   0,   0,   0,   0,   0,   0     ; $33
	.byte    8, $24, $34, $34,   8, $24, $34, $34     ; $34
	.byte    0,   0,   0,   0,   0,   0, $45, $34     ; $35
	.byte    0,   0,   0,   0,   0,   0, $25, $35     ; $36
	.byte  $19, $29, $29, $29, $39, $7A, $8A,   0     ; $37
	.byte  $19, $29, $29, $29, $39,   0,   0,   0     ; $38
	.byte    0,   0,   0,   0, $9A,   0,   0,   0     ; $39
	.byte    0,   0,   0,   0, $9B,   0, $BB,   0     ; $3A
	.byte  $75, $75, $56, $75, $75,  $E, $1E, $2E     ; $3B
	.byte  $75, $56, $75, $75,  $E, $1E, $1E, $2E     ; $3C
	.byte  $75, $75, $75,  $E, $1E, $1E, $1E, $2E     ; $3D
	.byte  $56, $75,  $E, $1E, $1E, $1E, $1E, $2E     ; $3E
	.byte  $75,  $E, $1E, $1E, $1E, $1E, $2E,   0     ; $3F
	.byte   $E, $1E, $1E, $1E, $1E, $1E, $1E, $2E     ; $40
	.byte   $E, $2E, $75, $75, $56, $75, $75, $75     ; $41
	.byte   $E, $1E, $2E, $75, $75, $75, $56, $75     ; $42
	.byte   $E, $1E, $1E, $2E, $75, $56, $75, $75     ; $43
	.byte  $75,  $E, $1E, $1E, $2E, $75, $75, $75     ; $44
	.byte  $56, $75, $75, $56, $75, $75, $75, $56     ; $45
	.byte    0,   0,   0,   0, $76, $86, $96,   0     ; $46
	.byte    0,   0,   0,   0, $77, $87, $97,   0     ; $47
	.byte    0,   0,   0,   0, $78, $88, $98,   0     ; $48
	.byte   $D, $1D, $2D, $3D, $3D, $3D, $3D, $3D     ; $49
	.byte    0,  $D, $1D, $2D, $3D, $3D, $3D, $3D     ; $4A
	.byte    0,   0,   0,  $D, $1D, $2D, $3D, $3D     ; $4B
	.byte    0,   0, $70, $80,   0,   0,   0,   0     ; $4C
	.byte    0,   0, $71, $81,   0,   0,   0,   0     ; $4D
	.byte    0,   0,   0,   0, $70, $80,   0,   0     ; $4E
	.byte    0,   0,   0,   0, $71, $81,   0,   0     ; $4F
	.byte    0,   0,   0,   0, $1F,   0,   0,   0     ; $50
	.byte    0,   0,   0,   0,  $F,   0,   0,   0     ; $51
	.byte    0,   0,   0,   0, $2F,   0,   0,   0     ; $52
	.byte  $1F,   0,   0,   0, $1F,   0,   0,   0     ; $53
	.byte   $F,   0,   0,   0,  $F,   0,   0,   0     ; $54
	.byte  $2F,   0,   0,   0, $2F,   0,   0,   0     ; $55
	.byte    0,   0,   0,   0,  $F, $24, $34, $34     ; $56
	.byte    0,   0,   0,   0,  $F, $24, $34, $44     ; $57
	.byte   $F, $24, $34, $44,  $F, $24, $34, $34     ; $58
	.byte  $34, $34, $34, $44,  $F, $24, $34, $34     ; $59
	.byte   $F, $24, $34, $34, $34, $34, $34, $34     ; $5A
	.byte   $F,   0,   0,   0,   0,   0,   0,   0     ; $5B
	.byte    0, $79, $89, $19, $29, $29, $29, $39     ; $5C
	.byte    0,   0,   0,  $C, $D2, $DD, $DD, $DD     ; $5D
	.byte    0,   0,   0, $19, $29, $29, $29, $39     ; $5E
	.byte    0,   0,   0,   0, $4C, $4C, $A4, $A4     ; $5F
	.byte  $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4     ; $60
	.byte  $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA     ; $61
	.byte  $AB, $AB, $AB, $AB, $AB, $AB, $AB, $AB     ; $62
	.byte    2,   2, $A4,   2,   2,   2, $A4,   2     ; $63
	.byte  $A4,   0,   0,   0, $A4,   0,   0,   0     ; $64
	.byte    0,   0, $A4,   0,   0,   0, $A4,   0     ; $65
IFDEF SAMPLE
	.byte    0,   0,   0,   0, $13, $E4,   0,   0     ; $66
	.byte    0,   0,   0,   0, $18, $E5,   0,   0     ; $67
	.byte    0,   0,   0,   0, $1A, $E6,   0,   0     ; $68
	.byte    0,   0,   0,   0, $21, $E7,   0,   0     ; $69
ELSE
	.byte    0,   0,   0,   0, $13, $28,   0,   0     ; $66
	.byte    0,   0,   0,   0, $18, $2A,   0,   0     ; $67
	.byte    0,   0,   0,   0, $1A, $38,   0,   0     ; $68
	.byte    0,   0,   0,   0, $21, $3A,   0,   0     ; $69
ENDIF
	.byte  $55, $61, $61, $63,   0, $7E, $8E, $9E     ; $6A
	.byte  $55, $61, $61,   0,   0, $7E, $8E, $9E     ; $6B
	.byte    0,   0,   0, $B4, $C4, $B5, $C5,   0     ; $6C
	.byte    0,   0,   0, $B5, $C5, $B6, $C6,   0     ; $6D
	.byte  $55,   0,   0,   0,   0, $7E, $8E, $9E     ; $6E
	.byte    0, $61,   0,   0,   0, $7E, $8E, $9E     ; $6F
	.byte    0,   0,   0,   0,   0, $7E, $8E, $9E     ; $70
	.byte    0,   0,   0,   0, $61, $7E, $8E, $9E     ; $71
	.byte    0,   0,   0, $61, $61, $7E, $8E, $9E     ; $72
	.byte    0,   0, $61, $61, $61, $7E, $8E, $9E     ; $73
	.byte    0, $61, $61, $61, $61, $7E, $8E, $9E     ; $74
	.byte  $54, $61,   0,   0,   0, $7E, $8E, $9E     ; $75
	.byte  $55, $61,   0,   0,   0, $7E, $8E, $9E     ; $76
	.byte  $53, $61, $62,   0,   0, $7E, $8E, $9E     ; $77
	.byte  $55, $61, $61, $61, $61, $7E, $8E, $9E     ; $78
	.byte  $55, $61, $62,   0,   0, $7E, $8E, $9E     ; $79
	.byte  $55, $61, $63,   0,   0, $7E, $8E, $9E     ; $7A
	.byte    0,   0,   0,   0,   0,   0,   0, $52     ; $7B
	.byte  $7D, $8D, $9D, $AD, $AD, $77, $87, $87     ; $7C
	.byte    0,   0,   0, $B4, $C4, $B4, $C4,   0     ; $7D
	.byte    0,   0,   0, $B6, $C6, $B6, $C6,   0     ; $7E
	.byte    0,   0,   0, $B6, $C6, $B5, $C5,   0     ; $7F
	.byte    0,   0,   0,   0, $5B, $6B, $6B, $6B     ; $80
	.byte    0,   0,   0,   0, $5C, $5E, $6B, $6B     ; $81
	.byte    0,   0,   0,   0, $5C, $5C, $4B, $4C     ; $82
	.byte    0,   0,   0,   0, $5C, $5F, $6F, $6F     ; $83
	.byte    0,   0,   0,   0, $5D, $6D, $6D, $6D     ; $84
	.byte  $5B, $6B, $6B, $6B, $5E, $6E, $6E, $6E     ; $85
	.byte  $5C, $5E, $6E, $6E, $5C, $5E, $6B, $6B     ; $86
	.byte  $5C, $5C, $4B, $4C, $5C, $5C, $4B, $4C     ; $87
	.byte  $5C, $5F, $6F, $5E, $6E, $6E, $6E, $6E     ; $88
	.byte  $5F, $6F, $6F, $5C, $5E, $6E, $6E, $6E     ; $89
	.byte  $6F, $6F, $6F, $5C, $5C, $4B, $4C, $4C     ; $8A
	.byte  $6D, $6D, $6D, $5C, $5F, $6F, $6F, $6F     ; $8B
	.byte    0,   0,   0, $5D, $6D, $6D, $6D, $6D     ; $8C
	.byte    0,   0,   0, $5C, $5F, $6F, $6F, $6F     ; $8D
	.byte  $5D, $6D, $6D, $5C, $5E, $6E, $6E, $6E     ; $8E
	.byte    0,   0, $4D,   0,   0,   0, $BC,   0     ; $8F
	.byte    0,   0,   0, $7F, $8F, $9F, $AF, $AF     ; $90
	.byte    0,   0,   0, $B4, $C4, $9F, $AF, $AF     ; $91
	.byte    0,   0,   0, $B5, $C5, $9F, $AF, $AF     ; $92
	.byte    0,   0,   0, $B6, $C6, $9F, $AF, $AF     ; $93
	.byte    0,   0,   0,   0, $AE, $9F, $AF, $AF     ; $94
	.byte    0,   0,   0,   0, $AC, $9F, $AF, $AF     ; $95
	.byte    0,   0,   0, $C9,   0,   0, $BD,   0     ; $96
	.byte  $1C, $1C, $1C, $1C, $1C, $1C, $1C, $1C     ; $97
	.byte  $A4, $A4, $2C, $1C, $1C, $1C, $1C, $1C     ; $98
	.byte  $A4, $A4, $A4, $2C, $1C, $1C, $1C, $1C     ; $99
	.byte  $A4, $A4, $A4, $A4, $2C, $1C, $1C, $1C     ; $9A
	.byte  $A4, $A4, $A4, $A4, $A4, $2C, $1C, $1C     ; $9B
	.byte  $A4, $A4, $A4, $A4, $A4, $A4, $A4, $2C     ; $9C
	.byte  $1C, $1C, $1C, $1C, $1C, $A4, $A4, $A4     ; $9D
	.byte  $1C, $1C, $1C, $1C, $A4, $A4, $A4, $A4     ; $9E
	.byte  $1C, $1C, $1C, $A4, $A4, $A4, $A4, $A4     ; $9F
	.byte  $64, $1B, $1B, $1B, $1B, $1B, $1B, $1B     ; $A0
	.byte  $64, $64, $64, $1B, $1B, $1B, $1B, $1B     ; $A1
	.byte  $1B, $64, $64, $64, $1B, $1B, $1B, $1B     ; $A2
	.byte  $1B, $1B, $64, $64, $64, $1B, $1B, $1B     ; $A3
	.byte  $1B, $1B, $1B, $64, $64, $64, $1B, $1B     ; $A4
	.byte  $1B, $1B, $1B, $1B, $64, $64, $1B, $1B     ; $A5
	.byte  $1B, $1B, $1B, $1B, $1B, $1B, $64, $64     ; $A6
	.byte  $1B, $1B, $1B, $1B, $64, $64, $64, $64     ; $A7
	.byte  $1B, $1B, $1B, $1B, $64, $64, $64, $1B     ; $A8
	.byte    0,   0,   0, $CA,   0,   0,   0,   0     ; $A9
	.byte    0,   0, $48, $68, $8A,   0,   0,   0     ; $AA
	.byte  $C8, $C8, $4A, $6A, $48, $68, $8A,   0     ; $AB
	.byte    0,   0, $48, $68, $4A, $6A, $8A,   0     ; $AC
	.byte    0, $79, $4A, $68, $48, $68, $B8, $C8     ; $AD
	.byte    0, $79, $48, $68, $4A, $6A,   0,   0     ; $AE
	.byte    0,   0,   0,   0, $4A, $6A,   0,   0     ; $AF
	.byte    0,   0,   0,   0, $7E, $8E, $9E,   3     ; $B0
	.byte    0,   0,   0, $82, $7E, $8E, $9E,   3     ; $B1
	.byte    0,   0, $82,   3, $7E, $8E, $9E,   3     ; $B2
	.byte    0, $82,   3,   3, $7E, $8E, $9E,   3     ; $B3
	.byte  $73,   3,   3,   3, $7E, $8E, $9E,   3     ; $B4
	.byte  $74, $84, $94,   3, $7E, $8E, $9E,   3     ; $B5
	.byte    0, $85, $95, $84, $7E, $8E, $9E,   3     ; $B6
	.byte    0,   0, $85, $93, $7E, $8E, $9E,   3     ; $B7
	.byte    0,   0,   0, $85, $7E, $8E, $9E,   3     ; $B8
	.byte    0,   0, $73,   3, $7E, $8E, $9E,   3     ; $B9
	.byte    0,   0, $74, $84, $7E, $8E, $9E,   3     ; $BA
	.byte    0, $73,   3,   3, $7E, $8E, $9E,   3     ; $BB
	.byte    0, $74, $84, $94, $7E, $8E, $9E,   3     ; $BC
	.byte    0,   0, $85, $95, $7E, $8E, $9E,   3     ; $BD
	.byte    0,   0, $73, $92, $7E, $8E, $9E,   3     ; $BE
	.byte    0,   0,   0,   0, $A4, $A4, $A4, $A4     ; $BF
	.byte    0,   0,   0,   0,   0, $A0, $A0, $A0     ; $C0
	.byte    0,   0,   0,   0,   0,   0,   0,   0     ; $C1
	.byte    0,   0,   0, $A2, $A2, $A2, $A2, $A2     ; $C2
	.byte    0,   0,   0, $A3, $A3, $A3, $A3, $A3     ; $C3
	.byte    0,   0,   0,   0,   0, $A1, $A1, $A1     ; $C4
	.byte    0,   0, $A4, $A4, $A4, $A4, $A4, $A4     ; $C5
	.byte  $A0, $A0, $A4, $A4, $A4, $A4, $A4, $A4     ; $C6
	.byte    0,   0,   0,   0,   0,   0,   0,   0     ; $C7
	.byte  $A2, $A2, $A4, $A4, $A4, $A4, $A4, $A4     ; $C8
	.byte  $A3, $A3, $A4, $A4, $A4, $A4, $A4, $A4     ; $C9
	.byte  $A1, $A1, $A4, $A4, $A4, $A4, $A4, $A4     ; $CA
	.byte    0,   0,   0, $CB,   0,   0,   0, $BF     ; $CB
	.byte    0,   0,   0, $CC,   0, $BE,   0, $69     ; $CC
	.byte    0,   0,   0,   0,   0, $90,   0,   0     ; $CD
	.byte    0,   0, $D9,   0,   0,   0,   0, $D6     ; $CE
	.byte    0,   0, $DA,   0, $D4,   0,   0, $D7     ; $CF
	.byte  $48, $68, $48, $68, $48, $68, $48, $68     ; $D0
	.byte  $4A, $6A, $48, $68, $4A, $6A, $48, $68     ; $D1
	.byte  $48, $68, $4A, $6A, $48, $68, $4A, $6A     ; $D2
	.byte  $4A, $6A, $4A, $6A, $4A, $6A, $4A, $6A     ; $D3
	.byte    0,   0,   0,   0, $D2, $B2, $C2, $B9     ; $D4
	.byte    0,   0,   0,   0, $BA, $B3, $C3,   0     ; $D5
	.byte    0,   0,   0,   0, $D3, $B2, $C2, $B9     ; $D6
	.byte    0,   0, $D2, $B2, $C2, $B9,   0,   0     ; $D7
	.byte    0,   0, $BA, $B2, $C2, $B9,   0,   0     ; $D8
	.byte    0,   0, $D3, $B3, $C3,   0,   0,   0     ; $D9
	.byte  $D2, $B2, $C2, $B9,   0,   0,   0,   0     ; $DA
	.byte  $BA, $B3, $C3,   0,   0,   0,   0,   0     ; $DB
	.byte  $D3, $B3, $C3,   0,   0,   0,   0,   0     ; $DC
	.byte  $6C, $7C, $8C, $9C, $7E, $8E, $9E, $9E     ; $DD
	.byte    0, $6C, $7C, $8C, $7E, $8E, $9E, $9E     ; $DE
	.byte    0,   0, $6C, $8C, $7E, $8E, $9E, $9E     ; $DF
	.byte  $A9, $1B, $99, $A9, $A9, $1B, $99, $A9     ; $E0
	.byte  $A9, $A9, $A9, $A9, $A9, $1B, $99, $A9     ; $E1
	.byte  $A9, $1B, $99, $A9, $A9, $A9, $A9, $A9     ; $E2
	.byte  $1B, $1B, $99, $A9, $A9, $1B, $99, $A9     ; $E3
	.byte  $1B, $1B, $99, $A9, $A9, $A9, $A9, $A9     ; $E4
	.byte  $A9, $1B, $99, $A9, $A9, $1B, $1B, $1B     ; $E5
	.byte  $A9, $A9, $A9, $A9, $A9, $1B, $1B, $1B     ; $E6
	.byte  $A9, $1B, $1B, $1B, $1B, $1B, $99, $A9     ; $E7
	.byte    0,   0, $DB,   0, $D5,   0,   0, $D8     ; $E8
	.byte    0,   0,   0,   0, $BD,   0, $5A,   0     ; $E9
	.byte  $B0, $C0, $D0, $E0, $7E, $8E, $9E,   3     ; $EA
	.byte  $B1, $C1, $D1, $E1, $7E, $8E, $9E,   3     ; $EB
	.byte    0,   0,   0, $E2, $7E, $8E, $9E,   3     ; $EC
	.byte  $B0, $C0, $D0, $E3, $7E, $8E, $9E,   3     ; $ED
	.byte  $A4, $A4, $A4, $A4, $2C, $1C, $66, $66     ; $EE
	.byte  $A4, $2C, $1C, $A4, $A4, $A4, $A4, $A4     ; $EF
	.byte  $1C, $1C, $A4, $2C, $1C, $1C, $1C, $1C     ; $F0
	.byte  $1C, $1C, $1C, $1C, $1C, $A4, $2C, $1C     ; $F1
	.byte  $1C, $1C, $A4, $A4, $A4, $A4, $2C, $1C     ; $F2
	.byte  $A4, $A4, $2C, $1C, $1C, $1C, $A4, $A4     ; $F3
	.byte  $1C, $1C, $1C, $1C, $1C, $1C, $1C, $1C     ; $F4
	.byte  $66, $66, $1C, $1C, $A4, $A4, $A4, $A4     ; $F5
	.byte  $A4, $A4, $A4, $A4, $2C, $1C, $66, $3E     ; $F6
	.byte  $A4, $A4, $A4, $A4, $2C, $1C, $66, $3F     ; $F7
	.byte  $66, $66, $3E, $4E, $A4, $A4, $A4, $A4     ; $F8
	.byte  $66, $66, $3F, $4F, $A4, $A4, $A4, $A4     ; $F9
	.byte  $66, $3E, $4E, $1C, $A4, $A4, $A4, $A4     ; $FA
	.byte  $66, $3F, $4F, $1C, $A4, $A4, $A4, $A4     ; $FB
	.byte  $3E, $4E, $1C, $1C, $A4, $A4, $A4, $A4     ; $FC
	.byte  $3F, $4F, $1C, $1C, $A4, $A4, $A4, $A4     ; $FD
	.byte  $4E, $66, $1C, $1C, $A4, $A4, $A4, $A4     ; $FE
	.byte  $4F, $66, $1C, $1C, $A4, $A4, $A4, $A4     ; $FF



ColumnAttributes:
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ;   0
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ;   1
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ;   2
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ;   3
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ;   4
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ;   5
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ;   6
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ;   7
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ;   8
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ;   9
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ;  $A
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ;  $B
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ;  $C
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ;  $D
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ;  $E
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ;  $F
	ColumnAttribs  3, 3, 3, 3, 0, 0, 0, 0             ; $10
	ColumnAttribs  0, 3, 3, 3, 0, 0, 0, 0             ; $11
	ColumnAttribs  0, 0, 3, 3, 0, 0, 0, 0             ; $12
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $13
	ColumnAttribs  2, 2, 2, 2, 0, 0, 0, 0             ; $14
	ColumnAttribs  2, 2, 2, 2, 0, 0, 0, 0             ; $15
	ColumnAttribs  2, 2, 2, 2, 0, 0, 0, 0             ; $16
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $17
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $18
	ColumnAttribs  0, 0, 3, 3, 0, 0, 0, 0             ; $19
	ColumnAttribs  0, 0, 3, 3, 0, 0, 0, 0             ; $1A
	ColumnAttribs  0, 0, 0, 3, 0, 0, 0, 0             ; $1B
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $1C
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $1D
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $1E
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $1F
	ColumnAttribs  2, 0, 2, 2, 2, 2, 2, 2             ; $20
	ColumnAttribs  2, 0, 2, 2, 2, 0, 2, 2             ; $21
	ColumnAttribs  2, 0, 2, 2, 2, 0, 0, 0             ; $22
	ColumnAttribs  2, 0, 0, 0, 0, 0, 0, 0             ; $23
	ColumnAttribs  0, 0, 0, 0, 0, 0, 2, 2             ; $24
	ColumnAttribs  0, 0, 2, 2, 2, 0, 2, 2             ; $25
	ColumnAttribs  2, 0, 0, 0, 0, 0, 2, 2             ; $26
	ColumnAttribs  2, 2, 2, 2, 2, 0, 2, 2             ; $27
	ColumnAttribs  2, 0, 3, 2, 2, 2, 3, 2             ; $28
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $29
	ColumnAttribs  2, 2, 2, 2, 0, 1, 1, 1             ; $2A
	ColumnAttribs  2, 0, 0, 0, 0, 1, 1, 1             ; $2B
	ColumnAttribs  0, 2, 2, 2, 0, 1, 1, 1             ; $2C
	ColumnAttribs  0, 0, 0, 0, 0, 1, 1, 1             ; $2D
	ColumnAttribs  0, 0, 0, 0, 0, 1, 1, 1             ; $2E
	ColumnAttribs  2, 2, 0, 0, 0, 1, 1, 1             ; $2F
	ColumnAttribs  2, 2, 0, 0, 0, 1, 1, 1             ; $30
	ColumnAttribs  2, 2, 2, 2, 0, 2, 2, 2             ; $31
	ColumnAttribs  2, 2, 2, 2, 0, 0, 0, 0             ; $32
	ColumnAttribs  0, 2, 2, 2, 0, 2, 2, 2             ; $33
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $34
	ColumnAttribs  2, 2, 2, 2, 2, 2, 0, 0             ; $35
	ColumnAttribs  2, 2, 2, 2, 2, 2, 0, 0             ; $36
	ColumnAttribs  0, 0, 0, 0, 0, 2, 2, 2             ; $37
	ColumnAttribs  0, 0, 0, 0, 0, 2, 2, 2             ; $38
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ; $39
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ; $3A
	ColumnAttribs  2, 2, 2, 2, 2, 0, 0, 0             ; $3B
	ColumnAttribs  2, 2, 2, 2, 0, 0, 0, 0             ; $3C
	ColumnAttribs  2, 2, 2, 0, 0, 0, 0, 0             ; $3D
	ColumnAttribs  2, 2, 0, 0, 0, 0, 0, 0             ; $3E
	ColumnAttribs  2, 0, 0, 0, 0, 0, 0, 2             ; $3F
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $40
	ColumnAttribs  0, 0, 2, 2, 2, 2, 2, 2             ; $41
	ColumnAttribs  0, 0, 0, 2, 2, 2, 2, 2             ; $42
	ColumnAttribs  0, 0, 0, 0, 2, 2, 2, 2             ; $43
	ColumnAttribs  2, 0, 0, 0, 0, 2, 2, 2             ; $44
	ColumnAttribs  2, 2, 2, 2, 2, 2, 2, 2             ; $45
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 0             ; $46
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 0             ; $47
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 0             ; $48
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $49
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $4A
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $4B
	ColumnAttribs  0, 3, 3, 3, 0, 0, 0, 0             ; $4C
	ColumnAttribs  0, 3, 3, 3, 0, 0, 0, 0             ; $4D
	ColumnAttribs  0, 0, 0, 3, 3, 3, 0, 0             ; $4E
	ColumnAttribs  0, 0, 0, 3, 3, 3, 0, 0             ; $4F
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $50
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $51
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $52
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $53
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $54
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $55
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $56
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $57
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $58
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $59
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $5A
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $5B
	ColumnAttribs  2, 2, 2, 0, 0, 0, 0, 0             ; $5C
	ColumnAttribs  0, 0, 1, 1, 0, 0, 0, 0             ; $5D
	ColumnAttribs  2, 2, 2, 0, 0, 0, 0, 0             ; $5E
	ColumnAttribs  0, 0, 0, 0, 2, 2, 2, 2             ; $5F
	ColumnAttribs  2, 2, 2, 2, 2, 2, 2, 2             ; $60
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ; $61
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ; $62
	ColumnAttribs  1, 1, 2, 1, 1, 1, 2, 1             ; $63
	ColumnAttribs  2, 2, 2, 2, 2, 2, 2, 2             ; $64
	ColumnAttribs  2, 2, 2, 2, 2, 2, 2, 2             ; $65
	ColumnAttribs  0, 0, 0, 0, 0, 0, 1, 0             ; $66
	ColumnAttribs  0, 0, 0, 0, 0, 0, 1, 0             ; $67
	ColumnAttribs  0, 0, 0, 0, 0, 0, 1, 0             ; $68
	ColumnAttribs  0, 0, 0, 0, 0, 0, 1, 0             ; $69
	ColumnAttribs  0, 3, 3, 3, 0, 1, 1, 1             ; $6A
	ColumnAttribs  0, 3, 3, 0, 0, 1, 1, 1             ; $6B
	ColumnAttribs  0, 0, 0, 2, 2, 2, 2, 2             ; $6C
	ColumnAttribs  0, 0, 0, 2, 2, 2, 2, 2             ; $6D
	ColumnAttribs  0, 0, 0, 0, 0, 1, 1, 1             ; $6E
	ColumnAttribs  0, 3, 0, 0, 0, 1, 1, 1             ; $6F
	ColumnAttribs  0, 0, 0, 0, 0, 1, 1, 1             ; $70
	ColumnAttribs  0, 0, 0, 0, 3, 1, 1, 1             ; $71
	ColumnAttribs  0, 0, 0, 3, 3, 1, 1, 1             ; $72
	ColumnAttribs  0, 0, 3, 3, 3, 1, 1, 1             ; $73
	ColumnAttribs  0, 3, 3, 3, 3, 1, 1, 1             ; $74
	ColumnAttribs  0, 3, 0, 0, 0, 1, 1, 1             ; $75
	ColumnAttribs  0, 3, 0, 0, 0, 1, 1, 1             ; $76
	ColumnAttribs  0, 3, 3, 0, 0, 1, 1, 1             ; $77
	ColumnAttribs  0, 3, 3, 3, 3, 1, 1, 1             ; $78
	ColumnAttribs  0, 3, 3, 0, 0, 1, 1, 1             ; $79
	ColumnAttribs  0, 3, 3, 0, 0, 1, 1, 1             ; $7A
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $7B
	ColumnAttribs  0, 0, 0, 0, 0, 3, 3, 3             ; $7C
	ColumnAttribs  0, 0, 0, 2, 2, 2, 2, 0             ; $7D
	ColumnAttribs  0, 0, 0, 2, 2, 2, 2, 0             ; $7E
	ColumnAttribs  0, 0, 0, 2, 2, 2, 2, 0             ; $7F
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $80
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $81
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $82
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $83
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $84
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $85
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $86
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $87
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $88
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $89
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $8A
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $8B
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $8C
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $8D
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $8E
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ; $8F
	ColumnAttribs  0, 0, 0, 0, 0, 1, 1, 1             ; $90
	ColumnAttribs  0, 0, 0, 2, 2, 1, 1, 1             ; $91
	ColumnAttribs  0, 0, 0, 2, 2, 1, 1, 1             ; $92
	ColumnAttribs  0, 0, 0, 2, 2, 1, 1, 1             ; $93
	ColumnAttribs  0, 0, 0, 0, 2, 1, 1, 1             ; $94
	ColumnAttribs  0, 0, 0, 0, 0, 1, 1, 1             ; $95
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ; $96
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $97
	ColumnAttribs  2, 2, 0, 0, 0, 0, 0, 0             ; $98
	ColumnAttribs  1, 2, 2, 0, 0, 0, 0, 0             ; $99
	ColumnAttribs  1, 1, 2, 2, 0, 0, 0, 0             ; $9A
	ColumnAttribs  1, 1, 1, 2, 2, 0, 0, 0             ; $9B
	ColumnAttribs  1, 1, 1, 1, 2, 2, 2, 0             ; $9C
	ColumnAttribs  0, 0, 0, 0, 0, 2, 2, 1             ; $9D
	ColumnAttribs  0, 0, 0, 0, 2, 2, 1, 1             ; $9E
	ColumnAttribs  0, 0, 0, 2, 2, 1, 1, 1             ; $9F
	ColumnAttribs  1, 0, 0, 0, 0, 0, 0, 0             ; $A0
	ColumnAttribs  1, 1, 1, 0, 0, 0, 0, 0             ; $A1
	ColumnAttribs  0, 1, 1, 1, 0, 0, 0, 0             ; $A2
	ColumnAttribs  0, 0, 1, 1, 1, 0, 0, 0             ; $A3
	ColumnAttribs  0, 0, 0, 1, 1, 1, 0, 0             ; $A4
	ColumnAttribs  0, 0, 0, 0, 1, 1, 0, 0             ; $A5
	ColumnAttribs  0, 0, 0, 0, 0, 0, 1, 1             ; $A6
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $A7
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 0             ; $A8
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ; $A9
	ColumnAttribs  0, 0, 0, 0, 1, 1, 0, 0             ; $AA
	ColumnAttribs  2, 2, 0, 0, 0, 0, 1, 1             ; $AB
	ColumnAttribs  0, 0, 0, 0, 0, 0, 1, 1             ; $AC
	ColumnAttribs  1, 1, 0, 0, 0, 0, 2, 2             ; $AD
	ColumnAttribs  1, 1, 0, 0, 0, 0, 0, 0             ; $AE
	ColumnAttribs  0, 0, 0, 0, 0, 0, 1, 1             ; $AF
	ColumnAttribs  2, 2, 2, 2, 1, 1, 1, 1             ; $B0
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $B1
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $B2
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $B3
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $B4
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $B5
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $B6
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $B7
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $B8
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $B9
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $BA
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $BB
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $BC
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $BD
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $BE
	ColumnAttribs  0, 0, 0, 0, 2, 2, 2, 2             ; $BF
	ColumnAttribs  0, 0, 0, 0, 0, 2, 2, 2             ; $C0
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $C1
	ColumnAttribs  0, 0, 0, 2, 2, 2, 2, 2             ; $C2
	ColumnAttribs  0, 0, 0, 2, 2, 2, 2, 2             ; $C3
	ColumnAttribs  0, 0, 0, 0, 0, 2, 2, 2             ; $C4
	ColumnAttribs  0, 0, 2, 2, 2, 2, 2, 2             ; $C5
	ColumnAttribs  2, 2, 2, 2, 2, 2, 2, 2             ; $C6
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $C7
	ColumnAttribs  2, 2, 2, 2, 2, 2, 2, 2             ; $C8
	ColumnAttribs  2, 2, 2, 2, 2, 2, 2, 2             ; $C9
	ColumnAttribs  2, 2, 2, 2, 2, 2, 2, 2             ; $CA
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ; $CB
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ; $CC
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ; $CD
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ; $CE
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ; $CF
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $D0
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $D1
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $D2
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $D3
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $D4
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 0             ; $D5
	ColumnAttribs  0, 0, 0, 0, 1, 1, 1, 1             ; $D6
	ColumnAttribs  0, 0, 1, 1, 1, 1, 0, 0             ; $D7
	ColumnAttribs  0, 0, 1, 1, 1, 1, 0, 0             ; $D8
	ColumnAttribs  0, 0, 1, 1, 1, 0, 0, 0             ; $D9
	ColumnAttribs  1, 1, 1, 1, 0, 0, 0, 0             ; $DA
	ColumnAttribs  1, 1, 1, 0, 0, 0, 0, 0             ; $DB
	ColumnAttribs  1, 1, 1, 0, 0, 0, 0, 0             ; $DC
	ColumnAttribs  2, 2, 2, 2, 1, 1, 1, 1             ; $DD
	ColumnAttribs  2, 2, 2, 2, 1, 1, 1, 1             ; $DE
	ColumnAttribs  2, 2, 2, 2, 1, 1, 1, 1             ; $DF
	ColumnAttribs  0, 2, 0, 0, 0, 2, 0, 0             ; $E0
	ColumnAttribs  0, 0, 0, 0, 0, 2, 0, 0             ; $E1
	ColumnAttribs  0, 2, 0, 0, 0, 0, 0, 0             ; $E2
	ColumnAttribs  2, 2, 0, 0, 0, 2, 0, 0             ; $E3
	ColumnAttribs  2, 2, 0, 0, 0, 0, 0, 0             ; $E4
	ColumnAttribs  0, 2, 0, 0, 0, 2, 2, 2             ; $E5
	ColumnAttribs  0, 0, 0, 0, 0, 2, 2, 2             ; $E6
	ColumnAttribs  0, 2, 2, 2, 2, 2, 0, 0             ; $E7
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ; $E8
	ColumnAttribs  1, 1, 1, 1, 1, 1, 1, 1             ; $E9
	ColumnAttribs  2, 2, 2, 2, 1, 1, 1, 1             ; $EA
	ColumnAttribs  2, 2, 2, 2, 1, 1, 1, 1             ; $EB
	ColumnAttribs  2, 2, 2, 2, 1, 1, 1, 1             ; $EC
	ColumnAttribs  2, 2, 2, 2, 1, 1, 1, 1             ; $ED
	ColumnAttribs  2, 2, 2, 2, 0, 0, 0, 0             ; $EE
	ColumnAttribs  2, 0, 0, 2, 2, 2, 2, 2             ; $EF
	ColumnAttribs  0, 0, 2, 0, 0, 0, 0, 0             ; $F0
	ColumnAttribs  0, 0, 0, 0, 0, 2, 0, 0             ; $F1
	ColumnAttribs  0, 0, 2, 2, 2, 2, 0, 0             ; $F2
	ColumnAttribs  2, 2, 0, 0, 0, 0, 2, 2             ; $F3
	ColumnAttribs  0, 0, 0, 0, 0, 0, 0, 0             ; $F4
	ColumnAttribs  0, 0, 0, 0, 2, 2, 2, 2             ; $F5
	ColumnAttribs  2, 2, 2, 2, 0, 0, 0, 3             ; $F6
	ColumnAttribs  2, 2, 2, 2, 0, 0, 0, 3             ; $F7
	ColumnAttribs  0, 0, 1, 1, 2, 2, 2, 2             ; $F8
	ColumnAttribs  0, 0, 1, 1, 2, 2, 2, 2             ; $F9
	ColumnAttribs  0, 1, 1, 0, 2, 2, 2, 2             ; $FA
	ColumnAttribs  0, 1, 1, 0, 2, 2, 2, 2             ; $FB
	ColumnAttribs  1, 1, 0, 0, 2, 2, 2, 2             ; $FC
	ColumnAttribs  1, 1, 0, 0, 2, 2, 2, 2             ; $FD
	ColumnAttribs  3, 0, 0, 0, 2, 2, 2, 2             ; $FE
	ColumnAttribs  3, 0, 0, 0, 2, 2, 2, 2             ; $FF


; Column collision data	- two bits per 16x16 tile
; Not sure on the specifics, but
; 00 __ - clear
; 01    - (unused)
; 10 H_ - solid with boots item (?)
; 11 SB - solid
ColumnCollisionTable:
	ColumnSolidity  __,__,__,__,__,__,__,__		;   0
	ColumnSolidity  __,__,__,__,__,__,__,__		;   1
	ColumnSolidity  __,__,__,__,__,__,__,__		;   2
	ColumnSolidity  __,__,__,__,__,__,__,__		;   3
	ColumnSolidity  __,__,__,__,__,__,__,__		;   4
	ColumnSolidity  __,__,__,__,__,__,__,__		;   5
	ColumnSolidity  __,__,__,__,__,__,__,__		;   6
	ColumnSolidity  __,__,__,__,__,__,__,__		;   7
	ColumnSolidity  __,__,__,__,__,__,__,__		;   8
	ColumnSolidity  __,__,__,__,__,__,__,__		;   9
	ColumnSolidity  __,__,__,__,__,__,__,__		;  $A
	ColumnSolidity  __,__,__,__,__,__,__,__		;  $B
	ColumnSolidity  __,__,SB,SB,SB,SB,SB,SB		;  $C
	ColumnSolidity  __,__,SB,SB,SB,SB,SB,SB		;  $D
	ColumnSolidity  __,__,SB,SB,SB,SB,SB,SB		;  $E
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		;  $F
	ColumnSolidity  SB,__,__,__,SB,SB,SB,SB		; $10
	ColumnSolidity  __,SB,__,__,SB,SB,SB,SB		; $11
	ColumnSolidity  __,__,SB,__,SB,SB,SB,SB		; $12
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $13
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $14
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $15
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $16
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $17
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $18
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $19
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $1A
	ColumnSolidity  __,__,__,SB,SB,SB,SB,SB		; $1B
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $1C
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $1D
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $1E
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $1F
	ColumnSolidity  __,SB,__,__,__,__,__,__		; $20
	ColumnSolidity  __,SB,__,__,__,SB,__,__		; $21
	ColumnSolidity  __,SB,__,__,__,SB,SB,SB		; $22
	ColumnSolidity  __,SB,SB,SB,SB,SB,SB,SB		; $23
	ColumnSolidity  SB,SB,SB,SB,SB,SB,__,__		; $24
	ColumnSolidity  SB,SB,__,__,__,SB,__,__		; $25
	ColumnSolidity  __,SB,SB,SB,SB,SB,__,__		; $26
	ColumnSolidity  __,__,__,__,__,SB,__,__		; $27
	ColumnSolidity  __,SB,__,__,__,__,__,__		; $28
	ColumnSolidity  __,__,__,__,__,__,__,__		; $29
	ColumnSolidity  __,__,__,__,SB,__,__,__		; $2A
	ColumnSolidity  __,__,__,__,SB,__,__,__		; $2B
	ColumnSolidity  SB,__,__,__,SB,__,__,__		; $2C
	ColumnSolidity  SB,__,__,__,SB,__,__,__		; $2D
	ColumnSolidity  __,__,__,__,SB,__,__,__		; $2E
	ColumnSolidity  __,__,__,__,SB,__,__,__		; $2F
	ColumnSolidity  __,__,__,__,SB,__,__,__		; $30
	ColumnSolidity  __,__,__,__,SB,__,__,__		; $31
	ColumnSolidity  __,__,__,__,SB,__,__,__		; $32
	ColumnSolidity  SB,__,__,__,__,__,__,__		; $33
	ColumnSolidity  SB,__,__,__,SB,__,__,__		; $34
	ColumnSolidity  __,__,__,__,__,__,__,__		; $35
	ColumnSolidity  __,__,__,__,__,__,__,__		; $36
	ColumnSolidity  SB,SB,SB,SB,SB,__,__,__		; $37
	ColumnSolidity  SB,SB,SB,SB,SB,__,__,__		; $38
	ColumnSolidity  __,__,__,__,__,__,__,__		; $39
	ColumnSolidity  __,__,__,__,__,__,__,__		; $3A
	ColumnSolidity  __,__,__,__,__,SB,SB,SB		; $3B
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $3C
	ColumnSolidity  __,__,__,SB,SB,SB,SB,SB		; $3D
	ColumnSolidity  __,__,SB,SB,SB,SB,SB,SB		; $3E
	ColumnSolidity  __,SB,SB,SB,SB,SB,SB,__		; $3F
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $40
	ColumnSolidity  SB,SB,__,__,__,__,__,__		; $41
	ColumnSolidity  SB,SB,SB,__,__,__,__,__		; $42
	ColumnSolidity  SB,SB,SB,SB,__,__,__,__		; $43
	ColumnSolidity  __,SB,SB,SB,SB,__,__,__		; $44
	ColumnSolidity  __,__,__,__,__,__,__,__		; $45
	ColumnSolidity  __,__,__,__,SB,SB,SB,__		; $46
	ColumnSolidity  __,__,__,__,SB,SB,SB,__		; $47
	ColumnSolidity  __,__,__,__,SB,SB,SB,__		; $48
	ColumnSolidity  __,SB,SB,__,__,__,__,__		; $49
	ColumnSolidity  __,__,SB,SB,__,__,__,__		; $4A
	ColumnSolidity  __,__,__,__,SB,SB,__,__		; $4B
	ColumnSolidity  __,__,__,H_,__,__,__,__		; $4C	; POI: Only semi-solid platforms in the game
	ColumnSolidity  __,__,__,H_,__,__,__,__		; $4D	; ""
	ColumnSolidity  __,__,__,__,__,H_,__,__		; $4E	; ""
	ColumnSolidity  __,__,__,__,__,H_,__,__		; $4F	; ""
	ColumnSolidity  __,__,__,__,SB,__,__,__		; $50
	ColumnSolidity  __,__,__,__,SB,__,__,__		; $51
	ColumnSolidity  __,__,__,__,SB,__,__,__		; $52
	ColumnSolidity  SB,__,__,__,SB,__,__,__		; $53
	ColumnSolidity  SB,__,__,__,SB,__,__,__		; $54
	ColumnSolidity  SB,__,__,__,SB,__,__,__		; $55
	ColumnSolidity  __,__,__,__,SB,__,__,__		; $56
	ColumnSolidity  __,__,__,__,SB,__,__,__		; $57
	ColumnSolidity  SB,__,__,__,SB,__,__,__		; $58
	ColumnSolidity  __,__,__,__,SB,__,__,__		; $59
	ColumnSolidity  SB,__,__,__,__,__,__,__		; $5A
	ColumnSolidity  SB,__,__,__,__,__,__,__		; $5B
	ColumnSolidity  __,__,__,SB,SB,SB,SB,SB		; $5C
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $5D
	ColumnSolidity  __,__,__,SB,SB,SB,SB,SB		; $5E
	ColumnSolidity  __,__,__,__,__,__,SB,SB		; $5F
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $60
	ColumnSolidity  __,__,__,__,__,__,__,__		; $61
	ColumnSolidity  __,__,__,__,__,__,__,__		; $62
	ColumnSolidity  __,__,SB,__,__,__,SB,__		; $63
	ColumnSolidity  SB,__,__,__,SB,__,__,__		; $64
	ColumnSolidity  __,__,SB,__,__,__,SB,__		; $65
	ColumnSolidity  __,__,__,__,__,__,__,__		; $66
	ColumnSolidity  __,__,__,__,__,__,__,__		; $67
	ColumnSolidity  __,__,__,__,__,__,__,__		; $68
	ColumnSolidity  __,__,__,__,__,__,__,__		; $69
	ColumnSolidity  __,SB,SB,SB,__,__,__,__		; $6A
	ColumnSolidity  __,SB,SB,__,__,__,__,__		; $6B
	ColumnSolidity  __,__,__,SB,SB,SB,SB,__		; $6C
	ColumnSolidity  __,__,__,SB,SB,SB,SB,__		; $6D
	ColumnSolidity  __,__,__,__,__,__,__,__		; $6E
	ColumnSolidity  __,SB,__,__,__,__,__,__		; $6F
	ColumnSolidity  __,__,__,__,__,__,__,__		; $70
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $71
	ColumnSolidity  __,__,__,SB,SB,SB,SB,SB		; $72
	ColumnSolidity  __,__,SB,SB,SB,SB,SB,SB		; $73
	ColumnSolidity  __,SB,SB,SB,SB,SB,SB,SB		; $74
	ColumnSolidity  __,SB,__,__,__,__,__,__		; $75
	ColumnSolidity  __,SB,__,__,__,__,__,__		; $76
	ColumnSolidity  __,SB,SB,__,__,__,__,__		; $77
	ColumnSolidity  __,SB,SB,SB,SB,SB,SB,SB		; $78
	ColumnSolidity  __,SB,SB,__,__,__,__,__		; $79
	ColumnSolidity  __,SB,SB,__,__,__,__,__		; $7A
	ColumnSolidity  __,__,__,__,__,__,__,__		; $7B
	ColumnSolidity  __,SB,SB,__,__,__,__,__		; $7C
	ColumnSolidity  __,__,__,SB,SB,SB,SB,__		; $7D
	ColumnSolidity  __,__,__,SB,SB,SB,SB,__		; $7E
	ColumnSolidity  __,__,__,SB,SB,SB,SB,__		; $7F
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $80
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $81
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $82
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $83
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $84
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $85
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $86
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $87
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $88
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $89
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $8A
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $8B
	ColumnSolidity  __,__,__,SB,SB,SB,SB,SB		; $8C
	ColumnSolidity  __,__,__,SB,SB,SB,SB,SB		; $8D
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $8E
	ColumnSolidity  __,__,__,__,__,__,__,__		; $8F
	ColumnSolidity  __,__,__,__,__,SB,SB,SB		; $90
	ColumnSolidity  __,__,__,SB,SB,SB,SB,SB		; $91
	ColumnSolidity  __,__,__,SB,SB,SB,SB,SB		; $92
	ColumnSolidity  __,__,__,SB,SB,SB,SB,SB		; $93
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $94
	ColumnSolidity  __,__,__,__,__,SB,SB,SB		; $95
	ColumnSolidity  __,__,__,__,__,__,__,__		; $96
	ColumnSolidity  __,__,__,__,__,__,__,__		; $97
	ColumnSolidity  SB,SB,__,__,__,__,__,__		; $98
	ColumnSolidity  SB,SB,SB,__,__,__,__,__		; $99
	ColumnSolidity  SB,SB,SB,SB,__,__,__,__		; $9A
	ColumnSolidity  SB,SB,SB,SB,SB,__,__,__		; $9B
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,__		; $9C
	ColumnSolidity  __,__,__,__,__,SB,SB,SB		; $9D
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $9E
	ColumnSolidity  __,__,__,SB,SB,SB,SB,SB		; $9F
	ColumnSolidity  __,SB,SB,SB,SB,SB,SB,SB		; $A0
	ColumnSolidity  __,__,__,SB,SB,SB,SB,SB		; $A1
	ColumnSolidity  SB,__,__,__,SB,SB,SB,SB		; $A2
	ColumnSolidity  SB,SB,__,__,__,SB,SB,SB		; $A3
	ColumnSolidity  SB,SB,SB,__,__,__,SB,SB		; $A4
	ColumnSolidity  SB,SB,SB,SB,__,__,SB,SB		; $A5
	ColumnSolidity  SB,SB,SB,SB,SB,SB,__,__		; $A6
	ColumnSolidity  SB,SB,SB,SB,__,__,__,__		; $A7
	ColumnSolidity  SB,SB,SB,SB,__,__,__,SB		; $A8
	ColumnSolidity  __,__,__,__,__,__,__,__		; $A9
	ColumnSolidity  __,__,SB,SB,__,__,__,__		; $AA
	ColumnSolidity  __,__,SB,SB,SB,SB,__,__		; $AB
	ColumnSolidity  __,__,SB,SB,SB,SB,__,__		; $AC
	ColumnSolidity  __,__,SB,SB,SB,SB,__,__		; $AD
	ColumnSolidity  __,__,SB,SB,SB,SB,__,__		; $AE
	ColumnSolidity  __,__,__,__,SB,SB,__,__		; $AF
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $B0
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $B1
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $B2
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $B3
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $B4
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $B5
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $B6
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $B7
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $B8
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $B9
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $BA
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $BB
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $BC
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $BD
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $BE
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $BF
	ColumnSolidity  __,__,__,__,__,__,__,__		; $C0
	ColumnSolidity  __,__,__,__,__,__,__,__		; $C1
	ColumnSolidity  __,__,__,SB,SB,SB,SB,SB		; $C2
	ColumnSolidity  __,__,__,SB,SB,SB,SB,SB		; $C3
	ColumnSolidity  __,__,__,__,__,__,__,__		; $C4
	ColumnSolidity  __,__,SB,SB,SB,SB,SB,__		; $C5
	ColumnSolidity  __,__,SB,SB,SB,SB,SB,__		; $C6
	ColumnSolidity  __,__,__,__,__,__,__,__		; $C7
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,__		; $C8
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,__		; $C9
	ColumnSolidity  __,__,SB,SB,SB,SB,SB,__		; $CA
	ColumnSolidity  __,__,__,__,__,__,__,__		; $CB
	ColumnSolidity  __,__,__,__,__,__,__,__		; $CC
	ColumnSolidity  __,__,__,__,__,__,__,__		; $CD
	ColumnSolidity  __,__,__,__,__,__,__,__		; $CE
	ColumnSolidity  __,__,__,__,__,__,__,__		; $CF
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $D0
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $D1
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $D2
	ColumnSolidity  SB,SB,SB,SB,SB,SB,SB,SB		; $D3
	ColumnSolidity  __,__,__,__,SB,SB,__,__		; $D4
	ColumnSolidity  __,__,__,__,SB,SB,__,__		; $D5
	ColumnSolidity  __,__,__,__,SB,SB,__,__		; $D6
	ColumnSolidity  __,__,SB,SB,__,__,__,__		; $D7
	ColumnSolidity  __,__,SB,SB,__,__,__,__		; $D8
	ColumnSolidity  __,__,SB,SB,__,__,__,__		; $D9
	ColumnSolidity  SB,SB,__,__,__,__,__,__		; $DA
	ColumnSolidity  SB,SB,__,__,__,__,__,__		; $DB
	ColumnSolidity  SB,SB,__,__,__,__,__,__		; $DC
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $DD
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $DE
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $DF
	ColumnSolidity  __,SB,__,__,__,SB,__,__		; $E0
	ColumnSolidity  __,__,__,__,__,SB,__,__		; $E1
	ColumnSolidity  __,SB,__,__,__,__,__,__		; $E2
	ColumnSolidity  SB,SB,__,__,__,SB,__,__		; $E3
	ColumnSolidity  SB,SB,__,__,__,__,__,__		; $E4
	ColumnSolidity  __,SB,__,__,__,SB,SB,SB		; $E5
	ColumnSolidity  __,__,__,__,__,SB,SB,SB		; $E6
	ColumnSolidity  __,SB,SB,SB,SB,SB,__,__		; $E7
	ColumnSolidity  __,__,__,__,__,__,__,__		; $E8
	ColumnSolidity  __,__,__,__,__,__,__,__		; $E9
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $EA
	ColumnSolidity  SB,__,__,__,SB,SB,SB,SB		; $EB
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $EC
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $ED
	ColumnSolidity  SB,SB,SB,SB,__,__,__,__		; $EE
	ColumnSolidity  SB,__,__,SB,SB,SB,SB,SB		; $EF
	ColumnSolidity  __,__,SB,__,__,__,__,__		; $F0
	ColumnSolidity  __,__,__,__,__,SB,__,__		; $F1
	ColumnSolidity  __,__,SB,SB,SB,SB,__,__		; $F2
	ColumnSolidity  SB,SB,__,__,__,__,SB,SB		; $F3
	ColumnSolidity  __,__,__,__,__,__,__,__		; $F4
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $F5
	ColumnSolidity  SB,SB,SB,SB,__,__,__,__		; $F6
	ColumnSolidity  SB,SB,SB,SB,__,__,__,__		; $F7
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $F8
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $F9
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $FA
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $FB
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $FC
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $FD
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $FE
	ColumnSolidity  __,__,__,__,SB,SB,SB,SB		; $FF




; Block	definitions
; First	8 bytes	are the	top row
; Last 8 bytes are the bottom row
; Several blocks are not used:
; $09-$0F
; $42
; $74-$77
BlockTable:
    Block    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0      ;   0
    Block    0, $C5, $C0, $C6, $C0, $C6, $C2, $C8, $C3, $C9, $C4, $CA, $C4, $CA,   0, $C5      ;   1
    Block    0, $BF,   1, $BF,   2, $BF,   3, $BF,   0, $BF,   4, $BF,   5, $BF,   6, $BF      ;   2
    Block    7, $BF,   0, $BF,   8, $BF,   9, $BF,  $A, $BF,  $B, $BF,   0, $BF,   0, $BF      ;   3
    Block  $39, $BF, $3A, $BF, $8F, $BF, $96, $BF, $A9, $BF, $CB, $BF, $CC, $BF, $CD, $BF      ;   4
    Block    0, $BF,   0, $BF, $CE, $BF, $CF, $BF, $E8, $BF, $E9, $BF,   0, $BF,   0, $BF      ;   5
    Block    0,   0,   0, $49,   0, $49,   0,   0,   0,   0,   0, $49,   0, $49,   0,   0      ;   6
    Block    0,   0,   0, $4A,   0, $4A,   0,   0,   0,   0,   0, $4A,   0, $4A,   0,   0      ;   7
    Block    0,   0,   0, $4B,   0, $4B,   0,   0,   0,   0,   0, $4B,   0, $4B,   0,   0      ;   8
    Block    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0      ;   9
    Block    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0      ;  $A
    Block    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0      ;  $B
    Block    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0      ;  $C
    Block    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0      ;  $D
    Block    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0      ;  $E
    Block    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0      ;  $F
    Block  $1E, $1C,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F, $1F, $1D      ; $10
    Block    0, $13,   0, $13,   0, $13,   0, $13,   0, $13,   0, $13,   0, $13,   0, $13      ; $11
    Block    0, $19,   0, $1A,   0, $13,   0, $13,   0, $13,   0, $13,   0, $13,   0, $13      ; $12
    Block    0, $13,   0, $13,   0, $18,   0,   0,   0,   0,   0, $17,   0, $13,   0, $13      ; $13
    Block    0, $12,   0, $12,   0, $12,   0, $12,   0, $12,   0, $12,   0, $12,   0, $12      ; $14
    Block    0, $13,   0, $13,   0, $11,   0, $11,   0, $11,   0, $11,   0, $11,   0, $11      ; $15
    Block    0, $13,   0, $13,   0, $10,   0, $10,   0, $10,   0, $10,   0, $10,   0, $10      ; $16
    Block    0, $13,   0, $1B,   0, $1B,   0, $1B,   0, $1B,   0, $1B,   0, $1B,   0, $13      ; $17
    Block    0, $13,   0, $13,   0, $14,   0, $15,   0, $15,   0, $15,   0, $16,   0, $13      ; $18
    Block  $EE, $F5, $EE, $F5, $EE, $F5, $EE, $FA, $EE, $FB, $EE, $F5, $EE, $F5, $EE, $F5      ; $19
    Block  $EE, $F5, $EE, $F5, $EE, $F5, $EE, $FC, $EE, $FD, $EE, $F5, $EE, $F5, $EE, $F5      ; $1A
    Block  $EE, $F5, $EE, $F5, $EE, $F5, $EE, $F8, $EE, $F9, $EE, $F5, $EE, $F5, $EE, $F5      ; $1B
    Block  $EE, $F5, $EE, $F5, $EE, $F5, $F6, $FE, $F7, $FF, $EE, $F5, $EE, $F5, $EE, $F5      ; $1C
    Block  $60, $60, $60, $60, $60, $60, $60, $60, $60, $60, $60, $60, $60, $60, $60, $60      ; $1D
    Block  $F0, $F0, $F0, $F0, $F1, $F1, $F1, $F1, $F0, $F0, $F0, $F0, $F1, $F1, $F1, $F1      ; $1E
    Block  $F4, $F4, $F4, $F4, $F2, $F2, $F4, $F4, $F3, $F3, $F4, $F4, $F2, $F2, $F4, $F4      ; $1F
    Block  $21, $27, $21, $27, $21, $27, $21, $21, $20, $21, $20, $21, $20, $21, $23, $25      ; $20
    Block  $20, $21, $20, $21, $20, $21, $21, $21, $21, $27, $21, $27, $21, $27, $21, $26      ; $21
    Block  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21      ; $22
    Block  $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $22, $25      ; $23
    Block  $21, $21, $21, $21, $21, $21, $21, $21, $21, $27, $21, $27, $21, $27, $22, $24      ; $24
    Block  $21, $21, $20, $27, $20, $27, $20, $27, $23, $25, $20, $21, $20, $21, $20, $26      ; $25
    Block  $21, $21, $21, $21, $21, $21, $21, $21, $28, $28, $21, $21, $21, $21, $21, $21      ; $26
    Block  $EE, $F5, $EE, $F5, $EE, $F5, $EE, $F5, $EE, $F5, $EE, $F5, $EE, $F5, $EE, $F5      ; $27
    Block  $9A, $9D, $99, $9F, $99, $9F, $9A, $9E, $9B, $9E, $98, $9D, $97, $9E, $9C, $9D      ; $28
    Block  $60, $EF, $60, $EF, $60, $EF, $60, $EF, $60, $EF, $60, $EF, $60, $EF, $60, $EF      ; $29
    Block    0, $2A,   0, $2A,   0, $2A,   0, $2A,   0, $2A,   0, $2A,   0, $2B,   0, $2A      ; $2A
    Block  $31, $2C, $32, $2D, $31, $2C, $32, $2D,   0, $2C, $35, $2D,   0, $2C, $35, $2D      ; $2B
    Block  $31, $2C, $32, $2D, $31, $2C, $32, $2D, $31, $2A, $31, $2B, $31, $2A, $32, $2D      ; $2C
    Block    0, $2A,   0, $2B,   0, $2A,   0, $2B,   0, $2A,   0, $2A,   0, $2A,   0, $2A      ; $2D
    Block    0, $2A,   0, $2A,   0, $2A,   0, $2A,   0, $2A,   0, $2A,   0, $2A,   0, $2A      ; $2E
    Block    0, $2A,   0, $2F,   0, $30,   0, $2A,   0, $2A, $36, $2E,   0, $2A,   0, $2A      ; $2F
    Block  $33, $2C, $34, $2D, $33, $2C, $32, $2E, $31, $2A, $32, $2E, $33, $2C, $34, $2D      ; $30
    Block  $33, $2C, $34, $2D, $33, $2C, $35, $2D, $33, $2C, $35, $2D, $33, $2C, $34, $2D      ; $31
    Block    0,   0,   0,   0,   0, $49,   0,   0,   0, $4B,   0,   0,   0, $4A,   0,   0      ; $32
    Block    0,   0,   0,   0,   0, $49,   0,   0,   0,   0,   0,   0, $4C, $4A, $4D,   0      ; $33
    Block    0,   0,   0, $49,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, $49      ; $34
    Block    0,   0,   0,   0,   0,   0,   0, $4B, $4E,   0, $4F,   0,   0,   0,   0, $4A      ; $35
    Block    0, $5D,   0, $5D,   0, $5D,   0, $5D,   0, $5D,   0, $5D,   0, $5D,   0, $5D      ; $36
    Block    0, $60,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, $60      ; $37
    Block    0, $B0,   0, $B0,   0, $C5,   0, $5F,   0, $C5,   0, $B0,   0, $B0,   0, $B0      ; $38
    Block    0,   0,   0,   0,   0, $AA,   0, $AD, $AA, $AE, $AD, $AB, $AC, $AC, $AD, $AB      ; $39
    Block  $AE, $AC, $AB, $AD, $AE, $AE, $AD, $AB, $AC, $AE, $AD, $AB, $AC, $AE, $AD, $AB      ; $3A
    Block  $AE, $AC, $AD, $AB, $AC, $AC, $AD, $AD, $AF, $AF,   0,   0,   0,   0,   0,   0      ; $3B
    Block    0, $90,   0, $90, $4C, $90, $4D, $90,   0, $90,   0, $90,   0, $90,   0, $90      ; $3C
    Block    0, $91, $4C, $92, $4D, $93,   0, $95,   0, $90, $4E, $90, $4F, $95,   0, $90      ; $3D
    Block  $4E, $90, $4F, $95,   0, $90, $4C, $94, $4D, $90,   0, $90,   0, $95,   0, $95      ; $3E
    Block    0, $95,   0, $95,   0, $95,   0, $95,   0, $95,   0, $95,   0, $95,   0, $95      ; $3F
    Block    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, $29      ; $40
    Block    0, $B1,   0, $B2, $66, $B3, $67, $B4, $68, $B5, $69, $B6,   0, $B7,   0, $B8      ; $41
    Block  $4E, $95, $4F, $90,   0, $95, $4C, $95, $4D, $90,   0, $90,   0, $90,   0, $95      ; $42
    Block    0, $4B,   0,   0, $4C, $4B, $4D,   0,   0, $4B,   0,   0,   0, $4B,   0,   0      ; $43
    Block    0,   0,   0,   0,   0, $4A,   0, $4A,   0,   0,   0, $4A,   0, $4A,   0,   0      ; $44
    Block    0, $49,   0, $49,   0,   0,   0, $49, $4E, $49, $4F,   0,   0,   0,   0, $49      ; $45
    Block  $44, $3F, $43, $3E, $44, $3F, $41, $3B, $43, $3E, $42, $3C, $44, $3F, $40, $3F      ; $46
    Block  $41, $3D, $42, $3C, $45, $3B, $44, $3B, $43, $3C, $41, $3D, $43, $3C, $41, $3E      ; $47
    Block  $42, $3B, $43, $3C, $41, $3E, $45, $3F, $41, $40, $45, $3D, $42, $3E, $44, $3C      ; $48
    Block  $43, $45, $40, $3B, $44, $3D, $45, $3F, $43, $40, $44, $3E, $42, $3C, $41, $3B      ; $49
    Block  $42, $3F, $45, $45, $42, $3D, $41, $3C, $42, $45, $45, $45, $43, $3B, $44, $3C      ; $4A
    Block  $45, $45, $45, $45, $44, $3C, $41, $3E, $43, $3D, $41, $40, $45, $3B, $45, $45      ; $4B
    Block  $42, $41, $45, $42, $42, $45, $43, $3C, $43, $45, $41, $40, $43, $3F, $45, $3E      ; $4C
    Block  $43, $40, $44, $45, $43, $45, $40, $3C, $44, $3C, $43, $45, $44, $45, $43, $40      ; $4D
    Block  $44, $3C, $45, $41, $41, $3C, $3B, $45, $45, $42, $45, $41, $41, $3C, $40, $45      ; $4E
    Block  $45, $45, $44, $3F, $42, $45, $45, $40, $43, $45, $45, $3D, $40, $45, $42, $3C      ; $4F
    Block    0, $51,   0, $50,   0, $56,   0, $52,   0, $51,   0, $50,   0, $56,   0, $52      ; $50
    Block  $51, $51, $50, $50, $56, $59, $52, $52, $51, $51, $50, $50, $56, $59, $52, $52      ; $51
    Block  $51, $54, $50, $53, $57, $58, $52, $55, $51, $54, $50, $53, $57, $5A, $51, $5B      ; $52
    Block  $51, $54, $50, $53,   0, $58,   0, $55,   0, $54, $50, $53, $57, $58, $52, $55      ; $53
    Block    0, $51,   0, $50,   0, $56,   0, $55,   0, $54, $50, $5B, $57, $5A, $52, $5B      ; $54
    Block  $D0, $D0, $D1, $D1, $D2, $D2, $D1, $D1, $D2, $D2, $D1, $D1, $D2, $D2, $D3, $D3      ; $55
    Block    0, $46,   0, $47,   0, $47,   0, $47,   0, $47,   0, $47,   0, $47,   0, $48      ; $56
    Block    0,   0,   0, $46,   0, $47,   0, $48,   0,   0,   0, $46,   0, $47,   0, $48      ; $57
    Block    0,   0,   0,   0,   0, $46,   0, $47,   0, $47,   0, $47,   0, $47,   0, $48      ; $58
    Block    0, $7D,   0, $6D,   0, $7F,   0, $6C,   0, $6D,   0, $7F,   0, $6C,   0, $7E      ; $59
    Block  $A6, $A0, $A7, $A1, $A8, $A2, $A4, $A3, $A3, $A4, $A2, $A4, $A2, $A5, $A2, $A5      ; $5A
    Block  $A2, $A5, $A2, $A5, $A2, $A4, $A3, $A4, $A4, $A3, $A8, $A2, $A7, $A1, $A6, $A0      ; $5B
    Block  $A3, $A4, $A4, $A3, $A8, $A2, $A7, $A1, $A6, $A1, $A7, $A2, $A4, $A3, $A3, $A4      ; $5C
    Block  $A3, $A3, $A4, $A2, $A7, $A1, $A6, $A0, $A7, $A1, $A4, $A2, $A3, $A3, $A2, $A3      ; $5D
    Block  $A2, $A5, $A3, $A5, $A4, $A4, $A3, $A3, $A2, $A2, $A2, $A3, $A2, $A4, $A3, $A5      ; $5E
    Block  $A8, $A3, $A8, $A3, $A4, $A2, $A3, $A1, $A2, $A1, $A4, $A2, $A4, $A1, $A8, $A2      ; $5F
    Block  $60, $60, $60, $60, $60, $60, $61, $61, $62, $62, $60, $60, $60, $60, $60, $60      ; $60
    Block    0, $7C,   0, $7C,   0, $7C,   0, $7C,   0, $7C,   0, $7C,   0, $7C,   0, $7C      ; $61
    Block    0,   0, $4C,   0, $4D,   0,   0,   0,   0,   0, $4E,   0, $4F,   0,   0,   0      ; $62
    Block  $60, $60, $60, $60, $63, $63, $61, $61, $62, $62, $63, $63, $60, $60, $60, $60      ; $63
    Block  $60, $60, $60, $60, $63, $63, $61, $61, $62, $62, $60, $60, $60, $60, $60, $60      ; $64
    Block    0, $13,   0,  $C,   0,  $D,   0,  $E,   0, $13,   0, $13,   0,  $C,   0,  $E      ; $65
    Block    0, $13,   0, $13,   0, $13,   0, $1C,   0,  $F,   0,  $F,   0, $1D,   0, $13      ; $66
    Block  $38, $5E, $38, $5C, $38, $5C, $38, $5E, $38, $5C, $37, $5C, $38, $5C, $37, $5E      ; $67
    Block  $38, $5E, $38, $5C, $37, $5E, $38, $5C, $37, $5E, $37, $5E, $37, $5C, $38, $5E      ; $68
    Block    0,   0,   0, $4C,   0, $4D,   0,   0,   0,   0,   0, $4E,   0, $4F,   0,   0      ; $69
    Block    0,   0,   0, $D7,   0, $D8,   0, $D8,   0, $D8,   0, $D8,   0, $D8,   0, $D8      ; $6A
    Block    0, $D8, $D4, $D8, $D5, $D8, $D5, $D8, $D6, $D8,   0, $D9,   0,   0,   0,   0      ; $6B
    Block    0,   0,   0, $DA,   0, $DB,   0, $DB,   0, $DB,   0, $DB,   0, $DC,   0,   0      ; $6C
    Block  $D4,   0, $D5,   0, $D5,   0, $D6,   0,   0, $DA,   0, $DB,   0, $DB,   0, $DC      ; $6D
    Block    0,   0, $D4,   0, $D5,   0, $D5,   0, $D5,   0, $D5,   0, $D6,   0,   0,   0      ; $6E
    Block    0, $D7,   0, $D8, $D7, $D8, $D8, $D8, $D8, $D8, $D9, $D8,   0, $D8,   0, $D9      ; $6F
    Block    0, $72,   0, $72,   0, $72,   0, $72,   0, $72,   0, $72,   0, $72,   0, $70      ; $70
    Block    0, $70,   0, $71,   0, $71,   0, $71,   0, $71,   0, $71,   0, $71,   0, $70      ; $71
    Block    0, $70,   0, $70,   0, $73,   0, $73,   0, $70,   0, $70,   0, $72,   0, $72      ; $72
    Block    0, $70,   0, $71,   0, $70,   0, $73,   0, $70,   0, $70,   0, $72,   0, $70      ; $73
    Block  $D4,   0, $D5, $D7, $D5, $D8, $D5, $D8, $D5, $D8, $D5, $D8, $D5, $D9, $D6,   0      ; $74
    Block    0, $75,   0, $75,   0, $75,   0, $75,   0, $78,   0, $75,   0, $75, $7B, $7A      ; $75
    Block    0, $70,   0, $70,   0, $76,   0, $75,   0, $78,   0, $75,   0, $77,   0, $79      ; $76
    Block  $88, $90, $8B, $90, $8C,   5, $8C, $91, $8C, $93, $8D, $92, $8E, $94, $8F, $95      ; $77
    Block  $99, $9F, $98, $9E, $9A, $9D, $9B, $9D, $9C, $9D, $9A, $9D, $9B, $9D, $9A, $97      ; $78
    Block  $99, $9D, $98, $9E, $98, $9F, $97, $9F, $98, $9F, $98, $9F, $98, $9E, $99, $9D      ; $79
    Block    0, $81,   0, $81,   0, $82,   0, $81,   0, $81,   0, $83,   0, $82,   0, $82      ; $7A
    Block    0, $81,   0, $82,   0, $83,   0, $83,   0, $84,   0, $80,   0, $81,   0, $82      ; $7B
    Block    0, $82,   0, $82,   0, $83,   0, $83,   0, $84,   0,   0,   0,   0,   0, $80      ; $7C
    Block    0, $80,   0, $85,   0, $86,   0, $87,   0, $88,   0, $8E,   0, $8D,   0, $8C      ; $7D
    Block    0,   0,   0, $85, $80, $86, $84, $88,   0, $8E,   0, $8D,   0, $8C,   0,   0      ; $7E
    Block    0, $85,   0, $86, $80, $87, $81, $88, $82, $89, $83, $8A, $84, $8B,   0, $8C      ; $7F
    Block  $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E5, $E3, $E5, $E3, $E5, $E3, $E5, $E3      ; $80
    Block  $E0, $E5, $E0, $E5, $E0, $E5, $E0, $E5, $E3, $E0, $E3, $E0, $E3, $E0, $E3, $E0      ; $81
    Block  $E0, $E7, $E2, $E7, $E2, $E7, $E0, $E7, $E7, $E0, $E7, $E1, $E7, $E1, $E7, $E0      ; $82
    Block  $E3, $E0, $E3, $E0, $E4, $E2, $E4, $E2, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0      ; $83
    Block  $E0, $E5, $E0, $E6, $E0, $E6, $E0, $E5, $E5, $E3, $E5, $E3, $E5, $E3, $E5, $E3      ; $84
    Block  $E0, $E0, $E0, $E2, $E0, $E2, $E0, $E0, $E0, $E7, $E0, $E7, $E0, $E7, $E0, $E7      ; $85
    Block  $E0, $E5, $E0, $E6, $E0, $E6, $E0, $E5, $E4, $E0, $E4, $E0, $E3, $E0, $E3, $E0      ; $86
    Block    0, $BF,   0,   0,   0,   0, $64, $64, $60, $60, $65, $65,   0,   0,   0, $BF      ; $87
    Block  $9B, $9F, $9B, $9F, $9B, $9F, $9B, $9F, $F4, $9F, $9B, $9F, $9B, $9F, $9B, $9F      ; $88
    Block  $9B, $9F, $9B, $9F, $9B, $9E, $9B, $9F, $F4, $9F, $9B, $9F, $9B, $9F, $9B, $9F      ; $89
    Block    0, $B0,   0, $B0,   0, $B0,   0, $B0,   0, $B0,   0, $B0,   0, $B0,   0, $B0      ; $8A
    Block    0, $B0,   0, $B1,   0, $B9,   0, $BA,   0, $B8,   0, $B0,   0, $B0,   0, $B0      ; $8B
    Block    0, $B1,   0, $B2,   0, $BB,   0, $BC,   0, $BD,   0, $BE,   0, $BA,   0, $B8      ; $8C
    Block    0, $B1,   0, $B2,   0, $B3,   0, $B4,   0, $B5,   0, $B6,   0, $B7,   0, $B8      ; $8D
    Block    0, $B0,   0, $DD,   0, $DF,   0, $DD,   0, $DE,   0, $DD,   0, $DD,   0, $B0      ; $8E
    Block    0, $B0,   0, $DE,   0, $DE,   0, $DD,   0, $DE,   0, $DF,   0, $DF,   0, $B0      ; $8F
    Block    0, $76,   0, $79, $7B, $75,   0, $6F, $7B, $77,   0, $78,   0, $6A,   0, $6B      ; $90
    Block    0, $7A,   0, $76,   0, $76,   0, $79,   0, $76,   0, $78,   0, $7A,   0, $76      ; $91
    Block    0, $70,   0, $76,   0, $79,   0, $7A,   0, $76,   0, $78,   0, $7A,   0, $76      ; $92
    Block    0, $6E,   0, $76,   0, $79,   0, $6A,   0, $78,   0, $6F,   0, $79,   0, $76      ; $93
    Block    0, $B0,   0, $B0,   0, $B0,   0, $B0,   0, $B0,   0, $EA,   0, $EB,   0, $EC      ; $94
    Block    0, $EA,   0, $EB,   0, $ED,   0, $EB,   0, $EC,   0, $B0,   0, $B0,   0, $B0      ; $95
    Block    0, $EA,   0, $EB,   0, $ED,   0, $EB,   0, $ED,   0, $EB,   0, $EC,   0, $B0      ; $96


MetatileDefinitions:
	Metatile  $FF, $FF, $FF, $FF	;   0
	Metatile  $FC, $FC, $FC, $FC	;   1
	Metatile  $FD, $FD, $FD, $FD	;   2
	Metatile  $FE, $FE, $FE, $FE	;   3
	Metatile  $28, $29, $38, $39	;   4
	Metatile  $29, $28, $39, $38	;   5
	Metatile  $29, $FF, $39, $FF	;   6
	Metatile  $FF, $28, $FF, $38	;   7
	Metatile  $64, $65, $74, $75	;   8
	Metatile  $0B, $FF, $15, $FF	;   9
	Metatile  $E0, $E1, $F0, $F1	;  $A
	Metatile  $0A, $FF, $0C, $FF	;  $B
	Metatile  $52, $53, $54, $55	;  $C
	Metatile  $FF, $FF, $5E, $5F	;  $D
	Metatile  $00, $01, $10, $11	;  $E
	Metatile  $C9, $C9, $C9, $C9	;  $F
	Metatile  $14, $FF, $FF, $11	; $10
	Metatile  $FF, $18, $FF, $15	; $11
	Metatile  $FF, $0E, $FF, $25	; $12
	Metatile  $14, $0E, $FF, $FF	; $13
	Metatile  $48, $49, $58, $59	; $14
	Metatile  $49, $48, $59, $58	; $15
	Metatile  $49, $FF, $59, $FF	; $16
	Metatile  $FF, $48, $FF, $58	; $17
	Metatile  $22, $FF, $FF, $FF	; $18
	Metatile  $A4, $A3, $B4, $B3	; $19
	Metatile  $20, $18, $FF, $FF	; $1A
	Metatile  $AA, $AB, $BA, $BB	; $1B
	Metatile  $56, $56, $57, $57	; $1C
	Metatile  $6E, $6F, $7E, $7F	; $1D
	Metatile  $02, $03, $02, $03	; $1E
	Metatile  $D9, $D8, $D9, $D8	; $1F
	Metatile  $2E, $2F, $3E, $3F	; $20
	Metatile  $1B, $0D, $FF, $FF	; $21
	Metatile  $FF, $FF, $FF, $7B	; $22
	Metatile  $6C, $6D, $7C, $7D	; $23
	Metatile  $20, $21, $30, $31	; $24
	Metatile  $FF, $FF, $22, $23	; $25
	Metatile  $FF, $FF, $FF, $24	; $26
	Metatile  $FF, $FF, $25, $FF	; $27
	Metatile  $FF, $FF, $26, $17	; $28
	Metatile  $C4, $C3, $B4, $B3	; $29
	Metatile  $FF, $FF, $0A, $10	; $2A
	Metatile  $CA, $CB, $DA, $DB	; $2B
	Metatile  $14, $14, $57, $57	; $2C
	Metatile  $8E, $8F, $9E, $9F	; $2D
	Metatile  $02, $13, $04, $05	; $2E
	Metatile  $D7, $D6, $D7, $D6	; $2F
	Metatile  $4E, $4F, $5E, $5F	; $30
	Metatile  $4E, $4F, $5E, $89	; $31
	Metatile  $8A, $8B, $9A, $9B	; $32
	Metatile  $8C, $8D, $9C, $9D	; $33
	Metatile  $30, $31, $30, $31	; $34
	Metatile  $32, $33, $42, $43	; $35
	Metatile  $FF, $34, $26, $44	; $36
	Metatile  $35, $FF, $45, $27	; $37
	Metatile  $FF, $FF, $18, $22	; $38
	Metatile  $C4, $C3, $D4, $D3	; $39
	Metatile  $FF, $FF, $0A, $26	; $3A
	Metatile  $EA, $EB, $DA, $DB	; $3B
	Metatile  $E9, $F9, $F9, $E9	; $3C
	Metatile  $9E, $9F, $9E, $9F	; $3D
	Metatile  $60, $61, $70, $71	; $3E
	Metatile  $62, $63, $72, $73	; $3F
	Metatile  $6E, $6F, $7E, $7F	; $40
	Metatile  $99, $8F, $9E, $9F	; $41
	Metatile  $1D, $18, $FF, $FF	; $42
	Metatile  $16, $FF, $FF, $FF	; $43
	Metatile  $30, $31, $40, $41	; $44
	Metatile  $50, $51, $30, $31	; $45
	Metatile  $36, $37, $46, $47	; $46
	Metatile  $11, $12, $FF, $FF	; $47
	Metatile  $A6, $A7, $B6, $B7	; $48
	Metatile  $0D, $0E, $FF, $FF	; $49
	Metatile  $A7, $A8, $B7, $B8	; $4A
	Metatile  $BD, $BC, $4C, $4D	; $4B
	Metatile  $4C, $4D, $4C, $4D	; $4C
	Metatile  $FF, $FF, $16, $0F	; $4D
	Metatile  $80, $81, $90, $91	; $4E
	Metatile  $82, $83, $92, $93	; $4F
	Metatile  $8E, $8F, $9E, $9F	; $50
	Metatile  $69, $79, $9E, $9F	; $51
	Metatile  $FF, $FF, $FF, $7C	; $52
	Metatile  $FF, $8C, $FF, $9C	; $53
	Metatile  $8B, $8C, $9B, $9C	; $54
	Metatile  $8B, $8B, $9B, $9B	; $55
	Metatile  $84, $85, $94, $95	; $56
	Metatile  $0A, $1C, $FF, $FF	; $57
	Metatile  $1C, $11, $FF, $FF	; $58
	Metatile  $12, $25, $FF, $FF	; $59
	Metatile  $FF, $FF, $22, $20	; $5A
	Metatile  $AC, $EC, $CC, $BD	; $5B
	Metatile  $EC, $EC, $EC, $EC	; $5C
	Metatile  $EC, $ED, $BC, $CD	; $5D
	Metatile  $BD, $EC, $4C, $BD	; $5E
	Metatile  $EC, $BC, $BC, $4D	; $5F
	Metatile  $7B, $7B, $AB, $AB	; $60
	Metatile  $AC, $AC, $AB, $AB	; $61
	Metatile  $AC, $AC, $FF, $AB	; $62
	Metatile  $AC, $AC, $AB, $FF	; $63
	Metatile  $E4, $E5, $F4, $E4	; $64
	Metatile  $FF, $FF, $E5, $E5	; $65
	Metatile  $97, $E1, $F0, $7A	; $66
	Metatile  $FF, $FF, $11, $12	; $67
	Metatile  $B6, $B7, $C6, $C7	; $68
	Metatile  $FF, $FF, $1B, $18	; $69
	Metatile  $B7, $B8, $C7, $C8	; $6A
	Metatile  $CC, $4C, $CC, $4C	; $6B
	Metatile  $30, $31, $40, $41	; $6C
	Metatile  $4D, $CD, $4D, $CD	; $6D
	Metatile  $4C, $4C, $4C, $4C	; $6E
	Metatile  $4D, $4D, $4D, $4D	; $6F
	Metatile  $36, $37, $46, $47	; $70
	Metatile  $38, $FF, $48, $49	; $71
	Metatile  $FF, $FF, $16, $1D	; $72
	Metatile  $FF, $76, $96, $86	; $73
	Metatile  $77, $FF, $87, $88	; $74
	Metatile  $F2, $F3, $E2, $E3	; $75
	Metatile  $E6, $E7, $FA, $E9	; $76
	Metatile  $E7, $E7, $F9, $E9	; $77
	Metatile  $E7, $E8, $E9, $FB	; $78
	Metatile  $A0, $A1, $B0, $B1	; $79
	Metatile  $67, $68, $77, $78	; $7A
	Metatile  $FF, $FF, $FF, $16	; $7B
	Metatile  $50, $51, $60, $61	; $7C
	Metatile  $FF, $FF, $AE, $AF	; $7D
	Metatile  $79, $7A, $89, $8A	; $7E
	Metatile  $FF, $FF, $2E, $2F	; $7F
	Metatile  $56, $57, $66, $67	; $80
	Metatile  $58, $59, $68, $69	; $81
	Metatile  $FF, $76, $76, $FE	; $82
	Metatile  $FE, $A7, $FE, $FE	; $83
	Metatile  $97, $98, $A7, $A8	; $84
	Metatile  $88, $FF, $78, $88	; $85
	Metatile  $FA, $E9, $FA, $F9	; $86
	Metatile  $E9, $F9, $F9, $E9	; $87
	Metatile  $E9, $FB, $F9, $FB	; $88
	Metatile  $C0, $C1, $D0, $D1	; $89
	Metatile  $87, $88, $FF, $98	; $8A
	Metatile  $FF, $FF, $22, $FF	; $8B
	Metatile  $70, $71, $80, $81	; $8C
	Metatile  $BE, $BF, $CE, $CF	; $8D
	Metatile  $99, $9A, $A9, $AA	; $8E
	Metatile  $3E, $3F, $4E, $4F	; $8F
	Metatile  $16, $0A, $FF, $FF	; $90
	Metatile  $1C, $0A, $FF, $FF	; $91
	Metatile  $A6, $FE, $78, $A6	; $92
	Metatile  $78, $78, $78, $78	; $93
	Metatile  $FE, $97, $FE, $A7	; $94
	Metatile  $98, $78, $A8, $78	; $95
	Metatile  $FA, $F9, $F6, $E9	; $96
	Metatile  $E9, $F9, $F7, $F7	; $97
	Metatile  $E9, $FB, $F7, $F8	; $98
	Metatile  $FF, $FF, $A4, $A3	; $99
	Metatile  $17, $0A, $FF, $FF	; $9A
	Metatile  $18, $FF, $FF, $FF	; $9B
	Metatile  $90, $91, $A0, $A1	; $9C
	Metatile  $DE, $DF, $EE, $EF	; $9D
	Metatile  $7D, $8D, $FE, $FE	; $9E
	Metatile  $AE, $AF, $6C, $39	; $9F
	Metatile  $4C, $FD, $4C, $FD	; $A0
	Metatile  $FD, $4D, $FD, $4D	; $A1
	Metatile  $5C, $AD, $5C, $AD	; $A2
	Metatile  $AD, $5D, $AD, $5D	; $A3
	Metatile  $2C, $2D, $3C, $3D	; $A4
	Metatile  $FF, $FF, $FF, $26	; $A5
	Metatile  $FF, $FF, $0A, $24	; $A6
	Metatile  $FF, $FF, $1D, $26	; $A7
	Metatile  $00, $00, $00, $00	; $A8
	Metatile  $B4, $B3, $C4, $C3	; $A9
	Metatile  $5D, $FD, $5D, $FD	; $AA
	Metatile  $FD, $5C, $FD, $5C	; $AB
	Metatile  $2E, $2F, $3E, $3F	; $AC
	Metatile  $EE, $EF, $EE, $EF	; $AD
	Metatile  $35, $45, $55, $85	; $AE
	Metatile  $39, $6C, $6C, $39	; $AF
	Metatile  $FF, $32, $FF, $42	; $B0
	Metatile  $33, $34, $43, $44	; $B1
	Metatile  $06, $07, $16, $17	; $B2
	Metatile  $08, $09, $18, $19	; $B3
	Metatile  $35, $6D, $45, $39	; $B4
	Metatile  $6D, $6D, $6C, $39	; $B5
	Metatile  $6D, $65, $39, $75	; $B6
	Metatile  $FF, $FF, $FF, $17	; $B7
	Metatile  $66, $FF, $76, $FF	; $B8
	Metatile  $12, $FF, $FF, $FF	; $B9
	Metatile  $1E, $1F, $08, $09	; $BA
	Metatile  $FF, $FF, $0A, $14	; $BB
	Metatile  $FF, $FF, $12, $1B	; $BC
	Metatile  $FF, $FF, $0A, $FF	; $BD
	Metatile  $14, $18, $FF, $FF	; $BE
	Metatile  $FF, $FF, $10, $18	; $BF
	Metatile  $FF, $52, $FF, $62	; $C0
	Metatile  $53, $54, $63, $64	; $C1
	Metatile  $0A, $0B, $1A, $1B	; $C2
	Metatile  $0C, $0D, $FF, $1D	; $C3
	Metatile  $45, $39, $55, $9D	; $C4
	Metatile  $39, $6C, $9D, $9D	; $C5
	Metatile  $6C, $75, $9D, $85	; $C6
	Metatile  $FF, $FF, $16, $FF	; $C7
	Metatile  $86, $FF, $76, $FF	; $C8
	Metatile  $FF, $01, $FF, $FF	; $C9
	Metatile  $10, $26, $FF, $FF	; $CA
	Metatile  $10, $1D, $FF, $FF	; $CB
	Metatile  $0E, $1E, $FF, $FF	; $CC
	Metatile  $FF, $FF, $FF, $23	; $CD
	Metatile  $FF, $FF, $0A, $0C	; $CE
	Metatile  $FF, $FF, $18, $FF	; $CF
	Metatile  $FF, $72, $FF, $82	; $D0
	Metatile  $73, $74, $83, $84	; $D1
	Metatile  $0E, $1E, $15, $1C	; $D2
	Metatile  $1F, $0F, $15, $1C	; $D3
	Metatile  $FF, $FF, $18, $14	; $D4
	Metatile  $FF, $FF, $12, $1D	; $D5
	Metatile  $FF, $FF, $22, $18	; $D6
	Metatile  $FF, $FF, $1C, $11	; $D7
	Metatile  $FF, $FF, $12, $FF	; $D8
	Metatile  $FF, $FF, $FF, $14	; $D9
	Metatile  $FF, $FF, $0E, $12	; $DA
	Metatile  $FF, $FF, $1D, $18	; $DB
	Metatile  $24, $17, $FF, $FF	; $DC
	Metatile  $08, $09, $15, $1C	; $DD
	Metatile  $00, $00, $00, $00	; $DE
	Metatile  $00, $00, $00, $00	; $DF
	Metatile  $FF, $92, $FF, $A2	; $E0
	Metatile  $93, $94, $A3, $A4	; $E1
	Metatile  $95, $FF, $A5, $FF	; $E2
	Metatile  $95, $92, $A5, $A2	; $E3
IFDEF SAMPLE
	Metatile  $FF, $FF, $14, $12	; $E4
	Metatile  $FF, $FF, $1D, $0A	; $E5
	Metatile  $FF, $FF, $23, $1E	; $E6
	Metatile  $FF, $FF, $16, $12	; $E7
ELSE
	Metatile  $00, $00, $00, $00	; $E4
	Metatile  $00, $00, $00, $00	; $E5
	Metatile  $00, $00, $00, $00	; $E6
	Metatile  $00, $00, $00, $00	; $E7
ENDIF
	Metatile  $00, $00, $00, $00	; $E8
	Metatile  $00, $00, $00, $00	; $E9
	Metatile  $00, $00, $00, $00	; $EA
	Metatile  $00, $00, $00, $00	; $EB
	Metatile  $00, $00, $00, $00	; $EC
	Metatile  $00, $00, $00, $00	; $ED
	Metatile  $00, $00, $00, $00	; $EE
	Metatile  $00, $00, $00, $00	; $EF



; Every	zone is	comprised of 32	"blocks".
; The entire level data	is one long string of blocks IDs,
; with each Zone having	a pointer into it somewhere.
; Zones	are their initial pointed-to block, plus 31 more after it.
; There	is no terminator; blocks from other Zones will be used
; The game is capable of wrapping around when you go past the first
; or last block	in a given Zone, too.
;
; Interestingly, only one Zone uses this feature; Zone 99.
ZoneBlockPointerTable:
	.WORD ZoneBlocks_01, ZoneBlocks_02, ZoneBlocks_03, ZoneBlocks_04, ZoneBlocks_05		;
	.WORD ZoneBlocks_06, ZoneBlocks_07, ZoneBlocks_08, ZoneBlocks_09, ZoneBlocks_10		; 5
	.WORD ZoneBlocks_11, ZoneBlocks_12, ZoneBlocks_13, ZoneBlocks_14, ZoneBlocks_15		; 10
	.WORD ZoneBlocks_16, ZoneBlocks_17, ZoneBlocks_18, ZoneBlocks_19, ZoneBlocks_20		; 15
	.WORD ZoneBlocks_21, ZoneBlocks_22, ZoneBlocks_23, ZoneBlocks_24, ZoneBlocks_25		; 20
	.WORD ZoneBlocks_26, ZoneBlocks_27, ZoneBlocks_28, ZoneBlocks_29, ZoneBlocks_30		; 25
	.WORD ZoneBlocks_31, ZoneBlocks_32, ZoneBlocks_33, ZoneBlocks_34, ZoneBlocks_35		; 30
	.WORD ZoneBlocks_36, ZoneBlocks_37, ZoneBlocks_38, ZoneBlocks_39, ZoneBlocks_40		; 35
	.WORD ZoneBlocks_41, ZoneBlocks_42, ZoneBlocks_43, ZoneBlocks_44, ZoneBlocks_45		; 40
	.WORD ZoneBlocks_46, ZoneBlocks_47, ZoneBlocks_48, ZoneBlocks_49, ZoneBlocks_50		; 45
	.WORD ZoneBlocks_51, ZoneBlocks_52, ZoneBlocks_53, ZoneBlocks_54, ZoneBlocks_55		; 50
	.WORD ZoneBlocks_56, ZoneBlocks_57, ZoneBlocks_58, ZoneBlocks_59, ZoneBlocks_60		; 55
	.WORD ZoneBlocks_61, ZoneBlocks_62, ZoneBlocks_63, ZoneBlocks_64, ZoneBlocks_65		; 60
	.WORD ZoneBlocks_66, ZoneBlocks_67, ZoneBlocks_68, ZoneBlocks_69, ZoneBlocks_70		; 65
	.WORD ZoneBlocks_71, ZoneBlocks_72, ZoneBlocks_73, ZoneBlocks_74, ZoneBlocks_75		; 70
	.WORD ZoneBlocks_76, ZoneBlocks_77, ZoneBlocks_78, ZoneBlocks_79, ZoneBlocks_80		; 75
	.WORD ZoneBlocks_81, ZoneBlocks_82, ZoneBlocks_83, ZoneBlocks_84, ZoneBlocks_85		; 80
	.WORD ZoneBlocks_86, ZoneBlocks_87, ZoneBlocks_88, ZoneBlocks_89, ZoneBlocks_90		; 85
	.WORD ZoneBlocks_91, ZoneBlocks_92, ZoneBlocks_93, ZoneBlocks_94, ZoneBlocks_95		; 90
	.WORD ZoneBlocks_96, ZoneBlocks_97, ZoneBlocks_98, ZoneBlocks_99, ZoneBlocks_100	; 95

		;       0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F  10  11  12  13  14  15  16  17  18  19  1A  1B  1C  1D  1E  1F
ZoneBlocks_06:
		.BYTE  $10,$18,$11,$18,$10
ZoneBlocks_90:
		.BYTE  $10,$18,$13,$18,$10
ZoneBlocks_25:
		.BYTE  $10,$18,$18,$10
ZoneBlocks_16:
		.BYTE  $10,$18,$11,$12,$17,$17,$11,$14,$14,$11,$14,$15,$15,$15,$11,$16,$16,$11,$16,$15,$15,$15,$11,$14,$14,$11,$14,$17,$17,$17,$18,$10
ZoneBlocks_87:
		.BYTE  $25,$22,$22,$24,$21,$22,$20,$20,$21,$21,$23,$20,$23,$22,$22,$25
ZoneBlocks_19:
		.BYTE  $25,$22,$20,$21,$22,$23,$21,$22,$20,$21,$20,$21,$24,$20,$20,$22,$21,$25,$20
ZoneBlocks_36:
		.BYTE  $25,$26,$22,$26,$20,$26,$21,$26,$25,$26,$25,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26
ZoneBlocks_18:
		.BYTE  $21,$25,$24,$25,$24,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
ZoneBlocks_33:
		.BYTE    1,$2A,$2A,$2B,$2C,$2D,$2E,$2F,$2E,$2A,$2B,$2B,$2A,$2F,$2E,$2C,$2D,$2B,$30,$31,$30,$2B,$30,$2C,$31,$2D,$2F,$2E,$2A,$2A,  1,  0
ZoneBlocks_56:
		.BYTE    0,  1,$2E,$2A,$2F,  0,$31,$31,$30,  1,$2B,$2C,$2D,$2E,  1,  0
ZoneBlocks_08:
		.BYTE  $46,$47,$48,$49,$47,$48,$47,$48,$47,$48,$48,$47,$48,$47,$48,$49,$4A,$4C,$49,$49,$48,$47,$47,$48,$48,$47,$48,$47,$49,$48,$47,$46
ZoneBlocks_37:
		.BYTE  $46,$48,$49,$47,$4A,$48,$49,$4B,$4A,$4B,$49,$49,$48,$47,$49,$46
ZoneBlocks_43:
		.BYTE  $46,$49,$4B,$4A,$4C,$4D,$4A,$49,$4B,$4A,$4C,$4A,$4D,$49,$49,$46
ZoneBlocks_77:
		.BYTE  $46,$4D,$4B,$4A,$4B,$4D,$4C,$4B,$4C,$4D,$4D,$4E,$4B,$4A,$4F,$4F,$4E,$49,$4E,$47,$4F,$4A,$4B,$4E,$4D,$4D
ZoneBlocks_92:
		.BYTE    0,  0,  0,$50,$51,$52,$53,$51,$51,$53,$52,$51,$54,$53,$53,$52,$51,$54,$53,$51,$50,  0,  0,  0
ZoneBlocks_27:
		.BYTE    0,  0,  0,$7D,$7B,$7A,$7C,$7B,$7B,$7A,$7D,$7D,$7F,$7D,$7E,$7E,$7D,$7E,$7F,$7F,$7A,$7B,$7B,$7C,$7C,$7A,$7B,$7C,$7A,$7F,  0,  0
ZoneBlocks_03:
		.BYTE    0,  0,  0,$56,$57,$56,$57,$56,$58,$56,$57,$57,$58,$57,$58,$57,$56,$57,$58,$56,$56,  0,  0,  0
ZoneBlocks_82:
		.BYTE    0,  1,$34,$35,$34,$35,$34,$33,$35,$32,$33,$34,$32,$33,$34,$35,$32,$34,$35,  1,  0
ZoneBlocks_10:
		.BYTE    0,  0,$62,$59,$44,$45,$43,$43,$43,$44,$44,$45,$45,$44,$43,$45,$44,$43,$45,$59,$62,  0,  0
ZoneBlocks_69:
		.BYTE    1,$8A,$8A,$8A,$8B,$8A,$8A,$8B,$8C,$8A,$8A,$8A,$8A,$8A,$8C,$8B,$8D,$8B,$8A,$8A,$8A,$8A,$8B,$8C,$8A,$8A,$8A,$8B,$8B,$8A,  1,$8B
ZoneBlocks_60:
		.BYTE  $1D,$78,$79,$78,$79,$78,$79,$79,$78,$78,$79,$78,$79,$78,$79,$79,$1D
ZoneBlocks_74:
		.BYTE  $8A,  1,$8A,$94,$8A,$94,$8A,$95,$94,$8A,$94,$95,$8A,$95,$94,$8A,$8A,  1,$8A
ZoneBlocks_70:
		.BYTE  $62,$60,$62
ZoneBlocks_34:
		.BYTE  $73,  1,$70,$71,$71,$72,$70,$73,$73,$73,$71,$73,$71,$73,  1,$73
ZoneBlocks_81:
		.BYTE    0,  0,  0,  0,$63,  0,  0,  0,  0
ZoneBlocks_13:
		.BYTE  $81,$80,$82,$83,$84,$83,$85,$86,$82,$84,$86,$81,$82,$85,$83,$84,$82,$83,$86,$81,$81,$80,$83
ZoneBlocks_02:
		.BYTE  $5F,$5A,$5E,$5B,$5A,$5E,$5B,$5A,$5E,$5B,$5A,$5E,$5E,$5E,$5E,$5B,$5A,$5E,$5B,$5A,$5E,$5B,$5A,$5E,$5B,$5A,$5E,$5B,$5F
ZoneBlocks_50:
		.BYTE  $5F,$5B,$5A,$5E,$5B,$5A,$5B,$5A,$5B,$5A,$5B,$5A,$5B,$5A,$5B,$5F
ZoneBlocks_73:
		.BYTE  $5F,$5E,$5C,$5D,$5C,$5D,$5C,$5D,$5C,$5D,$5C,$5D,$5C,$5D,$5C,$5F,$5F,$5F,$1D
ZoneBlocks_01:
		.BYTE  $62,  0,$62,$59,$59,$8A,$8E,$8F,$8A,$8F,$8E,$8A,$8E,$8F,$8F,$8F,$8A,$8E,$8E,$8A,$59,$59,  0,$62,  0
ZoneBlocks_04:
		.BYTE    0,  0,  0,$39,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3B,$39,$3A,$3B,$39,$3B,$39,$3B,$39,$3B,$39,$3A,$3B,  0,  0,  0
ZoneBlocks_21:
		.BYTE  $63,$67,$68,$68,$67,$68,$67,$64
ZoneBlocks_12:
		.BYTE  $10,$13,$65,$66,$11,$65,$65,$65,$66,$11,$13,$13,$13,$13,$66,$10
ZoneBlocks_07:
		.BYTE    0,  0,  0,$59,$3D,$3E,$3F,$3C,$3C,$3E,$3C,$3F,$3C,$3F,$3C,$3E,$3C,$3E,$3C,$3D,$59,  0,  0,  0
ZoneBlocks_62:
		.BYTE    0,  0,  0,$1D,$3A,$3A,$3B,  0,  0,  0
ZoneBlocks_80:
		.BYTE  $1D,$1E,$1E,$1F,$1E,$1F,$1F,$1F,$1D
ZoneBlocks_97:
		.BYTE    0,  0,  0,$69,$69,$69,$69,  0,$63,  0,  0,  0
ZoneBlocks_39:
		.BYTE  $81,$80,$81,$80,$81
ZoneBlocks_42:
		.BYTE    0,  0,$40,  0,  0
ZoneBlocks_51:
		.BYTE    0,  0,  0,$7E,$7F,$7F,$7C,$7C,$7D,$7E,$7F,$7D,$7E,  0,  0,  0
ZoneBlocks_94:
		.BYTE    0,$7F,  0,$7E,$7D,$7C,$7D,$7F,  0,  1,  0
ZoneBlocks_65:
		.BYTE    0,$7F,$7B,$7C,$7D,$7E,$7F,$7F,  0,  0,  0
ZoneBlocks_98:
		.BYTE    0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,$7E,  0,  0,  0
ZoneBlocks_75:
		.BYTE    0,$64,  0
ZoneBlocks_95:
		.BYTE    0,  1,$54,$56,$54,$52,$51,$51,$50,$57,  0,  0,  0
ZoneBlocks_32:
		.BYTE  $3D,  1,$3D,$3F,$3C,$3C,$3F,$3C,$3F,$37,  1,$3D
ZoneBlocks_57:
		.BYTE    0,  0,  0,$6A,$6F,$6B,$6C,$6D,$6C,$6E,$6D,$6A,$6F,$6F,$6F,$6F,$6B,$6D,$6C,$6C,$6E,  0,  0,  0
ZoneBlocks_45:
		.BYTE    0,  1,$6A,$6B,$6D,$6C,$6E,$6D,$6C,$6A,$6B,$6C,$6D,$6D,$6C,$1D
ZoneBlocks_67:
		.BYTE    0,  0,  0,$6C,$6F,$6C,$6A,$6B,$6E,$6F,$6F,$6B,$6E,  0,  0,  0
ZoneBlocks_23:
		.BYTE  $55,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3B,$39,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$55
ZoneBlocks_64:
		.BYTE  $1D,$2A,$2B,$1D,$52,$54,  0,  0,  0,  0
ZoneBlocks_99:
		;       0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F  10  11  12  13  14  15  16  17  18  19  1A  1B  1C  1D  1E  1F
		.BYTE  $88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$89,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88
ZoneBlocks_79:
		.BYTE  $91,$87,$92,$90,$91,$93,$92,$90,$93,$91,$91,$92,$90,$92,$91,$92,$92,$90,$91,$91,$90,$91,$87,$92
ZoneBlocks_52:
		.BYTE    0,  1,$92,$90,$72,$93,$90,$73,$91,$93,$71,$93,$73,  1,  0
ZoneBlocks_100:
		.BYTE  $1D,$27,$27,$19,$1B,$1A,$1B,$19,$1B,$1C,$1A,$27,$1D,$27,$1D
ZoneBlocks_29:
		.BYTE  $36,  1,$36,$36,$36,$37,$36,$36,$36,$36,$37,$36,$36,$36,$37,  0,  0,  0
ZoneBlocks_20:
		.BYTE  $8A,  1,$8E,$96,$41,$94,$8F,  1,$8A
ZoneBlocks_85:
		.BYTE    0,  0,  0,$37,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$37,  1,  0
ZoneBlocks_46:
		.BYTE  $55,$67,$68,$68,$67,$68,$67,$68,$68,$67,$67,$67,$55
ZoneBlocks_54:
		.BYTE  $60,$87,$69,$69,$69,  0,  0,  0
ZoneBlocks_14:
		.BYTE    0,  0,  0,$59,$3C,$59,  0,  0,  0
ZoneBlocks_26:
		.BYTE    6,  1,  6,  6,  7,  8,  8,  2,  3,  4,  5,  8,  8,  7,  6,  6,  1,  6
ZoneBlocks_96:
		.BYTE  $1D,$78,$79,$28,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$79,$78,$28,$1D
ZoneBlocks_83:
		.BYTE  $1D,$28,$29,$78,$29,$79,$29,$28,$29,$1D
ZoneBlocks_47:
		.BYTE  $8A,$87,$8A,$8F,$8A,$8F,$8F,$8A,$8E,$8E,$8E,$8A,$8A,$8A,$87,$8A
ZoneBlocks_78:
		.BYTE    0,  0,  0,$87,$87,  0,  0,  0
ZoneBlocks_84:
		.BYTE  $8A,  1,$8A,$8A,$95,$8A,$8A,  1,$8A
ZoneBlocks_93:
		.BYTE  $1D,$88,$1D
ZoneBlocks_91:
		.BYTE  $1D,$79,$1D
ZoneBlocks_63:
		.BYTE  $1D,$28,$1D
ZoneBlocks_76:
		.BYTE  $1D,$78,$1D
ZoneBlocks_59:
		.BYTE    0,  0,  0,  0,$87,$87,$87,$87,$87,$87,$87,$87,$87,$87,  0,  0,  0
ZoneBlocks_24:
		.BYTE  $8A,  1,$8A,$8A,$8A,$8A,$38,$8A,$8A,$8A,$8A,  1,$8A
ZoneBlocks_49:
		.BYTE  $36,  1,$36,$36,  1,$36
ZoneBlocks_44:
		.BYTE    0,  1,$32,$45,$34,$44,$43,$33,$32,$45,$32,$43,$32,$45,$44,$32,  1,  0
ZoneBlocks_66:
		.BYTE  $1D,$37,$1D
ZoneBlocks_11:
		.BYTE  $46,$46,$47
ZoneBlocks_72:
		.BYTE  $1D,$2A,$2F,$2C,$2B,$2D,$2C,$2B,$2C,$31,$2B,$30,$2B,$2C,$2D,$31,$2F,$30,$2F,$1D
ZoneBlocks_30:
		.BYTE    0,  0,  0,$7F,$56,$57,$57,$57,$58,$57,$57,$58,$57,$56,$56,$7F,  0,  0,  0
ZoneBlocks_40:
		.BYTE  $10,$13,$13,$13,$65,$13,$66,$13,$66,$66,$13,$65,$66,$13,$13,$10
ZoneBlocks_61:
		.BYTE    0,  0,  0,$39,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3B,  0,  0,  0
ZoneBlocks_71:
		.BYTE  $73,  1,$72,$73,$72,$73,$73,$71,$72,$73,$73,$71,  1,$73
ZoneBlocks_55:
		.BYTE    0,  0,  0,  1,  0,  0,  0
ZoneBlocks_53:
		.BYTE    0,  0,  0,$7F,  0,  0,  0
ZoneBlocks_15:
		.BYTE  $10,$18,$10
ZoneBlocks_05:
		.BYTE  $5C,$5A,$5E,$5B,$5C
ZoneBlocks_35:
		.BYTE  $1D,$5A,$5B,$1D
ZoneBlocks_22:
		.BYTE  $5B,$5C,$5A
ZoneBlocks_41:
		.BYTE  $1D,  1,$1D
ZoneBlocks_31:
		.BYTE  $55,$36,$55
ZoneBlocks_17:
		.BYTE  $55,$56,$55
ZoneBlocks_09:
		.BYTE  $10,$66,$10
ZoneBlocks_38:
		.BYTE    0,  0,  0,$56,$57,$57,$58,$56,$57,$57,$58,$56,$56,  0,  0,  0
ZoneBlocks_28:
		.BYTE  $10,$13,$11,$65,$11,$13,$13,$13,$65,$65,$13,$66,$10
ZoneBlocks_48:
		.BYTE    0,  0,  0,$39,$3B,$39,$3B,$39,$3B,$39,$3B,$39,$3B,  0,  0,  0
ZoneBlocks_58:
		.BYTE  $1D,$37,$71,$73,$72,$73,$72,$70,$72,$37,$1D
ZoneBlocks_68:
		.BYTE  $1D,$1E,$1E,$1E,$1E,$1E,$1E,$1D
ZoneBlocks_86:
		.BYTE    0,  0,  0,$56,$56,$57,$57,$57,$58,$58,$57,$58,$57,$56,$56,  0,  0,  0
ZoneBlocks_88:
		.BYTE  $55,$4D,$4E,$55
ZoneBlocks_89:
		.BYTE    0,  0,  0,$7D,$7A,$7B,$7D,$7C,$7D,$7E,$7D,$7C,$7D,$7F,$7E,  0,  0,  0


ZoneBlockPriorityTable:
	.BYTE    0			; 0
	.BYTE    0			; 1
	.BYTE    0			; 2
	.BYTE  $20			; 3
	.BYTE  $20			; 4
	.BYTE  $20			; 5
	.BYTE  $20			; 6
	.BYTE  $20			; 7
	.BYTE  $20			; 8
	.BYTE  $20			; 9
	.BYTE  $20			; $A
	.BYTE  $20			; $B
	.BYTE  $20			; $C
	.BYTE  $20			; $D
	.BYTE  $20			; $E
	.BYTE  $20			; $F
	.BYTE  $20			; $10
	.BYTE  $20			; $11
	.BYTE  $20			; $12
	.BYTE    0			; $13
	.BYTE  $20			; $14
	.BYTE  $20			; $15
	.BYTE  $20			; $16
	.BYTE  $20			; $17
	.BYTE    0			; $18
	.BYTE    0			; $19
	.BYTE    0			; $1A
	.BYTE    0			; $1B
	.BYTE    0			; $1C
	.BYTE  $20			; $1D
	.BYTE    0			; $1E
	.BYTE    0			; $1F
	.BYTE    0			; $20
	.BYTE    0			; $21
	.BYTE    0			; $22
	.BYTE    0			; $23
	.BYTE    0			; $24
	.BYTE    0			; $25
	.BYTE    0			; $26
	.BYTE    0			; $27
	.BYTE    0			; $28
	.BYTE    0			; $29
	.BYTE    0			; $2A
	.BYTE  $20			; $2B
	.BYTE  $20			; $2C
	.BYTE  $20			; $2D
	.BYTE  $20			; $2E
	.BYTE    0			; $2F
	.BYTE  $20			; $30
	.BYTE  $20			; $31
	.BYTE  $20			; $32
	.BYTE  $20			; $33
	.BYTE  $20			; $34
	.BYTE  $20			; $35
	.BYTE    0			; $36
	.BYTE    0			; $37
	.BYTE    0			; $38
	.BYTE    0			; $39
	.BYTE    0			; $3A
	.BYTE    0			; $3B
	.BYTE    0			; $3C
	.BYTE  $20			; $3D
	.BYTE    0			; $3E
	.BYTE  $20			; $3F
	.BYTE    0			; $40
	.BYTE    0			; $41
	.BYTE  $20			; $42
	.BYTE  $20			; $43
	.BYTE  $20			; $44
	.BYTE  $20			; $45
	.BYTE    0			; $46
	.BYTE    0			; $47
	.BYTE    0			; $48
	.BYTE    0			; $49
	.BYTE    0			; $4A
	.BYTE    0			; $4B
	.BYTE    0			; $4C
	.BYTE    0			; $4D
	.BYTE    0			; $4E
	.BYTE    0			; $4F
	.BYTE    0			; $50
	.BYTE  $20			; $51
	.BYTE  $20			; $52
	.BYTE  $20			; $53
	.BYTE  $20			; $54
	.BYTE    0			; $55
	.BYTE    0			; $56
	.BYTE    0			; $57
	.BYTE    0			; $58
	.BYTE    0			; $59
	.BYTE    0			; $5A
	.BYTE    0			; $5B
	.BYTE    0			; $5C
	.BYTE    0			; $5D
	.BYTE    0			; $5E
	.BYTE    0			; $5F
	.BYTE    0			; $60
	.BYTE  $20			; $61
	.BYTE  $20			; $62
	.BYTE    0			; $63
	.BYTE    0			; $64
	.BYTE    0			; $65
	.BYTE    0			; $66
	.BYTE  $20			; $67
	.BYTE    0			; $68
	.BYTE  $20			; $69
	.BYTE    0			; $6A
	.BYTE  $20			; $6B
	.BYTE    0			; $6C
	.BYTE  $20			; $6D
	.BYTE    0			; $6E
	.BYTE  $20			; $6F
	.BYTE  $20			; $70
	.BYTE  $20			; $71
	.BYTE  $20			; $72
	.BYTE  $20			; $73
	.BYTE    0			; $74
	.BYTE  $20			; $75
	.BYTE  $20			; $76
	.BYTE  $20			; $77
	.BYTE    0			; $78
	.BYTE    0			; $79
	.BYTE    0			; $7A
	.BYTE    0			; $7B
	.BYTE    0			; $7C
	.BYTE    0			; $7D
	.BYTE    0			; $7E
	.BYTE    0			; $7F
	.BYTE    0			; $80
	.BYTE    0			; $81
	.BYTE    0			; $82
	.BYTE    0			; $83
	.BYTE    0			; $84
	.BYTE    0			; $85
	.BYTE    0			; $86
	.BYTE    0			; $87
	.BYTE    0			; $88
	.BYTE    0			; $89
	.BYTE    0			; $8A
	.BYTE    0			; $8B
	.BYTE    0			; $8C
	.BYTE    0			; $8D
	.BYTE    0			; $8E
	.BYTE  $20			; $8F
	.BYTE  $20			; $90
	.BYTE  $20			; $91
	.BYTE  $20			; $92
	.BYTE  $20			; $93
	.BYTE    0			; $94
	.BYTE    0			; $95
	.BYTE    0			; $96
	.BYTE    0			; $97

ZoneCHRTable:
	; BBBBSSSS bg/sp
	.BYTE $36,$16,$16,$14,$14,$14,$34,$16,$14,$34	;  10
	.BYTE $14,$14,$14,$36,$14,$14,$16,$14,$16,$34	;  20
	.BYTE $14,$14,$14,$34,$14,$34,$16,$14,$14,$16	;  30
	.BYTE $14,$34,$14,$36,$14,$16,$16,$14,$14,$16	;  40
	.BYTE $14,$34,$16,$34,$16,$16,$34,$14,$14,$14	;  50
	.BYTE $16,$34,$14,$34,$34,$14,$16,$36,$14,$16	;  60
	.BYTE $16,$14,$14,$14,$16,$14,$16,$14,$34,$34	;  70
	.BYTE $34,$14,$16,$34,$14,$14,$14,$14,$36,$14	;  80
	.BYTE $14,$34,$14,$34,$16,$14,$14,$14,$16,$16	;  90
	.BYTE $14,$16,$14,$16,$16,$14,$34,$14,$14,$16	; 100

	.BYTE   0, 0, 0, 0

DebugWarpTable:
	.BYTE   0,$12,$14,$49,$A6,  3,$1C,  4,$AD,$42	;  10
	.BYTE $96,$17,$1B,$B0,$A4,	7,$AC,$4E,  8,$B1	;  20
	.BYTE $1F,$A9,$71,$8F,$45,$B2,$22,$B4,$48,$9A	;  30
	.BYTE $AB,$60, $A,$25,$A7,$28,$2C,$B6,$57,$9C	;  40
	.BYTE $AA,$59,$4A,$92,$6D,$79,$80,$B9,$91,$2F	;  50
	.BYTE $5A,$77,$A3,$AF,$A2,$30,$6A,$BA,$97,$37	;  60
	.BYTE $9F,$53,$89,$AE,$64,$95,$6F,$BD, $C,$38	;  70
	.BYTE $A0,$98,$3B,$3C,$5E,$8B,$4B,$81,$74,$68	;  80
	.BYTE $51, $F,$7E,$84,$52,$C0,$47,$BE,$C1,$3F	;  90
	.BYTE $87,$40,$85,$5B,$5F,$7B,$56,$5D,$72,$78	; 100

ZoneMusicTable:
	.BYTE MusicTrack_ZoneTheme2; 1
	.BYTE MusicTrack_ZoneTheme1		; 2
	.BYTE MusicTrack_ZoneTheme2		; 3
	.BYTE MusicTrack_ZoneTheme3		; 4
	.BYTE MusicTrack_ZoneTheme1		; 5
	.BYTE MusicTrack_ZoneTheme3		; 6
	.BYTE MusicTrack_ZoneTheme2		; 7
	.BYTE MusicTrack_ZoneTheme1		; 8
	.BYTE MusicTrack_ZoneTheme3		; 9
	.BYTE MusicTrack_ZoneTheme2		; 10
	.BYTE MusicTrack_ZoneTheme1		; 11
	.BYTE MusicTrack_ZoneTheme3		; 12
	.BYTE MusicTrack_ZoneTheme1		; 13
	.BYTE MusicTrack_ZoneTheme2		; 14
	.BYTE MusicTrack_ZoneTheme3		; 15
	.BYTE MusicTrack_ZoneTheme3		; 16
	.BYTE MusicTrack_ZoneTheme3		; 17
	.BYTE MusicTrack_ZoneTheme1		; 18
	.BYTE MusicTrack_ZoneTheme1		; 19
	.BYTE MusicTrack_ZoneTheme3		; 20
	.BYTE MusicTrack_ZoneTheme3		; 21
	.BYTE MusicTrack_ZoneTheme1		; 22
	.BYTE MusicTrack_ZoneTheme3		; 23
	.BYTE MusicTrack_ZoneTheme2		; 24
	.BYTE MusicTrack_ZoneTheme3		; 25
	.BYTE MusicTrack_ZoneTheme2		; 26
	.BYTE MusicTrack_ZoneTheme2		; 27
	.BYTE MusicTrack_ZoneTheme1		; 28
	.BYTE MusicTrack_ZoneTheme2		; 29
	.BYTE MusicTrack_ZoneTheme2		; 30
	.BYTE MusicTrack_ZoneTheme2		; 31
	.BYTE MusicTrack_ZoneTheme2		; 32
	.BYTE MusicTrack_ZoneTheme3		; 33
	.BYTE MusicTrack_ZoneTheme1		; 34
	.BYTE MusicTrack_ZoneTheme1		; 35
	.BYTE MusicTrack_ZoneTheme1		; 36
	.BYTE MusicTrack_ZoneTheme1		; 37
	.BYTE MusicTrack_ZoneTheme3		; 38
	.BYTE MusicTrack_ZoneTheme1		; 39
	.BYTE MusicTrack_ZoneTheme3		; 40
	.BYTE MusicTrack_ZoneTheme3		; 41
	.BYTE MusicTrack_Death			; 42
	.BYTE MusicTrack_ZoneTheme1		; 43
	.BYTE MusicTrack_ZoneTheme2		; 44
	.BYTE MusicTrack_ZoneTheme3		; 45
	.BYTE MusicTrack_ZoneTheme3		; 46
	.BYTE MusicTrack_ZoneTheme2		; 47
	.BYTE MusicTrack_ZoneTheme3		; 48
	.BYTE MusicTrack_ZoneTheme2		; 49
	.BYTE MusicTrack_ZoneTheme1		; 50
	.BYTE MusicTrack_ZoneTheme2		; 51
	.BYTE MusicTrack_ZoneTheme1		; 52
	.BYTE MusicTrack_ZoneTheme2		; 53
	.BYTE MusicTrack_ZoneTheme2		; 54
	.BYTE MusicTrack_ZoneTheme2		; 55
	.BYTE MusicTrack_ZoneTheme1		; 56
	.BYTE MusicTrack_ZoneTheme3		; 57
	.BYTE MusicTrack_ZoneTheme1		; 58
	.BYTE MusicTrack_ZoneTheme2		; 59
	.BYTE MusicTrack_ZoneTheme2		; 60
	.BYTE MusicTrack_ZoneTheme3		; 61
	.BYTE MusicTrack_ZoneTheme3		; 62
	.BYTE MusicTrack_ZoneTheme2		; 63
	.BYTE MusicTrack_ZoneTheme1		; 64
	.BYTE MusicTrack_ZoneTheme2		; 65
	.BYTE MusicTrack_ZoneTheme2		; 66
	.BYTE MusicTrack_ZoneTheme3		; 67
	.BYTE MusicTrack_ZoneTheme3		; 68
	.BYTE MusicTrack_ZoneTheme2		; 69
	.BYTE MusicTrack_ZoneTheme2		; 70
	.BYTE MusicTrack_ZoneTheme1		; 71
	.BYTE MusicTrack_ZoneTheme3		; 72
	.BYTE MusicTrack_ZoneTheme1		; 73
	.BYTE MusicTrack_ZoneTheme3		; 74
	.BYTE MusicTrack_ZoneTheme2		; 75
	.BYTE MusicTrack_ZoneTheme2		; 76
	.BYTE MusicTrack_ZoneTheme1		; 77
	.BYTE MusicTrack_ZoneTheme2		; 78
	.BYTE MusicTrack_ZoneTheme2		; 79
	.BYTE MusicTrack_ZoneTheme1		; 80
	.BYTE MusicTrack_ZoneTheme2		; 81
	.BYTE MusicTrack_ZoneTheme2		; 82
	.BYTE MusicTrack_ZoneTheme2		; 83
	.BYTE MusicTrack_ZoneTheme3		; 84
	.BYTE MusicTrack_ZoneTheme3		; 85
	.BYTE MusicTrack_ZoneTheme1		; 86
	.BYTE MusicTrack_ZoneTheme3		; 87
	.BYTE MusicTrack_ZoneTheme1		; 88
	.BYTE MusicTrack_ZoneTheme2		; 89
	.BYTE MusicTrack_ZoneTheme3		; 90
	.BYTE MusicTrack_ZoneTheme2		; 91
	.BYTE MusicTrack_ZoneTheme1		; 92
	.BYTE MusicTrack_ZoneTheme2		; 93
	.BYTE MusicTrack_ZoneTheme2		; 94
	.BYTE MusicTrack_ZoneTheme1		; 95
	.BYTE MusicTrack_ZoneTheme2		; 96
	.BYTE MusicTrack_ZoneTheme2		; 97
	.BYTE MusicTrack_ZoneTheme1		; 98
	.BYTE MusicTrack_ZoneTheme2		; 99
	.BYTE MusicTrack_ZoneTheme1		; 100


IFNDEF REMOVE_MAYBE_UNUSED_DATA
	.include "src/unused-unknown2.asm"
ENDIF
