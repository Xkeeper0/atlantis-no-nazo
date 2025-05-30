
MusicNoteScale:
	.BYTE  $D,$5C
	.BYTE  $C,$9C			; 2 ; probably.	idk.
	.BYTE  $B,$E8			; 4
	.BYTE  $B,$3C			; 6
	.BYTE  $A,$9A			; 8
	.BYTE  $A,	2			; $A
	.BYTE   9,$72			; $C
	.BYTE   8,$EA			; $E
	.BYTE   8,$6A			; $10
	.BYTE   7,$F2			; $12
	.BYTE   7,$80			; $14
	.BYTE   7,$14			; $16
MusicNoteLength:
	.BYTE $7F,  1,	2,  3,	4,  5,	6,  7
	.BYTE   8,	9, $A, $B, $C, $D, $E, $F; 8
	.BYTE   5, $A,$14,$28,$50,$1E,  7, $D; $10
	.BYTE   6, $C,$18,$30,$60,$24,  8,$10; $18
byte_C945:
	.BYTE	1
	.BYTE 2
	.BYTE 4
	.BYTE 8
byte_C949:
	.BYTE	$E
	.BYTE $D
	.BYTE $B
	.BYTE 7
MusicPointerTable:
	.WORD	Music_0
	.WORD Music_ZoneTheme1		; 1
	.WORD Music_ZoneTheme2		; 2
	.WORD Music_ZoneTheme3		; 3
	.WORD Music_TitleScreen		; 4
	.WORD Music_ZoneStart		; 5
	.WORD Music_GameOver		; 6
	.WORD Music_Death			; 7
	.WORD Music_Pause			; 8
	.WORD Music_ExtraLife		; 9
	.WORD Music_Treasure		; $A
	.WORD Music_ThrowBomb		; $B
	.WORD Music_BombExplode		; $C
	.WORD Music_Pause2			; $D
Music_0:
	.BYTE	6
	MusicSeg 5, byte_C994, 0, 0, 0, 0 ;
	MusicSeg 4, byte_C994, 1, 0, 0, 0 ;
	MusicSeg 3, byte_C994, 2, 0, 0, 0 ;
	MusicSeg 2, byte_C994, 3, 0, 0, 0 ;
	MusicSeg 1, byte_C994, 0, 0, 0, 0 ;
	MusicSeg 0, byte_C994, 1, 0, 0, 0 ;
byte_C994:
	.BYTE	$FF
Music_ZoneTheme1:
	.BYTE 3
	MusicSeg 2, byte_CAB1, 0, 0, 0, $C4 ;
	MusicSeg 1, byte_CBBD, 1, 0, 0, $CE ;
	MusicSeg 0, byte_CC49, 2, 0, 0, $7F ;
Music_ZoneTheme2:
	.BYTE 3
	MusicSeg 2, byte_CCBF, 0, 0, 0, $9F ;
	MusicSeg 1, byte_CDF0, 1, 0, 0, $82 ;
	MusicSeg 0, byte_CF2A, 2, 0, 0, $7F ;
Music_ZoneTheme3:
	.BYTE 3
	MusicSeg 2, byte_CF9E, 0, 0, 0, $DF ;
	MusicSeg 1, byte_D036, 1, 0, 0, $DF ;
	MusicSeg 0, byte_D0CE, 2, 0, 0, $7F ;
Music_TitleScreen:
	.BYTE	3
	MusicSeg 2, byte_D124, 0, 0, 0, $CA ;
	MusicSeg 1, byte_D177, 1, 0, 0, $CA ;
	MusicSeg 0, byte_D1CA, 2, 0, 0, $7F ;
Music_ZoneStart:
	.BYTE 3
	MusicSeg 2, byte_D1E9, 0, 0, 0, $CC ;
	MusicSeg 1, byte_D21A, 1, 0, 0, $CC ;
	MusicSeg 0, byte_D24B, 2, 0, 0, $7F ;
Music_GameOver:
	.BYTE 3
	MusicSeg 2, byte_D264, 0, 0, 0, $C2 ;
	MusicSeg 1, byte_D295, 1, 0, 0, $C2 ;
	MusicSeg 0, byte_D2C8, 2, 0, 0, $7F ;
Music_Death:
	.BYTE 3
	MusicSeg 2, byte_D2F5, 0, 0, $EE, $9F ;
	MusicSeg 1, byte_D310, 1, 0, 0, $9F ;
	MusicSeg 0, byte_C994, 2, 0, 0, 0 ;
Music_Pause:
	.BYTE 3
	MusicSeg 5, byte_D321, 0, 0, $BB, $9F ;
	MusicSeg 4, byte_D336, 1, 0, $BB, $9F ;
	MusicSeg 3, byte_D34B, 2, 0, 0, $7F ;
Music_Pause2:
	.BYTE 3
	MusicSeg 5, byte_D360, 0, 0, $BB, $9F ;
	MusicSeg 4, byte_D371, 1, 0, $BB, $9F ;
	MusicSeg 3, byte_D382, 2, 0, 0, $7F ;
Music_ExtraLife:
	.BYTE 3
	MusicSeg 5, byte_D393, 0, 0, $EE, $81 ;
	MusicSeg 4, byte_D3A4, 1, 0, $EE, $81 ;
	MusicSeg 3, byte_D3B5, 2, 0, 0, $7F ;
Music_Treasure:
	.BYTE 3
	MusicSeg 5, byte_D3C6, 0, 0, 0, $DF ;
	MusicSeg 4, byte_D3D3, 1, 0, 0, $DF ;
	MusicSeg 3, byte_D3E0, 2, 0, 0, $7F ;
Music_ThrowBomb:
	.BYTE 1
	MusicSeg 5, byte_CAAE, 1, 0, $8E, $BF ;
Music_BombExplode:
	.BYTE	3
	MusicSeg 5, byte_CAA5, 1, 0, 0, $DF ;
	MusicSeg 4, byte_CAA8, 2, 0, 0, $40 ;
	MusicSeg 3, byte_CAAB, 3, 0, 0, $A ;
byte_CAA5:
	.BYTE	0
	.BYTE $FC
	.BYTE $FF
byte_CAA8:
	.BYTE	$20
	.BYTE $FB
	.BYTE $FF
byte_CAAB:
	.BYTE	$F
	.BYTE $FC
	.BYTE $FF
byte_CAAE:
	.BYTE	$40
	.BYTE $EA
	.BYTE $FF
byte_CAB1:
	.BYTE	$F
	.BYTE $F3
	.BYTE $F
	.BYTE $F2
	.BYTE $27
	.BYTE $F1
	.BYTE $27
	.BYTE $F1
	.BYTE $A0
	.BYTE $CE
	.BYTE $30
	.BYTE $F3
	.BYTE $A0
	.BYTE $C4
	.BYTE $30
	.BYTE $F1
	.BYTE $32
	.BYTE $F1
	.BYTE $33
	.BYTE $F1
	.BYTE $35
	.BYTE $F1
	.BYTE $A0
	.BYTE $CE
	.BYTE $37
	.BYTE $EF
	.BYTE $38
	.BYTE $F0
	.BYTE $37
	.BYTE $F2
	.BYTE $A0
	.BYTE $C4
	.BYTE $37
	.BYTE $F1
	.BYTE $35
	.BYTE $F1
	.BYTE $33
	.BYTE $F1
	.BYTE $37
	.BYTE $F1
	.BYTE $A0
	.BYTE $CE
	.BYTE $35
	.BYTE $EF
	.BYTE $37
	.BYTE $F0
	.BYTE $35
	.BYTE $F2
	.BYTE $A0
	.BYTE $C4
	.BYTE $35
	.BYTE $F1
	.BYTE $33
	.BYTE $F1
	.BYTE $32
	.BYTE $F1
	.BYTE $35
	.BYTE $F1
	.BYTE $A0
	.BYTE $CE
	.BYTE $33
	.BYTE $F0
	.BYTE $33
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $30
	.BYTE $F2
	.BYTE $30
	.BYTE $F0
	.BYTE $F
	.BYTE $EF
	.BYTE $A0
	.BYTE $C4
	.BYTE $27
	.BYTE $F1
	.BYTE $27
	.BYTE $F1
	.BYTE $A0
	.BYTE $CE
	.BYTE $30
	.BYTE $F3
	.BYTE $A0
	.BYTE $C4
	.BYTE $30
	.BYTE $F1
	.BYTE $32
	.BYTE $F1
	.BYTE $33
	.BYTE $F1
	.BYTE $35
	.BYTE $F1
	.BYTE $A0
	.BYTE $CE
	.BYTE $37
	.BYTE $EF
	.BYTE $38
	.BYTE $F0
	.BYTE $37
	.BYTE $F2
	.BYTE $A0
	.BYTE $C4
	.BYTE $37
	.BYTE $F1
	.BYTE $35
	.BYTE $F1
	.BYTE $33
	.BYTE $F1
	.BYTE $37
	.BYTE $F1
	.BYTE $A0
	.BYTE $CE
	.BYTE $35
	.BYTE $EF
	.BYTE $37
	.BYTE $F0
	.BYTE $35
	.BYTE $F2
	.BYTE $A0
	.BYTE $C4
	.BYTE $35
	.BYTE $F1
	.BYTE $33
	.BYTE $F1
	.BYTE $32
	.BYTE $F1
	.BYTE $35
	.BYTE $F1
	.BYTE $A0
	.BYTE $CE
	.BYTE $33
	.BYTE $F0
	.BYTE $33
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $30
	.BYTE $F2
	.BYTE $A0
	.BYTE $C4
	.BYTE $30
	.BYTE $F1
	.BYTE $33
	.BYTE $F1
	.BYTE $37
	.BYTE $F1
	.BYTE $40
	.BYTE $F1
	.BYTE $A0
	.BYTE $CE
	.BYTE $43
	.BYTE $F0
	.BYTE $43
	.BYTE $F0
	.BYTE $42
	.BYTE $F0
	.BYTE $42
	.BYTE $F0
	.BYTE $40
	.BYTE $F0
	.BYTE $40
	.BYTE $F0
	.BYTE $3A
	.BYTE $F0
	.BYTE $3A
	.BYTE $F0
	.BYTE $38
	.BYTE $F0
	.BYTE $38
	.BYTE $F0
	.BYTE $37
	.BYTE $F0
	.BYTE $37
	.BYTE $F0
	.BYTE $35
	.BYTE $F0
	.BYTE $35
	.BYTE $F0
	.BYTE $33
	.BYTE $F0
	.BYTE $33
	.BYTE $F0
	.BYTE $B0
	.BYTE $4D
	.BYTE $35
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $37
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $B0
	.BYTE $5E
	.BYTE $33
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $37
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $B0
	.BYTE $67
	.BYTE $32
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $37
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $B0
	.BYTE $70
	.BYTE $30
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $33
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $33
	.BYTE $F0
	.BYTE $35
	.BYTE $F0
	.BYTE $37
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $27
	.BYTE $F1
	.BYTE $27
	.BYTE $F1
	.BYTE $BF
	.BYTE 4
byte_CBBD:
	.BYTE	$F
	.BYTE $F4
	.BYTE $23
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $23
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $23
	.BYTE $F1
	.BYTE $23
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $23
	.BYTE $F1
	.BYTE $23
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $23
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $23
	.BYTE $F1
	.BYTE $23
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $23
	.BYTE $F1
	.BYTE $22
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $22
	.BYTE $F0
	.BYTE $22
	.BYTE $F0
	.BYTE $22
	.BYTE $F0
	.BYTE $22
	.BYTE $F0
	.BYTE $22
	.BYTE $F1
	.BYTE $22
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $22
	.BYTE $F1
	.BYTE $23
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $23
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $23
	.BYTE $F1
	.BYTE $23
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $23
	.BYTE $F1
	.BYTE $B0
	.BYTE 1
	.BYTE $40
	.BYTE $F0
	.BYTE $40
	.BYTE $F0
	.BYTE $3A
	.BYTE $F0
	.BYTE $3A
	.BYTE $F0
	.BYTE $38
	.BYTE $F0
	.BYTE $38
	.BYTE $F0
	.BYTE $37
	.BYTE $F0
	.BYTE $37
	.BYTE $F0
	.BYTE $35
	.BYTE $F0
	.BYTE $35
	.BYTE $F0
	.BYTE $33
	.BYTE $F0
	.BYTE $33
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $B0
	.BYTE $2A
	.BYTE $F
	.BYTE $F4
	.BYTE $F
	.BYTE $F4
	.BYTE $F
	.BYTE $F4
	.BYTE $F
	.BYTE $F2
	.BYTE $30
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $33
	.BYTE $F1
	.BYTE $F
	.BYTE $F5
	.BYTE $BF
	.BYTE 1
byte_CC49:
	.BYTE	$F
	.BYTE $F4
	.BYTE $30
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $30
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $30
	.BYTE $F1
	.BYTE $30
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $30
	.BYTE $F1
	.BYTE $30
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $30
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $30
	.BYTE $F1
	.BYTE $30
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $30
	.BYTE $F1
	.BYTE $2B
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $2B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F1
	.BYTE $2B
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $2B
	.BYTE $F1
	.BYTE $30
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $30
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $30
	.BYTE $F1
	.BYTE $30
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $30
	.BYTE $F1
	.BYTE $B0
	.BYTE 1
	.BYTE $F
	.BYTE $F4
	.BYTE $F
	.BYTE $F4
	.BYTE $27
	.BYTE $F1
	.BYTE $37
	.BYTE $F1
	.BYTE $B2
	.BYTE $2C
	.BYTE $30
	.BYTE $F1
	.BYTE $40
	.BYTE $F1
	.BYTE $B2
	.BYTE $2F
	.BYTE $27
	.BYTE $F1
	.BYTE $37
	.BYTE $F1
	.BYTE $B2
	.BYTE $32
	.BYTE $30
	.BYTE $F1
	.BYTE $40
	.BYTE $F1
	.BYTE $B0
	.BYTE $35
	.BYTE $30
	.BYTE $F1
	.BYTE $F
	.BYTE $F5
	.BYTE $BF
	.BYTE 1
byte_CCBF:
	.BYTE	$F
	.BYTE $FC
	.BYTE $F
	.BYTE $FC
	.BYTE $27
	.BYTE $FB
	.BYTE $27
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $27
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $24
	.BYTE $F8
	.BYTE $25
	.BYTE $F8
	.BYTE $27
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $30
	.BYTE $FB
	.BYTE $30
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $30
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $27
	.BYTE $FA
	.BYTE $29
	.BYTE $FB
	.BYTE $29
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $29
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $25
	.BYTE $F8
	.BYTE $27
	.BYTE $F8
	.BYTE $29
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $27
	.BYTE $F4
	.BYTE $F
	.BYTE $FF
	.BYTE $27
	.BYTE $FB
	.BYTE $27
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $27
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $24
	.BYTE $F8
	.BYTE $25
	.BYTE $F8
	.BYTE $27
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $30
	.BYTE $FB
	.BYTE $30
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $30
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $34
	.BYTE $FA
	.BYTE $32
	.BYTE $FB
	.BYTE $32
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $32
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $29
	.BYTE $F8
	.BYTE $2B
	.BYTE $F8
	.BYTE $30
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $2B
	.BYTE $FB
	.BYTE $2B
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $2B
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $30
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $32
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $A0
	.BYTE $82
	.BYTE $34
	.BYTE $E6
	.BYTE $27
	.BYTE $E6
	.BYTE $30
	.BYTE $E6
	.BYTE $34
	.BYTE $E6
	.BYTE $37
	.BYTE $E6
	.BYTE $30
	.BYTE $E6
	.BYTE $34
	.BYTE $E6
	.BYTE $37
	.BYTE $E6
	.BYTE $40
	.BYTE $E6
	.BYTE $34
	.BYTE $E6
	.BYTE $37
	.BYTE $E6
	.BYTE $40
	.BYTE $E6
	.BYTE $44
	.BYTE $E6
	.BYTE $40
	.BYTE $E6
	.BYTE $37
	.BYTE $E6
	.BYTE $34
	.BYTE $E6
	.BYTE $32
	.BYTE $E6
	.BYTE $27
	.BYTE $E6
	.BYTE $2B
	.BYTE $E6
	.BYTE $32
	.BYTE $E6
	.BYTE $37
	.BYTE $E6
	.BYTE $2B
	.BYTE $E6
	.BYTE $32
	.BYTE $E6
	.BYTE $37
	.BYTE $E6
	.BYTE $3B
	.BYTE $E6
	.BYTE $32
	.BYTE $E6
	.BYTE $37
	.BYTE $E6
	.BYTE $3B
	.BYTE $E6
	.BYTE $42
	.BYTE $E6
	.BYTE $3B
	.BYTE $E6
	.BYTE $37
	.BYTE $E6
	.BYTE $32
	.BYTE $E6
	.BYTE $30
	.BYTE $E6
	.BYTE $24
	.BYTE $E6
	.BYTE $29
	.BYTE $E6
	.BYTE $30
	.BYTE $E6
	.BYTE $34
	.BYTE $E6
	.BYTE $29
	.BYTE $E6
	.BYTE $30
	.BYTE $E6
	.BYTE $34
	.BYTE $E6
	.BYTE $39
	.BYTE $E6
	.BYTE $30
	.BYTE $E6
	.BYTE $34
	.BYTE $E6
	.BYTE $39
	.BYTE $E6
	.BYTE $40
	.BYTE $E6
	.BYTE $39
	.BYTE $E6
	.BYTE $34
	.BYTE $E6
	.BYTE $30
	.BYTE $E6
	.BYTE $2B
	.BYTE $E6
	.BYTE $24
	.BYTE $E6
	.BYTE $27
	.BYTE $E6
	.BYTE $2B
	.BYTE $E6
	.BYTE $34
	.BYTE $E6
	.BYTE $27
	.BYTE $E6
	.BYTE $2B
	.BYTE $E6
	.BYTE $34
	.BYTE $E6
	.BYTE $37
	.BYTE $E6
	.BYTE $2B
	.BYTE $E6
	.BYTE $34
	.BYTE $E6
	.BYTE $37
	.BYTE $E6
	.BYTE $3B
	.BYTE $E6
	.BYTE $37
	.BYTE $E6
	.BYTE $34
	.BYTE $E6
	.BYTE $2B
	.BYTE $E6
	.BYTE $A0
	.BYTE $9F
	.BYTE $29
	.BYTE $F8
	.BYTE $29
	.BYTE $F8
	.BYTE $29
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $2B
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $30
	.BYTE $F9
	.BYTE $30
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $30
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $2B
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $30
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $34
	.BYTE $F8
	.BYTE $34
	.BYTE $F8
	.BYTE $34
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $34
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $32
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $F
	.BYTE $FB
	.BYTE $BF
	.BYTE 0
	.BYTE $FF
byte_CDF0:
	.BYTE	$A0
	.BYTE $82
	.BYTE $20
	.BYTE $F8
	.BYTE $20
	.BYTE $F8
	.BYTE $17
	.BYTE $F8
	.BYTE $17
	.BYTE $F8
	.BYTE $20
	.BYTE $F8
	.BYTE $20
	.BYTE $F8
	.BYTE $17
	.BYTE $F8
	.BYTE $17
	.BYTE $F8
	.BYTE $20
	.BYTE $F8
	.BYTE $20
	.BYTE $F8
	.BYTE $17
	.BYTE $F8
	.BYTE $17
	.BYTE $F8
	.BYTE $20
	.BYTE $F8
	.BYTE $20
	.BYTE $F8
	.BYTE $17
	.BYTE $F8
	.BYTE $17
	.BYTE $F8
	.BYTE $B0
	.BYTE 1
	.BYTE $A0
	.BYTE $9F
	.BYTE $24
	.BYTE $FB
	.BYTE $24
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $24
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $20
	.BYTE $F8
	.BYTE $22
	.BYTE $F8
	.BYTE $24
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $24
	.BYTE $FB
	.BYTE $24
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $24
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $24
	.BYTE $FA
	.BYTE $25
	.BYTE $FB
	.BYTE $25
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $25
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $19
	.BYTE $F8
	.BYTE $20
	.BYTE $F8
	.BYTE $25
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $24
	.BYTE $F4
	.BYTE $F
	.BYTE $FF
	.BYTE $24
	.BYTE $FB
	.BYTE $24
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $24
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $20
	.BYTE $F8
	.BYTE $22
	.BYTE $F8
	.BYTE $24
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $24
	.BYTE $FB
	.BYTE $24
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $24
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $27
	.BYTE $FA
	.BYTE $26
	.BYTE $FB
	.BYTE $26
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $26
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $26
	.BYTE $F8
	.BYTE $27
	.BYTE $F8
	.BYTE $29
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $27
	.BYTE $FB
	.BYTE $27
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $27
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $29
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $2B
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $A0
	.BYTE $82
	.BYTE $F
	.BYTE $FA
	.BYTE $34
	.BYTE $F8
	.BYTE $27
	.BYTE $F8
	.BYTE $30
	.BYTE $F8
	.BYTE $34
	.BYTE $F8
	.BYTE $37
	.BYTE $F8
	.BYTE $30
	.BYTE $F8
	.BYTE $34
	.BYTE $F8
	.BYTE $37
	.BYTE $F8
	.BYTE $30
	.BYTE $F8
	.BYTE $37
	.BYTE $F8
	.BYTE $34
	.BYTE $F8
	.BYTE $30
	.BYTE $F8
	.BYTE $F
	.BYTE $FA
	.BYTE $32
	.BYTE $F8
	.BYTE $27
	.BYTE $F8
	.BYTE $2B
	.BYTE $F8
	.BYTE $32
	.BYTE $F8
	.BYTE $37
	.BYTE $F8
	.BYTE $2B
	.BYTE $F8
	.BYTE $32
	.BYTE $F8
	.BYTE $37
	.BYTE $F8
	.BYTE $3B
	.BYTE $F8
	.BYTE $37
	.BYTE $F8
	.BYTE $32
	.BYTE $F8
	.BYTE $2B
	.BYTE $F8
	.BYTE $F
	.BYTE $FA
	.BYTE $30
	.BYTE $F8
	.BYTE $24
	.BYTE $F8
	.BYTE $29
	.BYTE $F8
	.BYTE $30
	.BYTE $F8
	.BYTE $34
	.BYTE $F8
	.BYTE $29
	.BYTE $F8
	.BYTE $30
	.BYTE $F8
	.BYTE $34
	.BYTE $F8
	.BYTE $39
	.BYTE $F8
	.BYTE $34
	.BYTE $F8
	.BYTE $30
	.BYTE $F8
	.BYTE $29
	.BYTE $F8
	.BYTE $F
	.BYTE $FA
	.BYTE $2B
	.BYTE $F8
	.BYTE $24
	.BYTE $F8
	.BYTE $27
	.BYTE $F8
	.BYTE $2B
	.BYTE $F8
	.BYTE $34
	.BYTE $F8
	.BYTE $27
	.BYTE $F8
	.BYTE $2B
	.BYTE $F8
	.BYTE $34
	.BYTE $F8
	.BYTE $37
	.BYTE $F8
	.BYTE $34
	.BYTE $F8
	.BYTE $2B
	.BYTE $F8
	.BYTE $27
	.BYTE $F8
	.BYTE $A0
	.BYTE $9F
	.BYTE $25
	.BYTE $F8
	.BYTE $25
	.BYTE $F8
	.BYTE $25
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $27
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $25
	.BYTE $F9
	.BYTE $25
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $25
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $25
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $25
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $27
	.BYTE $F8
	.BYTE $27
	.BYTE $F8
	.BYTE $27
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $27
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $25
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $F
	.BYTE $FB
	.BYTE $BF
	.BYTE 0
byte_CF2A:
	.BYTE	$30
	.BYTE $F8
	.BYTE $30
	.BYTE $F8
	.BYTE $27
	.BYTE $F8
	.BYTE $27
	.BYTE $F8
	.BYTE $BE
	.BYTE 0
	.BYTE $30
	.BYTE $F8
	.BYTE $30
	.BYTE $F8
	.BYTE $25
	.BYTE $F8
	.BYTE $25
	.BYTE $F8
	.BYTE $B2
	.BYTE 5
	.BYTE $30
	.BYTE $F8
	.BYTE $30
	.BYTE $F8
	.BYTE $27
	.BYTE $F8
	.BYTE $27
	.BYTE $F8
	.BYTE $BA
	.BYTE $A
	.BYTE $32
	.BYTE $F8
	.BYTE $32
	.BYTE $F8
	.BYTE $29
	.BYTE $F8
	.BYTE $29
	.BYTE $F8
	.BYTE $B2
	.BYTE $F
	.BYTE $32
	.BYTE $F8
	.BYTE $32
	.BYTE $F8
	.BYTE $27
	.BYTE $F8
	.BYTE $27
	.BYTE $F8
	.BYTE $B2
	.BYTE $14
	.BYTE $F
	.BYTE $FC
	.BYTE $F
	.BYTE $FC
	.BYTE $F
	.BYTE $FC
	.BYTE $F
	.BYTE $FC
	.BYTE $35
	.BYTE $F8
	.BYTE $35
	.BYTE $F8
	.BYTE $35
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $34
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $32
	.BYTE $F9
	.BYTE $32
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $32
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $32
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $32
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $37
	.BYTE $F8
	.BYTE $37
	.BYTE $F8
	.BYTE $37
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $37
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $37
	.BYTE $E4
	.BYTE $F
	.BYTE $E8
	.BYTE $F
	.BYTE $FA
	.BYTE $37
	.BYTE $F8
	.BYTE $35
	.BYTE $F8
	.BYTE $34
	.BYTE $F8
	.BYTE $32
	.BYTE $F8
	.BYTE $BF
	.BYTE 0
byte_CF9E:
	.BYTE	$2B
	.BYTE $F3
	.BYTE $2B
	.BYTE $F1
	.BYTE $27
	.BYTE $F1
	.BYTE $29
	.BYTE $F1
	.BYTE $2B
	.BYTE $F1
	.BYTE $30
	.BYTE $EF
	.BYTE $32
	.BYTE $F0
	.BYTE $30
	.BYTE $F2
	.BYTE $30
	.BYTE $F1
	.BYTE $29
	.BYTE $F1
	.BYTE $2B
	.BYTE $F1
	.BYTE $30
	.BYTE $F1
	.BYTE $2B
	.BYTE $F3
	.BYTE $2B
	.BYTE $F1
	.BYTE $27
	.BYTE $F1
	.BYTE $29
	.BYTE $F1
	.BYTE $2B
	.BYTE $F1
	.BYTE $29
	.BYTE $EF
	.BYTE $27
	.BYTE $F0
	.BYTE $26
	.BYTE $F2
	.BYTE $26
	.BYTE $F1
	.BYTE $26
	.BYTE $F1
	.BYTE $26
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $B0
	.BYTE 0
	.BYTE $24
	.BYTE $F0
	.BYTE $25
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $28
	.BYTE $F0
	.BYTE $29
	.BYTE $F0
	.BYTE $2A
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $2A
	.BYTE $F0
	.BYTE $29
	.BYTE $F0
	.BYTE $28
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $25
	.BYTE $F0
	.BYTE $B0
	.BYTE $1B
	.BYTE $2A
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $1B
	.BYTE $F0
	.BYTE $1B
	.BYTE $F0
	.BYTE $F
	.BYTE $F2
	.BYTE $B0
	.BYTE $2C
	.BYTE $3B
	.BYTE $F0
	.BYTE $3A
	.BYTE $F0
	.BYTE $39
	.BYTE $F0
	.BYTE $38
	.BYTE $F0
	.BYTE $37
	.BYTE $F0
	.BYTE $38
	.BYTE $F0
	.BYTE $39
	.BYTE $F0
	.BYTE $3A
	.BYTE $F0
	.BYTE $B0
	.BYTE $32
	.BYTE $3B
	.BYTE $F0
	.BYTE $3A
	.BYTE $F0
	.BYTE $39
	.BYTE $F0
	.BYTE $38
	.BYTE $F0
	.BYTE $37
	.BYTE $F0
	.BYTE $36
	.BYTE $F0
	.BYTE $35
	.BYTE $F0
	.BYTE $34
	.BYTE $F0
	.BYTE $33
	.BYTE $F0
	.BYTE $31
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $29
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $29
	.BYTE $F0
	.BYTE $BF
	.BYTE 0
byte_D036:
	.BYTE	$27
	.BYTE $F3
	.BYTE $27
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $26
	.BYTE $F1
	.BYTE $27
	.BYTE $F1
	.BYTE $29
	.BYTE $EF
	.BYTE $2B
	.BYTE $F0
	.BYTE $29
	.BYTE $F2
	.BYTE $29
	.BYTE $F1
	.BYTE $26
	.BYTE $F1
	.BYTE $27
	.BYTE $F1
	.BYTE $29
	.BYTE $F1
	.BYTE $27
	.BYTE $F3
	.BYTE $27
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $26
	.BYTE $F1
	.BYTE $27
	.BYTE $F1
	.BYTE $26
	.BYTE $EF
	.BYTE $24
	.BYTE $F0
	.BYTE $23
	.BYTE $F2
	.BYTE $23
	.BYTE $F1
	.BYTE $23
	.BYTE $F1
	.BYTE $23
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $B0
	.BYTE 0
	.BYTE $21
	.BYTE $F0
	.BYTE $22
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $25
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $28
	.BYTE $F0
	.BYTE $29
	.BYTE $F0
	.BYTE $28
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $25
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $22
	.BYTE $F0
	.BYTE $B0
	.BYTE $1B
	.BYTE $F
	.BYTE $F2
	.BYTE $3A
	.BYTE $F0
	.BYTE $3B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $B0
	.BYTE $2C
	.BYTE $37
	.BYTE $F0
	.BYTE $36
	.BYTE $F0
	.BYTE $35
	.BYTE $F0
	.BYTE $34
	.BYTE $F0
	.BYTE $33
	.BYTE $F0
	.BYTE $34
	.BYTE $F0
	.BYTE $35
	.BYTE $F0
	.BYTE $36
	.BYTE $F0
	.BYTE $B0
	.BYTE $32
	.BYTE $37
	.BYTE $F0
	.BYTE $36
	.BYTE $F0
	.BYTE $35
	.BYTE $F0
	.BYTE $34
	.BYTE $F0
	.BYTE $33
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $31
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $29
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $BF
	.BYTE 0
byte_D0CE:
	.BYTE	$24
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $B2
	.BYTE 0
	.BYTE $24
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $B2
	.BYTE 5
	.BYTE $24
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $B2
	.BYTE $A
	.BYTE $26
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $B2
	.BYTE $F
	.BYTE $24
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $B2
	.BYTE $14
	.BYTE $24
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $B2
	.BYTE $19
	.BYTE $24
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $B2
	.BYTE $1E
	.BYTE $26
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $B2
	.BYTE $23
	.BYTE $F
	.BYTE $F4
	.BYTE $B3
	.BYTE $28
	.BYTE $BF
	.BYTE 0
byte_D124:
	.BYTE	$32
	.BYTE $F5
	.BYTE $32
	.BYTE $F1
	.BYTE $31
	.BYTE $F1
	.BYTE $31
	.BYTE $F1
	.BYTE $31
	.BYTE $F1
	.BYTE $32
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $32
	.BYTE $F1
	.BYTE $31
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $29
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $31
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $32
	.BYTE $F5
	.BYTE $32
	.BYTE $F1
	.BYTE $31
	.BYTE $F1
	.BYTE $31
	.BYTE $F1
	.BYTE $31
	.BYTE $F1
	.BYTE $32
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $32
	.BYTE $F1
	.BYTE $31
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $29
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $31
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $27
	.BYTE $F1
	.BYTE $B4
	.BYTE $1C
	.BYTE $F
	.BYTE $F1
	.BYTE $29
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $29
	.BYTE $F1
	.BYTE $27
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $A0
	.BYTE $DF
	.BYTE $29
	.BYTE $F3
	.BYTE $29
	.BYTE $F1
	.BYTE $F
	.BYTE $F5
	.BYTE $F
	.BYTE $F3
	.BYTE $FF
byte_D177:
	.BYTE	$26
	.BYTE $F5
	.BYTE $26
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $26
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $26
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $22
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $26
	.BYTE $F5
	.BYTE $26
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $26
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $26
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $22
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $B4
	.BYTE $1C
	.BYTE $F
	.BYTE $F1
	.BYTE $26
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $26
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $A0
	.BYTE $DF
	.BYTE $26
	.BYTE $F3
	.BYTE $26
	.BYTE $F1
	.BYTE $F
	.BYTE $F5
	.BYTE $F
	.BYTE $F3
	.BYTE $FF
byte_D1CA:
	.BYTE	$22
	.BYTE $F1
	.BYTE $32
	.BYTE $F1
	.BYTE $BE
	.BYTE 0
	.BYTE $29
	.BYTE $F1
	.BYTE $B4
	.BYTE 3
	.BYTE $F
	.BYTE $F1
	.BYTE $32
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $32
	.BYTE $F1
	.BYTE $29
	.BYTE $F1
	.BYTE $F
	.BYTE $F1
	.BYTE $32
	.BYTE $F3
	.BYTE $32
	.BYTE $F1
	.BYTE $F
	.BYTE $F5
	.BYTE $F
	.BYTE $F3
	.BYTE $FF
byte_D1E9:
	.BYTE	$19
	.BYTE $F1
	.BYTE $19
	.BYTE $F1
	.BYTE $22
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $26
	.BYTE $F1
	.BYTE $27
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $24
	.BYTE $F1
	.BYTE $29
	.BYTE $EF
	.BYTE $29
	.BYTE $F0
	.BYTE $29
	.BYTE $F2
	.BYTE $29
	.BYTE $F1
	.BYTE $26
	.BYTE $F1
	.BYTE $2B
	.BYTE $F1
	.BYTE $27
	.BYTE $F1
	.BYTE $29
	.BYTE $F0
	.BYTE $29
	.BYTE $F0
	.BYTE $27
	.BYTE $F1
	.BYTE $27
	.BYTE $F1
	.BYTE $29
	.BYTE $F1
	.BYTE $A0
	.BYTE $DF
	.BYTE $32
	.BYTE $F3
	.BYTE $32
	.BYTE $F1
	.BYTE $FF
byte_D21A:
	.BYTE	$16
	.BYTE $F1
	.BYTE $16
	.BYTE $F1
	.BYTE $16
	.BYTE $F1
	.BYTE $20
	.BYTE $F1
	.BYTE $20
	.BYTE $F1
	.BYTE $22
	.BYTE $F1
	.BYTE $24
	.BYTE $F0
	.BYTE $22
	.BYTE $F0
	.BYTE $20
	.BYTE $F1
	.BYTE $26
	.BYTE $EF
	.BYTE $26
	.BYTE $F0
	.BYTE $26
	.BYTE $F2
	.BYTE $26
	.BYTE $F1
	.BYTE $22
	.BYTE $F1
	.BYTE $22
	.BYTE $F1
	.BYTE $1B
	.BYTE $F1
	.BYTE $26
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $24
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $26
	.BYTE $F1
	.BYTE $A0
	.BYTE $DF
	.BYTE $26
	.BYTE $F3
	.BYTE $26
	.BYTE $F1
	.BYTE $FF
byte_D24B:
	.BYTE	$22
	.BYTE $F1
	.BYTE $BA
	.BYTE 0
	.BYTE $24
	.BYTE $F1
	.BYTE $22
	.BYTE $F1
	.BYTE $17
	.BYTE $F1
	.BYTE $17
	.BYTE $F1
	.BYTE $22
	.BYTE $F1
	.BYTE $19
	.BYTE $F1
	.BYTE $19
	.BYTE $F1
	.BYTE $22
	.BYTE $F1
	.BYTE $22
	.BYTE $F3
	.BYTE $22
	.BYTE $F1
	.BYTE $FF
byte_D264:
	.BYTE	$2B
	.BYTE $F1
	.BYTE $2B
	.BYTE $F1
	.BYTE $A0
	.BYTE $CC
	.BYTE $29
	.BYTE $F0
	.BYTE $29
	.BYTE $F0
	.BYTE $29
	.BYTE $F0
	.BYTE $29
	.BYTE $F0
	.BYTE $A0
	.BYTE $C2
	.BYTE $27
	.BYTE $F1
	.BYTE $27
	.BYTE $F1
	.BYTE $26
	.BYTE $F1
	.BYTE $26
	.BYTE $F1
	.BYTE $B0
	.BYTE 0
	.BYTE $A0
	.BYTE $CC
	.BYTE $F
	.BYTE $FB
	.BYTE $24
	.BYTE $E3
	.BYTE $2B
	.BYTE $E3
	.BYTE $34
	.BYTE $E3
	.BYTE $3B
	.BYTE $E3
	.BYTE $44
	.BYTE $E3
	.BYTE $3B
	.BYTE $E3
	.BYTE $34
	.BYTE $E3
	.BYTE $2B
	.BYTE $E3
	.BYTE $F
	.BYTE $FA
	.BYTE $FF
byte_D295:
	.BYTE	$27
	.BYTE $F1
	.BYTE $27
	.BYTE $F1
	.BYTE $A0
	.BYTE $CC
	.BYTE $26
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $A0
	.BYTE $C2
	.BYTE $24
	.BYTE $F1
	.BYTE $24
	.BYTE $F1
	.BYTE $23
	.BYTE $F1
	.BYTE $23
	.BYTE $F1
	.BYTE $B0
	.BYTE 0
	.BYTE $A0
	.BYTE $CC
	.BYTE $F
	.BYTE $FA
	.BYTE $14
	.BYTE $E3
	.BYTE $1B
	.BYTE $E3
	.BYTE $24
	.BYTE $E3
	.BYTE $2B
	.BYTE $E3
	.BYTE $34
	.BYTE $E3
	.BYTE $2B
	.BYTE $E3
	.BYTE $24
	.BYTE $E3
	.BYTE $1B
	.BYTE $E3
	.BYTE $B0
	.BYTE $F
	.BYTE $F
	.BYTE $FA
	.BYTE $FF
byte_D2C8:
	.BYTE	$44
	.BYTE $F1
	.BYTE $44
	.BYTE $F1
	.BYTE $42
	.BYTE $F0
	.BYTE $42
	.BYTE $F0
	.BYTE $42
	.BYTE $F0
	.BYTE $42
	.BYTE $F0
	.BYTE $40
	.BYTE $F1
	.BYTE $40
	.BYTE $F1
	.BYTE $3B
	.BYTE $F1
	.BYTE $3B
	.BYTE $F1
	.BYTE $B0
	.BYTE 0
	.BYTE $24
	.BYTE $E3
	.BYTE $2B
	.BYTE $E3
	.BYTE $34
	.BYTE $E3
	.BYTE $3B
	.BYTE $E3
	.BYTE $44
	.BYTE $E3
	.BYTE $3B
	.BYTE $E3
	.BYTE $34
	.BYTE $E3
	.BYTE $2B
	.BYTE $E3
	.BYTE $B1
	.BYTE $B
	.BYTE $24
	.BYTE $E3
	.BYTE $B6
	.BYTE $14
	.BYTE $FF
byte_D2F5:
	.BYTE	$F
	.BYTE $F2
	.BYTE $2B
	.BYTE $F0
	.BYTE $29
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $F
	.BYTE $EF
	.BYTE $14
	.BYTE $F0
	.BYTE $F
	.BYTE $EF
	.BYTE $FF
byte_D310:
	.BYTE	$F
	.BYTE $F2
	.BYTE $27
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $23
	.BYTE $F0
	.BYTE $F
	.BYTE $F3
	.BYTE 4
	.BYTE $F0
	.BYTE $F
	.BYTE $EF
	.BYTE $FF
byte_D321:
	.BYTE	$25
	.BYTE $F0
	.BYTE $28
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $2A
	.BYTE $F0
	.BYTE $F
	.BYTE $F1
	.BYTE $31
	.BYTE $F0
	.BYTE $31
	.BYTE $F0
	.BYTE $31
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $BF
	.BYTE 8
	.BYTE $FF
byte_D336:
	.BYTE	$23
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $25
	.BYTE $F0
	.BYTE $28
	.BYTE $F0
	.BYTE $F
	.BYTE $F1
	.BYTE $2B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $BF
	.BYTE 8
	.BYTE $FF
byte_D34B:
	.BYTE	$22
	.BYTE $F0
	.BYTE $25
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $F
	.BYTE $F1
	.BYTE $2A
	.BYTE $F0
	.BYTE $2A
	.BYTE $F0
	.BYTE $2A
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $BF
	.BYTE 8
	.BYTE $FF
byte_D360:
	.BYTE	$25
	.BYTE $F0
	.BYTE $28
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $2A
	.BYTE $F0
	.BYTE $F
	.BYTE $F1
	.BYTE $31
	.BYTE $F0
	.BYTE $31
	.BYTE $F0
	.BYTE $31
	.BYTE $F0
	.BYTE $FF
byte_D371:
	.BYTE	$23
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $25
	.BYTE $F0
	.BYTE $28
	.BYTE $F0
	.BYTE $F
	.BYTE $F1
	.BYTE $2B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $FF
byte_D382:
	.BYTE	$22
	.BYTE $F0
	.BYTE $25
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $27
	.BYTE $F0
	.BYTE $F
	.BYTE $F1
	.BYTE $2A
	.BYTE $F0
	.BYTE $2A
	.BYTE $F0
	.BYTE $2A
	.BYTE $F0
	.BYTE $FF
byte_D393:
	.BYTE	$29
	.BYTE $F0
	.BYTE $29
	.BYTE $F0
	.BYTE $2B
	.BYTE $F0
	.BYTE $29
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $FF
byte_D3A4:
	.BYTE	$26
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $28
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $29
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $29
	.BYTE $F0
	.BYTE $FF
byte_D3B5:
	.BYTE	$22
	.BYTE $F0
	.BYTE $22
	.BYTE $F0
	.BYTE $24
	.BYTE $F0
	.BYTE $22
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $26
	.BYTE $F0
	.BYTE $FF
byte_D3C6:
	.BYTE	$37
	.BYTE $EF
	.BYTE $37
	.BYTE $F0
	.BYTE $35
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $37
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $FF
byte_D3D3:
	.BYTE	$34
	.BYTE $EF
	.BYTE $34
	.BYTE $F0
	.BYTE $32
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $34
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $FF
byte_D3E0:
	.BYTE	$30
	.BYTE $EF
	.BYTE $30
	.BYTE $F0
	.BYTE $2A
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $30
	.BYTE $F0
	.BYTE $F
	.BYTE $F0
	.BYTE $FF
