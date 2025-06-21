
	;.segment RAM
PPUCtrl:
	.dsb 1	                     ; $0000
PPUMask:
	.dsb 1	                     ; $0001
byte_2:
	.dsb 1                      ; $0002
byte_3:
	.dsb 1                      ; $0003
byte_4:
	.dsb 1                      ; $0004
PPUScrollY:
	.dsb 1                      ; $0005
byte_6:
	.dsb 1                      ; $0006
byte_7:
	.dsb 1                      ; $0007
byte_8:
	.dsb 1                      ; $0008
PPUScrollX:
	.dsb 1                      ; $0009
CurrentCHRBanks:
	.dsb 1	                     ; $000a
APUSoundChn:
	.dsb 1                      ; $000b
	.dsb 1                      ; $000c
	.dsb 1                      ; $000d
byte_E:
	.dsb 1                      ; $000e
byte_F:
	.dsb 1                      ; $000f
byte_10:
	.dsb 1	                     ; $0010
byte_11:
	.dsb 1	                     ; $0011
byte_12:
	.dsb 1	                     ; $0012
byte_13:
	.dsb 1	                     ; $0013
word_14:
	.dsb 2                      ; $0014
word_16:
	.dsb 2                      ; $0016
word_18:
	.dsb 2                      ; $0018
word_1A:
	.dsb 2                      ; $001a
word_1C:
	.dsb 2                      ; $001c
word_1E:
	.dsb 2                      ; $001e
byte_20:
	.dsb 1	                     ; $0020
byte_21:
	.dsb 1	                     ; $0021
byte_22:
	.dsb 1	                     ; $0022
byte_23:
	.dsb 1	                     ; $0023
byte_24:
	.dsb 1	                     ; $0024
byte_25:
	.dsb 1	                     ; $0025
byte_26:
	.dsb 1	                     ; $0026
byte_27:
	.dsb 1	                     ; $0027
byte_28:
	.dsb 1	                     ; $0028
byte_29:
	.dsb 1	                     ; $0029
byte_2A:
	.dsb 1	                     ; $002a
byte_2B:
	.dsb 1	                     ; $002b
byte_2C:
	.dsb 1	                     ; $002c
byte_2D:
	.dsb 1	                     ; $002d
byte_2E:
	.dsb 1	                     ; $002e
byte_2F:
	.dsb 1	                     ; $002f

SoundRamArea: ; $40 bytes total
InstLoPtr:
	.dsb 6                      ; $0030
InstHiPtr:
	.dsb 6                      ; $0036
InstChannel:
	.dsb 6                      ; $003c
InstCursor:
	.dsb 6                      ; $0042
InstReg1:
	.dsb 6                      ; $0048
InstReg0:
	.dsb 6                      ; $004e
InstTimer:
	.dsb 6                      ; $0054
InstLoop:
	.dsb 6                      ; $005a
InstCtrlRegsChanged:
	.dsb 6                      ; $0060
InstUnused:
	.dsb 6                      ; $0066
ChannelsInUse:
	.dsb 4                      ; $006c

	.dsb 1                      ; $0070
	.dsb 1                      ; $0071
	.dsb 1                      ; $0072
	.dsb 1                      ; $0073
	.dsb 1                      ; $0074
	.dsb 1                      ; $0075
	.dsb 1                      ; $0076
	.dsb 1                      ; $0077
	.dsb 1                      ; $0078
	.dsb 1                      ; $0079
	.dsb 1                      ; $007a
	.dsb 1                      ; $007b
	.dsb 1                      ; $007c
	.dsb 1                      ; $007d
	.dsb 1                      ; $007e
	.dsb 1                      ; $007f
	.dsb 1                      ; $0080
	.dsb 1                      ; $0081
	.dsb 1                      ; $0082
	.dsb 1                      ; $0083
unk_84:
	.dsb 1                      ; $0084
	.dsb 1                      ; $0085
	.dsb 1                      ; $0086
	.dsb 1                      ; $0087
	.dsb 1                      ; $0088
	.dsb 1                      ; $0089
	.dsb 1                      ; $008a
	.dsb 1                      ; $008b
	.dsb 1                      ; $008c
	.dsb 1                      ; $008d
	.dsb 1                      ; $008e
	.dsb 1                      ; $008f
	.dsb 1                      ; $0090
	.dsb 1                      ; $0091
	.dsb 1                      ; $0092
	.dsb 1                      ; $0093
	.dsb 1                      ; $0094
	.dsb 1                      ; $0095
	.dsb 1                      ; $0096
	.dsb 1                      ; $0097
	.dsb 1                      ; $0098
	.dsb 1                      ; $0099
	.dsb 1                      ; $009a
	.dsb 1                      ; $009b
	.dsb 1                      ; $009c
	.dsb 1                      ; $009d
	.dsb 1                      ; $009e
	.dsb 1                      ; $009f
byte_A0:
	.dsb 1	                     ; $00a0
byte_A1:
	.dsb 1	                     ; $00a1
word_A2:
	.dsb 2                      ; $00a2
byte_A4:
	.dsb 1	                     ; $00a4
byte_A5:
	.dsb 1	                     ; $00a5
byte_A6:
	.dsb 1	                     ; $00a6
byte_A7:
	.dsb 1	                     ; $00a7
byte_A8:
	.dsb 1	                     ; $00a8
	.dsb 1                      ; $00a9
	.dsb 1                      ; $00aa
byte_AB:
	.dsb 1	                     ; $00ab
byte_AC:
	.dsb 1	                     ; $00ac
byte_AD:
	.dsb 1	                     ; $00ad
	.dsb 1                      ; $00ae
	.dsb 1                      ; $00af
byte_B0:
	.dsb 1	                     ; $00b0
byte_B1:
	.dsb 1	                     ; $00b1
byte_B2:
	.dsb 1	                     ; $00b2
byte_B3:
	.dsb 1	                     ; $00b3
byte_B4:
	.dsb 1	                     ; $00b4
byte_B5:
	.dsb 1	                     ; $00b5
byte_B6:
	.dsb 1	                     ; $00b6
byte_B7:
	.dsb 1	                     ; $00b7
word_B8:
	.dsb 2                      ; $00b8
CurrentZoneBlockPointer:
	.dsb 2                      ; $00ba
byte_BC:
	.dsb 1	                     ; $00bc
byte_BD:
	.dsb 1	                     ; $00bd
byte_BE:
	.dsb 1	                     ; $00be
byte_BF:
	.dsb 1	                     ; $00bf
unk_C0:
	.dsb 1                      ; $00c0
unk_C1:
	.dsb 1                      ; $00c1
	.dsb 1                      ; $00c2
	.dsb 1                      ; $00c3
	.dsb 1                      ; $00c4
	.dsb 1                      ; $00c5
	.dsb 1                      ; $00c6
	.dsb 1                      ; $00c7
	.dsb 1                      ; $00c8
	.dsb 1                      ; $00c9
	.dsb 1                      ; $00ca
	.dsb 1                      ; $00cb
	.dsb 1                      ; $00cc
	.dsb 1                      ; $00cd
	.dsb 1                      ; $00ce
	.dsb 1                      ; $00cf
	.dsb 1                      ; $00d0
	.dsb 1                      ; $00d1
	.dsb 1                      ; $00d2
	.dsb 1                      ; $00d3
	.dsb 1                      ; $00d4
	.dsb 1                      ; $00d5
	.dsb 1                      ; $00d6
	.dsb 1                      ; $00d7
	.dsb 1                      ; $00d8
	.dsb 1                      ; $00d9
	.dsb 1                      ; $00da
	.dsb 1                      ; $00db
	.dsb 1                      ; $00dc
	.dsb 1                      ; $00dd
	.dsb 1                      ; $00de
	.dsb 1                      ; $00df
unk_E0:
	.dsb 1                      ; $00e0
unk_E1:
	.dsb 1                      ; $00e1
	.dsb 1                      ; $00e2
	.dsb 1                      ; $00e3
	.dsb 1                      ; $00e4
	.dsb 1                      ; $00e5
	.dsb 1                      ; $00e6
	.dsb 1                      ; $00e7
	.dsb 1                      ; $00e8
	.dsb 1                      ; $00e9
	.dsb 1                      ; $00ea
	.dsb 1                      ; $00eb
	.dsb 1                      ; $00ec
	.dsb 1                      ; $00ed
	.dsb 1                      ; $00ee
	.dsb 1                      ; $00ef
	.dsb 1                      ; $00f0
	.dsb 1                      ; $00f1
	.dsb 1                      ; $00f2
	.dsb 1                      ; $00f3
	.dsb 1                      ; $00f4
	.dsb 1                      ; $00f5
	.dsb 1                      ; $00f6
	.dsb 1                      ; $00f7
	.dsb 1                      ; $00f8
	.dsb 1                      ; $00f9
	.dsb 1                      ; $00fa
	.dsb 1                      ; $00fb
	.dsb 1                      ; $00fc
	.dsb 1                      ; $00fd
	.dsb 1                      ; $00fe
	.dsb 1                      ; $00ff
	.dsb 1                      ; $0100
	.dsb 1                      ; $0101
	.dsb 1                      ; $0102
	.dsb 1                      ; $0103
	.dsb 1                      ; $0104
	.dsb 1                      ; $0105
	.dsb 1                      ; $0106
	.dsb 1                      ; $0107
	.dsb 1                      ; $0108
	.dsb 1                      ; $0109
	.dsb 1                      ; $010a
	.dsb 1                      ; $010b
	.dsb 1                      ; $010c
	.dsb 1                      ; $010d
	.dsb 1                      ; $010e
	.dsb 1                      ; $010f
	.dsb 1                      ; $0110
	.dsb 1                      ; $0111
	.dsb 1                      ; $0112
	.dsb 1                      ; $0113
	.dsb 1                      ; $0114
	.dsb 1                      ; $0115
	.dsb 1                      ; $0116
	.dsb 1                      ; $0117
	.dsb 1                      ; $0118
	.dsb 1                      ; $0119
	.dsb 1                      ; $011a
	.dsb 1                      ; $011b
	.dsb 1                      ; $011c
	.dsb 1                      ; $011d
	.dsb 1                      ; $011e
	.dsb 1                      ; $011f
	.dsb 1                      ; $0120
	.dsb 1                      ; $0121
	.dsb 1                      ; $0122
	.dsb 1                      ; $0123
	.dsb 1                      ; $0124
	.dsb 1                      ; $0125
	.dsb 1                      ; $0126
	.dsb 1                      ; $0127
	.dsb 1                      ; $0128
	.dsb 1                      ; $0129
	.dsb 1                      ; $012a
	.dsb 1                      ; $012b
	.dsb 1                      ; $012c
	.dsb 1                      ; $012d
	.dsb 1                      ; $012e
	.dsb 1                      ; $012f
	.dsb 1                      ; $0130
	.dsb 1                      ; $0131
	.dsb 1                      ; $0132
	.dsb 1                      ; $0133
	.dsb 1                      ; $0134
	.dsb 1                      ; $0135
	.dsb 1                      ; $0136
	.dsb 1                      ; $0137
	.dsb 1                      ; $0138
	.dsb 1                      ; $0139
	.dsb 1                      ; $013a
	.dsb 1                      ; $013b
	.dsb 1                      ; $013c
	.dsb 1                      ; $013d
	.dsb 1                      ; $013e
	.dsb 1                      ; $013f
byte_140:
	.dsb 1                      ; $0140
byte_141:
	.dsb 1                      ; $0141
	.dsb 1                      ; $0142
	.dsb 1                      ; $0143
	.dsb 1                      ; $0144
	.dsb 1                      ; $0145
	.dsb 1                      ; $0146
	.dsb 1                      ; $0147
UnknownTimer0148:
	.dsb 1                      ; $0148
PauseCooldownTimer:
	.dsb 1                      ; $0149
					; Can't pause while non-zero
UnknownTimer014A:
	.dsb 1                      ; $014a
UnknownTimer014B:
	.dsb 1                      ; $014b
	.dsb 1                      ; $014c
	.dsb 1                      ; $014d
	.dsb 1                      ; $014e
	.dsb 1                      ; $014f
NMIWaitFlag:
	.dsb 1                      ; $0150
DemoActive:
	.dsb 1                      ; $0151
					; Nonzero = demo inputs	active
GamePaused:
	.dsb 1                      ; $0152
					; Nonzero = paused, game sets FF
	.dsb 1                      ; $0153
	.dsb 1                      ; $0154
byte_155:
	.dsb 1                      ; $0155
PaletteUpdateRequest:
	.dsb 1                      ; $0156
					; Nonzero when palettes	need updating
NametableUpdateRequest:
	.dsb 1                      ; $0157
					; Maybe	wrong, but causes updates to PPU data when nonzero
	.dsb 1                      ; $0158
byte_159:
	.dsb 1                      ; $0159
byte_15A:
	.dsb 1                      ; $015a
DemoCounter:
	.dsb 1                      ; $015b
					; Goes up by 1 when the	demo starts playing, used to pick doors
Cheat_P2APresses:
	.dsb 1                      ; $015c
Cheat_P1BPresses:
	.dsb 1                      ; $015d
Cheat_SelectPresses:
	.dsb 1                      ; $015e
Cheat_LastPress:
	.dsb 1	                     ; $015f
	.dsb 1                      ; $0160
	.dsb 1                      ; $0161
	.dsb 1                      ; $0162
	.dsb 1                      ; $0163
	.dsb 1                      ; $0164
	.dsb 1                      ; $0165
	.dsb 1                      ; $0166
	.dsb 1                      ; $0167
	.dsb 1                      ; $0168
	.dsb 1                      ; $0169
	.dsb 1                      ; $016a
	.dsb 1                      ; $016b
	.dsb 1                      ; $016c
	.dsb 1                      ; $016d
	.dsb 1                      ; $016e
	.dsb 1                      ; $016f
	.dsb 1                      ; $0170
	.dsb 1                      ; $0171
	.dsb 1                      ; $0172
	.dsb 1                      ; $0173
	.dsb 1                      ; $0174
	.dsb 1                      ; $0175
	.dsb 1                      ; $0176
	.dsb 1                      ; $0177
	.dsb 1                      ; $0178
	.dsb 1                      ; $0179
	.dsb 1                      ; $017a
	.dsb 1                      ; $017b
	.dsb 1                      ; $017c
	.dsb 1                      ; $017d
	.dsb 1                      ; $017e
	.dsb 1                      ; $017f
HighScore:
	.dsb 1                      ; $0180
	.dsb 1 ; 1 ; Same deal	with Score here	-- the first byte ; $0181
	.dsb 1 ; 2 ; doesn't seem to actually track the score ; $0182
	.dsb 1 ; 3                  ; $0183
	.dsb 1 ; 4                  ; $0184
	.dsb 1 ; 5                  ; $0185
	.dsb 1 ; 6                  ; $0186
	.dsb 1 ; 7                  ; $0187
SoftResetSentinel:
	.dsb 1                      ; $0188
	.dsb 1 ; 1                  ; $0189
	.dsb 1                      ; $018a
	.dsb 1                      ; $018b
	.dsb 1                      ; $018c
	.dsb 1                      ; $018d
	.dsb 1                      ; $018e
	.dsb 1                      ; $018f
GotEndingGem:
	.dsb 1                      ; $0190
DebugFlag_InfiniteLives:
	.dsb 1	                     ; $0191
CurrentZone:
	.dsb 1                      ; $0192
	.dsb 1                      ; $0193
PlayerLives:
	.dsb 1                      ; $0194
	.dsb 1                      ; $0195
LastDoorEntered:
	.dsb 1	                     ; $0196
	.dsb 1                      ; $0197
	.dsb 1                      ; $0198
	.dsb 1                      ; $0199
byte_19A:
	.dsb 1                      ; $019a
	.dsb 1                      ; $019b
PlayerChestsOpened:
	.dsb 1                      ; $019c
					; Count	of chests opened, shown	on game	over
byte_19D:
	.dsb 1                      ; $019d
DebugFlag_ZoneSkipNumber:
	.dsb 1 ;	DATA XREF: BANK0:819Ar ; $019e
DebugFlag_ZoneSkip:
	.dsb 1                      ; $019f
byte_1A0:
	.dsb 1                      ; $01a0
	.dsb 1                      ; $01a1
	.dsb 1                      ; $01a2
	.dsb 1                      ; $01a3
	.dsb 1                      ; $01a4
	.dsb 1                      ; $01a5
	.dsb 1                      ; $01a6
	.dsb 1                      ; $01a7
	.dsb 1                      ; $01a8
	.dsb 1                      ; $01a9
	.dsb 1                      ; $01aa
	.dsb 1                      ; $01ab
	.dsb 1                      ; $01ac
	.dsb 1                      ; $01ad
	.dsb 1                      ; $01ae
	.dsb 1                      ; $01af
PlayerScore:
	.dsb 1                      ; $01b0
	.dsb 1 ; 1 ; $01B0 Seems to be	used interchangably as part of the score ; $01b1
	.dsb 1 ; 2 ; or as a flag in some places ; $01b2
	.dsb 1 ; 3 ; if $01B0 is non-zero, score will not be added ; $01b3
	.dsb 1 ; 4 ;                ; $01b4
	.dsb 1 ; 5 ; $01B1 is seven or	so bytes for tracking the player's score ; $01b5
	.dsb 1 ; 6 ; Sometimes	addressed as if	the first byte is $01B0, ; $01b6
	.dsb 1 ; 7 ; but only $01B1-$01B7 are displayed ; $01b7
byte_1B8:
	.dsb 1                      ; $01b8
	.dsb 1                      ; $01b9
	.dsb 1                      ; $01ba
	.dsb 1                      ; $01bb
	.dsb 1                      ; $01bc
	.dsb 1                      ; $01bd
	.dsb 1                      ; $01be
	.dsb 1                      ; $01bf
byte_1C0:
	.dsb 1                      ; $01c0
byte_1C1:
	.dsb 1                      ; $01c1
TriggerZoneChange:
	.dsb 1                      ; $01c2
					; If nonzero, will go to next zone screen based	on LastDoorEntered
byte_1C3:
	.dsb 1                      ; $01c3
byte_1C4:
	.dsb 1                      ; $01c4
byte_1C5:
	.dsb 1                      ; $01c5
byte_1C6:
	.dsb 1                      ; $01c6
ZoneTimerTickDelay:
	.dsb 1                      ; $01c7
byte_1C8:
	.dsb 1                      ; $01c8
byte_1C9:
	.dsb 1                      ; $01c9
byte_1CA:
	.dsb 1                      ; $01ca
byte_1CB:
	.dsb 1                      ; $01cb
	.dsb 1                      ; $01cc
	.dsb 1                      ; $01cd
	.dsb 1                      ; $01ce
	.dsb 1                      ; $01cf
ZoneTimer:
	.dsb 1                      ; $01d0
	.dsb 1 ; 1                  ; $01d1
	.dsb 1 ; 2                  ; $01d2
	.dsb 1                      ; $01d3
	.dsb 1                      ; $01d4
	.dsb 1                      ; $01d5
	.dsb 1                      ; $01d6
	.dsb 1                      ; $01d7
	.dsb 1                      ; $01d8
	.dsb 1                      ; $01d9
byte_1DA:
	.dsb 1                      ; $01da
	.dsb 1                      ; $01db
	.dsb 1                      ; $01dc
	.dsb 1                      ; $01dd
CurrentZoneASM:
	.dsb 2                      ; $01de
PaletteData:
	.dsb 1                      ; $01e0
	.dsb 1 ; 1                  ; $01e1
	.dsb 1 ; 2                  ; $01e2
	.dsb 1 ; 3                  ; $01e3
	.dsb 1 ; 4                  ; $01e4
	.dsb 1 ; 5                  ; $01e5
	.dsb 1 ; 6                  ; $01e6
	.dsb 1 ; 7                  ; $01e7
	.dsb 1 ; 8                  ; $01e8
	.dsb 1 ; 9                  ; $01e9
	.dsb 1 ; 10                 ; $01ea
	.dsb 1 ; 11                 ; $01eb
	.dsb 1 ; 12                 ; $01ec
	.dsb 1 ; 13                 ; $01ed
	.dsb 1 ; 14                 ; $01ee
	.dsb 1 ; 15                 ; $01ef
	.dsb 1 ; 16                 ; $01f0
	.dsb 1 ; 17                 ; $01f1
	.dsb 1 ; 18                 ; $01f2
	.dsb 1 ; 19                 ; $01f3
	.dsb 1 ; 20                 ; $01f4
	.dsb 1 ; 21                 ; $01f5
	.dsb 1 ; 22                 ; $01f6
	.dsb 1 ; 23                 ; $01f7
	.dsb 1 ; 24                 ; $01f8
	.dsb 1 ; 25                 ; $01f9
	.dsb 1 ; 26                 ; $01fa
	.dsb 1 ; 27                 ; $01fb
	.dsb 1 ; 28                 ; $01fc
	.dsb 1 ; 29                 ; $01fd
	.dsb 1 ; 30                 ; $01fe
	.dsb 1 ; 31                 ; $01ff
Joypad1_Held:
	.dsb 1                      ; $0200
Joypad2_Held:
	.dsb 1                      ; $0201
Joypad1_Previous:
	.dsb 1                      ; $0202
Joypad2_Previous:
	.dsb 1                      ; $0203
Joypad1_Immediate:
	.dsb 1                      ; $0204
					; Buttons pushed this frame only
Joypad2_Immediate:
	.dsb 1                      ; $0205
					; Buttons pushed this frame only
Joypad_Held:
	.dsb 1                      ; $0206
					; Buttons pressed (either controller)
Joypad_Immediate:
	.dsb 1                      ; $0207
					; Buttons pushed this frame only (either controller)
JoypadMic_Current:
	.dsb 1                      ; $0208
JoypadMic_Previous:
	.dsb 1                      ; $0209
	.dsb 1                      ; $020a
	.dsb 1                      ; $020b
	.dsb 1                      ; $020c
	.dsb 1                      ; $020d
	.dsb 1                      ; $020e
	.dsb 1                      ; $020f
PlayerX:
	.dsb 1	                     ; $0210
PlayerXLo:
	.dsb 1                      ; $0211
PlayerY:
	.dsb 1	                     ; $0212
PlayerYLo:
	.dsb 1                      ; $0213
byte_214:
	.dsb 1                      ; $0214
byte_215:
	.dsb 1                      ; $0215
PlayerState:
	.dsb 1                      ; $0216
ProbablyZoneStatusShit:
	.dsb 1                      ; $0217
					; 01 = ice physics, 80 = ???
byte_218:
	.dsb 1                      ; $0218
byte_219:
	.dsb 1                      ; $0219
byte_21A:
	.dsb 1                      ; $021a
	.dsb 1                      ; $021b
PlayerSpeedX:
	.dsb 1                      ; $021c
	.dsb 1                      ; $021d
	.dsb 1                      ; $021e
byte_21F:
	.dsb 1                      ; $021f
byte_220:
	.dsb 1                      ; $0220
	.dsb 1                      ; $0221
	.dsb 1                      ; $0222
	.dsb 1                      ; $0223
	.dsb 1                      ; $0224
	.dsb 1                      ; $0225
	.dsb 1                      ; $0226
	.dsb 1                      ; $0227
	.dsb 1                      ; $0228
	.dsb 1                      ; $0229
	.dsb 1                      ; $022a
	.dsb 1                      ; $022b
	.dsb 1                      ; $022c
	.dsb 1                      ; $022d
	.dsb 1                      ; $022e
	.dsb 1                      ; $022f
unk_230:
	.dsb 1                      ; $0230
unk_231:
	.dsb 1                      ; $0231
unk_232:
	.dsb 1                      ; $0232
	.dsb 1                      ; $0233
unk_234:
	.dsb 1                      ; $0234
unk_235:
	.dsb 1                      ; $0235
unk_236:
	.dsb 1                      ; $0236
unk_237:
	.dsb 1                      ; $0237
	.dsb 1                      ; $0238
	.dsb 1                      ; $0239
	.dsb 1                      ; $023a
	.dsb 1                      ; $023b
	.dsb 1                      ; $023c
	.dsb 1                      ; $023d
	.dsb 1                      ; $023e
	.dsb 1                      ; $023f
	.dsb 1                      ; $0240
	.dsb 1                      ; $0241
	.dsb 1                      ; $0242
	.dsb 1                      ; $0243
	.dsb 1                      ; $0244
	.dsb 1                      ; $0245
	.dsb 1                      ; $0246
	.dsb 1                      ; $0247
	.dsb 1                      ; $0248
	.dsb 1                      ; $0249
	.dsb 1                      ; $024a
	.dsb 1                      ; $024b
	.dsb 1                      ; $024c
	.dsb 1                      ; $024d
	.dsb 1                      ; $024e
	.dsb 1                      ; $024f
ZoneDoors:
	.dsb 1                      ; $0250
	.dsb 1 ; 1                  ; $0251
	.dsb 1 ; 2                  ; $0252
	.dsb 1 ; 3                  ; $0253
	.dsb 1 ; 4                  ; $0254
	.dsb 1 ; 5                  ; $0255
	.dsb 1 ; 6                  ; $0256
	.dsb 1 ; 7                  ; $0257
	.dsb 1 ; 8                  ; $0258
	.dsb 1 ; 9                  ; $0259
	.dsb 1 ; $A                 ; $025a
	.dsb 1 ; $B                 ; $025b
	.dsb 1 ; $C                 ; $025c
	.dsb 1 ; $D                 ; $025d
	.dsb 1 ; $E                 ; $025e
	.dsb 1 ; $F                 ; $025f
byte_260:
	.dsb 1                      ; $0260
byte_261:
	.dsb 1                      ; $0261
byte_262:
	.dsb 1                      ; $0262
byte_263:
	.dsb 1                      ; $0263
byte_264:
	.dsb 1                      ; $0264
byte_265:
	.dsb 1                      ; $0265
byte_266:
	.dsb 1                      ; $0266
byte_267:
	.dsb 1                      ; $0267
byte_268:
	.dsb 1                      ; $0268
byte_269:
	.dsb 1                      ; $0269
byte_26A:
	.dsb 1                      ; $026a
byte_26B:
	.dsb 1                      ; $026b
	.dsb 1                      ; $026c
	.dsb 1                      ; $026d
byte_26E:
	.dsb 1                      ; $026e
byte_26F:
	.dsb 1                      ; $026f
	.dsb 1                      ; $0270
	.dsb 1                      ; $0271
	.dsb 1                      ; $0272
	.dsb 1                      ; $0273
byte_274:
	.dsb 1                      ; $0274
byte_275:
	.dsb 1                      ; $0275
byte_276:
	.dsb 1                      ; $0276
	.dsb 1                      ; $0277
byte_278:
	.dsb 1                      ; $0278
byte_279:
	.dsb 1                      ; $0279
	.dsb 1                      ; $027a
	.dsb 1                      ; $027b
	.dsb 1                      ; $027c
	.dsb 1                      ; $027d
	.dsb 1                      ; $027e
	.dsb 1                      ; $027f
unk_280:
	.dsb 1                      ; $0280
	.dsb 1                      ; $0281
	.dsb 1                      ; $0282
	.dsb 1                      ; $0283
byte_284:
	.dsb 1                      ; $0284
byte_285:
	.dsb 1                      ; $0285
	.dsb 1                      ; $0286
byte_287:
	.dsb 1                      ; $0287
byte_288:
	.dsb 1                      ; $0288
byte_289:
	.dsb 1                      ; $0289
	.dsb 1                      ; $028a
	.dsb 1                      ; $028b
	.dsb 1                      ; $028c
	.dsb 1                      ; $028d
	.dsb 1                      ; $028e
	.dsb 1                      ; $028f
unk_290:
	.dsb 1                      ; $0290
	.dsb 1                      ; $0291
	.dsb 1                      ; $0292
	.dsb 1                      ; $0293
byte_294:
	.dsb 1                      ; $0294
byte_295:
	.dsb 1                      ; $0295
	.dsb 1                      ; $0296
	.dsb 1                      ; $0297
	.dsb 1                      ; $0298
	.dsb 1                      ; $0299
	.dsb 1                      ; $029a
	.dsb 1                      ; $029b
	.dsb 1                      ; $029c
	.dsb 1                      ; $029d
	.dsb 1                      ; $029e
byte_29F:
	.dsb 1                      ; $029f
	.dsb 1                      ; $02a0
	.dsb 1                      ; $02a1
	.dsb 1                      ; $02a2
	.dsb 1                      ; $02a3
	.dsb 1                      ; $02a4
	.dsb 1                      ; $02a5
	.dsb 1                      ; $02a6
	.dsb 1                      ; $02a7
	.dsb 1                      ; $02a8
	.dsb 1                      ; $02a9
	.dsb 1                      ; $02aa
	.dsb 1                      ; $02ab
	.dsb 1                      ; $02ac
	.dsb 1                      ; $02ad
	.dsb 1                      ; $02ae
	.dsb 1                      ; $02af
EnemyPointersLo:
	.dsb 1                      ; $02b0
	.dsb 1                      ; $02b1
	.dsb 1                      ; $02b2
	.dsb 1                      ; $02b3
	.dsb 1                      ; $02b4
	.dsb 1                      ; $02b5
	.dsb 1                      ; $02b6
	.dsb 1                      ; $02b7
EnemyPointersHi:
	.dsb 1                      ; $02b8
	.dsb 1                      ; $02b9
	.dsb 1                      ; $02ba
	.dsb 1                      ; $02bb
	.dsb 1                      ; $02bc
	.dsb 1                      ; $02bd
	.dsb 1                      ; $02be
	.dsb 1                      ; $02bf
unk_2C0:
	.dsb 1                      ; $02c0
unk_2C1:
	.dsb 1                      ; $02c1
	.dsb 1                      ; $02c2
	.dsb 1                      ; $02c3
	.dsb 1                      ; $02c4
	.dsb 1                      ; $02c5
	.dsb 1                      ; $02c6
	.dsb 1                      ; $02c7
	.dsb 1                      ; $02c8
	.dsb 1                      ; $02c9
	.dsb 1                      ; $02ca
	.dsb 1                      ; $02cb
	.dsb 1                      ; $02cc
	.dsb 1                      ; $02cd
	.dsb 1                      ; $02ce
	.dsb 1                      ; $02cf
	.dsb 1                      ; $02d0
	.dsb 1                      ; $02d1
	.dsb 1                      ; $02d2
	.dsb 1                      ; $02d3
	.dsb 1                      ; $02d4
	.dsb 1                      ; $02d5
	.dsb 1                      ; $02d6
	.dsb 1                      ; $02d7
	.dsb 1                      ; $02d8
	.dsb 1                      ; $02d9
	.dsb 1                      ; $02da
	.dsb 1                      ; $02db
	.dsb 1                      ; $02dc
	.dsb 1                      ; $02dd
	.dsb 1                      ; $02de
	.dsb 1                      ; $02df
	.dsb 1                      ; $02e0
	.dsb 1                      ; $02e1
	.dsb 1                      ; $02e2
	.dsb 1                      ; $02e3
	.dsb 1                      ; $02e4
	.dsb 1                      ; $02e5
	.dsb 1                      ; $02e6
	.dsb 1                      ; $02e7
	.dsb 1                      ; $02e8
	.dsb 1                      ; $02e9
	.dsb 1                      ; $02ea
	.dsb 1                      ; $02eb
	.dsb 1                      ; $02ec
	.dsb 1                      ; $02ed
	.dsb 1                      ; $02ee
	.dsb 1                      ; $02ef
	.dsb 1                      ; $02f0
	.dsb 1                      ; $02f1
	.dsb 1                      ; $02f2
	.dsb 1                      ; $02f3
	.dsb 1                      ; $02f4
	.dsb 1                      ; $02f5
	.dsb 1                      ; $02f6
	.dsb 1                      ; $02f7
	.dsb 1                      ; $02f8
	.dsb 1                      ; $02f9
	.dsb 1                      ; $02fa
	.dsb 1                      ; $02fb
	.dsb 1                      ; $02fc
	.dsb 1                      ; $02fd
	.dsb 1                      ; $02fe
	.dsb 1                      ; $02ff
	.dsb 1                      ; $0300
	.dsb 1                      ; $0301
	.dsb 1                      ; $0302
	.dsb 1                      ; $0303
	.dsb 1                      ; $0304
	.dsb 1                      ; $0305
	.dsb 1                      ; $0306
	.dsb 1                      ; $0307
	.dsb 1                      ; $0308
	.dsb 1                      ; $0309
	.dsb 1                      ; $030a
	.dsb 1                      ; $030b
	.dsb 1                      ; $030c
	.dsb 1                      ; $030d
	.dsb 1                      ; $030e
	.dsb 1                      ; $030f
	.dsb 1                      ; $0310
	.dsb 1                      ; $0311
	.dsb 1                      ; $0312
	.dsb 1                      ; $0313
	.dsb 1                      ; $0314
	.dsb 1                      ; $0315
	.dsb 1                      ; $0316
	.dsb 1                      ; $0317
	.dsb 1                      ; $0318
	.dsb 1                      ; $0319
	.dsb 1                      ; $031a
	.dsb 1                      ; $031b
	.dsb 1                      ; $031c
	.dsb 1                      ; $031d
	.dsb 1                      ; $031e
	.dsb 1                      ; $031f
	.dsb 1                      ; $0320
	.dsb 1                      ; $0321
	.dsb 1                      ; $0322
	.dsb 1                      ; $0323
	.dsb 1                      ; $0324
	.dsb 1                      ; $0325
	.dsb 1                      ; $0326
	.dsb 1                      ; $0327
	.dsb 1                      ; $0328
	.dsb 1                      ; $0329
	.dsb 1                      ; $032a
	.dsb 1                      ; $032b
	.dsb 1                      ; $032c
	.dsb 1                      ; $032d
	.dsb 1                      ; $032e
	.dsb 1                      ; $032f
	.dsb 1                      ; $0330
	.dsb 1                      ; $0331
	.dsb 1                      ; $0332
	.dsb 1                      ; $0333
	.dsb 1                      ; $0334
	.dsb 1                      ; $0335
	.dsb 1                      ; $0336
	.dsb 1                      ; $0337
	.dsb 1                      ; $0338
	.dsb 1                      ; $0339
	.dsb 1                      ; $033a
	.dsb 1                      ; $033b
	.dsb 1                      ; $033c
	.dsb 1                      ; $033d
	.dsb 1                      ; $033e
	.dsb 1                      ; $033f
	.dsb 1                      ; $0340
	.dsb 1                      ; $0341
	.dsb 1                      ; $0342
	.dsb 1                      ; $0343
	.dsb 1                      ; $0344
	.dsb 1                      ; $0345
	.dsb 1                      ; $0346
	.dsb 1                      ; $0347
	.dsb 1                      ; $0348
	.dsb 1                      ; $0349
	.dsb 1                      ; $034a
	.dsb 1                      ; $034b
	.dsb 1                      ; $034c
	.dsb 1                      ; $034d
	.dsb 1                      ; $034e
	.dsb 1                      ; $034f
	.dsb 1                      ; $0350
	.dsb 1                      ; $0351
	.dsb 1                      ; $0352
	.dsb 1                      ; $0353
	.dsb 1                      ; $0354
	.dsb 1                      ; $0355
	.dsb 1                      ; $0356
	.dsb 1                      ; $0357
	.dsb 1                      ; $0358
	.dsb 1                      ; $0359
	.dsb 1                      ; $035a
	.dsb 1                      ; $035b
	.dsb 1                      ; $035c
	.dsb 1                      ; $035d
	.dsb 1                      ; $035e
	.dsb 1                      ; $035f
	.dsb 1                      ; $0360
	.dsb 1                      ; $0361
	.dsb 1                      ; $0362
	.dsb 1                      ; $0363
	.dsb 1                      ; $0364
	.dsb 1                      ; $0365
	.dsb 1                      ; $0366
	.dsb 1                      ; $0367
	.dsb 1                      ; $0368
	.dsb 1                      ; $0369
	.dsb 1                      ; $036a
	.dsb 1                      ; $036b
	.dsb 1                      ; $036c
	.dsb 1                      ; $036d
	.dsb 1                      ; $036e
	.dsb 1                      ; $036f
	.dsb 1                      ; $0370
	.dsb 1                      ; $0371
	.dsb 1                      ; $0372
	.dsb 1                      ; $0373
	.dsb 1                      ; $0374
	.dsb 1                      ; $0375
	.dsb 1                      ; $0376
	.dsb 1                      ; $0377
	.dsb 1                      ; $0378
	.dsb 1                      ; $0379
	.dsb 1                      ; $037a
	.dsb 1                      ; $037b
	.dsb 1                      ; $037c
	.dsb 1                      ; $037d
	.dsb 1                      ; $037e
	.dsb 1                      ; $037f
unk_380:
	.dsb 1                      ; $0380
unk_381:
	.dsb 1                      ; $0381
unk_382:
	.dsb 1                      ; $0382
unk_383:
	.dsb 1                      ; $0383
	.dsb 1                      ; $0384
	.dsb 1                      ; $0385
	.dsb 1                      ; $0386
unk_387:
	.dsb 1                      ; $0387
	.dsb 1                      ; $0388
unk_389:
	.dsb 1                      ; $0389
	.dsb 1                      ; $038a
	.dsb 1                      ; $038b
	.dsb 1                      ; $038c
	.dsb 1                      ; $038d
	.dsb 1                      ; $038e
	.dsb 1                      ; $038f
	.dsb 1                      ; $0390
	.dsb 1                      ; $0391
	.dsb 1                      ; $0392
	.dsb 1                      ; $0393
	.dsb 1                      ; $0394
	.dsb 1                      ; $0395
	.dsb 1                      ; $0396
	.dsb 1                      ; $0397
	.dsb 1                      ; $0398
	.dsb 1                      ; $0399
	.dsb 1                      ; $039a
	.dsb 1                      ; $039b
	.dsb 1                      ; $039c
	.dsb 1                      ; $039d
	.dsb 1                      ; $039e
	.dsb 1                      ; $039f
	.dsb 1                      ; $03a0
	.dsb 1                      ; $03a1
	.dsb 1                      ; $03a2
	.dsb 1                      ; $03a3
	.dsb 1                      ; $03a4
	.dsb 1                      ; $03a5
	.dsb 1                      ; $03a6
	.dsb 1                      ; $03a7
	.dsb 1                      ; $03a8
	.dsb 1                      ; $03a9
	.dsb 1                      ; $03aa
	.dsb 1                      ; $03ab
	.dsb 1                      ; $03ac
	.dsb 1                      ; $03ad
	.dsb 1                      ; $03ae
	.dsb 1                      ; $03af
	.dsb 1                      ; $03b0
	.dsb 1                      ; $03b1
	.dsb 1                      ; $03b2
	.dsb 1                      ; $03b3
	.dsb 1                      ; $03b4
	.dsb 1                      ; $03b5
	.dsb 1                      ; $03b6
	.dsb 1                      ; $03b7
	.dsb 1                      ; $03b8
	.dsb 1                      ; $03b9
	.dsb 1                      ; $03ba
	.dsb 1                      ; $03bb
	.dsb 1                      ; $03bc
	.dsb 1                      ; $03bd
	.dsb 1                      ; $03be
	.dsb 1                      ; $03bf
byte_3C0:
	.dsb 1                      ; $03c0
	.dsb 1                      ; $03c1
byte_3C2:
	.dsb 1                      ; $03c2
byte_3C3:
	.dsb 1                      ; $03c3
byte_3C4:
	.dsb 1                      ; $03c4
byte_3C5:
	.dsb 1                      ; $03c5
byte_3C6:
	.dsb 1                      ; $03c6
byte_3C7:
	.dsb 1                      ; $03c7
byte_3C8:
	.dsb 1                      ; $03c8
	.dsb 1                      ; $03c9
	.dsb 1                      ; $03ca
	.dsb 1                      ; $03cb
byte_3CC:
	.dsb 1                      ; $03cc
byte_3CD:
	.dsb 1                      ; $03cd
byte_3CE:
	.dsb 1                      ; $03ce
byte_3CF:
	.dsb 1                      ; $03cf
	.dsb 1                      ; $03d0
	.dsb 1                      ; $03d1
	.dsb 1                      ; $03d2
	.dsb 1                      ; $03d3
	.dsb 1                      ; $03d4
	.dsb 1                      ; $03d5
	.dsb 1                      ; $03d6
	.dsb 1                      ; $03d7
	.dsb 1                      ; $03d8
	.dsb 1                      ; $03d9
	.dsb 1                      ; $03da
	.dsb 1                      ; $03db
	.dsb 1                      ; $03dc
	.dsb 1                      ; $03dd
	.dsb 1                      ; $03de
	.dsb 1                      ; $03df
	.dsb 1                      ; $03e0
	.dsb 1                      ; $03e1
	.dsb 1                      ; $03e2
	.dsb 1                      ; $03e3
	.dsb 1                      ; $03e4
	.dsb 1                      ; $03e5
	.dsb 1                      ; $03e6
	.dsb 1                      ; $03e7
	.dsb 1                      ; $03e8
	.dsb 1                      ; $03e9
	.dsb 1                      ; $03ea
	.dsb 1                      ; $03eb
	.dsb 1                      ; $03ec
	.dsb 1                      ; $03ed
	.dsb 1                      ; $03ee
	.dsb 1                      ; $03ef
	.dsb 1                      ; $03f0
	.dsb 1                      ; $03f1
	.dsb 1                      ; $03f2
	.dsb 1                      ; $03f3
	.dsb 1                      ; $03f4
	.dsb 1                      ; $03f5
	.dsb 1                      ; $03f6
	.dsb 1                      ; $03f7
	.dsb 1                      ; $03f8
	.dsb 1                      ; $03f9
	.dsb 1                      ; $03fa
	.dsb 1                      ; $03fb
	.dsb 1                      ; $03fc
	.dsb 1                      ; $03fd
	.dsb 1                      ; $03fe
	.dsb 1                      ; $03ff
unk_400:
	.dsb 1                      ; $0400
	.dsb 1                      ; $0401
	.dsb 1                      ; $0402
	.dsb 1                      ; $0403
	.dsb 1                      ; $0404
	.dsb 1                      ; $0405
	.dsb 1                      ; $0406
	.dsb 1                      ; $0407
	.dsb 1                      ; $0408
	.dsb 1                      ; $0409
	.dsb 1                      ; $040a
	.dsb 1                      ; $040b
	.dsb 1                      ; $040c
	.dsb 1                      ; $040d
	.dsb 1                      ; $040e
	.dsb 1                      ; $040f
	.dsb 1                      ; $0410
	.dsb 1                      ; $0411
	.dsb 1                      ; $0412
	.dsb 1                      ; $0413
	.dsb 1                      ; $0414
	.dsb 1                      ; $0415
	.dsb 1                      ; $0416
	.dsb 1                      ; $0417
	.dsb 1                      ; $0418
	.dsb 1                      ; $0419
	.dsb 1                      ; $041a
	.dsb 1                      ; $041b
	.dsb 1                      ; $041c
	.dsb 1                      ; $041d
	.dsb 1                      ; $041e
	.dsb 1                      ; $041f
	.dsb 1                      ; $0420
	.dsb 1                      ; $0421
	.dsb 1                      ; $0422
	.dsb 1                      ; $0423
	.dsb 1                      ; $0424
	.dsb 1                      ; $0425
	.dsb 1                      ; $0426
	.dsb 1                      ; $0427
	.dsb 1                      ; $0428
	.dsb 1                      ; $0429
	.dsb 1                      ; $042a
	.dsb 1                      ; $042b
	.dsb 1                      ; $042c
	.dsb 1                      ; $042d
	.dsb 1                      ; $042e
	.dsb 1                      ; $042f
	.dsb 1                      ; $0430
	.dsb 1                      ; $0431
	.dsb 1                      ; $0432
	.dsb 1                      ; $0433
	.dsb 1                      ; $0434
	.dsb 1                      ; $0435
	.dsb 1                      ; $0436
	.dsb 1                      ; $0437
	.dsb 1                      ; $0438
	.dsb 1                      ; $0439
	.dsb 1                      ; $043a
	.dsb 1                      ; $043b
	.dsb 1                      ; $043c
	.dsb 1                      ; $043d
	.dsb 1                      ; $043e
	.dsb 1                      ; $043f
	.dsb 1                      ; $0440
	.dsb 1                      ; $0441
	.dsb 1                      ; $0442
	.dsb 1                      ; $0443
	.dsb 1                      ; $0444
	.dsb 1                      ; $0445
	.dsb 1                      ; $0446
	.dsb 1                      ; $0447
	.dsb 1                      ; $0448
	.dsb 1                      ; $0449
	.dsb 1                      ; $044a
	.dsb 1                      ; $044b
	.dsb 1                      ; $044c
	.dsb 1                      ; $044d
	.dsb 1                      ; $044e
	.dsb 1                      ; $044f
PlayerItem_Lightbulb:
	.dsb 1                      ; $0450
					; Bombs	temporarily light up dark areas
PlayerItem_Shoes:
	.dsb 1                      ; $0451
					; Can walk on semi-solid platforms
PlayerItem_SuperBomb:
	.dsb 1                      ; $0452
					; Bombs	hit all	enemies	on screen
PlayerItem_UpArrow:
	.dsb 1                      ; $0453
					; Gives	3 (or 6) points	when you push Up
PlayerItem_DoubleScore:
	.dsb 1                      ; $0454
					; All treasure scores are doubled
PlayerItem_SlowTimer:
	.dsb 1                      ; $0455
					; Slows	down the timer
PlayerItem_Microphone:
	.dsb 1                      ; $0456
					; Stuns	enemies, I guess
PlayerItem_Invulnerable:
	.dsb 1	                     ; $0457
					; Invulnerability to enemies (star)
	.dsb 1                      ; $0458
	.dsb 1                      ; $0459
	.dsb 1                      ; $045a
	.dsb 1                      ; $045b
	.dsb 1                      ; $045c
	.dsb 1                      ; $045d
	.dsb 1                      ; $045e
	.dsb 1                      ; $045f
	.dsb 1                      ; $0460
	.dsb 1                      ; $0461
	.dsb 1                      ; $0462
	.dsb 1                      ; $0463
	.dsb 1                      ; $0464
	.dsb 1                      ; $0465
	.dsb 1                      ; $0466
	.dsb 1                      ; $0467
	.dsb 1                      ; $0468
	.dsb 1                      ; $0469
	.dsb 1                      ; $046a
	.dsb 1                      ; $046b
	.dsb 1                      ; $046c
	.dsb 1                      ; $046d
	.dsb 1                      ; $046e
	.dsb 1                      ; $046f
	.dsb 1                      ; $0470
	.dsb 1                      ; $0471
	.dsb 1                      ; $0472
	.dsb 1                      ; $0473
	.dsb 1                      ; $0474
	.dsb 1                      ; $0475
	.dsb 1                      ; $0476
	.dsb 1                      ; $0477
	.dsb 1                      ; $0478
	.dsb 1                      ; $0479
	.dsb 1                      ; $047a
	.dsb 1                      ; $047b
	.dsb 1                      ; $047c
	.dsb 1                      ; $047d
	.dsb 1                      ; $047e
	.dsb 1                      ; $047f
unk_480:
	.dsb 1                      ; $0480
	.dsb 1                      ; $0481
	.dsb 1                      ; $0482
	.dsb 1                      ; $0483
	.dsb 1                      ; $0484
	.dsb 1                      ; $0485
	.dsb 1                      ; $0486
	.dsb 1                      ; $0487
unk_488:
	.dsb 1                      ; $0488
	.dsb 1                      ; $0489
	.dsb 1                      ; $048a
	.dsb 1                      ; $048b
	.dsb 1                      ; $048c
	.dsb 1                      ; $048d
	.dsb 1                      ; $048e
	.dsb 1                      ; $048f
unk_490:
	.dsb 1                      ; $0490
	.dsb 1                      ; $0491
	.dsb 1                      ; $0492
	.dsb 1                      ; $0493
	.dsb 1                      ; $0494
	.dsb 1                      ; $0495
	.dsb 1                      ; $0496
	.dsb 1                      ; $0497
unk_498:
	.dsb 1                      ; $0498
	.dsb 1                      ; $0499
	.dsb 1                      ; $049a
	.dsb 1                      ; $049b
	.dsb 1                      ; $049c
	.dsb 1                      ; $049d
	.dsb 1                      ; $049e
	.dsb 1                      ; $049f
unk_4A0:
	.dsb 1                      ; $04a0
	.dsb 1                      ; $04a1
	.dsb 1                      ; $04a2
	.dsb 1                      ; $04a3
	.dsb 1                      ; $04a4
	.dsb 1                      ; $04a5
	.dsb 1                      ; $04a6
	.dsb 1                      ; $04a7
unk_4A8:
	.dsb 1                      ; $04a8
	.dsb 1                      ; $04a9
	.dsb 1                      ; $04aa
	.dsb 1                      ; $04ab
	.dsb 1                      ; $04ac
	.dsb 1                      ; $04ad
	.dsb 1                      ; $04ae
	.dsb 1                      ; $04af
unk_4B0:
	.dsb 1                      ; $04b0
	.dsb 1                      ; $04b1
	.dsb 1                      ; $04b2
	.dsb 1                      ; $04b3
	.dsb 1                      ; $04b4
	.dsb 1                      ; $04b5
	.dsb 1                      ; $04b6
	.dsb 1                      ; $04b7
unk_4B8:
	.dsb 1                      ; $04b8
	.dsb 1                      ; $04b9
	.dsb 1                      ; $04ba
	.dsb 1                      ; $04bb
	.dsb 1                      ; $04bc
	.dsb 1                      ; $04bd
	.dsb 1                      ; $04be
	.dsb 1                      ; $04bf
	.dsb 1                      ; $04c0
	.dsb 1                      ; $04c1
	.dsb 1                      ; $04c2
	.dsb 1                      ; $04c3
	.dsb 1                      ; $04c4
	.dsb 1                      ; $04c5
	.dsb 1                      ; $04c6
	.dsb 1                      ; $04c7
	.dsb 1                      ; $04c8
	.dsb 1                      ; $04c9
	.dsb 1                      ; $04ca
	.dsb 1                      ; $04cb
	.dsb 1                      ; $04cc
	.dsb 1                      ; $04cd
	.dsb 1                      ; $04ce
	.dsb 1                      ; $04cf
	.dsb 1                      ; $04d0
	.dsb 1                      ; $04d1
	.dsb 1                      ; $04d2
	.dsb 1                      ; $04d3
	.dsb 1                      ; $04d4
	.dsb 1                      ; $04d5
	.dsb 1                      ; $04d6
	.dsb 1                      ; $04d7
	.dsb 1                      ; $04d8
	.dsb 1                      ; $04d9
	.dsb 1                      ; $04da
	.dsb 1                      ; $04db
	.dsb 1                      ; $04dc
	.dsb 1                      ; $04dd
	.dsb 1                      ; $04de
	.dsb 1                      ; $04df
	.dsb 1                      ; $04e0
	.dsb 1                      ; $04e1
	.dsb 1                      ; $04e2
	.dsb 1                      ; $04e3
	.dsb 1                      ; $04e4
	.dsb 1                      ; $04e5
	.dsb 1                      ; $04e6
	.dsb 1                      ; $04e7
	.dsb 1                      ; $04e8
	.dsb 1                      ; $04e9
	.dsb 1                      ; $04ea
	.dsb 1                      ; $04eb
	.dsb 1                      ; $04ec
	.dsb 1                      ; $04ed
	.dsb 1                      ; $04ee
	.dsb 1                      ; $04ef
	.dsb 1                      ; $04f0
	.dsb 1                      ; $04f1
	.dsb 1                      ; $04f2
	.dsb 1                      ; $04f3
	.dsb 1                      ; $04f4
	.dsb 1                      ; $04f5
	.dsb 1                      ; $04f6
	.dsb 1                      ; $04f7
	.dsb 1                      ; $04f8
	.dsb 1                      ; $04f9
	.dsb 1                      ; $04fa
	.dsb 1                      ; $04fb
	.dsb 1                      ; $04fc
	.dsb 1                      ; $04fd
	.dsb 1                      ; $04fe
	.dsb 1                      ; $04ff
byte_500:
	.dsb 1                      ; $0500
	.dsb 1                      ; $0501
	.dsb 1                      ; $0502
	.dsb 1                      ; $0503
	.dsb 1                      ; $0504
	.dsb 1                      ; $0505
	.dsb 1                      ; $0506
	.dsb 1                      ; $0507
	.dsb 1                      ; $0508
	.dsb 1                      ; $0509
	.dsb 1                      ; $050a
	.dsb 1                      ; $050b
	.dsb 1                      ; $050c
	.dsb 1                      ; $050d
	.dsb 1                      ; $050e
	.dsb 1                      ; $050f
	.dsb 1                      ; $0510
	.dsb 1                      ; $0511
	.dsb 1                      ; $0512
	.dsb 1                      ; $0513
	.dsb 1                      ; $0514
	.dsb 1                      ; $0515
	.dsb 1                      ; $0516
	.dsb 1                      ; $0517
	.dsb 1                      ; $0518
	.dsb 1                      ; $0519
	.dsb 1                      ; $051a
	.dsb 1                      ; $051b
	.dsb 1                      ; $051c
	.dsb 1                      ; $051d
	.dsb 1                      ; $051e
	.dsb 1                      ; $051f
	.dsb 1                      ; $0520
	.dsb 1                      ; $0521
	.dsb 1                      ; $0522
	.dsb 1                      ; $0523
	.dsb 1                      ; $0524
	.dsb 1                      ; $0525
	.dsb 1                      ; $0526
	.dsb 1                      ; $0527
	.dsb 1                      ; $0528
	.dsb 1                      ; $0529
	.dsb 1                      ; $052a
	.dsb 1                      ; $052b
	.dsb 1                      ; $052c
	.dsb 1                      ; $052d
	.dsb 1                      ; $052e
	.dsb 1                      ; $052f
	.dsb 1                      ; $0530
	.dsb 1                      ; $0531
	.dsb 1                      ; $0532
	.dsb 1                      ; $0533
	.dsb 1                      ; $0534
	.dsb 1                      ; $0535
	.dsb 1                      ; $0536
	.dsb 1                      ; $0537
	.dsb 1                      ; $0538
	.dsb 1                      ; $0539
	.dsb 1                      ; $053a
	.dsb 1                      ; $053b
	.dsb 1                      ; $053c
	.dsb 1                      ; $053d
	.dsb 1                      ; $053e
	.dsb 1                      ; $053f
	.dsb 1                      ; $0540
	.dsb 1                      ; $0541
	.dsb 1                      ; $0542
	.dsb 1                      ; $0543
	.dsb 1                      ; $0544
	.dsb 1                      ; $0545
	.dsb 1                      ; $0546
	.dsb 1                      ; $0547
	.dsb 1                      ; $0548
	.dsb 1                      ; $0549
	.dsb 1                      ; $054a
	.dsb 1                      ; $054b
	.dsb 1                      ; $054c
	.dsb 1                      ; $054d
	.dsb 1                      ; $054e
	.dsb 1                      ; $054f
	.dsb 1                      ; $0550
	.dsb 1                      ; $0551
	.dsb 1                      ; $0552
	.dsb 1                      ; $0553
	.dsb 1                      ; $0554
	.dsb 1                      ; $0555
	.dsb 1                      ; $0556
	.dsb 1                      ; $0557
	.dsb 1                      ; $0558
	.dsb 1                      ; $0559
	.dsb 1                      ; $055a
	.dsb 1                      ; $055b
	.dsb 1                      ; $055c
	.dsb 1                      ; $055d
	.dsb 1                      ; $055e
	.dsb 1                      ; $055f
	.dsb 1                      ; $0560
	.dsb 1                      ; $0561
	.dsb 1                      ; $0562
	.dsb 1                      ; $0563
	.dsb 1                      ; $0564
	.dsb 1                      ; $0565
	.dsb 1                      ; $0566
	.dsb 1                      ; $0567
	.dsb 1                      ; $0568
	.dsb 1                      ; $0569
	.dsb 1                      ; $056a
	.dsb 1                      ; $056b
	.dsb 1                      ; $056c
	.dsb 1                      ; $056d
	.dsb 1                      ; $056e
	.dsb 1                      ; $056f
	.dsb 1                      ; $0570
	.dsb 1                      ; $0571
	.dsb 1                      ; $0572
	.dsb 1                      ; $0573
	.dsb 1                      ; $0574
	.dsb 1                      ; $0575
	.dsb 1                      ; $0576
	.dsb 1                      ; $0577
	.dsb 1                      ; $0578
	.dsb 1                      ; $0579
	.dsb 1                      ; $057a
	.dsb 1                      ; $057b
	.dsb 1                      ; $057c
	.dsb 1                      ; $057d
	.dsb 1                      ; $057e
	.dsb 1                      ; $057f
	.dsb 1                      ; $0580
	.dsb 1                      ; $0581
	.dsb 1                      ; $0582
	.dsb 1                      ; $0583
	.dsb 1                      ; $0584
	.dsb 1                      ; $0585
	.dsb 1                      ; $0586
	.dsb 1                      ; $0587
	.dsb 1                      ; $0588
	.dsb 1                      ; $0589
	.dsb 1                      ; $058a
	.dsb 1                      ; $058b
	.dsb 1                      ; $058c
	.dsb 1                      ; $058d
	.dsb 1                      ; $058e
	.dsb 1                      ; $058f
	.dsb 1                      ; $0590
	.dsb 1                      ; $0591
	.dsb 1                      ; $0592
	.dsb 1                      ; $0593
	.dsb 1                      ; $0594
	.dsb 1                      ; $0595
	.dsb 1                      ; $0596
	.dsb 1                      ; $0597
	.dsb 1                      ; $0598
	.dsb 1                      ; $0599
	.dsb 1                      ; $059a
	.dsb 1                      ; $059b
	.dsb 1                      ; $059c
	.dsb 1                      ; $059d
	.dsb 1                      ; $059e
	.dsb 1                      ; $059f
	.dsb 1                      ; $05a0
	.dsb 1                      ; $05a1
	.dsb 1                      ; $05a2
	.dsb 1                      ; $05a3
	.dsb 1                      ; $05a4
	.dsb 1                      ; $05a5
	.dsb 1                      ; $05a6
	.dsb 1                      ; $05a7
	.dsb 1                      ; $05a8
	.dsb 1                      ; $05a9
	.dsb 1                      ; $05aa
	.dsb 1                      ; $05ab
	.dsb 1                      ; $05ac
	.dsb 1                      ; $05ad
	.dsb 1                      ; $05ae
	.dsb 1                      ; $05af
	.dsb 1                      ; $05b0
	.dsb 1                      ; $05b1
	.dsb 1                      ; $05b2
	.dsb 1                      ; $05b3
	.dsb 1                      ; $05b4
	.dsb 1                      ; $05b5
	.dsb 1                      ; $05b6
	.dsb 1                      ; $05b7
	.dsb 1                      ; $05b8
	.dsb 1                      ; $05b9
	.dsb 1                      ; $05ba
	.dsb 1                      ; $05bb
	.dsb 1                      ; $05bc
	.dsb 1                      ; $05bd
	.dsb 1                      ; $05be
	.dsb 1                      ; $05bf
	.dsb 1                      ; $05c0
	.dsb 1                      ; $05c1
	.dsb 1                      ; $05c2
	.dsb 1                      ; $05c3
	.dsb 1                      ; $05c4
	.dsb 1                      ; $05c5
	.dsb 1                      ; $05c6
	.dsb 1                      ; $05c7
	.dsb 1                      ; $05c8
	.dsb 1                      ; $05c9
	.dsb 1                      ; $05ca
	.dsb 1                      ; $05cb
	.dsb 1                      ; $05cc
	.dsb 1                      ; $05cd
	.dsb 1                      ; $05ce
	.dsb 1                      ; $05cf
	.dsb 1                      ; $05d0
	.dsb 1                      ; $05d1
	.dsb 1                      ; $05d2
	.dsb 1                      ; $05d3
	.dsb 1                      ; $05d4
	.dsb 1                      ; $05d5
	.dsb 1                      ; $05d6
	.dsb 1                      ; $05d7
	.dsb 1                      ; $05d8
	.dsb 1                      ; $05d9
	.dsb 1                      ; $05da
	.dsb 1                      ; $05db
	.dsb 1                      ; $05dc
	.dsb 1                      ; $05dd
	.dsb 1                      ; $05de
	.dsb 1                      ; $05df
	.dsb 1                      ; $05e0
	.dsb 1                      ; $05e1
	.dsb 1                      ; $05e2
	.dsb 1                      ; $05e3
	.dsb 1                      ; $05e4
	.dsb 1                      ; $05e5
	.dsb 1                      ; $05e6
	.dsb 1                      ; $05e7
	.dsb 1                      ; $05e8
	.dsb 1                      ; $05e9
	.dsb 1                      ; $05ea
	.dsb 1                      ; $05eb
	.dsb 1                      ; $05ec
	.dsb 1                      ; $05ed
	.dsb 1                      ; $05ee
	.dsb 1                      ; $05ef
	.dsb 1                      ; $05f0
	.dsb 1                      ; $05f1
	.dsb 1                      ; $05f2
	.dsb 1                      ; $05f3
	.dsb 1                      ; $05f4
	.dsb 1                      ; $05f5
	.dsb 1                      ; $05f6
	.dsb 1                      ; $05f7
	.dsb 1                      ; $05f8
	.dsb 1                      ; $05f9
	.dsb 1                      ; $05fa
	.dsb 1                      ; $05fb
	.dsb 1                      ; $05fc
	.dsb 1                      ; $05fd
	.dsb 1                      ; $05fe
	.dsb 1                      ; $05ff
	.dsb 1                      ; $0600
	.dsb 1                      ; $0601
	.dsb 1                      ; $0602
	.dsb 1                      ; $0603
	.dsb 1                      ; $0604
	.dsb 1                      ; $0605
	.dsb 1                      ; $0606
	.dsb 1                      ; $0607
	.dsb 1                      ; $0608
	.dsb 1                      ; $0609
	.dsb 1                      ; $060a
	.dsb 1                      ; $060b
	.dsb 1                      ; $060c
	.dsb 1                      ; $060d
	.dsb 1                      ; $060e
	.dsb 1                      ; $060f
	.dsb 1                      ; $0610
	.dsb 1                      ; $0611
	.dsb 1                      ; $0612
	.dsb 1                      ; $0613
	.dsb 1                      ; $0614
	.dsb 1                      ; $0615
	.dsb 1                      ; $0616
	.dsb 1                      ; $0617
	.dsb 1                      ; $0618
	.dsb 1                      ; $0619
	.dsb 1                      ; $061a
	.dsb 1                      ; $061b
	.dsb 1                      ; $061c
	.dsb 1                      ; $061d
	.dsb 1                      ; $061e
	.dsb 1                      ; $061f
	.dsb 1                      ; $0620
	.dsb 1                      ; $0621
	.dsb 1                      ; $0622
	.dsb 1                      ; $0623
	.dsb 1                      ; $0624
	.dsb 1                      ; $0625
	.dsb 1                      ; $0626
	.dsb 1                      ; $0627
	.dsb 1                      ; $0628
	.dsb 1                      ; $0629
	.dsb 1                      ; $062a
	.dsb 1                      ; $062b
	.dsb 1                      ; $062c
	.dsb 1                      ; $062d
	.dsb 1                      ; $062e
	.dsb 1                      ; $062f
	.dsb 1                      ; $0630
	.dsb 1                      ; $0631
	.dsb 1                      ; $0632
	.dsb 1                      ; $0633
	.dsb 1                      ; $0634
	.dsb 1                      ; $0635
	.dsb 1                      ; $0636
	.dsb 1                      ; $0637
	.dsb 1                      ; $0638
	.dsb 1                      ; $0639
	.dsb 1                      ; $063a
	.dsb 1                      ; $063b
	.dsb 1                      ; $063c
	.dsb 1                      ; $063d
	.dsb 1                      ; $063e
	.dsb 1                      ; $063f
	.dsb 1                      ; $0640
	.dsb 1                      ; $0641
	.dsb 1                      ; $0642
	.dsb 1                      ; $0643
	.dsb 1                      ; $0644
	.dsb 1                      ; $0645
	.dsb 1                      ; $0646
	.dsb 1                      ; $0647
	.dsb 1                      ; $0648
	.dsb 1                      ; $0649
	.dsb 1                      ; $064a
	.dsb 1                      ; $064b
	.dsb 1                      ; $064c
	.dsb 1                      ; $064d
	.dsb 1                      ; $064e
	.dsb 1                      ; $064f
	.dsb 1                      ; $0650
	.dsb 1                      ; $0651
	.dsb 1                      ; $0652
	.dsb 1                      ; $0653
	.dsb 1                      ; $0654
	.dsb 1                      ; $0655
	.dsb 1                      ; $0656
	.dsb 1                      ; $0657
	.dsb 1                      ; $0658
	.dsb 1                      ; $0659
	.dsb 1                      ; $065a
	.dsb 1                      ; $065b
	.dsb 1                      ; $065c
	.dsb 1                      ; $065d
	.dsb 1                      ; $065e
	.dsb 1                      ; $065f
	.dsb 1                      ; $0660
	.dsb 1                      ; $0661
	.dsb 1                      ; $0662
	.dsb 1                      ; $0663
	.dsb 1                      ; $0664
	.dsb 1                      ; $0665
	.dsb 1                      ; $0666
	.dsb 1                      ; $0667
	.dsb 1                      ; $0668
	.dsb 1                      ; $0669
	.dsb 1                      ; $066a
	.dsb 1                      ; $066b
	.dsb 1                      ; $066c
	.dsb 1                      ; $066d
	.dsb 1                      ; $066e
	.dsb 1                      ; $066f
	.dsb 1                      ; $0670
	.dsb 1                      ; $0671
	.dsb 1                      ; $0672
	.dsb 1                      ; $0673
	.dsb 1                      ; $0674
	.dsb 1                      ; $0675
	.dsb 1                      ; $0676
	.dsb 1                      ; $0677
	.dsb 1                      ; $0678
	.dsb 1                      ; $0679
	.dsb 1                      ; $067a
	.dsb 1                      ; $067b
	.dsb 1                      ; $067c
	.dsb 1                      ; $067d
	.dsb 1                      ; $067e
	.dsb 1                      ; $067f
	.dsb 1                      ; $0680
	.dsb 1                      ; $0681
	.dsb 1                      ; $0682
	.dsb 1                      ; $0683
	.dsb 1                      ; $0684
	.dsb 1                      ; $0685
	.dsb 1                      ; $0686
	.dsb 1                      ; $0687
	.dsb 1                      ; $0688
	.dsb 1                      ; $0689
	.dsb 1                      ; $068a
	.dsb 1                      ; $068b
	.dsb 1                      ; $068c
	.dsb 1                      ; $068d
	.dsb 1                      ; $068e
	.dsb 1                      ; $068f
	.dsb 1                      ; $0690
	.dsb 1                      ; $0691
	.dsb 1                      ; $0692
	.dsb 1                      ; $0693
	.dsb 1                      ; $0694
	.dsb 1                      ; $0695
	.dsb 1                      ; $0696
	.dsb 1                      ; $0697
	.dsb 1                      ; $0698
	.dsb 1                      ; $0699
	.dsb 1                      ; $069a
	.dsb 1                      ; $069b
	.dsb 1                      ; $069c
	.dsb 1                      ; $069d
	.dsb 1                      ; $069e
	.dsb 1                      ; $069f
	.dsb 1                      ; $06a0
	.dsb 1                      ; $06a1
	.dsb 1                      ; $06a2
	.dsb 1                      ; $06a3
	.dsb 1                      ; $06a4
	.dsb 1                      ; $06a5
	.dsb 1                      ; $06a6
	.dsb 1                      ; $06a7
	.dsb 1                      ; $06a8
	.dsb 1                      ; $06a9
	.dsb 1                      ; $06aa
	.dsb 1                      ; $06ab
	.dsb 1                      ; $06ac
	.dsb 1                      ; $06ad
	.dsb 1                      ; $06ae
	.dsb 1                      ; $06af
	.dsb 1                      ; $06b0
	.dsb 1                      ; $06b1
	.dsb 1                      ; $06b2
	.dsb 1                      ; $06b3
	.dsb 1                      ; $06b4
	.dsb 1                      ; $06b5
	.dsb 1                      ; $06b6
	.dsb 1                      ; $06b7
	.dsb 1                      ; $06b8
	.dsb 1                      ; $06b9
	.dsb 1                      ; $06ba
	.dsb 1                      ; $06bb
	.dsb 1                      ; $06bc
	.dsb 1                      ; $06bd
	.dsb 1                      ; $06be
	.dsb 1                      ; $06bf
	.dsb 1                      ; $06c0
	.dsb 1                      ; $06c1
	.dsb 1                      ; $06c2
	.dsb 1                      ; $06c3
	.dsb 1                      ; $06c4
	.dsb 1                      ; $06c5
	.dsb 1                      ; $06c6
	.dsb 1                      ; $06c7
	.dsb 1                      ; $06c8
	.dsb 1                      ; $06c9
	.dsb 1                      ; $06ca
	.dsb 1                      ; $06cb
	.dsb 1                      ; $06cc
	.dsb 1                      ; $06cd
	.dsb 1                      ; $06ce
	.dsb 1                      ; $06cf
	.dsb 1                      ; $06d0
	.dsb 1                      ; $06d1
	.dsb 1                      ; $06d2
	.dsb 1                      ; $06d3
	.dsb 1                      ; $06d4
	.dsb 1                      ; $06d5
	.dsb 1                      ; $06d6
	.dsb 1                      ; $06d7
	.dsb 1                      ; $06d8
	.dsb 1                      ; $06d9
	.dsb 1                      ; $06da
	.dsb 1                      ; $06db
	.dsb 1                      ; $06dc
	.dsb 1                      ; $06dd
	.dsb 1                      ; $06de
	.dsb 1                      ; $06df
	.dsb 1                      ; $06e0
	.dsb 1                      ; $06e1
	.dsb 1                      ; $06e2
	.dsb 1                      ; $06e3
	.dsb 1                      ; $06e4
	.dsb 1                      ; $06e5
	.dsb 1                      ; $06e6
	.dsb 1                      ; $06e7
	.dsb 1                      ; $06e8
	.dsb 1                      ; $06e9
	.dsb 1                      ; $06ea
	.dsb 1                      ; $06eb
	.dsb 1                      ; $06ec
	.dsb 1                      ; $06ed
	.dsb 1                      ; $06ee
	.dsb 1                      ; $06ef
	.dsb 1                      ; $06f0
	.dsb 1                      ; $06f1
	.dsb 1                      ; $06f2
	.dsb 1                      ; $06f3
	.dsb 1                      ; $06f4
	.dsb 1                      ; $06f5
	.dsb 1                      ; $06f6
	.dsb 1                      ; $06f7
	.dsb 1                      ; $06f8
	.dsb 1                      ; $06f9
	.dsb 1                      ; $06fa
	.dsb 1                      ; $06fb
	.dsb 1                      ; $06fc
	.dsb 1                      ; $06fd
	.dsb 1                      ; $06fe
	.dsb 1                      ; $06ff
SpriteData:
	.dsb 1                      ; $0700
	.dsb 1 ; 1                  ; $0701
	.dsb 1 ; 2                  ; $0702
	.dsb 1 ; 3                  ; $0703
	.dsb 1 ; 4                  ; $0704
	.dsb 1 ; 5                  ; $0705
	.dsb 1 ; 6                  ; $0706
	.dsb 1 ; 7                  ; $0707
	.dsb 1 ; 8                  ; $0708
	.dsb 1 ; 9                  ; $0709
	.dsb 1 ; $A                 ; $070a
	.dsb 1 ; $B                 ; $070b
	.dsb 1 ; $C                 ; $070c
	.dsb 1 ; $D                 ; $070d
	.dsb 1 ; $E                 ; $070e
	.dsb 1 ; $F                 ; $070f
	.dsb 1 ; $10                ; $0710
	.dsb 1 ; $11                ; $0711
	.dsb 1 ; $12                ; $0712
	.dsb 1 ; $13                ; $0713
	.dsb 1 ; $14                ; $0714
	.dsb 1 ; $15                ; $0715
	.dsb 1 ; $16                ; $0716
	.dsb 1 ; $17                ; $0717
	.dsb 1 ; $18                ; $0718
	.dsb 1 ; $19                ; $0719
	.dsb 1 ; $1A                ; $071a
	.dsb 1 ; $1B                ; $071b
	.dsb 1 ; $1C                ; $071c
	.dsb 1 ; $1D                ; $071d
	.dsb 1 ; $1E                ; $071e
	.dsb 1 ; $1F                ; $071f
	.dsb 1 ; $20                ; $0720
	.dsb 1 ; $21                ; $0721
	.dsb 1 ; $22                ; $0722
	.dsb 1 ; $23                ; $0723
	.dsb 1 ; $24                ; $0724
	.dsb 1 ; $25                ; $0725
	.dsb 1 ; $26                ; $0726
	.dsb 1 ; $27                ; $0727
	.dsb 1 ; $28                ; $0728
	.dsb 1 ; $29                ; $0729
	.dsb 1 ; $2A                ; $072a
	.dsb 1 ; $2B                ; $072b
	.dsb 1 ; $2C                ; $072c
	.dsb 1 ; $2D                ; $072d
	.dsb 1 ; $2E                ; $072e
	.dsb 1 ; $2F                ; $072f
	.dsb 1 ; $30                ; $0730
	.dsb 1 ; $31                ; $0731
	.dsb 1 ; $32                ; $0732
	.dsb 1 ; $33                ; $0733
	.dsb 1 ; $34                ; $0734
	.dsb 1 ; $35                ; $0735
	.dsb 1 ; $36                ; $0736
	.dsb 1 ; $37                ; $0737
	.dsb 1 ; $38                ; $0738
	.dsb 1 ; $39                ; $0739
	.dsb 1 ; $3A                ; $073a
	.dsb 1 ; $3B                ; $073b
	.dsb 1 ; $3C                ; $073c
	.dsb 1 ; $3D                ; $073d
	.dsb 1 ; $3E                ; $073e
	.dsb 1 ; $3F                ; $073f
	.dsb 1 ; $40                ; $0740
	.dsb 1 ; $41                ; $0741
	.dsb 1 ; $42                ; $0742
	.dsb 1 ; $43                ; $0743
	.dsb 1 ; $44                ; $0744
	.dsb 1 ; $45                ; $0745
	.dsb 1 ; $46                ; $0746
	.dsb 1 ; $47                ; $0747
	.dsb 1 ; $48                ; $0748
	.dsb 1 ; $49                ; $0749
	.dsb 1 ; $4A                ; $074a
	.dsb 1 ; $4B                ; $074b
	.dsb 1 ; $4C                ; $074c
	.dsb 1 ; $4D                ; $074d
	.dsb 1 ; $4E                ; $074e
	.dsb 1 ; $4F                ; $074f
	.dsb 1 ; $50                ; $0750
	.dsb 1 ; $51                ; $0751
	.dsb 1 ; $52                ; $0752
	.dsb 1 ; $53                ; $0753
	.dsb 1 ; $54                ; $0754
	.dsb 1 ; $55                ; $0755
	.dsb 1 ; $56                ; $0756
	.dsb 1 ; $57                ; $0757
	.dsb 1 ; $58                ; $0758
	.dsb 1 ; $59                ; $0759
	.dsb 1 ; $5A                ; $075a
	.dsb 1 ; $5B                ; $075b
	.dsb 1 ; $5C                ; $075c
	.dsb 1 ; $5D                ; $075d
	.dsb 1 ; $5E                ; $075e
	.dsb 1 ; $5F                ; $075f
	.dsb 1 ; $60                ; $0760
	.dsb 1 ; $61                ; $0761
	.dsb 1 ; $62                ; $0762
	.dsb 1 ; $63                ; $0763
	.dsb 1 ; $64                ; $0764
	.dsb 1 ; $65                ; $0765
	.dsb 1 ; $66                ; $0766
	.dsb 1 ; $67                ; $0767
	.dsb 1 ; $68                ; $0768
	.dsb 1 ; $69                ; $0769
	.dsb 1 ; $6A                ; $076a
	.dsb 1 ; $6B                ; $076b
	.dsb 1 ; $6C                ; $076c
	.dsb 1 ; $6D                ; $076d
	.dsb 1 ; $6E                ; $076e
	.dsb 1 ; $6F                ; $076f
	.dsb 1 ; $70                ; $0770
	.dsb 1 ; $71                ; $0771
	.dsb 1 ; $72                ; $0772
	.dsb 1 ; $73                ; $0773
	.dsb 1 ; $74                ; $0774
	.dsb 1 ; $75                ; $0775
	.dsb 1 ; $76                ; $0776
	.dsb 1 ; $77                ; $0777
	.dsb 1 ; $78                ; $0778
	.dsb 1 ; $79                ; $0779
	.dsb 1 ; $7A                ; $077a
	.dsb 1 ; $7B                ; $077b
	.dsb 1 ; $7C                ; $077c
	.dsb 1 ; $7D                ; $077d
	.dsb 1 ; $7E                ; $077e
	.dsb 1 ; $7F                ; $077f
	.dsb 1 ; $80                ; $0780
	.dsb 1 ; $81                ; $0781
	.dsb 1 ; $82                ; $0782
	.dsb 1 ; $83                ; $0783
	.dsb 1 ; $84                ; $0784
	.dsb 1 ; $85                ; $0785
	.dsb 1 ; $86                ; $0786
	.dsb 1 ; $87                ; $0787
	.dsb 1 ; $88                ; $0788
	.dsb 1 ; $89                ; $0789
	.dsb 1 ; $8A                ; $078a
	.dsb 1 ; $8B                ; $078b
	.dsb 1 ; $8C                ; $078c
	.dsb 1 ; $8D                ; $078d
	.dsb 1 ; $8E                ; $078e
	.dsb 1 ; $8F                ; $078f
	.dsb 1 ; $90                ; $0790
	.dsb 1 ; $91                ; $0791
	.dsb 1 ; $92                ; $0792
	.dsb 1 ; $93                ; $0793
	.dsb 1 ; $94                ; $0794
	.dsb 1 ; $95                ; $0795
	.dsb 1 ; $96                ; $0796
	.dsb 1 ; $97                ; $0797
	.dsb 1 ; $98                ; $0798
	.dsb 1 ; $99                ; $0799
	.dsb 1 ; $9A                ; $079a
	.dsb 1 ; $9B                ; $079b
	.dsb 1 ; $9C                ; $079c
	.dsb 1 ; $9D                ; $079d
	.dsb 1 ; $9E                ; $079e
	.dsb 1 ; $9F                ; $079f
	.dsb 1 ; $A0                ; $07a0
	.dsb 1 ; $A1                ; $07a1
	.dsb 1 ; $A2                ; $07a2
	.dsb 1 ; $A3                ; $07a3
	.dsb 1 ; $A4                ; $07a4
	.dsb 1 ; $A5                ; $07a5
	.dsb 1 ; $A6                ; $07a6
	.dsb 1 ; $A7                ; $07a7
	.dsb 1 ; $A8                ; $07a8
	.dsb 1 ; $A9                ; $07a9
	.dsb 1 ; $AA                ; $07aa
	.dsb 1 ; $AB                ; $07ab
	.dsb 1 ; $AC                ; $07ac
	.dsb 1 ; $AD                ; $07ad
	.dsb 1 ; $AE                ; $07ae
	.dsb 1 ; $AF                ; $07af
	.dsb 1 ; $B0                ; $07b0
	.dsb 1 ; $B1                ; $07b1
	.dsb 1 ; $B2                ; $07b2
	.dsb 1 ; $B3                ; $07b3
	.dsb 1 ; $B4                ; $07b4
	.dsb 1 ; $B5                ; $07b5
	.dsb 1 ; $B6                ; $07b6
	.dsb 1 ; $B7                ; $07b7
	.dsb 1 ; $B8                ; $07b8
	.dsb 1 ; $B9                ; $07b9
	.dsb 1 ; $BA                ; $07ba
	.dsb 1 ; $BB                ; $07bb
	.dsb 1 ; $BC                ; $07bc
	.dsb 1 ; $BD                ; $07bd
	.dsb 1 ; $BE                ; $07be
	.dsb 1 ; $BF                ; $07bf
	.dsb 1 ; $C0                ; $07c0
	.dsb 1 ; $C1                ; $07c1
	.dsb 1 ; $C2                ; $07c2
	.dsb 1 ; $C3                ; $07c3
	.dsb 1 ; $C4                ; $07c4
	.dsb 1 ; $C5                ; $07c5
	.dsb 1 ; $C6                ; $07c6
	.dsb 1 ; $C7                ; $07c7
	.dsb 1 ; $C8                ; $07c8
	.dsb 1 ; $C9                ; $07c9
	.dsb 1 ; $CA                ; $07ca
	.dsb 1 ; $CB                ; $07cb
	.dsb 1 ; $CC                ; $07cc
	.dsb 1 ; $CD                ; $07cd
	.dsb 1 ; $CE                ; $07ce
	.dsb 1 ; $CF                ; $07cf
	.dsb 1 ; $D0                ; $07d0
	.dsb 1 ; $D1                ; $07d1
	.dsb 1 ; $D2                ; $07d2
	.dsb 1 ; $D3                ; $07d3
	.dsb 1 ; $D4                ; $07d4
	.dsb 1 ; $D5                ; $07d5
	.dsb 1 ; $D6                ; $07d6
	.dsb 1 ; $D7                ; $07d7
	.dsb 1 ; $D8                ; $07d8
	.dsb 1 ; $D9                ; $07d9
	.dsb 1 ; $DA                ; $07da
	.dsb 1 ; $DB                ; $07db
	.dsb 1 ; $DC                ; $07dc
	.dsb 1 ; $DD                ; $07dd
	.dsb 1 ; $DE                ; $07de
	.dsb 1 ; $DF                ; $07df
	.dsb 1 ; $E0                ; $07e0
	.dsb 1 ; $E1                ; $07e1
	.dsb 1 ; $E2                ; $07e2
	.dsb 1 ; $E3                ; $07e3
	.dsb 1 ; $E4                ; $07e4
	.dsb 1 ; $E5                ; $07e5
	.dsb 1 ; $E6                ; $07e6
	.dsb 1 ; $E7                ; $07e7
	.dsb 1 ; $E8                ; $07e8
	.dsb 1 ; $E9                ; $07e9
	.dsb 1 ; $EA                ; $07ea
	.dsb 1 ; $EB                ; $07eb
	.dsb 1 ; $EC                ; $07ec
	.dsb 1 ; $ED                ; $07ed
	.dsb 1 ; $EE                ; $07ee
	.dsb 1 ; $EF                ; $07ef
	.dsb 1 ; $F0                ; $07f0
	.dsb 1 ; $F1                ; $07f1
	.dsb 1 ; $F2                ; $07f2
	.dsb 1 ; $F3                ; $07f3
	.dsb 1 ; $F4                ; $07f4
	.dsb 1 ; $F5                ; $07f5
	.dsb 1 ; $F6                ; $07f6
	.dsb 1 ; $F7                ; $07f7
	.dsb 1 ; $F8                ; $07f8
	.dsb 1 ; $F9                ; $07f9
	.dsb 1 ; $FA                ; $07fa
	.dsb 1 ; $FB                ; $07fb
	.dsb 1 ; $FC                ; $07fc
	.dsb 1 ; $FD                ; $07fd
	.dsb 1 ; $FE                ; $07fe
	.dsb 1 ; $FF                ; $07ff
; RAM:0800
;
