
.include "src/music-data.asm"
.include "src/unused-unknown.asm"

ZoneDoorTable:
    Door   0, $30, $20,   0 ;
    Door   0, $92, $30, $12 ;		; 1
    Door   5,	$C, $28,   4 ;		; 2
    Door   5, $1C, $28, $59 ;		; 3
    Door   7,	$A, $18, $1D ;		; 4
    Door   7, $CB, $34, $42 ;		; 5
    Door  15,	$C, $30,   8 ;		; 6
    Door  15, $F3, $30, $1A ;		; 7
    Door  18,	 8, $34,   6 ;		; 8
    Door  18, $88, $34, $1F ;		; 9
    Door  32,	 5, $20, $59 ;		; $A
    Door  32, $F2, $28, $25 ;		; $B
    Door  68,	 5, $20,  $C ;		; $C
    Door  68, $F2, $28, $38 ;		; $D
    Door  81,	$D, $28, $7E ;		; $E
    Door  81, $9A, $28, $4C ;		; $F
    Door   0, $17, $3C,  $A ;		; $10
    Door   1, $79, $10, $14 ;		; $11
    Door   1, $11, $38,   1 ;		; $12
    Door   1, $D7, $14, $AD ;		; $13
    Door   2, $22, $30, $11 ;		; $14
    Door   2, $A7, $30, $49 ;		; $15
    Door   2, $58, $3C,   3 ;		; $16
    Door  11,	 8, $30, $43 ;		; $17
    Door  11, $77, $30, $1B ;		; $18
    Door  11, $38, $30, $B0 ;		; $19
    Door  12,	$C, $14,   7 ;		; $1A
    Door  12, $AB, $24, $18 ;		; $1B
    Door   6, $1A, $2C, $A5 ;		; $1C
    Door   6, $A5, $2C,   4 ;		; $1D
    Door   7, $A0, $34, $A4 ;		; $1E
    Door  20, $1A, $1C,   9 ;		; $1F
    Door  20,	 9, $1C, $8F ;		; $20
    Door  20, $19, $2C, $71 ;		; $21
    Door  26, $18, $30, $70 ;		; $22
    Door  26, $AD, $30, $48 ;		; $23
    Door  26, $AF, $30, $B4 ;		; $24
    Door  33,	$D, $20, $59 ;		; $25
    Door  33, $72, $28, $28 ;		; $26
    Door  33, $47, $18, $2C ;		; $27
    Door  35, $38, $34, $26 ;		; $28
    Door  35, $14, $14, $2C ;		; $29
    Door  36, $7B, $34, $B6 ;		; $2A
    Door  36, $7D, $30, $57 ;		; $2B
    Door  36, $13, $10, $59 ;		; $2C
    Door  49,	 8, $38, $5A ;		; $2D
    Door  49,	 8, $10, $77 ;		; $2E
    Door  49, $76, $18, $59 ;		; $2F
    Door  55, $72, $20, $59 ;		; $30
    Door  55, $4D, $28, $53 ;		; $31
    Door  55, $4A, $28, $6A ;		; $32
    Door  55,	$D, $28, $8B ;		; $33
    Door  59, $78, $34, $AE ;		; $34
    Door  59,	 8, $2C, $9F ;		; $35
    Door  59,	$F, $3C, $BD ;		; $36
    Door  59, $12, $24, $59 ;		; $37
    Door  69,	$B, $10,  $D ;		; $38
    Door  69,	$C, $38, $98 ;		; $39
    Door  72, $8F, $30, $3C ;		; $3A
    Door  72,	 8, $10, $99 ;		; $3B
    Door  73,	$D, $28, $3A ;		; $3C
    Door  73, $8A, $28, $5E ;		; $3D
    Door  89,	$C, $30, $85 ;		; $3E
    Door  89, $1C, $30, $46 ;		; $3F
    Door  91, $18, $30, $A8 ;		; $40
    Door  91, $A6, $30, $7B ;		; $41
    Door   9, $1A, $2C,   5 ;		; $42
    Door   9, $9E, $2C, $17 ;		; $43
    Door  24,	$C, $30,  $A ;		; $44
    Door  24, $12, $30, $67 ;		; $45
    Door  86,	 8, $34, $3F ;		; $46
    Door  86, $60, $14, $BF ;		; $47
    Door  28,	$D, $28, $23 ;		; $48
    Door   3, $1E, $28, $15 ;		; $49
    Door  42, $16, $10, $9D ;		; $4A
    Door  76,	 8, $1C, $59 ;		; $4B
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
    Door  74,	$A, $18, $3D ;		; $5E
    Door  94,	$D, $28, $88 ;		; $5F
    Door  31, $52, $20, $59 ;		; $60
    Door  74,	$A, $28, $4B ;		; $61
    Door  50, $5E, $2C, $30 ;		; $62
    Door  97, $1A, $28, $72 ;		; $63
    Door  64,	$F, $2C, $9E ;		; $64
    Door  94, $40, $30, $85 ;		; $65
    Door  31,	$D, $28,  $A ;		; $66
    Door   3, $CC, $30, $45 ;		; $67
    Door  79,	 8, $28, $75 ;		; $68
    Door  96, $19, $2C, $D0 ;		; $69
    Door  56, $A5, $10, $32 ;		; $6A
    Door  56, $1E, $28, $BA ;		; $6B
    Door  44,	$D, $28, $79 ;		; $6C
    Door  44, $74, $20, $93 ;		; $6D
    Door  66, $1A, $20,  $C ;		; $6E
    Door  66, $65, $10, $5C ;		; $6F
    Door  22,	 8, $28, $22 ;		; $70
    Door  22, $9F, $28, $21 ;		; $71
    Door  98, $E4,  $C, $63 ;		; $72
    Door  98, $92, $30, $78 ;		; $73
    Door  78,	$D, $18, $82 ;		; $74
    Door  78, $B3, $20, $68 ;		; $75
    Door  51,	$D, $28, $30 ;		; $76
    Door  51, $6A, $20, $59 ;		; $77
    Door  99,	 8, $30, $73 ;		; $78
    Door  45, $46, $2C, $6C ;		; $79
    Door  45, $11, $2C, $2F ;		; $7A
    Door  95,	 9, $20, $59 ;		; $7B
    Door  95, $85, $34, $5D ;		; $7C
    Door  82,	 8, $24, $52 ;		; $7D
    Door  82, $2B, $14,   0 ;		; $7E
    Door  46,	$D, $28, $77 ;		; $7F
    Door  46, $73, $30, $B8 ;		; $80
    Door  77, $1D, $38, $50 ;		; $81
    Door  77, $25, $28, $74 ;		; $82
    Door  83,	$D, $28, $7E ;		; $83
    Door  83, $3A, $20, $D1 ;		; $84
    Door  92,	$C, $10, $59 ;		; $85
    Door  92,	$A, $2C, $7B ;		; $86
    Door  90,	$B, $10, $E5 ;		; $87
    Door  90,	$B, $2C, $5F ;		; $88
    Door  62,	$E, $10, $54 ;		; $89
    Door  62,	$B, $30, $37 ;		; $8A
    Door  75,	 9, $30, $33 ;		; $8B
    Door  75,	$F, $3C, $4B ;		; $8C
    Door  23,	$D, $28, $25 ;		; $8D
    Door  23, $33, $38, $A7 ;		; $8E
    Door  23, $5A, $20, $59 ;		; $8F
    Door  48, $22, $28, $2F ;		; $90
    Door  48,	$D, $28, $58 ;		; $91
    Door  43,	$D, $20, $4F ;		; $92
    Door  43, $82, $28, $6D ;		; $93
    Door  65,	 8, $20, $A0 ;		; $94
    Door  65,	$F, $20, $CD ;		; $95
    Door  10,	 9, $28, $C2 ;		; $96
    Door  58, $28, $30, $B3 ;		; $97
    Door  71,	 8, $28, $47 ;		; $98
    Door  71, $95, $30, $3B ;		; $99
    Door  29, $19, $20, $B5 ;		; $9A
    Door  29, $7F, $2C, $60 ;		; $9B
    Door  39,	 8, $30, $B7 ;		; $9C
    Door  39, $77, $30, $4A ;		; $9D
    Door  60, $1E, $28, $64 ;		; $9E
    Door  60, $62, $28, $35 ;		; $9F
    Door  70,	$D, $28, $94 ;		; $A0
    Door  70, $62, $28, $98 ;		; $A1
    Door  54, $1A, $28, $D1 ;		; $A2
    Door  52, $19, $20, $C7 ;		; $A3
    Door  14,	$C, $30, $1E ;		; $A4
    Door   3, $68, $28, $1C ;		; $A5
    Door   4, $12, $18, $D8 ;		; $A6
    Door  34, $10, $38, $8E ;		; $A7
    Door  88, $75, $2C, $40 ;		; $A8
    Door  21,	$F, $38, $CC ;		; $A9
    Door  40,	$D, $28, $DF ;		; $AA
    Door  30,	 8, $30, $CB ;		; $AB
    Door  16,	 9, $30, $C5 ;		; $AC
    Door   8,	 8, $30, $13 ;		; $AD
    Door  63,	$E, $30, $34 ;		; $AE
    Door  53,	$D, $38, $C6 ;		; $AF
    Door  13, $21, $34, $19 ;		; $B0
    Door  19,	$D, $28, $E6 ;		; $B1
    Door  25,	$D, $28, $DD ;		; $B2
    Door  25, $82, $28, $60 ;		; $B3
    Door  27,	 8, $30, $24 ;		; $B4
    Door  27, $5D, $20, $9A ;		; $B5
    Door  37, $19, $30, $2A ;		; $B6
    Door  37, $5E, $30, $9C ;		; $B7
    Door  47, $1E, $28, $80 ;		; $B8
    Door  47, $60, $28, $C8 ;		; $B9
    Door  57,	 8, $20, $6B ;		; $BA
    Door  57, $48, $20, $37 ;		; $BB
    Door  67, $37, $24, $98 ;		; $BC
    Door  67,	 8, $20, $36 ;		; $BD
    Door  87, $14, $20, $DE ;		; $BE
    Door  85, $1E, $30, $47 ;		; $BF
    Door  85, $6E, $30,  $C ;		; $C0
    Door  88, $1E, $2C, $4D ;		; $C1
    Door   0, $9F, $30, $96 ;		; $C2
    Door   8,	$F, $30,   4 ;		; $C3
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
    Door  71,	 8, $30, $77 ;		; $CE
    Door  82,	$F, $24, $85 ;		; $CF
    Door  99,	 8, $1C, $59 ;		; $D0
    Door  58, $50, $30, $A2 ;		; $D1
    Door  58, $58, $30,  $C ;		; $D2
    Door  49, $2C, $24, $97 ;		; $D3
    Door  19, $3A, $28,   4 ;		; $D4
    Door   4, $17, $14, $8F ;		; $D5
    Door  40,	$E, $28, $5B ;		; $D6
    Door  93, $3F, $2C, $56 ;		; $D7
    Door   1, $D5, $10, $A6 ;		; $D8
    Door   5,	$B, $30, $60 ;		; $D9
    Door   6, $AD, $24, $2C ;		; $DA
    Door  10,	$D, $3C, $77 ;		; $DB
    Door  12, $84, $34, $92 ;		; $DC
    Door  17, $18, $24, $B2 ;		; $DD
    Door  18, $70, $14, $BE ;		; $DE
    Door  24, $13, $30, $AA ;		; $DF
    Door  26, $EF, $2C, $30 ;		; $E0
    Door  31,	$E, $28, $2C ;		; $E1
    Door  32,	 2, $20, $59 ;		; $E2
    Door  43,	$A, $20, $59 ;		; $E3
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
    Door 255,	 0,   0,   0 ;		; $EE
    Door 255,	 0, $F7,   0 ;		; $EF
ZoneDoorFlagsTable:
    .BYTE DoorFlags_Hidden|$80
    .BYTE DoorFlags_Open|$80		; 1
    .BYTE DoorFlags_Open|$80		; 2
    .BYTE DoorFlags_Closed|$80		; 3
    .BYTE DoorFlags_Closed|$80		; 4
    .BYTE DoorFlags_Open|$80		; 5
    .BYTE DoorFlags_Open|$80		; 6
    .BYTE DoorFlags_Open|$80		; 7
    .BYTE DoorFlags_Open|$80		; 8
    .BYTE DoorFlags_Open|$80		; 9
    .BYTE DoorFlags_Open|$80		; $A
    .BYTE DoorFlags_Open|$80		; $B
    .BYTE DoorFlags_Open|$80		; $C
    .BYTE DoorFlags_Open|$80		; $D
    .BYTE DoorFlags_Open|$80		; $E
    .BYTE DoorFlags_Open|$80		; $F
    .BYTE DoorFlags_Invisible|$80	; $10
    .BYTE DoorFlags_Open|$80		; $11
    .BYTE DoorFlags_Open|$80		; $12
    .BYTE DoorFlags_Open|$80		; $13
    .BYTE DoorFlags_Open|$80		; $14
    .BYTE DoorFlags_Open|$80		; $15
    .BYTE DoorFlags_Invisible|$80	; $16
    .BYTE DoorFlags_Open|$80		; $17
    .BYTE DoorFlags_Closed|$80		; $18
    .BYTE DoorFlags_Hidden|$80		; $19
    .BYTE DoorFlags_Open|$80		; $1A
    .BYTE DoorFlags_Open|$80		; $1B
    .BYTE DoorFlags_Open|$80		; $1C
    .BYTE DoorFlags_Open|$80		; $1D
    .BYTE DoorFlags_Hidden|$80		; $1E
    .BYTE DoorFlags_Closed|$80		; $1F
    .BYTE DoorFlags_Invisible|$80	; $20
    .BYTE DoorFlags_Closed|$80		; $21
    .BYTE DoorFlags_Open|$80		; $22
    .BYTE DoorFlags_Closed|$80		; $23
    .BYTE DoorFlags_Closed|$80		; $24
    .BYTE DoorFlags_Open|$80		; $25
    .BYTE DoorFlags_Open|$80		; $26
    .BYTE DoorFlags_Invisible|$80	; $27
    .BYTE DoorFlags_Open|$80		; $28
    .BYTE DoorFlags_Open|$80		; $29
    .BYTE DoorFlags_Open|$80		; $2A
    .BYTE DoorFlags_Hidden|$80		; $2B
    .BYTE DoorFlags_Open|$80		; $2C
    .BYTE DoorFlags_Closed|$80		; $2D
    .BYTE DoorFlags_Closed|$80		; $2E
    .BYTE DoorFlags_Open|$80		; $2F
    .BYTE DoorFlags_Open|$80		; $30
    .BYTE DoorFlags_Hidden|$80		; $31
    .BYTE DoorFlags_Closed|$80		; $32
    .BYTE DoorFlags_Open|$80		; $33
    .BYTE DoorFlags_Closed|$80		; $34
    .BYTE DoorFlags_Open|$80		; $35
    .BYTE DoorFlags_Invisible|$80	; $36
    .BYTE DoorFlags_Closed|$80		; $37
    .BYTE DoorFlags_Open|$80		; $38
    .BYTE DoorFlags_Open|$80		; $39
    .BYTE DoorFlags_Open|$80		; $3A
    .BYTE DoorFlags_Open|$80		; $3B
    .BYTE DoorFlags_Open|$80		; $3C
    .BYTE DoorFlags_Open|$80		; $3D
    .BYTE DoorFlags_Open|$80		; $3E
    .BYTE DoorFlags_Open|$80		; $3F
    .BYTE DoorFlags_Open|$80		; $40
    .BYTE DoorFlags_Open|$80		; $41
    .BYTE DoorFlags_Open|$80		; $42
    .BYTE DoorFlags_Open|$80		; $43
    .BYTE DoorFlags_Open|$80		; $44
    .BYTE DoorFlags_Open|$80		; $45
    .BYTE DoorFlags_Open|$80		; $46
    .BYTE DoorFlags_Closed|$80		; $47
    .BYTE DoorFlags_Open|$80		; $48
    .BYTE DoorFlags_Open|$80		; $49
    .BYTE DoorFlags_Open|$80		; $4A
    .BYTE DoorFlags_Closed|$80		; $4B
    .BYTE DoorFlags_Open|$80		; $4C
    .BYTE DoorFlags_Open|$80		; $4D
    .BYTE DoorFlags_Open|$80		; $4E
    .BYTE DoorFlags_Open|$80		; $4F
    .BYTE DoorFlags_Open|$80		; $50
    .BYTE DoorFlags_Open|$80		; $51
    .BYTE DoorFlags_Open|$80		; $52
    .BYTE DoorFlags_Open|$80		; $53
    .BYTE DoorFlags_Closed|$80		; $54
    .BYTE DoorFlags_Open|$80		; $55
    .BYTE DoorFlags_Open|$80		; $56
    .BYTE DoorFlags_Open|$80		; $57
    .BYTE DoorFlags_Open|$80		; $58
    .BYTE DoorFlags_Open|$80		; $59
    .BYTE DoorFlags_Open|$80		; $5A
    .BYTE DoorFlags_Open|$80		; $5B
    .BYTE DoorFlags_Open|$80		; $5C
    .BYTE DoorFlags_Open|$80		; $5D
    .BYTE DoorFlags_Open|$80		; $5E
    .BYTE DoorFlags_Open|$80		; $5F
    .BYTE DoorFlags_Closed|$80		; $60
    .BYTE DoorFlags_Open|$80		; $61
    .BYTE DoorFlags_Open|$80		; $62
    .BYTE DoorFlags_Open|$80		; $63
    .BYTE DoorFlags_Open|$80		; $64
    .BYTE DoorFlags_Open|$80		; $65
    .BYTE DoorFlags_Open|$80		; $66
    .BYTE DoorFlags_Open|$80		; $67
    .BYTE DoorFlags_Open|$80		; $68
    .BYTE DoorFlags_Open|$80		; $69
    .BYTE DoorFlags_Open|$80		; $6A
    .BYTE DoorFlags_Open|$80		; $6B
    .BYTE DoorFlags_Open|$80		; $6C
    .BYTE DoorFlags_Open|$80		; $6D
    .BYTE DoorFlags_Open|$80		; $6E
    .BYTE DoorFlags_Open|$80		; $6F
    .BYTE DoorFlags_Open|$80		; $70
    .BYTE DoorFlags_Open|$80		; $71
    .BYTE DoorFlags_Open|$80		; $72
    .BYTE DoorFlags_Hidden|$80		; $73
    .BYTE DoorFlags_Open|$80		; $74
    .BYTE DoorFlags_Open|$80		; $75
    .BYTE DoorFlags_Open|$80		; $76
    .BYTE DoorFlags_Closed|$80		; $77
    .BYTE DoorFlags_Closed|$80		; $78
    .BYTE DoorFlags_Open|$80		; $79
    .BYTE DoorFlags_Open|$80		; $7A
    .BYTE DoorFlags_Closed|$80		; $7B
    .BYTE DoorFlags_Open|$80		; $7C
    .BYTE DoorFlags_Open|$80		; $7D
    .BYTE DoorFlags_Open|$80		; $7E
    .BYTE DoorFlags_Open|$80		; $7F
    .BYTE DoorFlags_Open|$80		; $80
    .BYTE DoorFlags_Open|$80		; $81
    .BYTE DoorFlags_Open|$80		; $82
    .BYTE DoorFlags_Open|$80		; $83
    .BYTE DoorFlags_Closed|$80		; $84
    .BYTE DoorFlags_Hidden|$80		; $85
    .BYTE DoorFlags_Hidden|$80		; $86
    .BYTE DoorFlags_Open|$80		; $87
    .BYTE DoorFlags_Open|$80		; $88
    .BYTE DoorFlags_Open|$80		; $89
    .BYTE DoorFlags_Hidden|$80		; $8A
    .BYTE DoorFlags_Open|$80		; $8B
    .BYTE DoorFlags_Invisible|$80	; $8C
    .BYTE DoorFlags_Open|$80		; $8D
    .BYTE DoorFlags_Hidden|$80		; $8E
    .BYTE DoorFlags_Open|$80		; $8F
    .BYTE DoorFlags_Open|$80		; $90
    .BYTE DoorFlags_Open|$80		; $91
    .BYTE DoorFlags_Open|$80		; $92
    .BYTE DoorFlags_Open|$80		; $93
    .BYTE DoorFlags_Open|$80		; $94
    .BYTE DoorFlags_Open|$80		; $95
    .BYTE DoorFlags_Open|$80		; $96
    .BYTE DoorFlags_Open|$80		; $97
    .BYTE DoorFlags_Closed|$80		; $98
    .BYTE DoorFlags_Open|$80		; $99
    .BYTE DoorFlags_Open|$80		; $9A
    .BYTE DoorFlags_Open|$80		; $9B
    .BYTE DoorFlags_Open|$80		; $9C
    .BYTE DoorFlags_Open|$80		; $9D
    .BYTE DoorFlags_Open|$80		; $9E
    .BYTE DoorFlags_Open|$80		; $9F
    .BYTE DoorFlags_Open|$80		; $A0
    .BYTE DoorFlags_Open|$80		; $A1
    .BYTE DoorFlags_Open|$80		; $A2
    .BYTE DoorFlags_Open|$80		; $A3
    .BYTE DoorFlags_Open|$80		; $A4
    .BYTE DoorFlags_Open|$80		; $A5
    .BYTE DoorFlags_Open|$80		; $A6
    .BYTE DoorFlags_Open|$80		; $A7
    .BYTE DoorFlags_Open|$80		; $A8
    .BYTE DoorFlags_Open|$80		; $A9
    .BYTE DoorFlags_Open|$80		; $AA
    .BYTE DoorFlags_Open|$80		; $AB
    .BYTE DoorFlags_Open|$80		; $AC
    .BYTE DoorFlags_Open|$80		; $AD
    .BYTE DoorFlags_Open|$80		; $AE
    .BYTE DoorFlags_Open|$80		; $AF
    .BYTE DoorFlags_Open|$80		; $B0
    .BYTE DoorFlags_Open|$80		; $B1
    .BYTE DoorFlags_Open|$80		; $B2
    .BYTE DoorFlags_Open|$80		; $B3
    .BYTE DoorFlags_Open|$80		; $B4
    .BYTE DoorFlags_Open|$80		; $B5
    .BYTE DoorFlags_Open|$80		; $B6
    .BYTE DoorFlags_Open|$80		; $B7
    .BYTE DoorFlags_Open|$80		; $B8
    .BYTE DoorFlags_Open|$80		; $B9
    .BYTE DoorFlags_Open|$80		; $BA
    .BYTE DoorFlags_Open|$80		; $BB
    .BYTE DoorFlags_Open|$80		; $BC
    .BYTE DoorFlags_Open|$80		; $BD
    .BYTE DoorFlags_Open|$80		; $BE
    .BYTE DoorFlags_Open|$80		; $BF
    .BYTE DoorFlags_Open|$80		; $C0
    .BYTE DoorFlags_Open|$80		; $C1
    .BYTE DoorFlags_Closed|$80		; $C2
    .BYTE DoorFlags_Open|$80		; $C3
    .BYTE DoorFlags_Hidden|$80		; $C4
    .BYTE DoorFlags_Hidden|$80		; $C5
    .BYTE DoorFlags_Hidden|$80		; $C6
    .BYTE DoorFlags_Hidden|$80		; $C7
    .BYTE DoorFlags_Open|$80		; $C8
    .BYTE DoorFlags_Closed|$80		; $C9
    .BYTE DoorFlags_Closed|$80		; $CA
    .BYTE DoorFlags_Closed|$80		; $CB
    .BYTE DoorFlags_Hidden|$80		; $CC
    .BYTE DoorFlags_Open|$80		; $CD
    .BYTE DoorFlags_Closed|$80		; $CE
    .BYTE DoorFlags_Invisible|$80	; $CF
    .BYTE DoorFlags_Closed|$80		; $D0
    .BYTE DoorFlags_Invisible|$80	; $D1
    .BYTE DoorFlags_Open|$80		; $D2
    .BYTE DoorFlags_Hidden|$80		; $D3
    .BYTE DoorFlags_Open|$80		; $D4
    .BYTE DoorFlags_Hidden|$80		; $D5
    .BYTE DoorFlags_Hidden|$80		; $D6
    .BYTE DoorFlags_Hidden|$80		; $D7
    .BYTE DoorFlags_Hidden|$80		; $D8
    .BYTE DoorFlags_Hidden|$80		; $D9
    .BYTE DoorFlags_Invisible|$80	; $DA
    .BYTE DoorFlags_Invisible|$80	; $DB
    .BYTE DoorFlags_Hidden|$80		; $DC
    .BYTE DoorFlags_Hidden|$80		; $DD
    .BYTE DoorFlags_Hidden|$80		; $DE
    .BYTE DoorFlags_Hidden|$80		; $DF
    .BYTE DoorFlags_Invisible|$80	; $E0
    .BYTE DoorFlags_Hidden|$80		; $E1
    .BYTE DoorFlags_Closed|$80		; $E2
    .BYTE DoorFlags_Closed|$80		; $E3
    .BYTE DoorFlags_Hidden|$80		; $E4
    .BYTE DoorFlags_Invisible|$80	; $E5
    .BYTE DoorFlags_Open|$80		; $E6
    .BYTE DoorFlags_Hidden|$80		; $E7
    .BYTE DoorFlags_Closed|$80		; $E8
    .BYTE DoorFlags_Hidden|$80		; $E9
    .BYTE DoorFlags_Hidden|$80		; $EA
    .BYTE DoorFlags_Hidden|$80		; $EB
    .BYTE DoorFlags_Hidden|$80		; $EC
    .BYTE DoorFlags_Invisible|$80	; $ED
    .BYTE DoorFlags_Open|$80		; $EE
    .BYTE DoorFlags_Open|$80		; $EF
ZoneItemTable:
    Item   5, $19, $70, $31 ;		  ;	DATA XREF: LoadZoneItemst
    Item   5,	$F, $70, $21 ;		; 1
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
    Item  65,	 8, $58, $21 ;		; $F
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
    Item   8,	$C, $60, $52 ;		; $1B
    Item   9, $34, $70, $31 ;		; $1C
    Item   9, $60, $64, $41 ;		; $1D
    Item   9, $98, $6C, $31 ;		; $1E
    Item  10,	$B, $74, $45 ;		; $1F
    Item  10,	$D, $70, $45 ;		; $20
    Item  11, $46, $60, $23 ;		; $21
    Item  11, $32, $68, $12 ;		; $22
    Item  12, $A7, $74, $32 ;		; $23
    Item  12, $70, $74, $21 ;		; $24
    Item  12, $18, $64, $31 ;		; $25
    Item  13, $2F, $6C, $32 ;		; $26
    Item  13, $18, $6C, $31 ;		; $27
    Item  14,	$C, $60, $52 ;		; $28
    Item  16,	 8, $70, $52 ;		; $29
    Item  17, $10, $74, $41 ;		; $2A
    Item  20, $33, $6C, $35 ;		; $2B
    Item  20,	 8, $6C,   4 ;		; $2C
    Item  21,	 8, $54, $45 ;		; $2D
    Item  21,	$F, $54, $45 ;		; $2E
    Item  22, $28, $68, $11 ;		; $2F
    Item  23, $4B, $70, $11 ;		; $30
    Item  23, $32, $68, $21 ;		; $31
    Item  24, $17, $70, $45 ;		; $32
    Item  24,	 8, $70, $45 ;		; $33
    Item  26, $56, $6C, $31 ;		; $34
    Item  26, $73, $50, $31 ;		; $35
    Item  26, $EC, $50, $31 ;		; $36
    Item  27, $48, $70, $33 ;		; $37
    Item  27, $5A, $70, $31 ;		; $38
    Item  28, $5E, $70, $51 ;		; $39
    Item  28, $77, $60,   3 ;		; $3A
    Item  29, $36, $70, $15 ;		; $3B
    Item  29, $79, $60, $15 ;		; $3C
    Item  30,	$E, $70, $51 ;		; $3D
    Item  31, $35, $74, $15 ;		; $3E
    Item  31, $1A, $74, $12 ;		; $3F
    Item  33, $32, $6C, $31 ;		; $40
    Item  33, $49, $70, $31 ;		; $41
    Item  33, $66, $70, $31 ;		; $42
    Item  34,	$A, $5C, $51 ;		; $43
    Item  34, $15, $5C, $21 ;		; $44
    Item  35, $10, $64, $41 ;		; $45
    Item  35, $36, $74, $31 ;		; $46
    Item  36,	 8, $74,   4 ;		; $47
    Item  36, $3E, $74, $31 ;		; $48
    Item  36, $77, $74, $41 ;		; $49
    Item  37, $46, $70, $21 ;		; $4A
    Item  37, $1D, $70, $41 ;		; $4B
    Item  38,	$D, $54, $45 ;		; $4C
    Item  39, $27, $68, $42 ;		; $4D
    Item  40,	$F, $68, $51 ;		; $4E
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
    Item  49,	$A, $78, $24 ;		; $5F
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
    Item  62,	 8, $74, $52 ;		; $7A
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
    Item  75,	 8, $6C, $52 ;		; $8C
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
    Item  87,	 8, $60, $52 ;		; $9C
    Item  88, $3F, $70, $45 ;		; $9D
    Item  88, $5C, $70, $42 ;		; $9E
    Item  89,	$B, $70, $52 ;		; $9F
    Item  90,	$E, $70, $52 ;		; $A0
    Item  90,	 8, $74, $51 ;		; $A1
    Item  91, $49, $50, $31 ;		; $A2
    Item  91, $50, $70, $21 ;		; $A3
    Item  91, $90, $70, $13 ;		; $A4
    Item  92,	$D, $6C, $53 ;		; $A5
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
    Item  16,	$F, $70,   5 ;		; $B1
    Item  17, $13, $74, $35 ;		; $B2
    Item  17, $11, $64, $25 ;		; $B3
    Item  18, $10, $54, $21 ;		; $B4
    Item  27, $5F, $70, $35 ;		; $B5
    Item  27, $1A, $68, $31 ;		; $B6
    Item  47, $54, $70, $25 ;		; $B7
    Item  50, $1B, $50, $25 ;		; $B8
    Item  25, $42, $70, $35 ;		; $B9
    Item  25, $51, $70, $21 ;		; $BA
    Item  63,	 8, $70,   5 ;		; $BB
    Item  70, $36, $6C, $35 ;		; $BC
    Item  78,	$F, $70, $35 ;		; $BD
    Item  84, $18, $58, $41 ;		; $BE
    Item  84, $1F, $60, $15 ;		; $BF
    Item  84, $88, $60, $15 ;		; $C0
    Item  38,	$E, $74, $25 ;		; $C1
    Item  86, $56, $64, $25 ;		; $C2
    Item  87, $16, $70, $35 ;		; $C3
    Item  87,	$B, $70, $35 ;		; $C4
    Item  91, $68, $70, $35 ;		; $C5
    Item  94, $3D, $50, $31 ;		; $C6
    Item   0, $1A, $6C, $25 ;		; $C7
    Item   4, $17, $54, $82 ;		; $C8
    Item   3, $6D, $5A, $80 ;		; $C9
    Item   5, $15, $61, $81 ;		; $CA
    Item  24,	$F, $60, $85 ;		; $CB
    Item   8,	$A, $50, $83 ;		; $CC
    Item  14,	$C, $24, $86 ;		; $CD
    Item  17, $1E, $6F, $80 ;		; $CE
    Item  87,	 8, $57, $87 ;		; $CF
    Item  28, $73, $50, $86 ;		; $D0
    Item  31, $4A, $56, $82 ;		; $D1
    Item   9, $39, $54, $87 ;		; $D2
    Item  21,	 8, $78, $81 ;		; $D3
    Item  34,	$F, $50, $85 ;		; $D4
    Item  56,	$D, $5B, $80 ;		; $D5
    Item  37, $40, $70, $80 ;		; $D6
    Item 119, $3A, $70, $84 ;		; $D7
    Item  43, $13, $70, $86 ;		; $D8
    Item  46, $4B, $67, $80 ;		; $D9
    Item  49, $33, $4F, $83 ;		; $DA
    Item  51, $3C, $54, $85 ;		; $DB
    Item  52, $17, $60, $81 ;		; $DC
    Item  53, $11, $58, $87 ;		; $DD
    Item  61, $34, $5F, $82 ;		; $DE
    Item  63,	 9, $4E, $81 ;		; $DF
    Item 119, $20, $54, $86 ;		; $E0
    Item  65,	$B, $50, $84 ;		; $E1
    Item  65,	$C, $50, $86 ;		; $E2
    Item  54, $18, $5F, $86 ;		; $E3
    Item  67, $27, $74, $80 ;		; $E4
    Item 119, $44, $60, $83 ;		; $E5
    Item  74,	$C, $4E, $84 ;		; $E6
    Item  76, $A3, $53, $85 ;		; $E7
    Item 119, $7C, $54, $82 ;		; $E8
    Item  79, $17, $62, $80 ;		; $E9
    Item 119, $67, $54, $84 ;		; $EA
    Item  86, $63, $62, $81 ;		; $EB
    Item 119, $1C, $60, $83 ;		; $EC
    Item 119, $32, $50, $87 ;		; $ED
    Item  97, $66, $53, $86 ;		; $EE
    .BYTE $FF
    .BYTE $BF
    .BYTE   2
    .BYTE $FF
loc_DE50:
	.BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $42
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $7B
    .BYTE 0
    .BYTE $43
    .BYTE $B7
    .BYTE 0
    .BYTE $47
    .BYTE 0
    .BYTE 0
    .BYTE $8B
    .BYTE 0
    .BYTE 0
    .BYTE $C7
    .BYTE 0
    .BYTE $49
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $57
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $CD
    .BYTE 0
    .BYTE $58
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $CE
    .BYTE 0
    .BYTE $59
    .BYTE 0
    .BYTE $67
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $CF
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $69
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $90
    .BYTE 0
    .BYTE 0
    .BYTE $72
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $91
    .BYTE 0
    .BYTE $A5
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $DC
    .BYTE 0
    .BYTE $A6
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $A7
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 4
    .BYTE $17
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 0
    .BYTE 0
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 0
    .BYTE 0
    .BYTE 4
    .BYTE 6
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE $20
    .BYTE $30
    .BYTE $40
    .BYTE $50
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 0
    .BYTE $20
    .BYTE $31
    .BYTE $41
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 0
    .BYTE 0
    .BYTE $20
    .BYTE $51
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 0
    .BYTE $17
    .BYTE 4
    .BYTE $17
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 0
    .BYTE $16
    .BYTE 4
    .BYTE $16
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 4
    .BYTE $17
    .BYTE 4
    .BYTE $17
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 4
    .BYTE $16
    .BYTE 4
    .BYTE $16
    .BYTE 0
    .BYTE 0
    .BYTE $22
    .BYTE $32
    .BYTE 4
    .BYTE 5
    .BYTE 4
    .BYTE 5
    .BYTE 0
    .BYTE 0
    .BYTE $23
    .BYTE $33
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $20
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $17
    .BYTE 4
    .BYTE $17
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $16
    .BYTE 4
    .BYTE $16
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $15
    .BYTE 4
    .BYTE $17
    .BYTE 4
    .BYTE $17
    .BYTE 4
    .BYTE $17
    .BYTE 4
    .BYTE $17
    .BYTE 4
    .BYTE $16
    .BYTE 4
    .BYTE $16
    .BYTE 4
    .BYTE $16
    .BYTE 4
    .BYTE $16
    .BYTE $3B
    .BYTE 8
    .BYTE $2B
    .BYTE $3B
    .BYTE $3B
    .BYTE $3B
    .BYTE $3B
    .BYTE $3B
    .BYTE $3B
    .BYTE 8
    .BYTE $2B
    .BYTE $3B
    .BYTE $3B
    .BYTE 8
    .BYTE $2B
    .BYTE $3B
    .BYTE $3B
    .BYTE 8
    .BYTE $2B
    .BYTE $3B
    .BYTE $3B
    .BYTE 8
    .BYTE 8
    .BYTE 8
    .BYTE $3B
    .BYTE 8
    .BYTE 8
    .BYTE 8
    .BYTE 8
    .BYTE 8
    .BYTE 8
    .BYTE 8
    .BYTE 8
    .BYTE 8
    .BYTE 8
    .BYTE 8
    .BYTE 8
    .BYTE 8
    .BYTE $2B
    .BYTE $3B
    .BYTE 8
    .BYTE 8
    .BYTE $2B
    .BYTE $3B
    .BYTE $3B
    .BYTE 8
    .BYTE $2B
    .BYTE $3B
    .BYTE $3B
    .BYTE 8
    .BYTE 8
    .BYTE 8
    .BYTE 8
    .BYTE 8
    .BYTE $2B
    .BYTE $3B
    .BYTE $3B
    .BYTE $3B
    .BYTE $3B
    .BYTE $3B
    .BYTE $3B
    .BYTE 8
    .BYTE $2B
    .BYTE $3B
    .BYTE $3B
    .BYTE 8
    .BYTE $46
    .BYTE $3B
    .BYTE $3B
    .BYTE $3B
    .BYTE $46
    .BYTE $3B
    .BYTE 9
    .BYTE $B
    .BYTE $10
    .BYTE $11
    .BYTE $12
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $A
    .BYTE $3C
    .BYTE $3C
    .BYTE $3C
    .BYTE 0
    .BYTE $45
    .BYTE $34
    .BYTE $44
    .BYTE $A
    .BYTE $3C
    .BYTE $3C
    .BYTE $3C
    .BYTE 8
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $A
    .BYTE $3C
    .BYTE $3C
    .BYTE $3C
    .BYTE 8
    .BYTE $24
    .BYTE $34
    .BYTE $44
    .BYTE $A
    .BYTE $3C
    .BYTE $3C
    .BYTE $3C
    .BYTE $34
    .BYTE $34
    .BYTE $34
    .BYTE $44
    .BYTE $A
    .BYTE $3C
    .BYTE $3C
    .BYTE $3C
    .BYTE 0
    .BYTE 0
    .BYTE $26
    .BYTE $36
    .BYTE $A
    .BYTE $3C
    .BYTE $3C
    .BYTE $3C
    .BYTE 0
    .BYTE 0
    .BYTE $27
    .BYTE $37
    .BYTE $A
    .BYTE $3C
    .BYTE $3C
    .BYTE $3C
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 8
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 8
    .BYTE $24
    .BYTE $34
    .BYTE $34
    .BYTE 8
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 8
    .BYTE $24
    .BYTE $34
    .BYTE $34
    .BYTE 8
    .BYTE $24
    .BYTE $34
    .BYTE $34
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $45
    .BYTE $34
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $25
    .BYTE $35
    .BYTE $19
    .BYTE $29
    .BYTE $29
    .BYTE $29
    .BYTE $39
    .BYTE $7A
    .BYTE $8A
    .BYTE 0
    .BYTE $19
    .BYTE $29
    .BYTE $29
    .BYTE $29
    .BYTE $39
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $9A
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $9B
    .BYTE 0
    .BYTE $BB
    .BYTE 0
    .BYTE $75
    .BYTE $75
    .BYTE $56
    .BYTE $75
    .BYTE $75
    .BYTE $E
    .BYTE $1E
    .BYTE $2E
    .BYTE $75
    .BYTE $56
    .BYTE $75
    .BYTE $75
    .BYTE $E
    .BYTE $1E
    .BYTE $1E
    .BYTE $2E
    .BYTE $75
    .BYTE $75
    .BYTE $75
    .BYTE $E
    .BYTE $1E
    .BYTE $1E
    .BYTE $1E
    .BYTE $2E
    .BYTE $56
    .BYTE $75
    .BYTE $E
    .BYTE $1E
    .BYTE $1E
    .BYTE $1E
    .BYTE $1E
    .BYTE $2E
    .BYTE $75
    .BYTE $E
    .BYTE $1E
    .BYTE $1E
    .BYTE $1E
    .BYTE $1E
    .BYTE $2E
    .BYTE 0
    .BYTE $E
    .BYTE $1E
    .BYTE $1E
    .BYTE $1E
    .BYTE $1E
    .BYTE $1E
    .BYTE $1E
    .BYTE $2E
    .BYTE $E
    .BYTE $2E
    .BYTE $75
    .BYTE $75
    .BYTE $56
    .BYTE $75
    .BYTE $75
    .BYTE $75
    .BYTE $E
    .BYTE $1E
    .BYTE $2E
    .BYTE $75
    .BYTE $75
    .BYTE $75
    .BYTE $56
    .BYTE $75
    .BYTE $E
    .BYTE $1E
    .BYTE $1E
    .BYTE $2E
    .BYTE $75
    .BYTE $56
    .BYTE $75
    .BYTE $75
    .BYTE $75
    .BYTE $E
    .BYTE $1E
    .BYTE $1E
    .BYTE $2E
    .BYTE $75
    .BYTE $75
    .BYTE $75
    .BYTE $56
    .BYTE $75
    .BYTE $75
    .BYTE $56
    .BYTE $75
    .BYTE $75
    .BYTE $75
    .BYTE $56
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $76
    .BYTE $86
    .BYTE $96
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $77
    .BYTE $87
    .BYTE $97
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $78
    .BYTE $88
    .BYTE $98
    .BYTE 0
    .BYTE $D
    .BYTE $1D
    .BYTE $2D
    .BYTE $3D
    .BYTE $3D
    .BYTE $3D
    .BYTE $3D
    .BYTE $3D
    .BYTE 0
    .BYTE $D
    .BYTE $1D
    .BYTE $2D
    .BYTE $3D
    .BYTE $3D
    .BYTE $3D
    .BYTE $3D
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $D
    .BYTE $1D
    .BYTE $2D
    .BYTE $3D
    .BYTE $3D
    .BYTE 0
    .BYTE 0
    .BYTE $70
    .BYTE $80
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $71
    .BYTE $81
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $70
    .BYTE $80
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $71
    .BYTE $81
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $1F
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $F
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $2F
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $1F
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $1F
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $F
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $F
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $2F
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $2F
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $F
    .BYTE $24
    .BYTE $34
    .BYTE $34
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $F
    .BYTE $24
    .BYTE $34
    .BYTE $44
    .BYTE $F
    .BYTE $24
    .BYTE $34
    .BYTE $44
    .BYTE $F
    .BYTE $24
    .BYTE $34
    .BYTE $34
    .BYTE $34
    .BYTE $34
    .BYTE $34
    .BYTE $44
    .BYTE $F
    .BYTE $24
    .BYTE $34
    .BYTE $34
    .BYTE $F
    .BYTE $24
    .BYTE $34
    .BYTE $34
    .BYTE $34
    .BYTE $34
    .BYTE $34
    .BYTE $34
    .BYTE $F
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $79
    .BYTE $89
    .BYTE $19
    .BYTE $29
    .BYTE $29
    .BYTE $29
    .BYTE $39
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $C
    .BYTE $D2
    .BYTE $DD
    .BYTE $DD
    .BYTE $DD
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $19
    .BYTE $29
    .BYTE $29
    .BYTE $29
    .BYTE $39
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $4C
    .BYTE $4C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $AA
    .BYTE $AA
    .BYTE $AA
    .BYTE $AA
    .BYTE $AA
    .BYTE $AA
    .BYTE $AA
    .BYTE $AA
    .BYTE $AB
    .BYTE $AB
    .BYTE $AB
    .BYTE $AB
    .BYTE $AB
    .BYTE $AB
    .BYTE $AB
    .BYTE $AB
    .BYTE 2
    .BYTE 2
    .BYTE $A4
    .BYTE 2
    .BYTE 2
    .BYTE 2
    .BYTE $A4
    .BYTE 2
    .BYTE $A4
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $A4
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $A4
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $A4
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $13
    .BYTE $28
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $18
    .BYTE $2A
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $1A
    .BYTE $38
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $21
    .BYTE $3A
    .BYTE 0
    .BYTE 0
    .BYTE $55
    .BYTE $61
    .BYTE $61
    .BYTE $63
    .BYTE 0
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE $55
    .BYTE $61
    .BYTE $61
    .BYTE 0
    .BYTE 0
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $B4
    .BYTE $C4
    .BYTE $B5
    .BYTE $C5
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $B5
    .BYTE $C5
    .BYTE $B6
    .BYTE $C6
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 0
    .BYTE $61
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $61
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $61
    .BYTE $61
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 0
    .BYTE 0
    .BYTE $61
    .BYTE $61
    .BYTE $61
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE   0
    .BYTE $61
    .BYTE $61
    .BYTE $61
    .BYTE $61
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE $54
    .BYTE $61
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE $55
    .BYTE $61
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE $53
    .BYTE $61
    .BYTE $62
    .BYTE 0
    .BYTE 0
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE $55
    .BYTE $61
    .BYTE $61
    .BYTE $61
    .BYTE $61
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE $55
    .BYTE $61
    .BYTE $62
    .BYTE 0
    .BYTE 0
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE $55
    .BYTE $61
    .BYTE $63
    .BYTE 0
    .BYTE 0
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $52
    .BYTE $7D
    .BYTE $8D
    .BYTE $9D
    .BYTE $AD
    .BYTE $AD
    .BYTE $77
    .BYTE $87
    .BYTE $87
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $B4
    .BYTE $C4
    .BYTE $B4
    .BYTE $C4
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $B6
    .BYTE $C6
    .BYTE $B6
    .BYTE $C6
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $B6
    .BYTE $C6
    .BYTE $B5
    .BYTE $C5
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $5B
    .BYTE $6B
    .BYTE $6B
    .BYTE $6B
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $5C
    .BYTE $5E
    .BYTE $6B
    .BYTE $6B
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $5C
    .BYTE $5C
    .BYTE $4B
    .BYTE $4C
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $5C
    .BYTE $5F
    .BYTE $6F
    .BYTE $6F
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $5D
    .BYTE $6D
    .BYTE $6D
    .BYTE $6D
    .BYTE $5B
    .BYTE $6B
    .BYTE $6B
    .BYTE $6B
    .BYTE $5E
    .BYTE $6E
    .BYTE $6E
    .BYTE $6E
    .BYTE $5C
    .BYTE $5E
    .BYTE $6E
    .BYTE $6E
    .BYTE $5C
    .BYTE $5E
    .BYTE $6B
    .BYTE $6B
    .BYTE $5C
    .BYTE $5C
    .BYTE $4B
    .BYTE $4C
    .BYTE $5C
    .BYTE $5C
    .BYTE $4B
    .BYTE $4C
    .BYTE $5C
    .BYTE $5F
    .BYTE $6F
    .BYTE $5E
    .BYTE $6E
    .BYTE $6E
    .BYTE $6E
    .BYTE $6E
    .BYTE $5F
    .BYTE $6F
    .BYTE $6F
    .BYTE $5C
    .BYTE $5E
    .BYTE $6E
    .BYTE $6E
    .BYTE $6E
    .BYTE $6F
    .BYTE $6F
    .BYTE $6F
    .BYTE $5C
    .BYTE $5C
    .BYTE $4B
    .BYTE $4C
    .BYTE $4C
    .BYTE $6D
    .BYTE $6D
    .BYTE $6D
    .BYTE $5C
    .BYTE $5F
    .BYTE $6F
    .BYTE $6F
    .BYTE $6F
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $5D
    .BYTE $6D
    .BYTE $6D
    .BYTE $6D
    .BYTE $6D
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $5C
    .BYTE $5F
    .BYTE $6F
    .BYTE $6F
    .BYTE $6F
    .BYTE $5D
    .BYTE $6D
    .BYTE $6D
    .BYTE $5C
    .BYTE $5E
    .BYTE $6E
    .BYTE $6E
    .BYTE $6E
    .BYTE 0
    .BYTE 0
    .BYTE $4D
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $BC
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $7F
    .BYTE $8F
    .BYTE $9F
    .BYTE $AF
    .BYTE $AF
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $B4
    .BYTE $C4
    .BYTE $9F
    .BYTE $AF
    .BYTE $AF
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $B5
    .BYTE $C5
    .BYTE $9F
    .BYTE $AF
    .BYTE $AF
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $B6
    .BYTE $C6
    .BYTE $9F
    .BYTE $AF
    .BYTE $AF
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $AE
    .BYTE $9F
    .BYTE $AF
    .BYTE $AF
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $AC
    .BYTE $9F
    .BYTE $AF
    .BYTE $AF
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $C9
    .BYTE 0
    .BYTE 0
    .BYTE $BD
    .BYTE 0
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $2C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $2C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $2C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $2C
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $2C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $64
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $64
    .BYTE $64
    .BYTE $64
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $64
    .BYTE $64
    .BYTE $64
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $64
    .BYTE $64
    .BYTE $64
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $64
    .BYTE $64
    .BYTE $64
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $64
    .BYTE $64
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $64
    .BYTE $64
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $64
    .BYTE $64
    .BYTE $64
    .BYTE $64
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $64
    .BYTE $64
    .BYTE $64
    .BYTE $1B
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $CA
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $48
    .BYTE $68
    .BYTE $8A
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $C8
    .BYTE $C8
    .BYTE $4A
    .BYTE $6A
    .BYTE $48
    .BYTE $68
    .BYTE $8A
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $48
    .BYTE $68
    .BYTE $4A
    .BYTE $6A
    .BYTE $8A
    .BYTE 0
    .BYTE 0
    .BYTE $79
    .BYTE $4A
    .BYTE $68
    .BYTE $48
    .BYTE $68
    .BYTE $B8
    .BYTE $C8
    .BYTE 0
    .BYTE $79
    .BYTE $48
    .BYTE $68
    .BYTE $4A
    .BYTE $6A
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $4A
    .BYTE $6A
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $82
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE 0
    .BYTE 0
    .BYTE $82
    .BYTE 3
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE 0
    .BYTE $82
    .BYTE 3
    .BYTE 3
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE $73
    .BYTE 3
    .BYTE 3
    .BYTE 3
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE $74
    .BYTE $84
    .BYTE $94
    .BYTE 3
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE 0
    .BYTE $85
    .BYTE $95
    .BYTE $84
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE 0
    .BYTE 0
    .BYTE $85
    .BYTE $93
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $85
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE 0
    .BYTE 0
    .BYTE $73
    .BYTE 3
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE 0
    .BYTE 0
    .BYTE $74
    .BYTE $84
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE 0
    .BYTE $73
    .BYTE 3
    .BYTE 3
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE 0
    .BYTE $74
    .BYTE $84
    .BYTE $94
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE 0
    .BYTE 0
    .BYTE $85
    .BYTE $95
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE 0
    .BYTE 0
    .BYTE $73
    .BYTE $92
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $A0
    .BYTE $A0
    .BYTE $A0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $A2
    .BYTE $A2
    .BYTE $A2
    .BYTE $A2
    .BYTE $A2
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $A3
    .BYTE $A3
    .BYTE $A3
    .BYTE $A3
    .BYTE $A3
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $A1
    .BYTE $A1
    .BYTE $A1
    .BYTE 0
    .BYTE 0
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A0
    .BYTE $A0
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE $A2
    .BYTE $A2
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A3
    .BYTE $A3
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A1
    .BYTE $A1
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $CB
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $BF
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $CC
    .BYTE 0
    .BYTE $BE
    .BYTE 0
    .BYTE $69
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $90
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $D9
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $D6
    .BYTE 0
    .BYTE 0
    .BYTE $DA
    .BYTE 0
    .BYTE $D4
    .BYTE 0
    .BYTE 0
    .BYTE $D7
    .BYTE $48
    .BYTE $68
    .BYTE $48
    .BYTE $68
    .BYTE $48
    .BYTE $68
    .BYTE $48
    .BYTE $68
    .BYTE $4A
    .BYTE $6A
    .BYTE $48
    .BYTE $68
    .BYTE $4A
    .BYTE $6A
    .BYTE $48
    .BYTE $68
    .BYTE $48
    .BYTE $68
    .BYTE $4A
    .BYTE $6A
    .BYTE $48
    .BYTE $68
    .BYTE $4A
    .BYTE $6A
    .BYTE $4A
    .BYTE $6A
    .BYTE $4A
    .BYTE $6A
    .BYTE $4A
    .BYTE $6A
    .BYTE $4A
    .BYTE $6A
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $D2
    .BYTE $B2
    .BYTE $C2
    .BYTE $B9
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $BA
    .BYTE $B3
    .BYTE $C3
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $D3
    .BYTE $B2
    .BYTE $C2
    .BYTE $B9
    .BYTE 0
    .BYTE 0
    .BYTE $D2
    .BYTE $B2
    .BYTE $C2
    .BYTE $B9
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $BA
    .BYTE $B2
    .BYTE $C2
    .BYTE $B9
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $D3
    .BYTE $B3
    .BYTE $C3
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $D2
    .BYTE $B2
    .BYTE $C2
    .BYTE $B9
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $BA
    .BYTE $B3
    .BYTE $C3
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $D3
    .BYTE $B3
    .BYTE $C3
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $6C
    .BYTE $7C
    .BYTE $8C
    .BYTE $9C
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE $9E
    .BYTE 0
    .BYTE $6C
    .BYTE $7C
    .BYTE $8C
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE $9E
    .BYTE 0
    .BYTE 0
    .BYTE $6C
    .BYTE $8C
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE $9E
    .BYTE $A9
    .BYTE $1B
    .BYTE $99
    .BYTE $A9
    .BYTE $A9
    .BYTE $1B
    .BYTE $99
    .BYTE $A9
    .BYTE $A9
    .BYTE $A9
    .BYTE $A9
    .BYTE $A9
    .BYTE $A9
    .BYTE $1B
    .BYTE $99
    .BYTE $A9
    .BYTE $A9
    .BYTE $1B
    .BYTE $99
    .BYTE $A9
    .BYTE $A9
    .BYTE $A9
    .BYTE $A9
    .BYTE $A9
    .BYTE $1B
    .BYTE $1B
    .BYTE $99
    .BYTE $A9
    .BYTE $A9
    .BYTE $1B
    .BYTE $99
    .BYTE $A9
    .BYTE $1B
    .BYTE $1B
    .BYTE $99
    .BYTE $A9
    .BYTE $A9
    .BYTE $A9
    .BYTE $A9
    .BYTE $A9
    .BYTE $A9
    .BYTE $1B
    .BYTE $99
    .BYTE $A9
    .BYTE $A9
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $A9
    .BYTE $A9
    .BYTE $A9
    .BYTE $A9
    .BYTE $A9
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $A9
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $1B
    .BYTE $99
    .BYTE $A9
    .BYTE 0
    .BYTE 0
    .BYTE $DB
    .BYTE 0
    .BYTE $D5
    .BYTE 0
    .BYTE 0
    .BYTE $D8
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $BD
    .BYTE 0
    .BYTE $5A
    .BYTE 0
    .BYTE $B0
    .BYTE $C0
    .BYTE $D0
    .BYTE $E0
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE $B1
    .BYTE $C1
    .BYTE $D1
    .BYTE $E1
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $E2
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE $B0
    .BYTE $C0
    .BYTE $D0
    .BYTE $E3
    .BYTE $7E
    .BYTE $8E
    .BYTE $9E
    .BYTE 3
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $2C
    .BYTE $1C
    .BYTE $66
    .BYTE $66
    .BYTE $A4
    .BYTE $2C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $2C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $2C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $2C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $2C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $1C
    .BYTE $66
    .BYTE $66
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $2C
    .BYTE $1C
    .BYTE $66
    .BYTE $3E
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $2C
    .BYTE $1C
    .BYTE $66
    .BYTE $3F
    .BYTE $66
    .BYTE $66
    .BYTE $3E
    .BYTE $4E
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $66
    .BYTE $66
    .BYTE $3F
    .BYTE $4F
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $66
    .BYTE $3E
    .BYTE $4E
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $66
    .BYTE $3F
    .BYTE $4F
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $3E
    .BYTE $4E
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $3F
    .BYTE $4F
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $4E
    .BYTE $66
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $4F
    .BYTE $66
    .BYTE $1C
    .BYTE $1C
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4
    .BYTE $A4

loc_E650:
	.BYTE 0
    .BYTE 0
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $FF
    .BYTE 0
    .BYTE $3F
    .BYTE 0
    .BYTE $F
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $AA
    .BYTE 0
    .BYTE $AA
    .BYTE 0
    .BYTE $AA
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $F
    .BYTE 0
    .BYTE $F
    .BYTE 0
    .BYTE 3
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $8A
    .BYTE $AA
    .BYTE $8A
    .BYTE $8A
    .BYTE $8A
    .BYTE $80
    .BYTE $80
    .BYTE 0
    .BYTE 0
    .BYTE $A
    .BYTE $A
    .BYTE $8A
    .BYTE $80
    .BYTE $A
    .BYTE $AA
    .BYTE $8A
    .BYTE $8E
    .BYTE $AE
    .BYTE 0
    .BYTE 0
    .BYTE $AA
    .BYTE $15
    .BYTE $80
    .BYTE $15
    .BYTE $2A
    .BYTE $15
    .BYTE 0
    .BYTE $15
    .BYTE 0
    .BYTE $15
    .BYTE $A0
    .BYTE $15
    .BYTE $A0
    .BYTE $15
    .BYTE $AA
    .BYTE $2A
    .BYTE $AA
    .BYTE 0
    .BYTE $2A
    .BYTE $2A
    .BYTE 0
    .BYTE 0
    .BYTE $AA
    .BYTE $A0
    .BYTE $AA
    .BYTE $A0
    .BYTE 0
    .BYTE $2A
    .BYTE 0
    .BYTE $2A
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $AA
    .BYTE $80
    .BYTE $AA
    .BYTE 0
    .BYTE $A8
    .BYTE 0
    .BYTE $A0
    .BYTE 0
    .BYTE $80
    .BYTE 2
    .BYTE 0
    .BYTE 0
    .BYTE $A
    .BYTE $AA
    .BYTE 2
    .BYTE $AA
    .BYTE 0
    .BYTE $AA
    .BYTE $80
    .BYTE $2A
    .BYTE $AA
    .BYTE $AA
    .BYTE 0
    .BYTE $54
    .BYTE 0
    .BYTE $54
    .BYTE 0
    .BYTE $54
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $3F
    .BYTE 0
    .BYTE $3F
    .BYTE 0
    .BYTE 3
    .BYTE $F0
    .BYTE 3
    .BYTE $F0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $A8
    .BYTE 0
    .BYTE 5
    .BYTE 0
    .BYTE $A8
    .BYTE 0
    .BYTE 0
    .BYTE $AA
    .BYTE $AA
    .BYTE $AA
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $59
    .BYTE $59
    .BYTE $AA
    .BYTE $AA
    .BYTE $AA
    .BYTE $AA
    .BYTE 0
    .BYTE 4
    .BYTE 0
    .BYTE 4
    .BYTE 0
    .BYTE 4
    .BYTE 0
    .BYTE 4
    .BYTE $3F
    .BYTE $15
    .BYTE $3C
    .BYTE $15
    .BYTE 2
    .BYTE $AA
    .BYTE 2
    .BYTE $AA
    .BYTE 0
    .BYTE $15
    .BYTE $30
    .BYTE $15
    .BYTE 0
    .BYTE $15
    .BYTE 0
    .BYTE $D5
    .BYTE 3
    .BYTE $D5
    .BYTE $F
    .BYTE $D5
    .BYTE $3F
    .BYTE $D5
    .BYTE $30
    .BYTE $15
    .BYTE $30
    .BYTE $15
    .BYTE $3C
    .BYTE $15
    .BYTE $3F
    .BYTE $D5
    .BYTE $3C
    .BYTE $15
    .BYTE $3C
    .BYTE $15
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $3F
    .BYTE 2
    .BYTE $A8
    .BYTE 2
    .BYTE $A8
    .BYTE 2
    .BYTE $A8
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $55
    .BYTE $55
    .BYTE 0
    .BYTE $15
    .BYTE 2
    .BYTE $95
    .BYTE 2
    .BYTE $95
    .BYTE 2
    .BYTE $95
    .BYTE 0
    .BYTE $95
    .BYTE 0
    .BYTE $15
    .BYTE $55
    .BYTE $55
    .BYTE 0
    .BYTE 0
    .BYTE $A0
    .BYTE 0
    .BYTE $68
    .BYTE 0
    .BYTE $5A
    .BYTE 0
    .BYTE $56
    .BYTE $80
    .BYTE $55
    .BYTE $A8
    .BYTE 0
    .BYTE $29
    .BYTE 0
    .BYTE $A5
    .BYTE 2
    .BYTE $95
    .BYTE $40
    .BYTE 0
    .BYTE $54
    .BYTE 0
    .BYTE $15
    .BYTE 0
    .BYTE 5
    .BYTE $40
    .BYTE 1
    .BYTE $50
    .BYTE 0
    .BYTE $50
    .BYTE 0
    .BYTE 5
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $54
    .BYTE $55
    .BYTE $55
    .BYTE 0
    .BYTE $50
    .BYTE $A0
    .BYTE 5
    .BYTE 0
    .BYTE 5
    .BYTE $50
    .BYTE $A
    .BYTE $50
    .BYTE 0
    .BYTE 0
    .BYTE 5
    .BYTE $AA
    .BYTE $55
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $AA
    .BYTE 0
    .BYTE $2A
    .BYTE   0
    .BYTE   0
    .BYTE 2
    .BYTE $AA
    .BYTE 2
    .BYTE $AA
    .BYTE 0
    .BYTE $2A
    .BYTE $A
    .BYTE $AA
    .BYTE $AA
    .BYTE $AA
    .BYTE   0
    .BYTE   0
    .BYTE $AA
    .BYTE $AA
    .BYTE $AA
    .BYTE $AA
    .BYTE $AA
    .BYTE $AA
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $55
    .BYTE 0
    .BYTE $54
    .BYTE 0
    .BYTE $55
    .BYTE 5
    .BYTE $50
    .BYTE 5
    .BYTE $50
    .BYTE 5
    .BYTE $40
    .BYTE $55
    .BYTE 0
    .BYTE $54
    .BYTE 0
    .BYTE $54
    .BYTE 0
    .BYTE $AA
    .BYTE $55
    .BYTE $AA
    .BYTE $55
    .BYTE $AA
    .BYTE $55
    .BYTE $20
    .BYTE $20
    .BYTE 0
    .BYTE $20
    .BYTE $20
    .BYTE 0
    .BYTE $A0
    .BYTE $20
    .BYTE $A0
    .BYTE 0
    .BYTE $20
    .BYTE $2A
    .BYTE 0
    .BYTE $2A
    .BYTE $2A
    .BYTE $A0
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $55
    .BYTE $AA
    .BYTE $55
    .BYTE $AA
    .BYTE $55
    .BYTE $AA
    .BYTE $55
    .BYTE $AA
    .BYTE $55
    .BYTE $AA
    .BYTE 0
    .BYTE $82
    .BYTE $AA
    .BYTE 8
    .BYTE 0
    .BYTE 0
    .BYTE $20
    .BYTE $A
    .BYTE $A0
    .BYTE $A0
    .BYTE $A
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $AA
    .BYTE $AA
    .BYTE 3
    .BYTE $AA
    .BYTE 3
    .BYTE 5
    .BYTE $AA
    .BYTE 5
    .BYTE $AA
    .BYTE $14
    .BYTE $AA
    .BYTE $14
    .BYTE $AA
    .BYTE $50
    .BYTE $AA
    .BYTE $50
    .BYTE $AA
    .BYTE $C0
    .BYTE $AA
    .BYTE $C0
    .BYTE $AA
; Column collision data	- two bits per 16x16 tile
; Not sure on the specifics, but
; 00 - clear
; 01 - ?
; 10 - solid with boots	item (?)
; 11 - solid
ColumnCollisionTable:
	.WORD		  0,		    0,		      0,		0; Column collision	data
    .WORD		  0,		    0,		      0,		0; 4
    .WORD		  0,		    0,		      0,		0; 8
    .WORD %1111111100001111,1111111100001111b,1111111100001111b,1111111111111111b; $C
    .WORD %1111111111000000,1111111100110000b,1111111100001100b,1111111100000000b; $10
    .WORD %1111111100000000,1111111100000000b,1111111100000000b,1111111100000000b; $14
    .WORD %1111111100000000,1111111100000000b,1111111100000000b,1111111100000011b; $18
    .WORD %1111111111111111,1111111111111111b,1111111111111111b,1111111111111111b; $1C
    .WORD	    %110000,  %11000000110000,	%11111100110000,1111111100111111b; $20
    .WORD %1111000011111111,  %11000011110000,1111000000111111b,  %11000000000000; $24
    .WORD	    %110000,		    0,1100000000000000b,1100000000000000b; $28
    .WORD %1100000011000000,1100000011000000b,1100000000000000b,1100000000000000b; $2C
    .WORD %1100000000000000,1100000000000000b,1100000000000000b,	%11000000; $30
    .WORD %1100000011000000,		    0,		      0,1100000011111111b; $34
    .WORD %1100000011111111,		    0,		      0,  %11111100000000; $38
    .WORD %1111111100000000,1111111100000011b,1111111100001111b,1111110000111111b; $3C
    .WORD %1111111111111111,	    %11110000,	      %11111100,	%11111111; $40
    .WORD %1100000000111111,		    0,1111110000000000b,1111110000000000b; $44
    .WORD %1111110000000000,	      %111100,		  %1111,1111000000000000b; $48
    .WORD		%10,		  %10,	%10000000000000,  %10000000000000; $4C
    .WORD %1100000000000000,1100000000000000b,1100000000000000b,1100000011000000b; $50
    .WORD %1100000011000000,1100000011000000b,1100000000000000b,1100000000000000b; $54
    .WORD %1100000011000000,1100000000000000b,	      %11000000,	%11000000; $58
    .WORD %1111111100000011,1111111100000000b,1111111100000011b,    %111100000000; $5C
    .WORD %1111111111111111,		    0,		      0,    %110000001100; $60
    .WORD %1100000011000000,	%110000001100,		      0,		0; $64
    .WORD		  0,		    0,		%111111,	  %111100; $68
    .WORD %1111110000000011,1111110000000011b,		      0,	  %110000; $6C
    .WORD		  0,1111111100000000b,1111111100000011b,1111111100001111b; $70
    .WORD %1111111100111111,	      %110000,		%110000,	  %111100; $74
    .WORD %1111111100111111,	      %111100,		%111100,		0; $78
    .WORD	    %111100,1111110000000011b,1111110000000011b,1111110000000011b; $7C
    .WORD %1111111100000000,1111111100000000b,1111111100000000b,1111111100000000b; $80
    .WORD %1111111100000000,1111111111111111b,1111111111111111b,1111111111111111b; $84
    .WORD %1111111111111111,1111111111111111b,1111111111111111b,1111111111111111b; $88
    .WORD %1111111100000011,1111111100000011b,1111111111111111b,		0; $8C
    .WORD   %11111100000000,1111111100000011b,1111111100000011b,1111111100000011b; $90
    .WORD %1111111100000000,  %11111100000000,		      0,		0; $94
    .WORD	  %11110000,	    %11111100,	      %11111111,1100000011111111b; $98
    .WORD %1111110011111111,  %11111100000000,1111111100000000b,1111111100000011b; $9C
    .WORD %1111111100111111,1111111100000011b,1111111111000000b,  %11111111110000; $A0
    .WORD     %111111111100,	%111111111111,1111000011111111b,	%11111111; $A4
    .WORD	%1111111111,		    0,		  %1111,1111000000001111b; $A8
    .WORD %1111000000001111,1111000000001111b,1111000000001111b,1111000000000000b; $AC
    .WORD %1111111100000000,1111111100000000b,1111111100000000b,1111111100000000b; $B0
    .WORD %1111111100000000,1111111100000000b,1111111100000000b,1111111100000000b; $B4
    .WORD %1111111100000000,1111111100000000b,1111111100000000b,1111111100000000b; $B8
    .WORD %1111111100000000,1111111100000000b,1111111100000000b,1111111100000000b; $BC
    .WORD		  0,		    0,1111111100000011b,1111111100000011b; $C0
    .WORD		  0,1111110000001111b,1111110000001111b,		0; $C4
    .WORD %1111110011111111,1111110011111111b,1111110000001111b,		0; $C8
    .WORD		  0,		    0,		      0,		0; $CC
    .WORD %1111111111111111,1111111111111111b,1111111111111111b,1111111111111111b; $D0
    .WORD %1111000000000000,1111000000000000b,1111000000000000b,	    %1111; $D4
    .WORD	      %1111,		%1111,	      %11110000,	%11110000; $D8
    .WORD	  %11110000,1111111100000000b,1111111100000000b,1111111100000000b; $DC
    .WORD   %11000000110000,  %11000000000000,		%110000,  %11000011110000; $E0
    .WORD	  %11110000,  %11111100110000,	%11111100000000,1111000000111111b; $E4
    .WORD		  0,		    0,1111111100000000b,1111111111000000b; $E8
    .WORD %1111111100000000,1111111100000000b,	      %11111111,1111111111000011b; $EC
    .WORD	      %1100,  %11000000000000,1111000000001111b,    %111111110000; $F0
    .WORD		  0,1111111100000000b,	      %11111111,	%11111111; $F4
    .WORD %1111111100000000,1111111100000000b,1111111100000000b,1111111100000000b; $F8
    .WORD %1111111100000000,1111111100000000b,1111111100000000b,1111111100000000b; $FC
; Block	definitions
; First	8 bytes	are the	top row
; Last 8 bytes are the bottom row
; Several blocks are not used:
; $09-$0F
; $42
; $74-$77
BlockTable:
    Block   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
    Block   0,	$C5, $C0, $C6, $C0, $C6, $C2, $C8, $C3,	$C9, $C4, $CA, $C4, $CA,   0, $C5 ;; 1
    Block   0,	$BF,   1, $BF,	 2, $BF,   3, $BF,   0,	$BF,   4, $BF,	 5, $BF,   6, $BF ;; 2
    Block   7,	$BF,   0, $BF,	 8, $BF,   9, $BF,  $A,	$BF,  $B, $BF,	 0, $BF,   0, $BF ;; 3
    Block $39,	$BF, $3A, $BF, $8F, $BF, $96, $BF, $A9,	$BF, $CB, $BF, $CC, $BF, $CD, $BF ;; 4
    Block   0,	$BF,   0, $BF, $CE, $BF, $CF, $BF, $E8,	$BF, $E9, $BF,	 0, $BF,   0, $BF ;; 5
    Block   0,	  0,   0, $49,	 0, $49,   0,	0,   0,	  0,   0, $49,	 0, $49,   0,	0 ;; 6
    Block   0,	  0,   0, $4A,	 0, $4A,   0,	0,   0,	  0,   0, $4A,	 0, $4A,   0,	0 ;; 7
    Block   0,	  0,   0, $4B,	 0, $4B,   0,	0,   0,	  0,   0, $4B,	 0, $4B,   0,	0 ;; 8
    Block   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0 ;; 9
    Block   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0 ;; $A
    Block   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0 ;; $B
    Block   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0 ;; $C
    Block   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0 ;; $D
    Block   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0 ;; $E
    Block   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0 ;; $F
    Block $1E,	$1C,  $F,  $F,	$F,  $F,  $F,  $F,  $F,	 $F,  $F,  $F,	$F,  $F, $1F, $1D ;; $10
    Block   0,	$13,   0, $13,	 0, $13,   0, $13,   0,	$13,   0, $13,	 0, $13,   0, $13 ;; $11
    Block   0,	$19,   0, $1A,	 0, $13,   0, $13,   0,	$13,   0, $13,	 0, $13,   0, $13 ;; $12
    Block   0,	$13,   0, $13,	 0, $18,   0,	0,   0,	  0,   0, $17,	 0, $13,   0, $13 ;; $13
    Block   0,	$12,   0, $12,	 0, $12,   0, $12,   0,	$12,   0, $12,	 0, $12,   0, $12 ;; $14
    Block   0,	$13,   0, $13,	 0, $11,   0, $11,   0,	$11,   0, $11,	 0, $11,   0, $11 ;; $15
    Block   0,	$13,   0, $13,	 0, $10,   0, $10,   0,	$10,   0, $10,	 0, $10,   0, $10 ;; $16
    Block   0,	$13,   0, $1B,	 0, $1B,   0, $1B,   0,	$1B,   0, $1B,	 0, $1B,   0, $13 ;; $17
    Block   0,	$13,   0, $13,	 0, $14,   0, $15,   0,	$15,   0, $15,	 0, $16,   0, $13 ;; $18
    Block $EE,	$F5, $EE, $F5, $EE, $F5, $EE, $FA, $EE,	$FB, $EE, $F5, $EE, $F5, $EE, $F5 ;; $19
    Block $EE,	$F5, $EE, $F5, $EE, $F5, $EE, $FC, $EE,	$FD, $EE, $F5, $EE, $F5, $EE, $F5 ;; $1A
    Block $EE,	$F5, $EE, $F5, $EE, $F5, $EE, $F8, $EE,	$F9, $EE, $F5, $EE, $F5, $EE, $F5 ;; $1B
    Block $EE,	$F5, $EE, $F5, $EE, $F5, $F6, $FE, $F7,	$FF, $EE, $F5, $EE, $F5, $EE, $F5 ;; $1C
    Block $60,	$60, $60, $60, $60, $60, $60, $60, $60,	$60, $60, $60, $60, $60, $60, $60 ;; $1D
    Block $F0,	$F0, $F0, $F0, $F1, $F1, $F1, $F1, $F0,	$F0, $F0, $F0, $F1, $F1, $F1, $F1 ;; $1E
    Block $F4,	$F4, $F4, $F4, $F2, $F2, $F4, $F4, $F3,	$F3, $F4, $F4, $F2, $F2, $F4, $F4 ;; $1F
    Block $21,	$27, $21, $27, $21, $27, $21, $21, $20,	$21, $20, $21, $20, $21, $23, $25 ;; $20
    Block $20,	$21, $20, $21, $20, $21, $21, $21, $21,	$27, $21, $27, $21, $27, $21, $26 ;; $21
    Block $21,	$21, $21, $21, $21, $21, $21, $21, $21,	$21, $21, $21, $21, $21, $21, $21 ;; $22
    Block $21,	$21, $21, $21, $21, $21, $21, $21, $21,	$21, $21, $21, $21, $21, $22, $25 ;; $23
    Block $21,	$21, $21, $21, $21, $21, $21, $21, $21,	$27, $21, $27, $21, $27, $22, $24 ;; $24
    Block $21,	$21, $20, $27, $20, $27, $20, $27, $23,	$25, $20, $21, $20, $21, $20, $26 ;; $25
    Block $21,	$21, $21, $21, $21, $21, $21, $21, $28,	$28, $21, $21, $21, $21, $21, $21 ;; $26
    Block $EE,	$F5, $EE, $F5, $EE, $F5, $EE, $F5, $EE,	$F5, $EE, $F5, $EE, $F5, $EE, $F5 ;; $27
    Block $9A,	$9D, $99, $9F, $99, $9F, $9A, $9E, $9B,	$9E, $98, $9D, $97, $9E, $9C, $9D ;; $28
    Block $60,	$EF, $60, $EF, $60, $EF, $60, $EF, $60,	$EF, $60, $EF, $60, $EF, $60, $EF ;; $29
    Block   0,	$2A,   0, $2A,	 0, $2A,   0, $2A,   0,	$2A,   0, $2A,	 0, $2B,   0, $2A ;; $2A
    Block $31,	$2C, $32, $2D, $31, $2C, $32, $2D,   0,	$2C, $35, $2D,	 0, $2C, $35, $2D ;; $2B
    Block $31,	$2C, $32, $2D, $31, $2C, $32, $2D, $31,	$2A, $31, $2B, $31, $2A, $32, $2D ;; $2C
    Block   0,	$2A,   0, $2B,	 0, $2A,   0, $2B,   0,	$2A,   0, $2A,	 0, $2A,   0, $2A ;; $2D
    Block   0,	$2A,   0, $2A,	 0, $2A,   0, $2A,   0,	$2A,   0, $2A,	 0, $2A,   0, $2A ;; $2E
    Block   0,	$2A,   0, $2F,	 0, $30,   0, $2A,   0,	$2A, $36, $2E,	 0, $2A,   0, $2A ;; $2F
    Block $33,	$2C, $34, $2D, $33, $2C, $32, $2E, $31,	$2A, $32, $2E, $33, $2C, $34, $2D ;; $30
    Block $33,	$2C, $34, $2D, $33, $2C, $35, $2D, $33,	$2C, $35, $2D, $33, $2C, $34, $2D ;; $31
    Block   0,	  0,   0,   0,	 0, $49,   0,	0,   0,	$4B,   0,   0,	 0, $4A,   0,	0 ;; $32
    Block   0,	  0,   0,   0,	 0, $49,   0,	0,   0,	  0,   0,   0, $4C, $4A, $4D,	0 ;; $33
    Block   0,	  0,   0, $49,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0, $49 ;; $34
    Block   0,	  0,   0,   0,	 0,   0,   0, $4B, $4E,	  0, $4F,   0,	 0,   0,   0, $4A ;; $35
    Block   0,	$5D,   0, $5D,	 0, $5D,   0, $5D,   0,	$5D,   0, $5D,	 0, $5D,   0, $5D ;; $36
    Block   0,	$60,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0, $60 ;; $37
    Block   0,	$B0,   0, $B0,	 0, $C5,   0, $5F,   0,	$C5,   0, $B0,	 0, $B0,   0, $B0 ;; $38
    Block   0,	  0,   0,   0,	 0, $AA,   0, $AD, $AA,	$AE, $AD, $AB, $AC, $AC, $AD, $AB ;; $39
    Block $AE,	$AC, $AB, $AD, $AE, $AE, $AD, $AB, $AC,	$AE, $AD, $AB, $AC, $AE, $AD, $AB ;; $3A
    Block $AE,	$AC, $AD, $AB, $AC, $AC, $AD, $AD, $AF,	$AF,   0,   0,	 0,   0,   0,	0 ;; $3B
    Block   0,	$90,   0, $90, $4C, $90, $4D, $90,   0,	$90,   0, $90,	 0, $90,   0, $90 ;; $3C
    Block   0,	$91, $4C, $92, $4D, $93,   0, $95,   0,	$90, $4E, $90, $4F, $95,   0, $90 ;; $3D
    Block $4E,	$90, $4F, $95,	 0, $90, $4C, $94, $4D,	$90,   0, $90,	 0, $95,   0, $95 ;; $3E
    Block   0,	$95,   0, $95,	 0, $95,   0, $95,   0,	$95,   0, $95,	 0, $95,   0, $95 ;; $3F
    Block   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0, $29 ;; $40
    Block   0,	$B1,   0, $B2, $66, $B3, $67, $B4, $68,	$B5, $69, $B6,	 0, $B7,   0, $B8 ;; $41
    Block $4E,	$95, $4F, $90,	 0, $95, $4C, $95, $4D,	$90,   0, $90,	 0, $90,   0, $95 ;; $42
    Block   0,	$4B,   0,   0, $4C, $4B, $4D,	0,   0,	$4B,   0,   0,	 0, $4B,   0,	0 ;; $43
    Block   0,	  0,   0,   0,	 0, $4A,   0, $4A,   0,	  0,   0, $4A,	 0, $4A,   0,	0 ;; $44
    Block   0,	$49,   0, $49,	 0,   0,   0, $49, $4E,	$49, $4F,   0,	 0,   0,   0, $49 ;; $45
    Block $44,	$3F, $43, $3E, $44, $3F, $41, $3B, $43,	$3E, $42, $3C, $44, $3F, $40, $3F ;; $46
    Block $41,	$3D, $42, $3C, $45, $3B, $44, $3B, $43,	$3C, $41, $3D, $43, $3C, $41, $3E ;; $47
    Block $42,	$3B, $43, $3C, $41, $3E, $45, $3F, $41,	$40, $45, $3D, $42, $3E, $44, $3C ;; $48
    Block $43,	$45, $40, $3B, $44, $3D, $45, $3F, $43,	$40, $44, $3E, $42, $3C, $41, $3B ;; $49
    Block $42,	$3F, $45, $45, $42, $3D, $41, $3C, $42,	$45, $45, $45, $43, $3B, $44, $3C ;; $4A
    Block $45,	$45, $45, $45, $44, $3C, $41, $3E, $43,	$3D, $41, $40, $45, $3B, $45, $45 ;; $4B
    Block $42,	$41, $45, $42, $42, $45, $43, $3C, $43,	$45, $41, $40, $43, $3F, $45, $3E ;; $4C
    Block $43,	$40, $44, $45, $43, $45, $40, $3C, $44,	$3C, $43, $45, $44, $45, $43, $40 ;; $4D
    Block $44,	$3C, $45, $41, $41, $3C, $3B, $45, $45,	$42, $45, $41, $41, $3C, $40, $45 ;; $4E
    Block $45,	$45, $44, $3F, $42, $45, $45, $40, $43,	$45, $45, $3D, $40, $45, $42, $3C ;; $4F
    Block   0,	$51,   0, $50,	 0, $56,   0, $52,   0,	$51,   0, $50,	 0, $56,   0, $52 ;; $50
    Block $51,	$51, $50, $50, $56, $59, $52, $52, $51,	$51, $50, $50, $56, $59, $52, $52 ;; $51
    Block $51,	$54, $50, $53, $57, $58, $52, $55, $51,	$54, $50, $53, $57, $5A, $51, $5B ;; $52
    Block $51,	$54, $50, $53,	 0, $58,   0, $55,   0,	$54, $50, $53, $57, $58, $52, $55 ;; $53
    Block   0,	$51,   0, $50,	 0, $56,   0, $55,   0,	$54, $50, $5B, $57, $5A, $52, $5B ;; $54
    Block $D0,	$D0, $D1, $D1, $D2, $D2, $D1, $D1, $D2,	$D2, $D1, $D1, $D2, $D2, $D3, $D3 ;; $55
    Block   0,	$46,   0, $47,	 0, $47,   0, $47,   0,	$47,   0, $47,	 0, $47,   0, $48 ;; $56
    Block   0,	  0,   0, $46,	 0, $47,   0, $48,   0,	  0,   0, $46,	 0, $47,   0, $48 ;; $57
    Block   0,	  0,   0,   0,	 0, $46,   0, $47,   0,	$47,   0, $47,	 0, $47,   0, $48 ;; $58
    Block   0,	$7D,   0, $6D,	 0, $7F,   0, $6C,   0,	$6D,   0, $7F,	 0, $6C,   0, $7E ;; $59
    Block $A6,	$A0, $A7, $A1, $A8, $A2, $A4, $A3, $A3,	$A4, $A2, $A4, $A2, $A5, $A2, $A5 ;; $5A
    Block $A2,	$A5, $A2, $A5, $A2, $A4, $A3, $A4, $A4,	$A3, $A8, $A2, $A7, $A1, $A6, $A0 ;; $5B
    Block $A3,	$A4, $A4, $A3, $A8, $A2, $A7, $A1, $A6,	$A1, $A7, $A2, $A4, $A3, $A3, $A4 ;; $5C
    Block $A3,	$A3, $A4, $A2, $A7, $A1, $A6, $A0, $A7,	$A1, $A4, $A2, $A3, $A3, $A2, $A3 ;; $5D
    Block $A2,	$A5, $A3, $A5, $A4, $A4, $A3, $A3, $A2,	$A2, $A2, $A3, $A2, $A4, $A3, $A5 ;; $5E
    Block $A8,	$A3, $A8, $A3, $A4, $A2, $A3, $A1, $A2,	$A1, $A4, $A2, $A4, $A1, $A8, $A2 ;; $5F
    Block $60,	$60, $60, $60, $60, $60, $61, $61, $62,	$62, $60, $60, $60, $60, $60, $60 ;; $60
    Block   0,	$7C,   0, $7C,	 0, $7C,   0, $7C,   0,	$7C,   0, $7C,	 0, $7C,   0, $7C ;; $61
    Block   0,	  0, $4C,   0, $4D,   0,   0,	0,   0,	  0, $4E,   0, $4F,   0,   0,	0 ;; $62
    Block $60,	$60, $60, $60, $63, $63, $61, $61, $62,	$62, $63, $63, $60, $60, $60, $60 ;; $63
    Block $60,	$60, $60, $60, $63, $63, $61, $61, $62,	$62, $60, $60, $60, $60, $60, $60 ;; $64
    Block   0,	$13,   0,  $C,	 0,  $D,   0,  $E,   0,	$13,   0, $13,	 0,  $C,   0,  $E ;; $65
    Block   0,	$13,   0, $13,	 0, $13,   0, $1C,   0,	 $F,   0,  $F,	 0, $1D,   0, $13 ;; $66
    Block $38,	$5E, $38, $5C, $38, $5C, $38, $5E, $38,	$5C, $37, $5C, $38, $5C, $37, $5E ;; $67
    Block $38,	$5E, $38, $5C, $37, $5E, $38, $5C, $37,	$5E, $37, $5E, $37, $5C, $38, $5E ;; $68
    Block   0,	  0,   0, $4C,	 0, $4D,   0,	0,   0,	  0,   0, $4E,	 0, $4F,   0,	0 ;; $69
    Block   0,	  0,   0, $D7,	 0, $D8,   0, $D8,   0,	$D8,   0, $D8,	 0, $D8,   0, $D8 ;; $6A
    Block   0,	$D8, $D4, $D8, $D5, $D8, $D5, $D8, $D6,	$D8,   0, $D9,	 0,   0,   0,	0 ;; $6B
    Block   0,	  0,   0, $DA,	 0, $DB,   0, $DB,   0,	$DB,   0, $DB,	 0, $DC,   0,	0 ;; $6C
    Block $D4,	  0, $D5,   0, $D5,   0, $D6,	0,   0,	$DA,   0, $DB,	 0, $DB,   0, $DC ;; $6D
    Block   0,	  0, $D4,   0, $D5,   0, $D5,	0, $D5,	  0, $D5,   0, $D6,   0,   0,	0 ;; $6E
    Block   0,	$D7,   0, $D8, $D7, $D8, $D8, $D8, $D8,	$D8, $D9, $D8,	 0, $D8,   0, $D9 ;; $6F
    Block   0,	$72,   0, $72,	 0, $72,   0, $72,   0,	$72,   0, $72,	 0, $72,   0, $70 ;; $70
    Block   0,	$70,   0, $71,	 0, $71,   0, $71,   0,	$71,   0, $71,	 0, $71,   0, $70 ;; $71
    Block   0,	$70,   0, $70,	 0, $73,   0, $73,   0,	$70,   0, $70,	 0, $72,   0, $72 ;; $72
    Block   0,	$70,   0, $71,	 0, $70,   0, $73,   0,	$70,   0, $70,	 0, $72,   0, $70 ;; $73
    Block $D4,	  0, $D5, $D7, $D5, $D8, $D5, $D8, $D5,	$D8, $D5, $D8, $D5, $D9, $D6,	0 ;; $74
    Block   0,	$75,   0, $75,	 0, $75,   0, $75,   0,	$78,   0, $75,	 0, $75, $7B, $7A ;; $75
    Block   0,	$70,   0, $70,	 0, $76,   0, $75,   0,	$78,   0, $75,	 0, $77,   0, $79 ;; $76
    Block $88,	$90, $8B, $90, $8C,   5, $8C, $91, $8C,	$93, $8D, $92, $8E, $94, $8F, $95 ;; $77
    Block $99,	$9F, $98, $9E, $9A, $9D, $9B, $9D, $9C,	$9D, $9A, $9D, $9B, $9D, $9A, $97 ;; $78
    Block $99,	$9D, $98, $9E, $98, $9F, $97, $9F, $98,	$9F, $98, $9F, $98, $9E, $99, $9D ;; $79
    Block   0,	$81,   0, $81,	 0, $82,   0, $81,   0,	$81,   0, $83,	 0, $82,   0, $82 ;; $7A
    Block   0,	$81,   0, $82,	 0, $83,   0, $83,   0,	$84,   0, $80,	 0, $81,   0, $82 ;; $7B
    Block   0,	$82,   0, $82,	 0, $83,   0, $83,   0,	$84,   0,   0,	 0,   0,   0, $80 ;; $7C
    Block   0,	$80,   0, $85,	 0, $86,   0, $87,   0,	$88,   0, $8E,	 0, $8D,   0, $8C ;; $7D
    Block   0,	  0,   0, $85, $80, $86, $84, $88,   0,	$8E,   0, $8D,	 0, $8C,   0,	0 ;; $7E
    Block   0,	$85,   0, $86, $80, $87, $81, $88, $82,	$89, $83, $8A, $84, $8B,   0, $8C ;; $7F
    Block $E7,	$E7, $E7, $E7, $E7, $E7, $E7, $E7, $E5,	$E3, $E5, $E3, $E5, $E3, $E5, $E3 ;; $80
    Block $E0,	$E5, $E0, $E5, $E0, $E5, $E0, $E5, $E3,	$E0, $E3, $E0, $E3, $E0, $E3, $E0 ;; $81
    Block $E0,	$E7, $E2, $E7, $E2, $E7, $E0, $E7, $E7,	$E0, $E7, $E1, $E7, $E1, $E7, $E0 ;; $82
    Block $E3,	$E0, $E3, $E0, $E4, $E2, $E4, $E2, $E0,	$E0, $E0, $E0, $E0, $E0, $E0, $E0 ;; $83
    Block $E0,	$E5, $E0, $E6, $E0, $E6, $E0, $E5, $E5,	$E3, $E5, $E3, $E5, $E3, $E5, $E3 ;; $84
    Block $E0,	$E0, $E0, $E2, $E0, $E2, $E0, $E0, $E0,	$E7, $E0, $E7, $E0, $E7, $E0, $E7 ;; $85
    Block $E0,	$E5, $E0, $E6, $E0, $E6, $E0, $E5, $E4,	$E0, $E4, $E0, $E3, $E0, $E3, $E0 ;; $86
    Block   0,	$BF,   0,   0,	 0,   0, $64, $64, $60,	$60, $65, $65,	 0,   0,   0, $BF ;; $87
    Block $9B,	$9F, $9B, $9F, $9B, $9F, $9B, $9F, $F4,	$9F, $9B, $9F, $9B, $9F, $9B, $9F ;; $88
    Block $9B,	$9F, $9B, $9F, $9B, $9E, $9B, $9F, $F4,	$9F, $9B, $9F, $9B, $9F, $9B, $9F ;; $89
    Block   0,	$B0,   0, $B0,	 0, $B0,   0, $B0,   0,	$B0,   0, $B0,	 0, $B0,   0, $B0 ;; $8A
    Block   0,	$B0,   0, $B1,	 0, $B9,   0, $BA,   0,	$B8,   0, $B0,	 0, $B0,   0, $B0 ;; $8B
    Block   0,	$B1,   0, $B2,	 0, $BB,   0, $BC,   0,	$BD,   0, $BE,	 0, $BA,   0, $B8 ;; $8C
    Block   0,	$B1,   0, $B2,	 0, $B3,   0, $B4,   0,	$B5,   0, $B6,	 0, $B7,   0, $B8 ;; $8D
    Block   0,	$B0,   0, $DD,	 0, $DF,   0, $DD,   0,	$DE,   0, $DD,	 0, $DD,   0, $B0 ;; $8E
    Block   0,	$B0,   0, $DE,	 0, $DE,   0, $DD,   0,	$DE,   0, $DF,	 0, $DF,   0, $B0 ;; $8F
    Block   0,	$76,   0, $79, $7B, $75,   0, $6F, $7B,	$77,   0, $78,	 0, $6A,   0, $6B ;; $90
    Block   0,	$7A,   0, $76,	 0, $76,   0, $79,   0,	$76,   0, $78,	 0, $7A,   0, $76 ;; $91
    Block   0,	$70,   0, $76,	 0, $79,   0, $7A,   0,	$76,   0, $78,	 0, $7A,   0, $76 ;; $92
    Block   0,	$6E,   0, $76,	 0, $79,   0, $6A,   0,	$78,   0, $6F,	 0, $79,   0, $76 ;; $93
    Block   0,	$B0,   0, $B0,	 0, $B0,   0, $B0,   0,	$B0,   0, $EA,	 0, $EB,   0, $EC ;; $94
    Block   0,	$EA,   0, $EB,	 0, $ED,   0, $EB,   0,	$EC,   0, $B0,	 0, $B0,   0, $B0 ;; $95
    .BYTE 0
    .BYTE $EA
    .BYTE 0
    .BYTE $EB
    .BYTE 0
    .BYTE $ED
    .BYTE 0
    .BYTE $EB
    .BYTE 0
    .BYTE $ED
    .BYTE 0
    .BYTE $EB
    .BYTE 0
    .BYTE $EC
    .BYTE 0
    .BYTE $B0

loc_F3C0:
	.BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $FC
    .BYTE $FC
    .BYTE $FC
    .BYTE $FC
    .BYTE $FD
    .BYTE $FD
    .BYTE $FD
    .BYTE $FD
    .BYTE $FE
    .BYTE $FE
    .BYTE $FE
    .BYTE $FE
    .BYTE $28
    .BYTE $29
    .BYTE $38
    .BYTE $39
    .BYTE $29
    .BYTE $28
    .BYTE $39
    .BYTE $38
    .BYTE $29
    .BYTE $FF
    .BYTE $39
    .BYTE $FF
    .BYTE $FF
    .BYTE $28
    .BYTE $FF
    .BYTE $38 ;	8
    .BYTE $64
    .BYTE $65
    .BYTE $74
    .BYTE $75
    .BYTE $B
    .BYTE $FF
    .BYTE $15
    .BYTE $FF
    .BYTE $E0
    .BYTE $E1
    .BYTE $F0
    .BYTE $F1
    .BYTE $A
    .BYTE $FF
    .BYTE $C
    .BYTE $FF
    .BYTE $52
    .BYTE $53
    .BYTE $54
    .BYTE $55
    .BYTE $FF
    .BYTE $FF
    .BYTE $5E
    .BYTE $5F
    .BYTE 0
    .BYTE 1
    .BYTE $10
    .BYTE $11
    .BYTE $C9
    .BYTE $C9
    .BYTE $C9
    .BYTE $C9
    .BYTE $14
    .BYTE $FF
    .BYTE $FF
    .BYTE $11
    .BYTE $FF
    .BYTE $18
    .BYTE $FF
    .BYTE $15
    .BYTE $FF
    .BYTE $E
    .BYTE $FF
    .BYTE $25
    .BYTE $14
    .BYTE $E
    .BYTE $FF
    .BYTE $FF
    .BYTE $48
    .BYTE $49
    .BYTE $58
    .BYTE $59
    .BYTE $49
    .BYTE $48
    .BYTE $59
    .BYTE $58
    .BYTE $49
    .BYTE $FF
    .BYTE $59
    .BYTE $FF
    .BYTE $FF
    .BYTE $48
    .BYTE $FF
    .BYTE $58
    .BYTE $22
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $A4
    .BYTE $A3
    .BYTE $B4
    .BYTE $B3
    .BYTE $20
    .BYTE $18
    .BYTE $FF
    .BYTE $FF
    .BYTE $AA
    .BYTE $AB
    .BYTE $BA
    .BYTE $BB
    .BYTE $56
    .BYTE $56
    .BYTE $57
    .BYTE $57
    .BYTE $6E
    .BYTE $6F
    .BYTE $7E
    .BYTE $7F
    .BYTE 2
    .BYTE 3
    .BYTE 2
    .BYTE 3
    .BYTE $D9
    .BYTE $D8
    .BYTE $D9
    .BYTE $D8
    .BYTE $2E
    .BYTE $2F
    .BYTE $3E
    .BYTE $3F
    .BYTE $1B
    .BYTE $D
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $7B
    .BYTE $6C
    .BYTE $6D
    .BYTE $7C
    .BYTE $7D
    .BYTE $20
    .BYTE $21
    .BYTE $30
    .BYTE $31
    .BYTE $FF
    .BYTE $FF
    .BYTE $22
    .BYTE $23
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $24
    .BYTE $FF
    .BYTE $FF
    .BYTE $25
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $26
    .BYTE $17
    .BYTE $C4
    .BYTE $C3
    .BYTE $B4
    .BYTE $B3
    .BYTE $FF
    .BYTE $FF
    .BYTE $A
    .BYTE $10
    .BYTE $CA
    .BYTE $CB
    .BYTE $DA
    .BYTE $DB
    .BYTE $14
    .BYTE $14
    .BYTE $57
    .BYTE $57
    .BYTE $8E
    .BYTE $8F
    .BYTE $9E
    .BYTE $9F
    .BYTE 2
    .BYTE $13
    .BYTE 4
    .BYTE 5
    .BYTE $D7
    .BYTE $D6
    .BYTE $D7
    .BYTE $D6
    .BYTE $4E
    .BYTE $4F
    .BYTE $5E
    .BYTE $5F
    .BYTE $4E
    .BYTE $4F
    .BYTE $5E
    .BYTE $89
    .BYTE $8A
    .BYTE $8B
    .BYTE $9A
    .BYTE $9B
    .BYTE $8C
    .BYTE $8D
    .BYTE $9C
    .BYTE $9D
    .BYTE $30
    .BYTE $31
    .BYTE $30
    .BYTE $31
    .BYTE $32
    .BYTE $33
    .BYTE $42
    .BYTE $43
    .BYTE $FF
    .BYTE $34
    .BYTE $26
    .BYTE $44
    .BYTE $35
    .BYTE $FF
    .BYTE $45
    .BYTE $27
    .BYTE $FF
    .BYTE $FF
    .BYTE $18
    .BYTE $22
    .BYTE $C4
    .BYTE $C3
    .BYTE $D4
    .BYTE $D3
    .BYTE $FF
    .BYTE $FF
    .BYTE $A
    .BYTE $26
    .BYTE $EA
    .BYTE $EB
    .BYTE $DA
    .BYTE $DB
    .BYTE $E9
    .BYTE $F9
    .BYTE $F9
    .BYTE $E9
    .BYTE $9E
    .BYTE $9F
    .BYTE $9E
    .BYTE $9F
    .BYTE $60
    .BYTE $61
    .BYTE $70
    .BYTE $71
    .BYTE $62
    .BYTE $63
    .BYTE $72
    .BYTE $73
    .BYTE $6E
    .BYTE $6F
    .BYTE $7E
    .BYTE $7F
    .BYTE $99
    .BYTE $8F
    .BYTE $9E
    .BYTE $9F
    .BYTE $1D
    .BYTE $18
    .BYTE $FF
    .BYTE $FF
    .BYTE $16
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $30
    .BYTE $31
    .BYTE $40
    .BYTE $41
    .BYTE $50
    .BYTE $51
    .BYTE $30
    .BYTE $31
    .BYTE $36
    .BYTE $37
    .BYTE $46
    .BYTE $47
    .BYTE $11
    .BYTE $12
    .BYTE $FF
    .BYTE $FF
    .BYTE $A6
    .BYTE $A7
    .BYTE $B6
    .BYTE $B7
    .BYTE $D
    .BYTE $E
    .BYTE $FF
    .BYTE $FF
    .BYTE $A7
    .BYTE $A8
    .BYTE $B7
    .BYTE $B8
    .BYTE $BD
    .BYTE $BC
    .BYTE $4C
    .BYTE $4D
    .BYTE $4C
    .BYTE $4D
    .BYTE $4C
    .BYTE $4D
    .BYTE $FF
    .BYTE $FF
    .BYTE $16
    .BYTE $F
    .BYTE $80
    .BYTE $81
    .BYTE $90
    .BYTE $91
    .BYTE $82
    .BYTE $83
    .BYTE $92
    .BYTE $93
    .BYTE $8E
    .BYTE $8F
    .BYTE $9E
    .BYTE $9F
    .BYTE $69
    .BYTE $79
    .BYTE $9E
    .BYTE $9F
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $7C
    .BYTE $FF
    .BYTE $8C
    .BYTE $FF
    .BYTE $9C
    .BYTE $8B
    .BYTE $8C
    .BYTE $9B
    .BYTE $9C
    .BYTE $8B
    .BYTE $8B
    .BYTE $9B
    .BYTE $9B
    .BYTE $84
    .BYTE $85
    .BYTE $94
    .BYTE $95
    .BYTE $A
    .BYTE $1C
    .BYTE $FF
    .BYTE $FF
    .BYTE $1C
    .BYTE $11
    .BYTE $FF
    .BYTE $FF
    .BYTE $12
    .BYTE $25
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $22
    .BYTE $20
    .BYTE $AC
    .BYTE $EC
    .BYTE $CC
    .BYTE $BD
    .BYTE $EC
    .BYTE $EC
    .BYTE $EC
    .BYTE $EC
    .BYTE $EC
    .BYTE $ED
    .BYTE $BC
    .BYTE $CD
    .BYTE $BD
    .BYTE $EC
    .BYTE $4C
    .BYTE $BD
    .BYTE $EC
    .BYTE $BC
    .BYTE $BC
    .BYTE $4D
    .BYTE $7B
    .BYTE $7B
    .BYTE $AB
    .BYTE $AB
    .BYTE $AC
    .BYTE $AC
    .BYTE $AB
    .BYTE $AB
    .BYTE $AC
    .BYTE $AC
    .BYTE $FF
    .BYTE $AB
    .BYTE $AC
    .BYTE $AC
    .BYTE $AB
    .BYTE $FF
    .BYTE $E4
    .BYTE $E5
    .BYTE $F4
    .BYTE $E4
    .BYTE $FF
    .BYTE $FF
    .BYTE $E5
    .BYTE $E5
    .BYTE $97
    .BYTE $E1
    .BYTE $F0
    .BYTE $7A
    .BYTE $FF
    .BYTE $FF
    .BYTE $11
    .BYTE $12
    .BYTE $B6
    .BYTE $B7
    .BYTE $C6
    .BYTE $C7
    .BYTE $FF
    .BYTE $FF
    .BYTE $1B
    .BYTE $18
    .BYTE $B7
    .BYTE $B8
    .BYTE $C7
    .BYTE $C8
    .BYTE $CC
    .BYTE $4C
    .BYTE $CC
    .BYTE $4C
    .BYTE $30
    .BYTE $31
    .BYTE $40
    .BYTE $41
    .BYTE $4D
    .BYTE $CD
    .BYTE $4D
    .BYTE $CD
    .BYTE $4C
    .BYTE $4C
    .BYTE $4C
    .BYTE $4C
    .BYTE $4D
    .BYTE $4D
    .BYTE $4D
    .BYTE $4D
    .BYTE $36
    .BYTE $37
    .BYTE $46
    .BYTE $47
    .BYTE $38
    .BYTE $FF
    .BYTE $48
    .BYTE $49
    .BYTE $FF
    .BYTE $FF
    .BYTE $16
    .BYTE $1D
    .BYTE $FF
    .BYTE $76
    .BYTE $96
    .BYTE $86
    .BYTE $77
    .BYTE $FF
    .BYTE $87
    .BYTE $88
    .BYTE $F2
    .BYTE $F3
    .BYTE $E2
    .BYTE $E3
    .BYTE $E6
    .BYTE $E7
    .BYTE $FA
    .BYTE $E9
    .BYTE $E7
    .BYTE $E7
    .BYTE $F9
    .BYTE $E9
    .BYTE $E7
    .BYTE $E8
    .BYTE $E9
    .BYTE $FB
    .BYTE $A0
    .BYTE $A1
    .BYTE $B0
    .BYTE $B1
    .BYTE $67
    .BYTE $68
    .BYTE $77
    .BYTE $78
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $16
    .BYTE $50
    .BYTE $51
    .BYTE $60
    .BYTE $61
    .BYTE $FF
    .BYTE $FF
    .BYTE $AE
    .BYTE $AF
    .BYTE $79
    .BYTE $7A
    .BYTE $89
    .BYTE $8A
    .BYTE $FF
    .BYTE $FF
    .BYTE $2E
    .BYTE $2F
    .BYTE $56
    .BYTE $57
    .BYTE $66
    .BYTE $67
    .BYTE $58
    .BYTE $59
    .BYTE $68
    .BYTE $69
    .BYTE $FF
    .BYTE $76
    .BYTE $76
    .BYTE $FE
    .BYTE $FE
    .BYTE $A7
    .BYTE $FE
    .BYTE $FE
    .BYTE $97
    .BYTE $98
    .BYTE $A7
    .BYTE $A8
    .BYTE $88
    .BYTE $FF
    .BYTE $78
    .BYTE $88
    .BYTE $FA
    .BYTE $E9
    .BYTE $FA
    .BYTE $F9
    .BYTE $E9
    .BYTE $F9
    .BYTE $F9
    .BYTE $E9
    .BYTE $E9
    .BYTE $FB
    .BYTE $F9
    .BYTE $FB
    .BYTE $C0
    .BYTE $C1
    .BYTE $D0
    .BYTE $D1
    .BYTE $87
    .BYTE $88
    .BYTE $FF
    .BYTE $98
    .BYTE $FF
    .BYTE $FF
    .BYTE $22
    .BYTE $FF
    .BYTE $70
    .BYTE $71
    .BYTE $80
    .BYTE $81
    .BYTE $BE
    .BYTE $BF
    .BYTE $CE
    .BYTE $CF
    .BYTE $99
    .BYTE $9A
    .BYTE $A9
    .BYTE $AA
    .BYTE $3E
    .BYTE $3F
    .BYTE $4E
    .BYTE $4F
    .BYTE $16
    .BYTE $A
    .BYTE $FF
    .BYTE $FF
    .BYTE $1C
    .BYTE $A
    .BYTE $FF
    .BYTE $FF
    .BYTE $A6
    .BYTE $FE
    .BYTE $78
    .BYTE $A6
    .BYTE $78
    .BYTE $78
    .BYTE $78
    .BYTE $78
    .BYTE $FE
    .BYTE $97
    .BYTE $FE
    .BYTE $A7
    .BYTE $98
    .BYTE $78
    .BYTE $A8
    .BYTE $78
    .BYTE $FA
    .BYTE $F9
    .BYTE $F6
    .BYTE $E9
    .BYTE $E9
    .BYTE $F9
    .BYTE $F7
    .BYTE $F7
    .BYTE $E9
    .BYTE $FB
    .BYTE $F7
    .BYTE $F8
    .BYTE $FF
    .BYTE $FF
    .BYTE $A4
    .BYTE $A3
    .BYTE $17
    .BYTE $A
    .BYTE $FF
    .BYTE $FF
    .BYTE $18
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $90
    .BYTE $91
    .BYTE $A0
    .BYTE $A1
    .BYTE $DE
    .BYTE $DF
    .BYTE $EE
    .BYTE $EF
    .BYTE $7D
    .BYTE $8D
    .BYTE $FE
    .BYTE $FE
    .BYTE $AE
    .BYTE $AF
    .BYTE $6C
    .BYTE $39
    .BYTE $4C
    .BYTE $FD
    .BYTE $4C
    .BYTE $FD
    .BYTE $FD
    .BYTE $4D
    .BYTE $FD
    .BYTE $4D
    .BYTE $5C
    .BYTE $AD
    .BYTE $5C
    .BYTE $AD
    .BYTE $AD
    .BYTE $5D
    .BYTE $AD
    .BYTE $5D
    .BYTE $2C
    .BYTE $2D
    .BYTE $3C
    .BYTE $3D
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $26
    .BYTE $FF
    .BYTE $FF
    .BYTE $A
    .BYTE $24
    .BYTE $FF
    .BYTE $FF
    .BYTE $1D
    .BYTE $26
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE $B4
    .BYTE $B3
    .BYTE $C4
    .BYTE $C3
    .BYTE $5D
    .BYTE $FD
    .BYTE $5D
    .BYTE $FD
    .BYTE $FD
    .BYTE $5C
    .BYTE $FD
    .BYTE $5C
    .BYTE $2E
    .BYTE $2F
    .BYTE $3E
    .BYTE $3F
    .BYTE $EE
    .BYTE $EF
    .BYTE $EE
    .BYTE $EF
    .BYTE $35
    .BYTE $45
    .BYTE $55
    .BYTE $85
    .BYTE $39
    .BYTE $6C
    .BYTE $6C
    .BYTE $39
    .BYTE $FF
    .BYTE $32
    .BYTE $FF
    .BYTE $42
    .BYTE $33
    .BYTE $34
    .BYTE $43
    .BYTE $44
    .BYTE 6
    .BYTE 7
    .BYTE $16
    .BYTE $17
    .BYTE 8
    .BYTE 9
    .BYTE $18
    .BYTE $19
    .BYTE $35
    .BYTE $6D
    .BYTE $45
    .BYTE $39
    .BYTE $6D
    .BYTE $6D
    .BYTE $6C
    .BYTE $39
    .BYTE $6D
    .BYTE $65
    .BYTE $39
    .BYTE $75
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $17
    .BYTE $66
    .BYTE $FF
    .BYTE $76
    .BYTE $FF
    .BYTE $12
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $1E
    .BYTE $1F
    .BYTE 8
    .BYTE 9
    .BYTE $FF
    .BYTE $FF
    .BYTE $A
    .BYTE $14
    .BYTE $FF
    .BYTE $FF
    .BYTE $12
    .BYTE $1B
    .BYTE $FF
    .BYTE $FF
    .BYTE $A
    .BYTE $FF
    .BYTE $14
    .BYTE $18
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $10
    .BYTE $18
    .BYTE $FF
    .BYTE $52
    .BYTE $FF
    .BYTE $62
    .BYTE $53
    .BYTE $54
    .BYTE $63
    .BYTE $64
    .BYTE $A
    .BYTE $B
    .BYTE $1A
    .BYTE $1B
    .BYTE $C
    .BYTE $D
    .BYTE $FF
    .BYTE $1D
    .BYTE $45
    .BYTE $39
    .BYTE $55
    .BYTE $9D
    .BYTE $39
    .BYTE $6C
    .BYTE $9D
    .BYTE $9D
    .BYTE $6C
    .BYTE $75
    .BYTE $9D
    .BYTE $85
    .BYTE $FF
    .BYTE $FF
    .BYTE $16
    .BYTE $FF
    .BYTE $86
    .BYTE $FF
    .BYTE $76
    .BYTE $FF
    .BYTE $FF
    .BYTE 1
    .BYTE $FF
    .BYTE $FF
    .BYTE $10
    .BYTE $26
    .BYTE $FF
    .BYTE $FF
    .BYTE $10
    .BYTE $1D
    .BYTE $FF
    .BYTE $FF
    .BYTE $E
    .BYTE $1E
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $23
    .BYTE $FF
    .BYTE $FF
    .BYTE $A
    .BYTE $C
    .BYTE $FF
    .BYTE $FF
    .BYTE $18
    .BYTE $FF
    .BYTE $FF
    .BYTE $72
    .BYTE $FF
    .BYTE $82
    .BYTE $73
    .BYTE $74
    .BYTE $83
    .BYTE $84
    .BYTE $E
    .BYTE $1E
    .BYTE $15
    .BYTE $1C
    .BYTE $1F
    .BYTE $F
    .BYTE $15
    .BYTE $1C
    .BYTE $FF
    .BYTE $FF
    .BYTE $18
    .BYTE $14
    .BYTE $FF
    .BYTE $FF
    .BYTE $12
    .BYTE $1D
    .BYTE $FF
    .BYTE $FF
    .BYTE $22
    .BYTE $18
    .BYTE $FF
    .BYTE $FF
    .BYTE $1C
    .BYTE $11
    .BYTE $FF
    .BYTE $FF
    .BYTE $12
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $FF
    .BYTE $14
    .BYTE $FF
    .BYTE $FF
    .BYTE $E
    .BYTE $12
    .BYTE $FF
    .BYTE $FF
    .BYTE $1D
    .BYTE $18
    .BYTE $24
    .BYTE $17
    .BYTE $FF
    .BYTE $FF
    .BYTE 8
    .BYTE 9
    .BYTE $15
    .BYTE $1C
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE $FF
    .BYTE $92
    .BYTE $FF
    .BYTE $A2
    .BYTE $93
    .BYTE $94
    .BYTE $A3
    .BYTE $A4
    .BYTE $95
    .BYTE $FF
    .BYTE $A5
    .BYTE $FF
    .BYTE $95
    .BYTE $92
    .BYTE $A5
    .BYTE $A2
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
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
    .WORD ZoneBlocks_01,ZoneBlocks_02,ZoneBlocks_03,ZoneBlocks_04,ZoneBlocks_05
    .WORD ZoneBlocks_06,ZoneBlocks_07,ZoneBlocks_08,ZoneBlocks_09,ZoneBlocks_10; 5
    .WORD ZoneBlocks_11,ZoneBlocks_12,ZoneBlocks_13,ZoneBlocks_14,ZoneBlocks_15; 10
    .WORD ZoneBlocks_16,ZoneBlocks_17,ZoneBlocks_18,ZoneBlocks_19,ZoneBlocks_20; 15
    .WORD ZoneBlocks_21,ZoneBlocks_22,ZoneBlocks_23,ZoneBlocks_24,ZoneBlocks_25; 20
    .WORD ZoneBlocks_26,ZoneBlocks_27,ZoneBlocks_28,ZoneBlocks_29,ZoneBlocks_30; 25
    .WORD ZoneBlocks_31,ZoneBlocks_32,ZoneBlocks_33,ZoneBlocks_34,ZoneBlocks_35; 30
    .WORD ZoneBlocks_36,ZoneBlocks_37,ZoneBlocks_38,ZoneBlocks_39,ZoneBlocks_40; 35
    .WORD ZoneBlocks_41,ZoneBlocks_42,ZoneBlocks_43,ZoneBlocks_44,ZoneBlocks_45; 40
    .WORD ZoneBlocks_46,ZoneBlocks_47,ZoneBlocks_48,ZoneBlocks_49,ZoneBlocks_50; 45
    .WORD ZoneBlocks_51,ZoneBlocks_52,ZoneBlocks_53,ZoneBlocks_54,ZoneBlocks_55; 50
    .WORD ZoneBlocks_56,ZoneBlocks_57,ZoneBlocks_58,ZoneBlocks_59,ZoneBlocks_60; 55
    .WORD ZoneBlocks_61,ZoneBlocks_62,ZoneBlocks_63,ZoneBlocks_64,ZoneBlocks_65; 60
    .WORD ZoneBlocks_66,ZoneBlocks_67,ZoneBlocks_68,ZoneBlocks_69,ZoneBlocks_70; 65
    .WORD ZoneBlocks_71,ZoneBlocks_72,ZoneBlocks_73,ZoneBlocks_74,ZoneBlocks_75; 70
    .WORD ZoneBlocks_76,ZoneBlocks_77,ZoneBlocks_78,ZoneBlocks_79,ZoneBlocks_80; 75
    .WORD ZoneBlocks_81,ZoneBlocks_82,ZoneBlocks_83,ZoneBlocks_84,ZoneBlocks_85; 80
    .WORD ZoneBlocks_86,ZoneBlocks_87,ZoneBlocks_88,ZoneBlocks_89,ZoneBlocks_90; 85
    .WORD ZoneBlocks_91,ZoneBlocks_92,ZoneBlocks_93,ZoneBlocks_94,ZoneBlocks_95; 90
    .WORD ZoneBlocks_96,ZoneBlocks_97,ZoneBlocks_98,ZoneBlocks_99,ZoneBlocks_100; 95
ZoneBlocks_06:
    .BYTE $10,$18,$11,$18,$10
ZoneBlocks_90:
    .BYTE $10,$18,$13,$18,$10
ZoneBlocks_25:
    .BYTE $10,$18,$18,$10
ZoneBlocks_16:
    .BYTE $10,$18,$11,$12,$17,$17,$11,$14,$14,$11,$14,$15,$15,$15,$11,$16,$16,$11,$16,$15,$15,$15,$11,$14,$14,$11,$14,$17,$17,$17,$18,$10
ZoneBlocks_87:
    .BYTE $25,$22,$22,$24,$21,$22,$20,$20,$21,$21,$23,$20,$23,$22,$22,$25
ZoneBlocks_19:
    .BYTE $25,$22,$20,$21,$22,$23,$21,$22,$20,$21,$20,$21,$24,$20,$20,$22,$21,$25,$20
ZoneBlocks_36:
    .BYTE $25,$26,$22,$26,$20,$26,$21,$26,$25,$26,$25,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26,$26
ZoneBlocks_18:
    .BYTE $21,$25,$24,$25,$24,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
ZoneBlocks_33:
    .BYTE   1,$2A,$2A,$2B,$2C,$2D,$2E,$2F,$2E,$2A,$2B,$2B,$2A,$2F,$2E,$2C,$2D,$2B,$30,$31,$30,$2B,$30,$2C,$31,$2D,$2F,$2E,$2A,$2A,  1,  0
ZoneBlocks_56:
    .BYTE   0,  1,$2E,$2A,$2F,  0,$31,$31,$30,  1,$2B,$2C,$2D,$2E,  1,  0
ZoneBlocks_08:
    .BYTE $46,$47,$48,$49,$47,$48,$47,$48,$47,$48,$48,$47,$48,$47,$48,$49,$4A,$4C,$49,$49,$48,$47,$47,$48,$48,$47,$48,$47,$49,$48,$47,$46
ZoneBlocks_37:
    .BYTE $46,$48,$49,$47,$4A,$48,$49,$4B,$4A,$4B,$49,$49,$48,$47,$49,$46
ZoneBlocks_43:
    .BYTE $46,$49,$4B,$4A,$4C,$4D,$4A,$49,$4B,$4A,$4C,$4A,$4D,$49,$49,$46
ZoneBlocks_77:
    .BYTE $46,$4D,$4B,$4A,$4B,$4D,$4C,$4B,$4C,$4D,$4D,$4E,$4B,$4A,$4F,$4F,$4E,$49,$4E,$47,$4F,$4A,$4B,$4E,$4D,$4D
ZoneBlocks_92:
    .BYTE   0,  0,  0,$50,$51,$52,$53,$51,$51,$53,$52,$51,$54,$53,$53,$52,$51,$54,$53,$51,$50,  0,  0,  0
ZoneBlocks_27:
    .BYTE   0,  0,  0,$7D,$7B,$7A,$7C,$7B,$7B,$7A,$7D,$7D,$7F,$7D,$7E,$7E,$7D,$7E,$7F,$7F,$7A,$7B,$7B,$7C,$7C,$7A,$7B,$7C,$7A,$7F,  0,  0
ZoneBlocks_03:
    .BYTE   0,  0,  0,$56,$57,$56,$57,$56,$58,$56,$57,$57,$58,$57,$58,$57,$56,$57,$58,$56,$56,  0,  0,  0
ZoneBlocks_82:
    .BYTE   0,  1,$34,$35,$34,$35,$34,$33,$35,$32,$33,$34,$32,$33,$34,$35,$32,$34,$35,  1,  0
ZoneBlocks_10:
    .BYTE   0,  0,$62,$59,$44,$45,$43,$43,$43,$44,$44,$45,$45,$44,$43,$45,$44,$43,$45,$59,$62,  0,  0
ZoneBlocks_69:
    .BYTE   1,$8A,$8A,$8A,$8B,$8A,$8A,$8B,$8C,$8A,$8A,$8A,$8A,$8A,$8C,$8B,$8D,$8B,$8A,$8A,$8A,$8A,$8B,$8C,$8A,$8A,$8A,$8B,$8B,$8A,  1,$8B
ZoneBlocks_60:
    .BYTE $1D,$78,$79,$78,$79,$78,$79,$79,$78,$78,$79,$78,$79,$78,$79,$79,$1D
ZoneBlocks_74:
    .BYTE $8A,  1,$8A,$94,$8A,$94,$8A,$95,$94,$8A,$94,$95,$8A,$95,$94,$8A,$8A,  1,$8A
ZoneBlocks_70:
    .BYTE $62,$60,$62
ZoneBlocks_34:
    .BYTE $73,  1,$70,$71,$71,$72,$70,$73,$73,$73,$71,$73,$71,$73,  1,$73
ZoneBlocks_81:
    .BYTE   0,  0,  0,  0,$63,  0,  0,  0,  0
ZoneBlocks_13:
    .BYTE $81,$80,$82,$83,$84,$83,$85,$86,$82,$84,$86,$81,$82,$85,$83,$84,$82,$83,$86,$81,$81,$80,$83
ZoneBlocks_02:
    .BYTE $5F,$5A,$5E,$5B,$5A,$5E,$5B,$5A,$5E,$5B,$5A,$5E,$5E,$5E,$5E,$5B,$5A,$5E,$5B,$5A,$5E,$5B,$5A,$5E,$5B,$5A,$5E,$5B,$5F
ZoneBlocks_50:
    .BYTE $5F,$5B,$5A,$5E,$5B,$5A,$5B,$5A,$5B,$5A,$5B,$5A,$5B,$5A,$5B,$5F
ZoneBlocks_73:
    .BYTE $5F,$5E,$5C,$5D,$5C,$5D,$5C,$5D,$5C,$5D,$5C,$5D,$5C,$5D,$5C,$5F,$5F,$5F,$1D
ZoneBlocks_01:
    .BYTE $62,  0,$62,$59,$59,$8A,$8E,$8F,$8A,$8F,$8E,$8A,$8E,$8F,$8F,$8F,$8A,$8E,$8E,$8A,$59,$59,  0,$62,  0
ZoneBlocks_04:
    .BYTE   0,  0,  0,$39,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3B,$39,$3A,$3B,$39,$3B,$39,$3B,$39,$3B,$39,$3A,$3B,  0,  0,  0
ZoneBlocks_21:
    .BYTE $63,$67,$68,$68,$67,$68,$67,$64
ZoneBlocks_12:
    .BYTE $10,$13,$65,$66,$11,$65,$65,$65,$66,$11,$13,$13,$13,$13,$66,$10
ZoneBlocks_07:
    .BYTE   0,  0,  0,$59,$3D,$3E,$3F,$3C,$3C,$3E,$3C,$3F,$3C,$3F,$3C,$3E,$3C,$3E,$3C,$3D,$59,  0,  0,  0
ZoneBlocks_62:
    .BYTE   0,  0,  0,$1D,$3A,$3A,$3B,  0,  0,  0
ZoneBlocks_80:
    .BYTE $1D,$1E,$1E,$1F,$1E,$1F,$1F,$1F,$1D
ZoneBlocks_97:
    .BYTE   0,  0,  0,$69,$69,$69,$69,  0,$63,  0,  0,  0
ZoneBlocks_39:
    .BYTE $81,$80,$81,$80,$81
ZoneBlocks_42:
    .BYTE   0,  0,$40,  0,  0
ZoneBlocks_51:
    .BYTE   0,  0,  0,$7E,$7F,$7F,$7C,$7C,$7D,$7E,$7F,$7D,$7E,  0,  0,  0
ZoneBlocks_94:
    .BYTE   0,$7F,  0,$7E,$7D,$7C,$7D,$7F,  0,  1,  0
ZoneBlocks_65:
    .BYTE   0,$7F,$7B,$7C,$7D,$7E,$7F,$7F,  0,  0,  0
ZoneBlocks_98:
    .BYTE   0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,$7E,  0,  0,  0
ZoneBlocks_75:
    .BYTE   0,$64,  0
ZoneBlocks_95:
    .BYTE   0,  1,$54,$56,$54,$52,$51,$51,$50,$57,  0,  0,  0
ZoneBlocks_32:
    .BYTE $3D,  1,$3D,$3F,$3C,$3C,$3F,$3C,$3F,$37,  1,$3D
ZoneBlocks_57:
    .BYTE   0,  0,  0,$6A,$6F,$6B,$6C,$6D,$6C,$6E,$6D,$6A,$6F,$6F,$6F,$6F,$6B,$6D,$6C,$6C,$6E,  0,  0,  0
ZoneBlocks_45:
    .BYTE   0,  1,$6A,$6B,$6D,$6C,$6E,$6D,$6C,$6A,$6B,$6C,$6D,$6D,$6C,$1D
ZoneBlocks_67:
    .BYTE   0,  0,  0,$6C,$6F,$6C,$6A,$6B,$6E,$6F,$6F,$6B,$6E,  0,  0,  0
ZoneBlocks_23:
    .BYTE $55,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3B,$39,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$55
ZoneBlocks_64:
    .BYTE $1D,$2A,$2B,$1D,$52,$54,  0,  0,  0,  0
ZoneBlocks_99:
    .BYTE $88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$89,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88,$88
ZoneBlocks_79:
    .BYTE $91,$87,$92,$90,$91,$93,$92,$90,$93,$91,$91,$92,$90,$92,$91,$92,$92,$90,$91,$91,$90,$91,$87,$92
ZoneBlocks_52:
    .BYTE   0,  1,$92,$90,$72,$93,$90,$73,$91,$93,$71,$93,$73,  1,  0
ZoneBlocks_100:
    .BYTE $1D,$27,$27,$19,$1B,$1A,$1B,$19,$1B,$1C,$1A,$27,$1D,$27,$1D
ZoneBlocks_29:
    .BYTE $36,  1,$36,$36,$36,$37,$36,$36,$36,$36,$37,$36,$36,$36,$37,  0,  0,  0
ZoneBlocks_20:
    .BYTE $8A,  1,$8E,$96,$41,$94,$8F,  1,$8A
ZoneBlocks_85:
    .BYTE   0,  0,  0,$37,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$37,  1,  0
ZoneBlocks_46:
    .BYTE $55,$67,$68,$68,$67,$68,$67,$68,$68,$67,$67,$67,$55
ZoneBlocks_54:
    .BYTE $60,$87,$69,$69,$69,  0,  0,  0
ZoneBlocks_14:
    .BYTE   0,  0,  0,$59,$3C,$59,  0,  0,  0
ZoneBlocks_26:
    .BYTE   6,  1,  6,  6,  7,  8,  8,  2,  3,  4,  5,  8,  8,  7,  6,  6,  1,  6
ZoneBlocks_96:
    .BYTE $1D,$78,$79,$28,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$79,$78,$28,$1D
ZoneBlocks_83:
    .BYTE $1D,$28,$29,$78,$29,$79,$29,$28,$29,$1D
ZoneBlocks_47:
    .BYTE $8A,$87,$8A,$8F,$8A,$8F,$8F,$8A,$8E,$8E,$8E,$8A,$8A,$8A,$87,$8A
ZoneBlocks_78:
    .BYTE   0,  0,  0,$87,$87,  0,  0,  0
ZoneBlocks_84:
    .BYTE $8A,  1,$8A,$8A,$95,$8A,$8A,  1,$8A
ZoneBlocks_93:
    .BYTE $1D,$88,$1D
ZoneBlocks_91:
    .BYTE $1D,$79,$1D
ZoneBlocks_63:
    .BYTE $1D,$28,$1D
ZoneBlocks_76:
    .BYTE $1D,$78,$1D
ZoneBlocks_59:
    .BYTE   0,  0,  0,  0,$87,$87,$87,$87,$87,$87,$87,$87,$87,$87,  0,  0,  0
ZoneBlocks_24:
    .BYTE $8A,  1,$8A,$8A,$8A,$8A,$38,$8A,$8A,$8A,$8A,  1,$8A
ZoneBlocks_49:
    .BYTE $36,  1,$36,$36,  1,$36
ZoneBlocks_44:
    .BYTE   0,  1,$32,$45,$34,$44,$43,$33,$32,$45,$32,$43,$32,$45,$44,$32,  1,  0
ZoneBlocks_66:
    .BYTE $1D,$37,$1D
ZoneBlocks_11:
    .BYTE $46,$46,$47
ZoneBlocks_72:
    .BYTE $1D,$2A,$2F,$2C,$2B,$2D,$2C,$2B,$2C,$31,$2B,$30,$2B,$2C,$2D,$31,$2F,$30,$2F,$1D
ZoneBlocks_30:
    .BYTE   0,  0,  0,$7F,$56,$57,$57,$57,$58,$57,$57,$58,$57,$56,$56,$7F,  0,  0,  0
ZoneBlocks_40:
    .BYTE $10,$13,$13,$13,$65,$13,$66,$13,$66,$66,$13,$65,$66,$13,$13,$10
ZoneBlocks_61:
    .BYTE   0,  0,  0,$39,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3B,  0,  0,  0
ZoneBlocks_71:
    .BYTE $73,  1,$72,$73,$72,$73,$73,$71,$72,$73,$73,$71,  1,$73
ZoneBlocks_55:
    .BYTE   0,  0,  0,  1,  0,  0,  0
ZoneBlocks_53:
    .BYTE   0,  0,  0,$7F,  0,  0,  0
ZoneBlocks_15:
    .BYTE $10,$18,$10
ZoneBlocks_05:
    .BYTE $5C,$5A,$5E,$5B,$5C
ZoneBlocks_35:
    .BYTE $1D,$5A,$5B,$1D
ZoneBlocks_22:
    .BYTE $5B,$5C,$5A
ZoneBlocks_41:
    .BYTE $1D,  1,$1D
ZoneBlocks_31:
    .BYTE $55,$36,$55
ZoneBlocks_17:
    .BYTE $55,$56,$55
ZoneBlocks_09:
    .BYTE $10,$66,$10
ZoneBlocks_38:
    .BYTE   0,  0,  0,$56,$57,$57,$58,$56,$57,$57,$58,$56,$56,  0,  0,  0
ZoneBlocks_28:
    .BYTE $10,$13,$11,$65,$11,$13,$13,$13,$65,$65,$13,$66,$10
ZoneBlocks_48:
    .BYTE   0,  0,  0,$39,$3B,$39,$3B,$39,$3B,$39,$3B,$39,$3B,  0,  0,  0
ZoneBlocks_58:
    .BYTE $1D,$37,$71,$73,$72,$73,$72,$70,$72,$37,$1D
ZoneBlocks_68:
    .BYTE $1D,$1E,$1E,$1E,$1E,$1E,$1E,$1D
ZoneBlocks_86:
    .BYTE   0,  0,  0,$56,$56,$57,$57,$57,$58,$58,$57,$58,$57,$56,$56,  0,  0,  0
ZoneBlocks_88:
    .BYTE $55,$4D,$4E,$55
ZoneBlocks_89:
    .BYTE   0,  0,  0,$7D,$7A,$7B,$7D,$7C,$7D,$7E,$7D,$7C,$7D,$7F,$7E,  0,  0,  0
byte_FDE5:
    .BYTE	0
    .BYTE 0
    .BYTE 0
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE 0
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $20
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE   0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE   0
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE 0
    .BYTE 0
    .BYTE   0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $20
    .BYTE 0
    .BYTE $20
    .BYTE 0
    .BYTE 0
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $20
    .BYTE $20
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $20
    .BYTE 0
    .BYTE $20
    .BYTE 0
    .BYTE $20
    .BYTE 0
    .BYTE $20
    .BYTE 0
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE   0
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE   0
    .BYTE   0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE $20
    .BYTE 0
    .BYTE   0
    .BYTE 0
    .BYTE   0
ZoneCHRTable:
    .BYTE $36,$16,$16,$14,$14,$14,$34,$16,$14,$34
    .BYTE $14,$14,$14,$36,$14,$14,$16,$14,$16,$34; 10
    .BYTE $14,$14,$14,$34,$14,$34,$16,$14,$14,$16; 20
    .BYTE $14,$34,$14,$36,$14,$16,$16,$14,$14,$16; 30
    .BYTE $14,$34,$16,$34,$16,$16,$34,$14,$14,$14; 40
    .BYTE $16,$34,$14,$34,$34,$14,$16,$36,$14,$16; 50
    .BYTE $16,$14,$14,$14,$16,$14,$16,$14,$34,$34; 60
    .BYTE $34,$14,$16,$34,$14,$14,$14,$14,$36,$14; 70
    .BYTE $14,$34,$14,$34,$16,$14,$14,$14,$16,$16; 80
    .BYTE $14,$16,$14,$16,$16,$14,$34,$14,$14,$16; 90
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
DebugWarpTable:
    .BYTE   0,$12,$14,$49,$A6,  3,$1C,  4,$AD,$42
    .BYTE $96,$17,$1B,$B0,$A4,	7,$AC,$4E,  8,$B1; $A
    .BYTE $1F,$A9,$71,$8F,$45,$B2,$22,$B4,$48,$9A; $14
    .BYTE $AB,$60, $A,$25,$A7,$28,$2C,$B6,$57,$9C; $1E
    .BYTE $AA,$59,$4A,$92,$6D,$79,$80,$B9,$91,$2F; $28
    .BYTE $5A,$77,$A3,$AF,$A2,$30,$6A,$BA,$97,$37; $32
    .BYTE $9F,$53,$89,$AE,$64,$95,$6F,$BD, $C,$38; $3C
    .BYTE $A0,$98,$3B,$3C,$5E,$8B,$4B,$81,$74,$68; $46
    .BYTE $51, $F,$7E,$84,$52,$C0,$47,$BE,$C1,$3F; $50
    .BYTE $87,$40,$85,$5B,$5F,$7B,$56,$5D,$72,$78; $5A
ZoneMusicTable:
    .BYTE MusicTrack_ZoneTheme2
    .BYTE MusicTrack_ZoneTheme1		; 1
    .BYTE MusicTrack_ZoneTheme2		; 2
    .BYTE MusicTrack_ZoneTheme3		; 3
    .BYTE MusicTrack_ZoneTheme1		; 4
    .BYTE MusicTrack_ZoneTheme3		; 5
    .BYTE MusicTrack_ZoneTheme2		; 6
    .BYTE MusicTrack_ZoneTheme1		; 7
    .BYTE MusicTrack_ZoneTheme3		; 8
    .BYTE MusicTrack_ZoneTheme2		; 9
    .BYTE MusicTrack_ZoneTheme1		; 10
    .BYTE MusicTrack_ZoneTheme3		; 11
    .BYTE MusicTrack_ZoneTheme1		; 12
    .BYTE MusicTrack_ZoneTheme2		; 13
    .BYTE MusicTrack_ZoneTheme3		; 14
    .BYTE MusicTrack_ZoneTheme3		; 15
    .BYTE MusicTrack_ZoneTheme3		; 16
    .BYTE MusicTrack_ZoneTheme1		; 17
    .BYTE MusicTrack_ZoneTheme1		; 18
    .BYTE MusicTrack_ZoneTheme3		; 19
    .BYTE MusicTrack_ZoneTheme3		; 20
    .BYTE MusicTrack_ZoneTheme1		; 21
    .BYTE MusicTrack_ZoneTheme3		; 22
    .BYTE MusicTrack_ZoneTheme2		; 23
    .BYTE MusicTrack_ZoneTheme3		; 24
    .BYTE MusicTrack_ZoneTheme2		; 25
    .BYTE MusicTrack_ZoneTheme2		; 26
    .BYTE MusicTrack_ZoneTheme1		; 27
    .BYTE MusicTrack_ZoneTheme2		; 28
    .BYTE MusicTrack_ZoneTheme2		; 29
    .BYTE MusicTrack_ZoneTheme2		; 30
    .BYTE MusicTrack_ZoneTheme2		; 31
    .BYTE MusicTrack_ZoneTheme3		; 32
    .BYTE MusicTrack_ZoneTheme1		; 33
    .BYTE MusicTrack_ZoneTheme1		; 34
    .BYTE MusicTrack_ZoneTheme1		; 35
    .BYTE MusicTrack_ZoneTheme1		; 36
    .BYTE MusicTrack_ZoneTheme3		; 37
    .BYTE MusicTrack_ZoneTheme1		; 38
    .BYTE MusicTrack_ZoneTheme3		; 39
    .BYTE MusicTrack_ZoneTheme3		; 40
    .BYTE MusicTrack_Death		; 41
    .BYTE MusicTrack_ZoneTheme1		; 42
    .BYTE MusicTrack_ZoneTheme2		; 43
    .BYTE MusicTrack_ZoneTheme3		; 44
    .BYTE MusicTrack_ZoneTheme3		; 45
    .BYTE MusicTrack_ZoneTheme2		; 46
    .BYTE MusicTrack_ZoneTheme3		; 47
    .BYTE MusicTrack_ZoneTheme2		; 48
    .BYTE MusicTrack_ZoneTheme1		; 49
    .BYTE MusicTrack_ZoneTheme2		; 50
    .BYTE MusicTrack_ZoneTheme1		; 51
    .BYTE MusicTrack_ZoneTheme2		; 52
    .BYTE MusicTrack_ZoneTheme2		; 53
    .BYTE MusicTrack_ZoneTheme2		; 54
    .BYTE MusicTrack_ZoneTheme1		; 55
    .BYTE MusicTrack_ZoneTheme3		; 56
    .BYTE MusicTrack_ZoneTheme1		; 57
    .BYTE MusicTrack_ZoneTheme2		; 58
    .BYTE MusicTrack_ZoneTheme2		; 59
    .BYTE MusicTrack_ZoneTheme3		; 60
    .BYTE MusicTrack_ZoneTheme3		; 61
    .BYTE MusicTrack_ZoneTheme2		; 62
    .BYTE MusicTrack_ZoneTheme1		; 63
    .BYTE MusicTrack_ZoneTheme2		; 64
    .BYTE MusicTrack_ZoneTheme2		; 65
    .BYTE MusicTrack_ZoneTheme3		; 66
    .BYTE MusicTrack_ZoneTheme3		; 67
    .BYTE MusicTrack_ZoneTheme2		; 68
    .BYTE MusicTrack_ZoneTheme2		; 69
    .BYTE MusicTrack_ZoneTheme1		; 70
    .BYTE MusicTrack_ZoneTheme3		; 71
    .BYTE MusicTrack_ZoneTheme1		; 72
    .BYTE MusicTrack_ZoneTheme3		; 73
    .BYTE MusicTrack_ZoneTheme2		; 74
    .BYTE MusicTrack_ZoneTheme2		; 75
    .BYTE MusicTrack_ZoneTheme1		; 76
    .BYTE MusicTrack_ZoneTheme2		; 77
    .BYTE MusicTrack_ZoneTheme2		; 78
    .BYTE MusicTrack_ZoneTheme1		; 79
    .BYTE MusicTrack_ZoneTheme2		; 80
    .BYTE MusicTrack_ZoneTheme2		; 81
    .BYTE MusicTrack_ZoneTheme2		; 82
    .BYTE MusicTrack_ZoneTheme3		; 83
    .BYTE MusicTrack_ZoneTheme3		; 84
    .BYTE MusicTrack_ZoneTheme1		; 85
    .BYTE MusicTrack_ZoneTheme3		; 86
    .BYTE MusicTrack_ZoneTheme1		; 87
    .BYTE MusicTrack_ZoneTheme2		; 88
    .BYTE MusicTrack_ZoneTheme3		; 89
    .BYTE MusicTrack_ZoneTheme2		; 90
    .BYTE MusicTrack_ZoneTheme1		; 91
    .BYTE MusicTrack_ZoneTheme2		; 92
    .BYTE MusicTrack_ZoneTheme2		; 93
    .BYTE MusicTrack_ZoneTheme1		; 94
    .BYTE MusicTrack_ZoneTheme2		; 95
    .BYTE MusicTrack_ZoneTheme2		; 96
    .BYTE MusicTrack_ZoneTheme1		; 97
    .BYTE MusicTrack_ZoneTheme2		; 98
    .BYTE MusicTrack_ZoneTheme1		; 99

.include "src/unused-unknown2.asm"
