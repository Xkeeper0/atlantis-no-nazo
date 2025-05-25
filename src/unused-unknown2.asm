UnknownData_FFAD:
    .BYTE $77,  2,$FF,$FE		     ; Not marked as read in CDL
    .BYTE   2,$FF,  2,$FE		; 4
    .BYTE   2,$FF,  2,$FF		; 8
    .BYTE   2,$FF,$12,$FF		; 12
    .BYTE   0,$7F,  2,	2		; 16
    .BYTE $FE,$2A,$FE,	2		; 20
    .BYTE $FE,	2,$FE,	2		; 24
    .BYTE $FE,	2,$FF,	2		; 28
    .BYTE $FE,	2,$FF,$FE		; 32
    .BYTE   2,$FE,  2,$FE		; 36
    .BYTE   2,$FE,  2,$7F		; 40
    .BYTE   2,$7E,  2,$FF		; 44
    .BYTE   2,$FE,  2,$82		; 48
    .BYTE $FF,$52,$7F,	2		; 52
    .BYTE $FF,	2,$FE,$82		; 56
    .BYTE $FF, $A,$FF,	2		; 60
    .BYTE $7F,$52,$F7,$77		; 64
    .BYTE   2,$FF,$10,$FE		; 68
    .BYTE   2,$FE,  2,$FF		; 72
