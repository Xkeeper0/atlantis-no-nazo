
    ;.segment BANK0
;     * =	 $8000

    ; public RESET
RESET:
    SEI
    CLD
    LDX	    #$3F
    TXS

loc_8005:
    LDX	    PPUSTATUS
    BPL	    loc_8005

loc_800A:
    LDX	    PPUSTATUS
    BPL	    loc_800A
    LDA	    #PPUCtrl_BaseAddr2000|PPUCtrl_WriteIncrementHorizontal|PPUCtrl_SpritePatternTable0000|PPUCtrl_BackgroundPatternTable1000|PPUCtrl_SpriteSize8x8|PPUControl_NMIDisabled
    STA	    PPUCtrl
    STA	    PPUCTRL
    LDA	    #PPUMask_ShowLeft8Pixels_BG|PPUMask_ShowLeft8Pixels_SPR|PPUMask_ShowBackground|PPUMask_ShowSprites
    STA	    PPUMask
    STA	    PPUMASK
    LDX	    #1
    LDY	    #$40
    LDA	    #$40
    JSR	    ClearSomeMemory
    LDX	    #0
    LDY	    #2
    LDA	    #$D
    JSR	    ClearSomeMemory
    LDA	    #0
    STA	    DMC_FREQ
    LDA	    #$40
    STA	    JOY2
    JSR	    InitSoundEngine
    JSR	    SoftResetCheck
    JMP	    InitTitleScreen

; =============== S U B	R O U T	I N E =======================================

    ; public NMI
NMI:
    PHP
    PHA
    STX	    byte_E
    STY	    byte_F
    LDA	    PPUSTATUS
    LDA	    NMIWaitFlag
    BNE	    loc_8057
    JMP	    ExitNMI
; ---------------------------------------------------------------------------

loc_8057:
    LDA	    PaletteUpdateRequest
    BEQ	    loc_808B
    LDA	    NametableUpdateRequest
    BNE	    loc_808B
    LDX	    #$3F
    LDY	    #0
    STX	    PPUADDR
    STY	    PPUADDR

loc_806B:
    LDA	    PaletteData,Y
    STA	    PPUDATA
    INY
    CPY	    #$20
    BNE	    loc_806B
    LDA	    #$3F
    STA	    PPUADDR
    LDA	    #0
    STA	    PPUADDR
    STA	    PPUADDR
    STA	    PPUADDR
    LDA	    #0
    STA	    PaletteUpdateRequest

loc_808B:
    LDA	    #0
    STA	    OAMADDR
    LDA	    #7
    STA	    OAM_DMA
    JSR	    OldOAMUpdate
    JSR	    sub_89F9
    LDA	    PPUCtrl
    STA	    PPUCTRL
    LDX	    PPUScrollX
    LDY	    PPUScrollY
    STX	    PPUSCROLL
    STY	    PPUSCROLL
    JSR	    RunMusicEngine
    LDA	    #0
    STA	    NMIWaitFlag

ExitNMI:
    JSR	    UpdateVariousTimers
    DEC	    byte_140
    LDY	    byte_F
    LDX	    byte_E
    PLA
    PLP
    RTI
; End of function NMI

; ---------------------------------------------------------------------------

InitTitleScreen:
    LDA	    #0
    STA	    DemoActive
    LDA	    #5
    STA	    byte_141
    LDA	    #3				; Prevent starting for 3 frames	(??)
    STA	    UnknownTimer014A
    JSR	    InitSoundEngine
    LDA	    #MusicTrack_TitleScreen
    JSR	    PlayMusicTrack
    JSR	    DrawTitleScreen

loc_80DE:
    JSR	    UpdateJoypads
    LDA	    UnknownTimer014A		; If the wait timer hasn't expired...
    BNE	    loc_80F0			; ...skip over the input checks	entirely.
    LDA	    Joypad_Immediate
    AND	    #ControllerInput_Start
    BNE	    TitleScreen_StartGame
    JSR	    HandleDebugCheatInputs

loc_80F0:
    JSR	    WaitForNMI
    LDA	    UnknownTimer0148		; Load timer on	title screen
    BNE	    loc_80DE			; If not 00, go	back
    DEC	    UnknownTimer0148		; Otherwise, reset timer to $FF
    DEC	    byte_141			; and decrease the title screen	timer
    BNE	    loc_80DE			; If that timer	isn't clear, go back and wait more
    JSR	    InitGameStuffMaybe		; Otherwise, do	something
    LDA	    DemoCounter			; Demo cycles through 8	different zones
    INC	    DemoCounter
    AND	    #7
    TAX
    LDA	    DemoStartingDoorIndexes,X	; Load whatever	zone we're going to "demo" today
    STA	    LastDoorEntered
    JSR	    InitZoneProbably		; and then set it up and everything
    LDA	    #$FF
    STA	    DemoActive			; and then turn	demo inputs on
    BNE	    loc_8144			; (Always branch ahead)

TitleScreen_StartGame:
    LDA	    #$FF
    STA	    UnknownTimer0148
    JSR	    InitGameStuffMaybe
    JSR	    CheckDebugCheatInputs
    JSR	    IntermissionScreenFirst
    JSR	    InitSoundEngine
    LDA	    #MusicTrack_ZoneStart
    JSR	    PlayMusicTrack
    LDA	    #4
    STA	    PauseCooldownTimer
    LDA	    #0
    STA	    GamePaused

loc_813C:
    JSR	    WaitForNMI
    LDA	    UnknownTimer0148
    BNE	    loc_813C

loc_8144:
    JSR	    sub_8FC9
    JSR	    LoadZoneMusic
    LDA	    #4
    STA	    PauseCooldownTimer

loc_814F:
    JSR	    UpdateJoypads
    LDA	    DemoActive
    BEQ	    loc_8164
    LDA	    Joypad_Immediate
    AND	    #ControllerInput_Start
    BEQ	    loc_8161
    JMP	    InitTitleScreen
; ---------------------------------------------------------------------------

loc_8161:
    JSR	    ProbablyDemoRelatedStuff

loc_8164:
    JSR	    HandlePauseUnpause
    JSR	    ClearSprites
    JSR	    sub_9387
    JSR	    sub_8B15
    JSR	    sub_869A
    JSR	    sub_97CC
    JSR	    sub_B99F
    JSR	    RunZoneASM
    JSR	    sub_B88E
    JSR	    sub_BA65
    JSR	    sub_826E
    JSR	    sub_B82A
    JSR	    sub_B411
    JSR	    WaitForNMI
    LDA	    DebugFlag_ZoneSkip
    BEQ	    loc_81B0
    LDA	    Joypad_Immediate
    AND	    #ControllerInput_Select
    BEQ	    loc_81B0
    LDX	    DebugFlag_ZoneSkipNumber
    INX
    CPX	    #100
    BEQ	    loc_81B0
    STX	    DebugFlag_ZoneSkipNumber
    LDA	    DebugWarpTable,X
    STA	    LastDoorEntered
    LDA	    #$20
    JMP	    loc_821D
; ---------------------------------------------------------------------------

loc_81B0:
    JSR	    UpdateZoneTimer
    LDA	    byte_1C3
    BEQ	    loc_81C0
    LDA	    DemoActive
    BNE	    loc_81D0
    JMP	    loc_81D3
; ---------------------------------------------------------------------------

loc_81C0:
    LDA	    TriggerZoneChange
    BEQ	    loc_81CD
    LDA	    DemoActive
    BNE	    loc_81D0
    JMP	    loc_821B
; ---------------------------------------------------------------------------

loc_81CD:
    JMP	    loc_814F
; ---------------------------------------------------------------------------

loc_81D0:
    JMP	    InitTitleScreen
; ---------------------------------------------------------------------------

loc_81D3:
    LDA	    #0
    STA	    PlayerItem_SuperBomb
    STA	    PlayerItem_Microphone
    LDA	    PlayerItem_Invulnerable
    BEQ	    loc_81E3
    INC	    PlayerItem_Invulnerable

loc_81E3:
    LDA	    DebugFlag_InfiniteLives
    BNE	    loc_8218
    DEC	    PlayerLives
    BPL	    loc_8218
    LDA	    #2
    STA	    byte_141
    LDA	    #$50
    STA	    UnknownTimer0148
    JSR	    UpdateHighScore
    JSR	    DrawGameOverScreen
    JSR	    InitSoundEngine
    LDA	    #MusicTrack_GameOver
    JSR	    PlayMusicTrack

loc_8205:
    JSR	    WaitForNMI
    LDA	    UnknownTimer0148
    BNE	    loc_8205
    DEC	    UnknownTimer0148
    DEC	    byte_141
    BNE	    loc_8205
    JMP	    InitTitleScreen
; ---------------------------------------------------------------------------

loc_8218:
    JMP	    loc_821B
; ---------------------------------------------------------------------------

loc_821B:
    LDA	    #$FF

loc_821D:
    STA	    UnknownTimer0148
    LDA	    PlayerState
    AND	    #$7F
    STA	    byte_19A
    JSR	    InitZoneProbably
    JSR	    IntermissionScreen
    JSR	    InitSoundEngine
    LDA	    #MusicTrack_ZoneStart
    JSR	    PlayMusicTrack
    LDA	    #4
    STA	    PauseCooldownTimer
    LDA	    #0
    STA	    GamePaused

loc_8240:
    JSR	    UpdateJoypads
    JSR	    HandlePauseUnpause
    JSR	    WaitForNMI
    LDA	    GamePaused
    BEQ	    loc_8253
    LDA	    #$45
    STA	    UnknownTimer0148

loc_8253:
    LDA	    UnknownTimer0148
    BNE	    loc_8240
    JSR	    sub_8FC9
    LDA	    byte_19A
    AND	    #PlayerStates_FacingLeft
    STA	    PlayerState
    JSR	    LoadZoneMusic
    LDA	    #4
    STA	    PauseCooldownTimer
    JMP	    loc_814F

; =============== S U B	R O U T	I N E =======================================

sub_826E:
    LDA	    #8
    STA	    byte_1C4
    LDA	    #4
    STA	    byte_1C6
    LDA	    byte_140
    AND	    #1
    BNE	    loc_828C
    JSR	    sub_A6DA
    JSR	    sub_B9C8
    JSR	    sub_B142
    JSR	    sub_A70E
    RTS
; ---------------------------------------------------------------------------

loc_828C:
    JSR	    sub_A71F
    JSR	    sub_B142
    JSR	    sub_B9C8
    JSR	    sub_A6EB
    RTS
; End of function sub_826E

; =============== S U B	R O U T	I N E =======================================

HandlePauseUnpause:
    LDA	    PauseCooldownTimer
    BNE	    loc_82B4
    LDA	    Joypad_Immediate
    AND	    #ControllerInput_Start
    BEQ	    locret_82BD
    LDA	    GamePaused
    BEQ	    loc_82BE
    LDA	    #$45
    STA	    PauseCooldownTimer
    LDA	    #MusicTrack_Pause2
    JMP	    PlayMusicTrack
; ---------------------------------------------------------------------------

loc_82B4:
    CMP	    #5
    BCS	    locret_82BD
    LDA	    #0
    STA	    GamePaused

locret_82BD:
    RTS
; ---------------------------------------------------------------------------

loc_82BE:
    LDA	    #$FF
    STA	    GamePaused
    LDA	    #MusicTrack_Pause
    JMP	    PlayMusicTrack
; End of function HandlePauseUnpause

; =============== S U B	R O U T	I N E =======================================

RunZoneASM:
    JMP	    (CurrentZoneASM)
; End of function RunZoneASM

; =============== S U B	R O U T	I N E =======================================

HandleDebugCheatInputs:
    LDA	    Joypad_Immediate
    AND	    #ControllerInput_Select
    BEQ	    loc_82D5
    INC	    Cheat_SelectPresses

loc_82D5:
    LDA	    Joypad1_Immediate
    AND	    #ControllerInput_B
    BEQ	    loc_82DF
    INC	    Cheat_P1BPresses

loc_82DF:
    LDA	    Joypad2_Immediate
    AND	    #ControllerInput_A
    BEQ	    loc_82E9
    INC	    Cheat_P2APresses

loc_82E9:
    LDA	    Joypad_Held
    STA	    Cheat_LastPress
    RTS
; End of function HandleDebugCheatInputs

; =============== S U B	R O U T	I N E =======================================

CheckDebugCheatInputs:
    LDX	    #$FF
    LDA	    Cheat_SelectPresses		; If Select is pressed 33 times...
    CMP	    #33
    BNE	    loc_830A
    LDA	    Cheat_P2APresses		; And P2 A was pressed 22 times...
    CMP	    #22
    BNE	    loc_830A
    LDA	    Cheat_LastPress		; And A	+ B were being held down...
    CMP	    #ControllerInput_B|ControllerInput_A
    BNE	    loc_830A
    STX	    DebugFlag_ZoneSkip		; ...then enable the zone skip cheat.

loc_830A:
    LDA	    Cheat_P2APresses		; If P2	A was pressed 11 times...
    CMP	    #11
    BNE	    loc_831B
    LDA	    Cheat_P1BPresses		; and P1 B was pressed 22 times...
    CMP	    #22
    BNE	    loc_831B
    STX	    DebugFlag_InfiniteLives	; ...then enable infinite lives.

loc_831B:
    LDA	    Cheat_LastPress		; If Up	+ Down + Select	+ B + A	were held
					; (on either controller)...
    CMP	    #ControllerInput_Down|ControllerInput_Up|ControllerInput_Select|ControllerInput_B|ControllerInput_A
    BNE	    locret_832C
    LDA	    Cheat_P1BPresses		; And P1 B was pressed 33 times...
    CMP	    #33
    BNE	    locret_832C
    INC	    PlayerItem_Invulnerable	; ... award invulnerability. The normal	way of
					; getting this item sets this to $FF, but the code
					; sets it to $01 instead. The code that	clears it
					; does an INC, so it won't clear this item unless
					; you die 255 times.

locret_832C:
    RTS
; End of function CheckDebugCheatInputs

; =============== S U B	R O U T	I N E =======================================

; Nulled-out subroutine	to update OAM data (see	below)

OldOAMUpdate:
    RTS
; End of function OldOAMUpdate

; =============== S U B	R O U T	I N E =======================================

; Not logged; subroutine begins	above
; This is a nulled-out routine to update OAM the wrong way,
; by manually inserting	sprite data, rather than using DMA
; Never	do this. Never,	ever do	this

UpdateOAMTheWrongWay:
    LDA	    byte_159
    TAX
    LDY	    NametableUpdateRequest
    BNE	    loc_833A
    ADC	    #$40
    CLC

loc_833A:
    ADC	    #$28
    STA	    byte_159
    LDY	    #$40
    STY	    OAMADDR

loc_8344:
    LDA	    SpriteData,X
    STA	    OAMDATA
    INX
    CPX	    byte_159
    BNE	    loc_8344
    RTS
; End of function UpdateOAMTheWrongWay

; =============== S U B	R O U T	I N E =======================================

EnableNMI:
    LDA	    PPUCtrl
    ORA	    #$80
    STA	    PPUCtrl
    STA	    PPUCTRL
    LDA	    PPUMask
    STA	    PPUMASK
    RTS
; End of function EnableNMI

; =============== S U B	R O U T	I N E =======================================

ClearPaletteToBlack:
    LDA	    #0
    STA	    PPUMASK
    LDA	    PPUCtrl
    AND	    #$7F
    STA	    PPUCtrl
    STA	    PPUCTRL
    LDX	    #$3F
    LDY	    #0
    STX	    PPUADDR
    STX	    PPUADDR
    LDA	    #$F
    LDY	    #$20

loc_8381:
    STA	    PPUDATA
    DEY
    BNE	    loc_8381
    LDA	    #$3F
    STA	    PPUADDR
    LDA	    #0
    STA	    PPUADDR
    STA	    PPUADDR
    STA	    PPUADDR
    LDA	    #$FF
    STA	    PaletteUpdateRequest
    RTS
; End of function ClearPaletteToBlack

; =============== S U B	R O U T	I N E =======================================

SetPPUAddrAndUpdateScroll:
    STX	    PPUADDR
    STY	    PPUADDR
    LDA	    PPUScrollX
    STA	    PPUSCROLL
    LDA	    PPUScrollY
    STA	    PPUSCROLL
    RTS
; End of function SetPPUAddrAndUpdateScroll

; =============== S U B	R O U T	I N E =======================================

ClearNametable2000:
    LDX	    #$20
    BNE	    loc_83B6
; End of function ClearNametable2000

; =============== S U B	R O U T	I N E =======================================

ClearNametable2400:
    LDX	    #$24

loc_83B6:
    LDY	    #0
    STX	    PPUADDR
    STY	    PPUADDR
    LDA	    #$FF
    LDY	    #$1E

loc_83C2:
    LDX	    #$20
					; Clears $3C0 bytes

loc_83C4:
    STA	    PPUDATA
    DEX
    BNE	    loc_83C4
    DEY
    BNE	    loc_83C2
    LDX	    #$40
					; Clears $3C0~$3FF (attribute tables)
    LDA	    #$FF			; ? A is already $FF here.
					; Was this supposed to set attr	to 0?

loc_83D1:
    STA	    PPUDATA
    DEX
    BNE	    loc_83D1
    RTS
; End of function ClearNametable2400

; =============== S U B	R O U T	I N E =======================================

UpdateJoypads:
    LDA	    Joypad1_Held
    STA	    Joypad1_Previous
    LDA	    Joypad2_Held
    STA	    Joypad2_Previous
    LDA	    #1
    STA	    JOY1
    LDA	    #0
    STA	    JOY1
    LDX	    #8

loc_83F0:
    LDA	    JOY1
    AND	    #3
    CMP	    #1
    ROL	    Joypad1_Held
    LDA	    JOY2
    AND	    #3
    CMP	    #1
    ROL	    Joypad2_Held
    DEX
    BNE	    loc_83F0
    LDA	    Joypad1_Previous
    EOR	    Joypad1_Held
    AND	    Joypad1_Held
    STA	    Joypad1_Immediate
    LDA	    Joypad2_Previous
    EOR	    Joypad2_Held
    AND	    Joypad2_Held
    STA	    Joypad2_Immediate
    ORA	    Joypad1_Immediate
    STA	    Joypad_Immediate
    LDA	    Joypad1_Held
    ORA	    Joypad2_Held
    STA	    Joypad_Held
    RTS
; End of function UpdateJoypads

; =============== S U B	R O U T	I N E =======================================

; Not logged. Copies palette data from $1E0?

Unused_CopyPaletteDataFrom1E0:
    LDX	    #$3F
    LDY	    #0
    STX	    PPUADDR
    STY	    PPUADDR
    LDX	    #0

loc_843B:
    LDA	    PaletteData,X
    STA	    PPUDATA
    INX
    CPX	    #$20
    BNE	    loc_843B
    RTS
; End of function Unused_CopyPaletteDataFrom1E0

; =============== S U B	R O U T	I N E =======================================

; Clear	some amount of memory
; starts at $XXYY, clears $A bytes

ClearSomeMemory:
    STX	    word_1E+1
    STY	    word_1E
    STA	    byte_2F
    LDA	    #0
    TAY

loc_8453:
    STA	    (word_1E),Y
    INY
    CPY	    byte_2F
    BNE	    loc_8453
    RTS
; End of function ClearSomeMemory

; =============== S U B	R O U T	I N E =======================================

ClearSprites:
    LDX	    #0
    STX	    byte_155
    LDA	    #$F6

loc_8463:
    STA	    SpriteData,X
    INX
    BNE	    loc_8463
    RTS
; End of function ClearSprites

; =============== S U B	R O U T	I N E =======================================

; Check	if the game was	soft reset.
; If not, clears the high score	(+ extra byte??)

SoftResetCheck:
    LDX	    #0

loc_846C:
    LDA	    byte_8489,X
    CMP	    SoftResetSentinel,X
    STA	    SoftResetSentinel,X
    BNE	    ClearHighScore

loc_8477:
    INX
    CPX	    #2
    BNE	    loc_846C
    RTS
; ---------------------------------------------------------------------------

ClearHighScore:
    LDY	    #7
    LDA	    #0

loc_8481:
    STA	    HighScore,Y
    DEY
    BPL	    loc_8481
    BMI	    loc_8477
; End of function SoftResetCheck

; ---------------------------------------------------------------------------
byte_8489:
    .BYTE	$80
					; Load-bearing $80. Actually a string terminator for the PPU drawing routine

; =============== S U B	R O U T	I N E =======================================

WaitForNMI:
    LDA	    #$FF
    STA	    NMIWaitFlag

loc_848F:
    LDA	    NMIWaitFlag
    BNE	    loc_848F
    RTS
; End of function WaitForNMI

; =============== S U B	R O U T	I N E =======================================

; This seems to	just decrement memory $0148-$014F every	frame,
; stopping when	they hit $00
;
; Notably $014C-F don't seem to be used anywhere

UpdateVariousTimers:
    LDX	    #7

loc_8497:
    LDA	    UnknownTimer0148,X		; Load timer
    SEC					; Set carry...
    SBC	    #1				; ...then subtract 1
    BCC	    loc_84A2			; If we	borrowed one (=FF), then skip ahead
    STA	    UnknownTimer0148,X		; ...otherwise,	store the updated value

loc_84A2:
    DEX
    BPL	    loc_8497

locret_84A5:
    RTS
; End of function UpdateVariousTimers

; =============== S U B	R O U T	I N E =======================================

; Unconfirmed, but from	my old notes:
; PPPP VVVV => V * (10 ^ P)
;
; (e.g.	#$25 = 5 * (10 ^ 2) = 500 points)

AwardPoints:
    LDY	    #0
    BEQ	    loc_84AC
; End of function AwardPoints

; =============== S U B	R O U T	I N E =======================================

AwardPoints2:
    LDY	    #8

loc_84AC:
    LDX	    PlayerScore
    BNE	    locret_84A5
    LDX	    PlayerScore+2
    STX	    byte_2D
    STY	    byte_276
    TAY
    AND	    #$70
    LSR	    A
    LSR	    A
    TAX
    LSR	    A
    LSR	    A
    STA	    byte_278
    TXA
    ADC	    #$83
    EOR	    #$FF
    STA	    byte_274
    LDA	    byte_215
    SBC	    #$24
    AND	    #$FC
    STA	    byte_275
    LDA	    #7
    SEC
    SBC	    byte_278
    TAX
    TYA
    AND	    #$F
    STA	    byte_279
    LDY	    PlayerItem_DoubleScore
    BEQ	    loc_84EA
    ASL	    A

loc_84EA:
    CLC
    ADC	    PlayerScore,X

loc_84EE:
    TAY
    SEC
    SBC	    #10
    BMI	    loc_8501
    STA	    PlayerScore,X
    DEX
    LDA	    PlayerScore,X
    CLC
    ADC	    #1
    JMP	    loc_84EE
; ---------------------------------------------------------------------------

loc_8501:
    TYA
    STA	    PlayerScore,X
    SEC
    LDA	    PlayerScore+2
    SBC	    byte_2D
    BEQ	    loc_8524
    BPL	    loc_8512
    ADC	    #$A

loc_8512:
    CLC
    ADC	    PlayerLives
    CMP	    #8
    BCC	    loc_851C
    LDA	    #8

loc_851C:
    STA	    PlayerLives
    LDA	    #MusicTrack_ExtraLife
    JSR	    PlayMusicTrack

loc_8524:
    LDX	    PlayerScore
    BEQ	    locret_8534
    LDX	    #6

loc_852B:
    LDA	    AllNines,X
    STA	    PlayerScore+1,X
    DEX
    BPL	    loc_852B

locret_8534:
    RTS
; End of function AwardPoints2

; ---------------------------------------------------------------------------
AllNines:
    .BYTE	 9,  9,	 9,  9,	 9,  9,	 9   ; =============== S U B	R O U T	I N E =======================================

UpdateHighScore:
    LDA	    HighScore
    BNE	    locret_8561
    LDX	    #0

loc_8543:
    LDA	    PlayerScore,X
    CMP	    HighScore,X
    BNE	    loc_8551
    INX
    CPX	    #8
    BNE	    loc_8543
    RTS
; ---------------------------------------------------------------------------

loc_8551:
    BMI	    locret_8561

loc_8553:
    STA	    HighScore,X
    INX
    CPX	    #8
    BEQ	    locret_8561
    LDA	    PlayerScore,X
    JMP	    loc_8553
; ---------------------------------------------------------------------------

locret_8561:
    RTS
; End of function UpdateHighScore

; =============== S U B	R O U T	I N E =======================================

UpdateMicrophone:
    LDA	    JoypadMic_Current
    STA	    JoypadMic_Previous
    LDA	    JOY1
    STA	    JoypadMic_Current
    EOR	    JoypadMic_Previous
    AND	    JoypadMic_Current
    AND	    #4
    RTS
; End of function UpdateMicrophone

; =============== S U B	R O U T	I N E =======================================

UpdateZoneTimer:
    LDA	    ZoneTimer
    CMP	    #$18
    BEQ	    locret_85E0
    LDA	    GamePaused
    BNE	    locret_85E0
    DEC	    ZoneTimerTickDelay
    BPL	    locret_85E0
    LDX	    #6
    LDA	    PlayerItem_SlowTimer
    BNE	    loc_8591
    LDX	    #4

loc_8591:
    STX	    ZoneTimerTickDelay
    LDX	    #2

loc_8596:
    LDA	    ZoneTimer,X
    SEC
    SBC	    #1
    BPL	    loc_85A9
    LDA	    #9
    STA	    ZoneTimer,X
    DEX
    BMI	    loc_85AC
    JMP	    loc_8596
; ---------------------------------------------------------------------------

loc_85A9:
    STA	    ZoneTimer,X

loc_85AC:
    LDA	    ZoneTimer
    ORA	    ZoneTimer+1
    ORA	    ZoneTimer+2
    BNE	    locret_85E0
    LDA	    PlayerState
    BMI	    loc_85D5
    ORA	    #PlayerStates_Dead
    STA	    PlayerState
    LDA	    #$61
    STA	    byte_220
    LDA	    #$21
    STA	    byte_21F
    LDA	    #0
    STA	    PlayerItem_SlowTimer
    LDA	    #MusicTrack_Death
    JSR	    PlayMusicTrack

loc_85D5:
    LDX	    #2

loc_85D7:
    LDA	    Timer_Out,X
    STA	    ZoneTimer,X
    DEX
    BPL	    loc_85D7

locret_85E0:
    RTS
; End of function UpdateZoneTimer

; ---------------------------------------------------------------------------
Timer_Out:
    .BYTE	$18,$1E,$1D		      ; =============== S U B	R O U T	I N E =======================================

sub_85E4:
    LDY	    #0
    LDA	    (word_A2),Y
; End of function sub_85E4

; =============== S U B	R O U T	I N E =======================================

sub_85E8:
    LSR	    A
    LSR	    A
    LSR	    A
    TAY
    LDA	    (CurrentZoneBlockPointer),Y
    TAX
    RTS
; End of function sub_85E8

; =============== S U B	R O U T	I N E =======================================

SetCurrentZoneCHR:
    LDX	    CurrentZone
    LDA	    ZoneCHRTable,X
; End of function SetCurrentZoneCHR

; =============== S U B	R O U T	I N E =======================================

;    $6000-7FFF:  [.HHH	.LLL]
;      H = Selects 4k CHR @ $1000
;      L = Selects 4k CHR @ $0000

SetCHRBanks:
    STA	    CurrentCHRBanks
    STA	    Mapper184CHRSelect
    RTS
; End of function SetCHRBanks

; =============== S U B	R O U T	I N E =======================================

; Resets PPUScrollX/Y to 0.
; Also resets nametable	to $2000.

ResetPPUScroll:
    LDA	    #0
    STA	    PPUScrollX
    STA	    PPUScrollY
    STA	    PPUSCROLL
    STA	    PPUSCROLL
    LDA	    PPUCtrl
    AND	    #PPUCtrl_BaseAddr2800|PPUCtrl_WriteIncrementVertical|PPUCtrl_SpritePatternTable1000|PPUCtrl_BackgroundPatternTable1000|PPUCtrl_SpriteSize8x16|PPUControl_NMIEnabled|$40
    STA	    PPUCtrl
    STA	    PPUCTRL
    RTS
; End of function ResetPPUScroll

; =============== S U B	R O U T	I N E =======================================

ProbablyDemoRelatedStuff:
    LDA	    byte_1C8
    AND	    #7
    TAX
    LDA	    byte_1C9
    BEQ	    loc_862D
    DEC	    byte_1C9
    BNE	    loc_8639
    INC	    byte_1C8
    JMP	    loc_8639
; ---------------------------------------------------------------------------

loc_862D:
    LDA	    byte_8672,X
    STA	    byte_1C9
    LDA	    byte_866A,X
    STA	    Joypad_Immediate

loc_8639:
    LDA	    byte_1CA
    AND	    #7
    TAX
    LDA	    byte_1CB
    BEQ	    loc_8655
    LDA	    byte_867A,X
    STA	    Joypad_Held
    DEC	    byte_1CB
    BNE	    locret_8661
    INC	    byte_1CA
    JMP	    locret_8661
; ---------------------------------------------------------------------------

loc_8655:
    LDA	    byte_8682,X
    STA	    byte_1CB
    LDA	    byte_867A,X
    STA	    Joypad_Held

locret_8661:
    RTS
; End of function ProbablyDemoRelatedStuff

; ---------------------------------------------------------------------------
DemoStartingDoorIndexes:
    .BYTE 0
    .BYTE $49
    .BYTE $1C
    .BYTE $42
    .BYTE $A
    .BYTE $37
    .BYTE $C
    .BYTE $40
byte_866A:
    .BYTE	0
    .BYTE 0
    .BYTE $80
    .BYTE $40
    .BYTE 0
    .BYTE $80
    .BYTE $40
    .BYTE 0
byte_8672:
    .BYTE	$20
    .BYTE $20
    .BYTE $70
    .BYTE $18
    .BYTE $10
    .BYTE $40
    .BYTE $10
    .BYTE $80
byte_867A:
    .BYTE	0
    .BYTE 1
    .BYTE $81
    .BYTE 0
    .BYTE 4
    .BYTE $81
    .BYTE 1
    .BYTE 1
byte_8682:
    .BYTE	$20
    .BYTE $20
    .BYTE $70
    .BYTE $18
    .BYTE $10
    .BYTE $40
    .BYTE $10
    .BYTE $80
; ---------------------------------------------------------------------------

locret_868A:
    RTS
; ---------------------------------------------------------------------------

loc_868B:
    LDA	    byte_3
    STA	    byte_13
    SEC
    LDA	    byte_2
    SBC	    #1
    JMP	    loc_8709

; =============== S U B	R O U T	I N E =======================================

sub_869A:
    LDA	    byte_2
    STA	    byte_10
    LDA	    byte_3
    STA	    byte_11
    LDA	    byte_6
    STA	    byte_2
    LDA	    byte_7
    STA	    byte_3
    LDA	    byte_2
    STA	    byte_8
    LDA	    byte_3
    LSR	    byte_8
    ROR	    A
    LSR	    byte_8
    ROR	    A
    LSR	    byte_8
    ROR	    A
    LSR	    byte_8
    ROR	    A
    STA	    PPUScrollX
    LSR	    PPUCtrl
    LDA	    byte_8
    LSR	    A
    LDA	    PPUCtrl
    ROL	    A
    STA	    PPUCtrl
    LDA	    byte_2
    AND	    #1
    STA	    byte_20
    LDA	    byte_10
    AND	    #1
    EOR	    byte_20
    BEQ	    locret_868A
    SEC
    LDA	    byte_3
    SBC	    byte_11
    LDA	    byte_2
    SBC	    byte_10
    BMI	    loc_868B
    LDA	    byte_3
    STA	    byte_13
    CLC
    LDA	    byte_2
    ADC	    #$11

loc_8709:
    STA	    byte_12
    LDX	    #$20
    LDY	    #$23
    AND	    #$10
    BEQ	    loc_8718
    LDX	    #$24
    LDY	    #$27

loc_8718:
    STX	    byte_BF
    STY	    byte_BD
    LDA	    byte_12
    AND	    #$F
    ASL	    A
    STA	    byte_BE
    LSR	    A
    LSR	    A
    STA	    byte_AB
    CLC
    ADC	    #$C0
    STA	    byte_BC
    LDA	    byte_12
    LSR	    A
    LSR	    A
    LSR	    A
    TAY
    LDA	    (CurrentZoneBlockPointer),Y
    LDX	    #0
    STX	    word_14+1
    ASL	    A
    ROL	    word_14+1
    ASL	    A
    ROL	    word_14+1
    ASL	    A
    ROL	    word_14+1
    ASL	    A
    ROL	    word_14+1
    ADC	    #<BlockTable
    STA	    word_14
    LDA	    word_14+1
    ADC	    #>BlockTable
    STA	    word_14+1
    LDA	    byte_12
    AND	    #7
    ASL	    A
    TAY
    LDA	    (word_14),Y
    STA	    byte_23
    LDX	    #0
    STX	    word_16+1
    STX	    word_18+1
    ASL	    A
    ROL	    word_16+1
    ASL	    A
    ROL	    word_16+1
    ASL	    A
    ROL	    word_16+1
    ADC	    #<loc_DE50
    STA	    word_16
    LDA	    word_16+1
    ADC	    #>loc_DE50
    STA	    word_16+1
    INY
    LDA	    (word_14),Y
    STA	    byte_24
    ASL	    A
    ROL	    word_18+1
    ASL	    A
    ROL	    word_18+1
    ASL	    A
    ROL	    word_18+1
    ADC	    #<loc_DE50
    STA	    word_18
    LDA	    word_18+1
    ADC	    #>loc_DE50
    STA	    word_18+1
    LDX	    #0
    STX	    byte_25

loc_87AE:
    LDA	    #0
    STA	    word_1A+1
    LDY	    byte_25
    LDA	    (word_16),Y
    ASL	    A
    ROL	    word_1A+1
    ASL	    A
    ROL	    word_1A+1
    ADC	    #<loc_F3C0
    STA	    word_1A
    LDA	    word_1A+1
    ADC	    #>loc_F3C0
    STA	    word_1A+1
    LDY	    #0
    LDA	    (word_1A),Y
    STA	    unk_C0,X
    INY
    LDA	    (word_1A),Y
    STA	    unk_E0,X
    INY
    LDA	    (word_1A),Y
    STA	    unk_C1,X
    INY
    LDA	    (word_1A),Y
    STA	    unk_E1,X
    INC	    byte_25
    INX
    INX
    CPX	    #$10
    BNE	    loc_87AE
    LDA	    #0
    STA	    byte_25

loc_87F4:
    LDA	    #0
    STA	    word_1A+1
    LDY	    byte_25
    LDA	    (word_18),Y
    ASL	    A
    ROL	    word_1A+1
    ASL	    A
    ROL	    word_1A+1
    ADC	    #<loc_F3C0
    STA	    word_1A
    LDA	    word_1A+1
    ADC	    #>loc_F3C0
    STA	    word_1A+1
    LDY	    #0
    LDA	    (word_1A),Y
    STA	    unk_C0,X
    INY
    LDA	    (word_1A),Y
    STA	    unk_E0,X
    INY
    LDA	    (word_1A),Y
    STA	    unk_C1,X
    INY
    LDA	    (word_1A),Y
    STA	    unk_E1,X
    INC	    byte_25
    INX
    INX
    CPX	    #$20
    BNE	    loc_87F4
    LDX	    #0
    LDA	    byte_12
    AND	    #$10
    BEQ	    loc_8840
    LDX	    #$40

loc_8840:
    TXA
    CLC
    ADC	    byte_AB
    STA	    byte_AB
    LDX	    #$CC
    LDY	    #$33
    LDA	    byte_12
    LSR	    A
    BCS	    loc_8856
    LDX	    #$33
    LDY	    #$CC

loc_8856:
    STX	    byte_AD
    STY	    byte_AC
    LDA	    byte_23
    LDX	    #0
    STX	    word_1E+1
    ASL	    A
    ROL	    word_1E+1
    ADC	    #<loc_E650
    STA	    word_1E
    LDA	    word_1E+1
    ADC	    #>loc_E650
    STA	    word_1E+1
    LDY	    #0
    LDA	    (word_1E),Y
    STA	    byte_28
    LDY	    byte_AB
    JSR	    sub_89AE
    LDA	    unk_480,Y
    AND	    byte_AC
    ORA	    byte_2B
    STA	    unk_480,Y
    STA	    byte_B0
    JSR	    sub_89D5
    LDA	    unk_488,Y
    AND	    byte_AC
    ORA	    byte_2B
    STA	    unk_488,Y
    STA	    byte_B1
    LDY	    #1
    LDA	    (word_1E),Y
    STA	    byte_28
    LDY	    byte_AB
    JSR	    sub_89AE
    LDA	    unk_490,Y
    AND	    byte_AC
    ORA	    byte_2B
    STA	    unk_490,Y
    STA	    byte_B2
    JSR	    sub_89D5
    LDA	    unk_498,Y
    AND	    byte_AC
    ORA	    byte_2B
    STA	    unk_498,Y
    STA	    byte_B3
    LDA	    byte_24
    LDX	    #0
    STX	    word_1E+1
    ASL	    A
    ROL	    word_1E+1
    ADC	    #<loc_E650
    STA	    word_1E
    LDA	    word_1E+1
    ADC	    #>loc_E650
    STA	    word_1E+1
    LDY	    #0
    LDA	    (word_1E),Y
    STA	    byte_28
    LDY	    byte_AB
    JSR	    sub_89AE
    LDA	    unk_4A0,Y
    AND	    byte_AC
    ORA	    byte_2B
    STA	    unk_4A0,Y
    STA	    byte_B4
    JSR	    sub_89D5
    LDA	    unk_4A8,Y
    AND	    byte_AC
    ORA	    byte_2B
    STA	    unk_4A8,Y
    STA	    byte_B5
    LDY	    #1
    LDA	    (word_1E),Y
    STA	    byte_28
    LDY	    byte_AB
    JSR	    sub_89AE
    LDA	    unk_4B0,Y
    AND	    byte_AC
    ORA	    byte_2B
    STA	    unk_4B0,Y
    STA	    byte_B6
    JSR	    sub_89D5
    LDA	    unk_4B8,Y
    AND	    byte_AC
    ORA	    byte_2B
    STA	    unk_4B8,Y
    STA	    byte_B7
    LDX	    #0

loc_8948:
    LDA	    ZoneDoors,X
    BPL	    loc_89A0
    LDA	    ZoneDoors+1,X
    CMP	    byte_12
    BNE	    loc_89A0
    LDA	    ZoneDoors+2,X
    LSR	    A
    TAY
    DEY
    STY	    byte_2F
    STX	    byte_2C
    LDA	    ZoneDoors,X
    AND	    #3
    BEQ	    loc_89A0
    LDX	    #3
    AND	    #1
    BNE	    loc_8970
    LDX	    #7

loc_8970:
    STX	    byte_2D
    LDA	    #3
    STA	    byte_2E

loc_8978:
    LDA	    byte_8C3E,X
    STA	    unk_C0,Y
    DEY
    DEX
    DEC	    byte_2E
    BPL	    loc_8978
    LDX	    byte_2D
    LDY	    byte_2F
    LDA	    #3
    STA	    byte_2E

loc_8990:
    LDA	    byte_8C46,X
    STA	    unk_E0,Y
    DEY
    DEX
    DEC	    byte_2E
    BPL	    loc_8990
    LDX	    byte_2C

loc_89A0:
    INX
    INX
    INX
    INX
    CPX	    #$10
    BNE	    loc_8948
    LDA	    #$FF
    STA	    NametableUpdateRequest
    RTS
; End of function sub_869A

; =============== S U B	R O U T	I N E =======================================

sub_89AE:
    AND	    #$C0
    CLC
    ROL	    A
    ROL	    A
    ROL	    A
    TAX
    LDA	    byte_8C36,X
    AND	    byte_AD
    STA	    byte_2B
    LDA	    byte_28
    AND	    #$30
    LSR	    A
    LSR	    A
    LSR	    A
    LSR	    A
    TAX
    LDA	    byte_8C3A,X
    AND	    byte_AD
    ORA	    byte_2B
    STA	    byte_2B
    RTS
; End of function sub_89AE

; =============== S U B	R O U T	I N E =======================================

sub_89D5:
    LDA	    byte_28
    AND	    #$C
    LSR	    A
    LSR	    A
    TAX
    LDA	    byte_8C36,X
    AND	    byte_AD
    STA	    byte_2B
    LDA	    byte_28
    AND	    #3
    TAX
    LDA	    byte_8C3A,X
    AND	    byte_AD
    ORA	    byte_2B
    STA	    byte_2B
    RTS
; End of function sub_89D5

; =============== S U B	R O U T	I N E =======================================

sub_89F9:
    LDA	    NametableUpdateRequest
    BNE	    loc_8A01
    JMP	    loc_8BE0
; ---------------------------------------------------------------------------

loc_8A01:
    LDA	    PPUCtrl
    ORA	    #PPUCtrl_BaseAddr2000|PPUCtrl_WriteIncrementVertical|PPUCtrl_SpritePatternTable0000|PPUCtrl_BackgroundPatternTable0000|PPUCtrl_SpriteSize8x8|PPUControl_NMIDisabled
    STA	    PPUCtrl
    STA	    PPUCTRL
    LDX	    byte_BF
    LDY	    byte_BE
    STX	    PPUADDR
    STY	    PPUADDR
    LDX	    #0

loc_8A1A:
    LDA	    unk_C0,X
    STA	    PPUDATA
    INX
    CPX	    #$1E
    BNE	    loc_8A1A
    LDX	    byte_BF
    INY
    STX	    PPUADDR
    STY	    PPUADDR
    LDX	    #$20

loc_8A31:
    LDA	    unk_C0,X
    STA	    PPUDATA
    INX
    CPX	    #$3E
    BNE	    loc_8A31
    LDA	    PPUCtrl
    AND	    #$FB
    STA	    PPUCtrl
    STA	    PPUCTRL
    LDY	    #0
    LDX	    byte_BD

loc_8A4C:
    LDA	    byte_BC
    STX	    PPUADDR
    STA	    PPUADDR
    CLC
    ADC	    #8
    STA	    byte_BC
    LDA	    byte_B0,Y
    STA	    PPUDATA
    INY
    CPY	    #8
    BNE	    loc_8A4C
    LDA	    #0
    STA	    NametableUpdateRequest
    RTS
; End of function sub_89F9

; =============== S U B	R O U T	I N E =======================================

sub_8A6C:
    LDA	    byte_A0
    AND	    #$F8
    LSR	    A
    LSR	    A
    TAY
    LDA	    (word_B8),Y
    STA	    word_1E
    INY
    LDA	    (word_B8),Y
    STA	    word_1E+1
    LDA	    byte_A0
    AND	    #7
    ASL	    A
    ASL	    A
    ADC	    word_1E
    STA	    word_1E
    LDA	    byte_A1
    AND	    #$E
    LSR	    A
    LSR	    A
    TAX
    LDA	    byte_A1
    AND	    #$30
    LSR	    A
    LSR	    A
    LSR	    A
    LSR	    A
    TAY
    LDA	    (word_1E),Y
    CPX	    #0

loc_8AA2:
    BEQ	    loc_8AA9
    ASL	    A
    ASL	    A
    DEX
    BNE	    loc_8AA2

loc_8AA9:
    STX	    byte_27
    ASL	    A
    ROL	    byte_27
    ASL	    A
    ROL	    byte_27
    LDA	    byte_27
    RTS
; End of function sub_8A6C

; =============== S U B	R O U T	I N E =======================================

sub_8AB8:
    LDY	    #7
    LDA	    (word_A2),Y
    STA	    byte_2F
    LDY	    #1
    LDA	    (word_A2),Y
    SEC
    SBC	    byte_3
    STA	    word_1E+1
    DEY
    LDA	    (word_A2),Y
    SBC	    byte_2
    BMI	    loc_8B0E
    LSR	    A
    ROR	    word_1E+1
    LSR	    A
    ROR	    word_1E+1
    LSR	    A
    ROR	    word_1E+1
    LSR	    A
    ROR	    word_1E+1
    AND	    #$FF
    BNE	    loc_8B0E
    LDA	    word_1E+1
    LDY	    #4
    STA	    (word_A2),Y
    DEY
    LDA	    (word_A2),Y
    STA	    word_1E+1
    DEY
    LDA	    (word_A2),Y
    ASL	    word_1E+1
    ROL	    A
    ASL	    word_1E+1
    ROL	    A
    BCC	    loc_8B0E
    LDY	    #5
    STA	    (word_A2),Y
    LDA	    byte_2F
    AND	    #$7F

loc_8B09:
    LDY	    #7
    STA	    (word_A2),Y
    RTS
; ---------------------------------------------------------------------------

loc_8B0E:
    LDA	    byte_2F
    ORA	    #$80
    BNE	    loc_8B09
; End of function sub_8AB8

; =============== S U B	R O U T	I N E =======================================

sub_8B15:
    LDA	    PlayerXLo
    STA	    byte_7
    SEC
    LDA	    PlayerX
    SBC	    #8
    STA	    byte_6
    RTS
; End of function sub_8B15

; =============== S U B	R O U T	I N E =======================================

sub_8B25:
    LDY	    #2
    LDA	    (word_A2),Y
    STA	    byte_A1
    DEY
    LDA	    (word_A2),Y
    CLC
    ADC	    #$40
    DEY
    LDA	    (word_A2),Y
    ADC	    #0
    STA	    byte_A0
    JSR	    sub_8A6C
    AND	    #1
    BNE	    loc_8B5A
    LDY	    #1
    LDA	    (word_A2),Y
    SEC
    SBC	    #$40
    DEY
    LDA	    (word_A2),Y
    SBC	    #0
    STA	    byte_A0
    JSR	    sub_8A6C
    AND	    #1
    BNE	    loc_8B5A
    LDA	    #0
    RTS
; ---------------------------------------------------------------------------

loc_8B5A:
    LDA	    #$FF
    RTS
; End of function sub_8B25

; =============== S U B	R O U T	I N E =======================================

sub_8B5D:
    LDX	    #3
    LDA	    PlayerItem_Shoes
    BNE	    loc_8B66
    LDX	    #1

loc_8B66:
    STX	    byte_2F
    LDA	    PlayerY
    STA	    byte_A1
    AND	    #$40
    BEQ	    loc_8B9F
    LDA	    PlayerXLo
    CLC
    ADC	    #$40
    LDA	    PlayerX
    ADC	    #0
    STA	    byte_A0
    JSR	    sub_8A6C
    AND	    byte_2F
    BNE	    loc_8BA2
    LDA	    PlayerXLo
    SEC
    SBC	    #$40
    LDA	    PlayerX
    SBC	    #0
    STA	    byte_A0
    JSR	    sub_8A6C
    AND	    byte_2F
    BNE	    loc_8BA2

loc_8B9F:
    LDA	    #0
    RTS
; ---------------------------------------------------------------------------

loc_8BA2:
    LDA	    #$FF
    RTS
; End of function sub_8B5D

; ---------------------------------------------------------------------------

loc_8BA5:
    LDA	    ZoneDoors+1,X
    LDY	    #$20
    AND	    #$10
    BEQ	    loc_8BB0
    LDY	    #$24

loc_8BB0:
    STY	    byte_A7
    LDA	    ZoneDoors+1,X
    AND	    #$F
    ASL	    A
    STA	    byte_A6
    LDA	    ZoneDoors+2,X
    SEC
    SBC	    #8
    TAY
    ASL	    A
    ASL	    A
    ASL	    A
    ASL	    A
    CLC
    ADC	    byte_A6
    STA	    byte_A6
    TYA
    LSR	    A
    LSR	    A
    LSR	    A
    LSR	    A
    CLC
    ADC	    byte_A7
    STA	    byte_A7
    LDA	    #$FF
    STA	    byte_15A
    RTS
; ---------------------------------------------------------------------------

loc_8BE0:
    LDA	    byte_15A
    BEQ	    locret_8C35
    LDA	    PPUCtrl
    ORA	    #4
    STA	    PPUCtrl
    STA	    PPUCTRL
    LDX	    byte_A7
    LDY	    byte_A6
    STX	    PPUADDR
    STY	    PPUADDR
    LDY	    #4
    LDX	    byte_A8

loc_8C01:
    LDA	    byte_8C3E,X
    STA	    PPUDATA
    INX
    DEY
    BNE	    loc_8C01
    LDX	    byte_A7
    LDY	    byte_A6
    INY
    STX	    PPUADDR
    STY	    PPUADDR
    LDY	    #4
    LDX	    byte_A8

loc_8C1D:
    LDA	    byte_8C46,X
    STA	    PPUDATA
    INX
    DEY
    BNE	    loc_8C1D
    STY	    byte_15A
    LDA	    PPUCtrl
    AND	    #$FB
    STA	    PPUCtrl
    STA	    PPUCTRL

locret_8C35:
    RTS
; ---------------------------------------------------------------------------
byte_8C36:
    .BYTE	0
    .BYTE 5
    .BYTE $A
    .BYTE $F
byte_8C3A:
    .BYTE	0
    .BYTE $50
    .BYTE $A0
    .BYTE $F0
byte_8C3E:
    .BYTE	$4A
    .BYTE $5A
    .BYTE $6A
    .BYTE $5A
    .BYTE $2A
    .BYTE $3A
    .BYTE $3A
    .BYTE $3A
byte_8C46:
    .BYTE	$4B
    .BYTE $5B
    .BYTE $6B
    .BYTE $5B
    .BYTE $2B
    .BYTE $3B
    .BYTE $3B
    .BYTE $3B

; =============== S U B	R O U T	I N E =======================================

InitGameStuffMaybe:
    LDX	    #1				; Clear	$0190-$01BF
    LDY	    #$90
    LDA	    #$30
    JSR	    ClearSomeMemory
    LDX	    #4				; Clear	$0400-$0480
    LDY	    #0
    LDA	    #$80
    JSR	    ClearSomeMemory
    LDA	    PPUCtrl
    AND	    #$E7
    ORA	    #$10
    STA	    PPUCtrl
    STA	    PPUCTRL
    JSR	    InitZoneProbably
    LDA	    #6
    STA	    PlayerLives
    RTS
; End of function InitGameStuffMaybe

; =============== S U B	R O U T	I N E =======================================

InitZoneProbably:
    LDX	    #1				; Clear	$01C0-$1DF
    LDY	    #$C0
    LDA	    #$20
    JSR	    ClearSomeMemory
    LDX	    #5				; Clear	$0500-$051F
    LDY	    #0
    LDA	    #$20
    JSR	    ClearSomeMemory
    LDX	    #2				; Clear	$0200-$02BF
    LDY	    #0
    LDA	    #$C0
    JSR	    ClearSomeMemory
    LDX	    #3				; Clear	$0300-$03FF
    LDY	    #0
    LDA	    #0
    JSR	    ClearSomeMemory
    JSR	    SetupZoneFromLastDoorEntered
    JSR	    LoadZoneBlocks
    JSR	    LoadZonePalettesMaybe
    JSR	    LoadZoneSpritePalettesMaybe
    JSR	    LoadZoneDoors
    JSR	    LoadZoneItems
    JSR	    LoadZoneASM
    JSR	    LoadZoneEnemyPointers
    RTS
; End of function InitZoneProbably

; =============== S U B	R O U T	I N E =======================================

SetupZoneFromLastDoorEntered:
    LDA	    LastDoorEntered		; Get the last door entered
    LDY	    #0
    STY	    word_18+1			; Shift	left twice (ID * 4)
    ASL	    A
    ROL	    word_18+1
    ASL	    A
    ROL	    word_18+1
    ADC	    #<ZoneDoorTable	; Add the offset to the	door table
    STA	    word_18
    LDA	    word_18+1
    ADC	    #>ZoneDoorTable
    STA	    word_18+1
    LDA	    (word_18),Y			; First	byte is	the Zone number	this door is in
    STA	    CurrentZone			; Store	it for use later, since	we're there now
    INY
    LDA	    (word_18),Y			; Second byte is the X position	of the door (in	tiles)
    STA	    PlayerX
    INY
    LDA	    (word_18),Y			; Third	byte is	the Y position (in... sort-of-not-tiles)
    ORA	    #$40
    STA	    PlayerY
    LDA	    #$80
    STA	    PlayerXLo
    RTS
; End of function SetupZoneFromLastDoorEntered

; =============== S U B	R O U T	I N E =======================================

LoadZoneBlocks:
    LDA	    CurrentZone
    ASL	    A
    TAX
    LDA	    ZoneBlockPointerTable,X
    STA	    CurrentZoneBlockPointer
    LDA	    ZoneBlockPointerTable+1,X
    STA	    CurrentZoneBlockPointer+1
    LDA	    #$C0
    STA	    word_B8
    LDA	    #2
    STA	    word_B8+1
    LDY	    #0
    STY	    byte_22
    STY	    byte_500
    INY
    STY	    byte_21

loc_8D10:
    LDY	    byte_21
    LDA	    (CurrentZoneBlockPointer),Y
    STA	    byte_20
    LDY	    #0

loc_8D1A:
    LDA	    (CurrentZoneBlockPointer),Y
    CMP	    byte_20
    BEQ	    loc_8D3F
    INY
    CPY	    byte_21
    BNE	    loc_8D1A
    INC	    byte_22
    LDA	    byte_22
    AND	    #$F

loc_8D2F:
    LDY	    byte_21
    STA	    byte_500,Y
    INY
    STY	    byte_21
    CPY	    #$20
    BNE	    loc_8D10
    BEQ	    loc_8D44

loc_8D3F:
    LDA	    byte_500,Y
    BPL	    loc_8D2F

loc_8D44:
    LDX	    #0
    LDY	    #0

loc_8D48:
    LDA	    #0
    STA	    byte_13
    LDA	    byte_500,X
    ASL	    A
    ROL	    byte_13
    ASL	    A
    ROL	    byte_13
    ASL	    A
    ROL	    byte_13
    ASL	    A
    ROL	    byte_13
    ASL	    A
    ROL	    byte_13
    ADC	    #0
    STA	    unk_2C0,Y
    LDA	    byte_13
    ADC	    #5
    INY
    STA	    unk_2C0,Y
    INY
    INX
    CPX	    #$20
    BNE	    loc_8D48
    LDA	    #0
    STA	    byte_20

loc_8D7D:
    LDY	    byte_20
    LDA	    (CurrentZoneBlockPointer),Y
    LDX	    #0
    STX	    word_14+1
    ASL	    A
    ROL	    word_14+1
    ASL	    A
    ROL	    word_14+1
    ASL	    A
    ROL	    word_14+1
    ASL	    A
    ROL	    word_14+1
    ADC	    #$50
    STA	    word_14
    LDA	    word_14+1
    ADC	    #$EA
    STA	    word_14+1
    LDA	    byte_20
    ASL	    A
    TAY
    LDA	    unk_2C0,Y
    STA	    word_18
    LDA	    unk_2C1,Y
    STA	    word_18+1
    LDA	    #0
    STA	    byte_23

loc_8DBA:
    LDY	    byte_23
    LDA	    (word_14),Y
    LDX	    #0
    STX	    word_1A+1
    ASL	    A
    ROL	    word_1A+1
    ADC	    #$50
    STA	    word_1A
    LDA	    word_1A+1
    ADC	    #$E8
    STA	    word_1A+1
    LDY	    #0
    LDA	    (word_1A),Y
    STA	    (word_18),Y
    INY
    LDA	    (word_1A),Y
    STA	    (word_18),Y
    INC	    word_18
    INC	    word_18
    INC	    byte_23
    LDA	    byte_23
    CMP	    #$10
    BNE	    loc_8DBA
    INC	    byte_20
    LDA	    byte_20
    CMP	    #$20
    BNE	    loc_8D7D
    RTS
; End of function LoadZoneBlocks

; =============== S U B	R O U T	I N E =======================================

LoadZonePalettesMaybe:
    LDA	    CurrentZone			; A = current zone
    ASL	    A				; A = current zone * 2
    TAX					; X = current zone * 2
    LDA	    byte_9079,X			; Load from table
    ASL	    A
    ASL	    A
    STA	    byte_25
    LDA	    byte_9140,X
    ASL	    A
    ASL	    A
    STA	    byte_26
    LDA	    byte_9141,X
    ASL	    A
    ASL	    A
    STA	    byte_27
    LDA	    byte_9078,X
    ASL	    A
    ASL	    A
    TAX
    LDA	    byte_9276,X
    LDY	    #$1F

loc_8E23:
    STA	    PaletteData,Y
    DEY
    BPL	    loc_8E23
    LDY	    #1

loc_8E2B:
    INX
    LDA	    byte_9276,X
    STA	    PaletteData,Y
    INY
    CPY	    #4
    BNE	    loc_8E2B
    LDX	    byte_25
    LDY	    #1

loc_8E3C:
    INX
    LDA	    byte_9276,X
    STA	    PaletteData+4,Y
    INY
    CPY	    #4
    BNE	    loc_8E3C
    LDX	    byte_26
    LDY	    #1

loc_8E4D:
    INX
    LDA	    byte_9276,X
    STA	    PaletteData+8,Y
    INY
    CPY	    #4
    BNE	    loc_8E4D
    LDX	    byte_27
    LDY	    #1

loc_8E5E:
    INX
    LDA	    byte_9276,X
    STA	    PaletteData+$C,Y
    INY
    CPY	    #4
    BNE	    loc_8E5E
    RTS
; End of function LoadZonePalettesMaybe

; =============== S U B	R O U T	I N E =======================================

LoadZoneSpritePalettesMaybe:
    LDX	    #2

loc_8E6D:
    LDA	    byte_9270,X
    STA	    PaletteData+$19,X
    DEX
    BPL	    loc_8E6D
    LDX	    #2

loc_8E78:
    LDA	    byte_9273,X
    STA	    PaletteData+$1D,X
    DEX
    BPL	    loc_8E78
    LDX	    CurrentZone
    LDA	    byte_9208,X
    STA	    byte_23
    AND	    #$F0
    LSR	    A
    LSR	    A
    LSR	    A
    STA	    byte_24
    LSR	    A
    CLC
    ADC	    byte_24
    TAX
    LDY	    #1

loc_8E9A:
    LDA	    byte_9356,X
    STA	    PaletteData+$10,Y
    INX
    INY
    CPY	    #4
    BNE	    loc_8E9A
    LDA	    byte_23
    AND	    #$F
    STA	    byte_24
    ASL	    A
    ADC	    byte_24
    TAX
    LDY	    #1

loc_8EB5:
    LDA	    byte_9356,X
    STA	    PaletteData+$14,Y
    INX
    INY
    CPY	    #4
    BNE	    loc_8EB5
    LDA	    #$FF
    STA	    PaletteUpdateRequest
    RTS
; End of function LoadZoneSpritePalettesMaybe

; =============== S U B	R O U T	I N E =======================================

LoadZoneDoors:
    LDA	    #<ZoneDoorTable
    STA	    word_1C
    LDA	    #>ZoneDoorTable
    STA	    word_1C+1
    LDA	    #<ZoneDoors
    STA	    word_1E
    LDA	    #>ZoneDoors
    STA	    word_1E+1
    LDA	    #$FF
    STA	    byte_2E

loc_8EE0:
    LDY	    #0
    LDA	    (word_1C),Y
    CMP	    #$FF
    BEQ	    locret_8F2A
    INC	    byte_2E
    CMP	    CurrentZone
    BNE	    loc_8F19
    LDX	    byte_2E
    LDA	    #DoorFlags_Closed|$C0
    CPX	    LastDoorEntered
    BEQ	    loc_8EFF
    LDA	    ZoneDoorFlagsTable,X
    ORA	    #$80

loc_8EFF:
    STA	    (word_1E),Y
    INY
    LDA	    (word_1C),Y
    STA	    (word_1E),Y
    INY
    LDA	    (word_1C),Y
    STA	    (word_1E),Y
    INY
    LDA	    (word_1C),Y
    STA	    (word_1E),Y
    CLC
    LDA	    word_1E
    ADC	    #4
    STA	    word_1E

loc_8F19:
    CLC
    LDA	    word_1C
    ADC	    #4
    STA	    word_1C
    BCC	    loc_8EE0
    INC	    word_1C+1
    JMP	    loc_8EE0
; ---------------------------------------------------------------------------

locret_8F2A:
    RTS
; End of function LoadZoneDoors

; =============== S U B	R O U T	I N E =======================================

LoadZoneItems:
    LDA	    #<ZoneItemTable
    STA	    word_1C
    LDA	    #>ZoneItemTable
    STA	    word_1C+1
    LDA	    #<unk_230
    STA	    word_1E
    LDA	    #>unk_230
    STA	    word_1E+1
    LDA	    #0
    STA	    byte_2F

loc_8F44:
    LDY	    #0
    LDA	    (word_1C),Y
    CMP	    #$FF
    BEQ	    locret_8FC8
    CMP	    CurrentZone
    BNE	    loc_8FB4
    INY
    LDA	    (word_1C),Y
    DEY
    STA	    (word_1E),Y
    LDA	    #$80
    INY
    STA	    (word_1E),Y
    INY
    LDA	    (word_1C),Y
    STA	    (word_1E),Y
    LDA	    #0
    INY
    STA	    (word_1E),Y
    LDA	    (word_1C),Y
    BMI	    loc_8F8A
    TAY
    LDA	    byte_2F
    AND	    #7
    STA	    byte_2E
    LDA	    byte_2F
    LSR	    A
    LSR	    A
    LSR	    A
    TAX
    LDA	    unk_400,X
    LDX	    byte_2E
    AND	    byte_9068,X
    BEQ	    loc_8FA0
    LDY	    #0
    JMP	    loc_8FA0
; ---------------------------------------------------------------------------

loc_8F8A:
    LDX	    #$FF
    STX	    byte_2F
    AND	    #7
    TAY
    LDA	    PlayerItem_Lightbulb,Y
    BEQ	    loc_8FA0
    LDY	    #1
    LDA	    #0
    STA	    (word_1E),Y
    JMP	    loc_8FB7
; ---------------------------------------------------------------------------

loc_8FA0:
    TYA
    LDY	    #7
    STA	    (word_1E),Y
    LDA	    byte_2F
    DEY
    STA	    (word_1E),Y
    CLC
    LDA	    word_1E
    ADC	    #8
    STA	    word_1E

loc_8FB4:
    INC	    byte_2F

loc_8FB7:
    CLC
    LDA	    word_1C
    ADC	    #4
    STA	    word_1C
    BCC	    loc_8F44
    INC	    word_1C+1
    JMP	    loc_8F44
; ---------------------------------------------------------------------------

locret_8FC8:
    RTS
; End of function LoadZoneItems

; =============== S U B	R O U T	I N E =======================================

sub_8FC9:
    JSR	    ClearPaletteToBlack
    JSR	    SetCurrentZoneCHR
    LDA	    PlayerX
    SEC
    SBC	    #$20
    STA	    byte_2
    LDA	    #$80
    STA	    byte_3
    STA	    byte_7

loc_8FE0:
    CLC
    LDA	    byte_2
    ADC	    #1
    STA	    byte_6
    JSR	    sub_869A
    JSR	    sub_89F9
    SEC
    LDA	    PlayerX
    SBC	    #8
    CMP	    byte_2
    BNE	    loc_8FE0
    LDX	    PPUScrollX
    LDY	    PPUScrollY
    LDA	    PPUCtrl
    STX	    PPUSCROLL
    STY	    PPUSCROLL
    STA	    PPUCTRL
    JSR	    EnableNMI
    RTS
; End of function sub_8FC9

; =============== S U B	R O U T	I N E =======================================

LoadZoneEnemyPointers:
    LDA	    CurrentZone
    ASL	    A
    TAX
    LDA	    ZoneEnemyTable,X		; Load table offset for	this zone's enemy list
    STA	    word_14
    LDA	    ZoneEnemyTable+1,X
    STA	    word_14+1
    LDY	    #0

loc_9023:
    LDA	    (word_14),Y			; Load this enemy ID
    BMI	    loc_9045			; If >=80 (i.e.	FF), we're done: skip ahead
    ASL	    A				; Otherwise, load the pointer
    TAX
    LDA	    ProbablyEnemyPointers,X	; Store	the lo part at $380 + Y
    STA	    EnemyPointersLo,Y
    LDA	    ProbablyEnemyPointers+1,X	; Store	the hi part at $388 + Y
    STA	    EnemyPointersHi,Y
    INY
    BNE	    loc_9023			; Repeat until we encounter an $FF

loc_9038:
    LDA	    ProbablyEnemyPointers	; Fill remaining slots with nothing
    STA	    EnemyPointersLo,Y
    LDA	    ProbablyEnemyPointers+1
    STA	    EnemyPointersHi,Y
    INY

loc_9045:
    CPY	    #8				; Did we fill 8	slots?
    BNE	    loc_9038			; If not, go back and fill the remaining slots with nothing
    RTS
; End of function LoadZoneEnemyPointers

; =============== S U B	R O U T	I N E =======================================

LoadZoneASM:
    LDA	    CurrentZone
    ASL	    A
    TAX
    LDA	    ZoneASMPointerTable,X
    STA	    CurrentZoneASM
    LDA	    ZoneASMPointerTable+1,X
    STA	    CurrentZoneASM+1
    RTS
; End of function LoadZoneASM

; =============== S U B	R O U T	I N E =======================================

LoadZoneMusic:
    JSR	    InitSoundEngine
    LDX	    CurrentZone
    LDA	    ZoneMusicTable,X
    JMP	    PlayMusicTrack
; End of function LoadZoneMusic

; ---------------------------------------------------------------------------
byte_9068:
    .BYTE	1
    .BYTE 2
    .BYTE 4
    .BYTE 8
    .BYTE $10
    .BYTE $20
    .BYTE $40
    .BYTE $80
    .BYTE $FE
    .BYTE $FD
    .BYTE $FB
    .BYTE $F7
    .BYTE $EF
    .BYTE $DF
    .BYTE $BF
    .BYTE $7F
byte_9078:
    .BYTE	$36
byte_9079:
    .BYTE	$28
    .BYTE 4
    .BYTE $19
    .BYTE 5
    .BYTE $1A
    .BYTE $12
    .BYTE $16
    .BYTE $16
    .BYTE 4
    .BYTE $19
    .BYTE $19
    .BYTE $25
    .BYTE $2F
    .BYTE $19
    .BYTE $19
    .BYTE $19
    .BYTE $19
    .BYTE $25
    .BYTE $25
    .BYTE 7
    .BYTE 0
    .BYTE 7
    .BYTE 7
    .BYTE $12
    .BYTE $12
    .BYTE $25
    .BYTE $2F
    .BYTE $1E
    .BYTE $1E
    .BYTE $D
    .BYTE $D
    .BYTE $19
    .BYTE $1F
    .BYTE $D
    .BYTE $D
    .BYTE 4
    .BYTE 4
    .BYTE $16
    .BYTE $1F
    .BYTE 4
    .BYTE 4
    .BYTE 0
    .BYTE $1F
    .BYTE $D
    .BYTE $1F
    .BYTE $1B
    .BYTE $1B
    .BYTE $2D
    .BYTE $2D
    .BYTE $28
    .BYTE 5
    .BYTE $1B
    .BYTE $1B
    .BYTE $31
    .BYTE $31
    .BYTE $1B
    .BYTE 1
    .BYTE $32
    .BYTE $32
    .BYTE $23
    .BYTE 7
    .BYTE $22
    .BYTE $30
    .BYTE 8
    .BYTE $B
    .BYTE $B
    .BYTE $B
    .BYTE $12
    .BYTE $2E
    .BYTE $31
    .BYTE $31
    .BYTE $12
    .BYTE $12
    .BYTE $31
    .BYTE $31
    .BYTE $B
    .BYTE $B
    .BYTE $32
    .BYTE $32
    .BYTE 0
    .BYTE 0
    .BYTE 4
    .BYTE 4
    .BYTE $B
    .BYTE $B
    .BYTE $26
    .BYTE $26
    .BYTE 0
    .BYTE $27
    .BYTE 0
    .BYTE 0
    .BYTE $1C
    .BYTE $1C
    .BYTE $31
    .BYTE $31
    .BYTE $C
    .BYTE $1D
    .BYTE $2D
    .BYTE $19
    .BYTE $32
    .BYTE $32
    .BYTE 0
    .BYTE $B
    .BYTE 0
    .BYTE 0
    .BYTE 6
    .BYTE 6
    .BYTE $2C
    .BYTE $2C
    .BYTE 0
    .BYTE $27
    .BYTE 0
    .BYTE $19
    .BYTE $31
    .BYTE $31
    .BYTE $27
    .BYTE $27
    .BYTE 0
    .BYTE $27
    .BYTE $32
    .BYTE $32
    .BYTE 0
    .BYTE $24
    .BYTE 0
    .BYTE $19
    .BYTE $2B
    .BYTE $19
    .BYTE $32
    .BYTE $32
    .BYTE 3
    .BYTE 3
    .BYTE $32
    .BYTE $32
    .BYTE $31
    .BYTE $31
    .BYTE $17
    .BYTE $20
    .BYTE $C
    .BYTE $C
    .BYTE $32
    .BYTE $32
    .BYTE $32
    .BYTE $32
    .BYTE 0
    .BYTE $2B
    .BYTE $19
    .BYTE $19
    .BYTE $19
    .BYTE $19
    .BYTE 0
    .BYTE $D
    .BYTE 0
    .BYTE 0
    .BYTE 4
    .BYTE 4
    .BYTE 0
    .BYTE $10
    .BYTE $D
    .BYTE $D
    .BYTE $2B
    .BYTE $2B
    .BYTE 8
    .BYTE 8
    .BYTE $B
    .BYTE 0
    .BYTE $B
    .BYTE $B
    .BYTE $10
    .BYTE $10
    .BYTE $31
    .BYTE $31
    .BYTE $2B
    .BYTE $2B
    .BYTE $31
    .BYTE $31
    .BYTE $31
    .BYTE $31
    .BYTE $2D
    .BYTE $2D
    .BYTE 4
    .BYTE $27
    .BYTE 7
    .BYTE 7
    .BYTE 8
    .BYTE $10
    .BYTE $2B
    .BYTE $2B
    .BYTE 0
    .BYTE $27
    .BYTE 0
    .BYTE $27
    .BYTE $10
    .BYTE $20
    .BYTE 4
    .BYTE 4
    .BYTE $B
    .BYTE 4
    .BYTE 0
    .BYTE $1F
byte_9140:
    .BYTE	$1A
byte_9141:
    .BYTE	5
    .BYTE $19
    .BYTE $19
    .BYTE $1A
    .BYTE $1A
    .BYTE $19
    .BYTE $19
    .BYTE 4
    .BYTE 4
    .BYTE 4
    .BYTE 4
    .BYTE $1A
    .BYTE 5
    .BYTE 4
    .BYTE 4
    .BYTE $19
    .BYTE $19
    .BYTE $13
    .BYTE 5
    .BYTE $15
    .BYTE 0
    .BYTE 7
    .BYTE 7
    .BYTE 4
    .BYTE 4
    .BYTE 5
    .BYTE 5
    .BYTE 7
    .BYTE 7
    .BYTE $B
    .BYTE $1F
    .BYTE $1F
    .BYTE $1F
    .BYTE $2D
    .BYTE $2D
    .BYTE $B
    .BYTE $B
    .BYTE $1F
    .BYTE $1F
    .BYTE $19
    .BYTE $19
    .BYTE $1F
    .BYTE $1F
    .BYTE $19
    .BYTE $19
    .BYTE 1
    .BYTE 1
    .BYTE 4
    .BYTE 4
    .BYTE 5
    .BYTE 5
    .BYTE $1B
    .BYTE $1B
    .BYTE $31
    .BYTE $33
    .BYTE $E
    .BYTE $E
    .BYTE $33
    .BYTE $33
    .BYTE 7
    .BYTE 7
    .BYTE 2
    .BYTE $19
    .BYTE $19
    .BYTE $19
    .BYTE $21
    .BYTE $12
    .BYTE $19
    .BYTE $19
    .BYTE $31
    .BYTE $37
    .BYTE $19
    .BYTE $19
    .BYTE $31
    .BYTE $33
    .BYTE 4
    .BYTE 4
    .BYTE $32
    .BYTE $32
    .BYTE 0
    .BYTE 0
    .BYTE 4
    .BYTE 4
    .BYTE 0
    .BYTE 0
    .BYTE $F
    .BYTE $18
    .BYTE 4
    .BYTE 4
    .BYTE $19
    .BYTE $19
    .BYTE $29
    .BYTE $29
    .BYTE $31
    .BYTE $33
    .BYTE 6
    .BYTE 6
    .BYTE $19
    .BYTE $19
    .BYTE $32
    .BYTE $32
    .BYTE 0
    .BYTE $16
    .BYTE 0
    .BYTE 0
    .BYTE $2A
    .BYTE $35
    .BYTE $2C
    .BYTE $2C
    .BYTE $2B
    .BYTE $2B
    .BYTE $19
    .BYTE $19
    .BYTE $33
    .BYTE $33
    .BYTE $27
    .BYTE $27
    .BYTE $2B
    .BYTE $2B
    .BYTE $32
    .BYTE $32
    .BYTE $19
    .BYTE $19
    .BYTE $1F
    .BYTE $1F
    .BYTE $1F
    .BYTE $1F
    .BYTE $32
    .BYTE $32
    .BYTE 7
    .BYTE 7
    .BYTE $32
    .BYTE $32
    .BYTE $31
    .BYTE $33
    .BYTE 5
    .BYTE 5
    .BYTE $A
    .BYTE $35
    .BYTE $32
    .BYTE $32
    .BYTE $32
    .BYTE $32
    .BYTE 0
    .BYTE $2B
    .BYTE 4
    .BYTE 4
    .BYTE $10
    .BYTE $10
    .BYTE $10
    .BYTE $10
    .BYTE $10
    .BYTE $10
    .BYTE $2B
    .BYTE $2B
    .BYTE $21
    .BYTE $B
    .BYTE 0
    .BYTE 0
    .BYTE $2D
    .BYTE $2D
    .BYTE $12
    .BYTE $B
    .BYTE 4
    .BYTE 4
    .BYTE 8
    .BYTE 8
    .BYTE 0
    .BYTE 8
    .BYTE $31
    .BYTE $34
    .BYTE 0
    .BYTE 0
    .BYTE $31
    .BYTE $33
    .BYTE $31
    .BYTE $34
    .BYTE $21
    .BYTE $21
    .BYTE $24
    .BYTE $24
    .BYTE 7
    .BYTE 7
    .BYTE $D
    .BYTE $D
    .BYTE $2B
    .BYTE $2B
    .BYTE $19
    .BYTE $19
    .BYTE $19
    .BYTE $19
    .BYTE $D
    .BYTE 8
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 0
    .BYTE 4
    .BYTE 8
byte_9208:
    .BYTE	$29,  0,$60,$21,  0,$20,$41,  0,  0,$40
    .BYTE   0,$21,  1,$20,  0,$21,$60,	0,  3,	0; 10
    .BYTE   1,	3,  1,$41,$20,	0,$67,	0,  1,	3; 20
    .BYTE   1,	1,$51,$67,  0,	0,$60,$20,$40,	0; 30
    .BYTE   0,	0,  3,$40,  0,	0,$41,	0,  1,	0; 40
    .BYTE $60,$40,$20,$40,  0,$51,  3,$67,$20,	3; 50
    .BYTE   3,	1,  0,	0,$67,	0,  0,	0,$40,$40; 60
    .BYTE   0,$21,$60,	1,$40,	0,  0,$40,$67,	0; 70
    .BYTE $20,$40,$21,	1,$67,$51,$41,	0,  0,$67; 80
    .BYTE   0,	3,  0,$67,$23,$51,$40,	0,$21,$BE; 90
    .BYTE   0
    .BYTE   0
    .BYTE   0
    .BYTE   0
byte_9270:
    .BYTE	$16
    .BYTE $28
    .BYTE $20
byte_9273:
    .BYTE	7
    .BYTE $27
    .BYTE $38
byte_9276:
    .BYTE	$F
    .BYTE $F
    .BYTE 0
    .BYTE $10
    .BYTE   3
    .BYTE $F
    .BYTE 0
    .BYTE $10
    .BYTE $35 ;	5
    .BYTE $F
    .BYTE 0
    .BYTE $10
    .BYTE 8
    .BYTE $F
    .BYTE 0
    .BYTE $10
    .BYTE $F
    .BYTE 0
    .BYTE $10
    .BYTE $20
    .BYTE $22
    .BYTE 0
    .BYTE $10
    .BYTE $20
    .BYTE $16
    .BYTE $F
    .BYTE 0
    .BYTE $10
    .BYTE 8
    .BYTE 0
    .BYTE $10
    .BYTE $20
    .BYTE $F
    .BYTE $12
    .BYTE $22
    .BYTE $32
    .BYTE $22
    .BYTE $12
    .BYTE $22
    .BYTE $32 ;	2
    .BYTE $16
    .BYTE $12
    .BYTE $22
    .BYTE $32
    .BYTE $F
    .BYTE $F
    .BYTE 3
    .BYTE $13
    .BYTE $16
    .BYTE $F
    .BYTE 3
    .BYTE $13
    .BYTE $F
    .BYTE 4
    .BYTE $14
    .BYTE $24
    .BYTE   3
    .BYTE 4
    .BYTE $14
    .BYTE $24
    .BYTE $35 ;	5
    .BYTE 4
    .BYTE $14
    .BYTE $24
    .BYTE $F
    .BYTE $16
    .BYTE $26
    .BYTE $36
    .BYTE $22
    .BYTE $16
    .BYTE $26
    .BYTE $36 ;	6
    .BYTE $F
    .BYTE 7
    .BYTE $17
    .BYTE $27
    .BYTE $22
    .BYTE 7
    .BYTE $17
    .BYTE $27
    .BYTE $16
    .BYTE   7
    .BYTE $17
    .BYTE $27
    .BYTE   8
    .BYTE 7
    .BYTE $17
    .BYTE $27
    .BYTE $F
    .BYTE $17
    .BYTE $27
    .BYTE $37
    .BYTE $22
    .BYTE $17
    .BYTE $27
    .BYTE $37
    .BYTE $35 ;	5
    .BYTE $17
    .BYTE $27
    .BYTE $37
    .BYTE $F
    .BYTE 8
    .BYTE $18
    .BYTE $28
    .BYTE $22
    .BYTE 8
    .BYTE $18
    .BYTE $28
    .BYTE 3
    .BYTE 8
    .BYTE $18
    .BYTE $28
    .BYTE $35
    .BYTE 8
    .BYTE $18
    .BYTE $28
    .BYTE $16
    .BYTE 8
    .BYTE $18
    .BYTE $28
    .BYTE 8
    .BYTE 8
    .BYTE $18
    .BYTE $28
    .BYTE  $F
    .BYTE $18
    .BYTE $28
    .BYTE $38
    .BYTE $22
    .BYTE $18
    .BYTE $28
    .BYTE $38
    .BYTE  $F
    .BYTE 9
    .BYTE $19
    .BYTE $29
    .BYTE $35
    .BYTE 9
    .BYTE $19
    .BYTE $29
    .BYTE 8
    .BYTE 9
    .BYTE $19
    .BYTE $29
    .BYTE  $F
    .BYTE $19
    .BYTE $29
    .BYTE $39
    .BYTE $22
    .BYTE $19
    .BYTE $29
    .BYTE $39
    .BYTE $35
    .BYTE $19
    .BYTE $29
    .BYTE $39
    .BYTE $F
    .BYTE $A
    .BYTE $1A
    .BYTE $2A
    .BYTE $22
    .BYTE $A
    .BYTE $1A
    .BYTE $2A
    .BYTE $35 ;	5
    .BYTE $A
    .BYTE $1A
    .BYTE $2A
    .BYTE $16
    .BYTE $A
    .BYTE $1A
    .BYTE $2A
    .BYTE $F
    .BYTE $1C
    .BYTE $2C
    .BYTE $3C
    .BYTE $16
    .BYTE $1C
    .BYTE $2C
    .BYTE $3C
    .BYTE $F
    .BYTE 7
    .BYTE $1A
    .BYTE $37
    .BYTE  $F
    .BYTE 8
    .BYTE $18
    .BYTE $29
    .BYTE $22
    .BYTE 8
    .BYTE $18
    .BYTE $29
    .BYTE $35 ;	5
    .BYTE 8
    .BYTE $18
    .BYTE $29
    .BYTE $F
    .BYTE $F
    .BYTE $F
    .BYTE $F
    .BYTE $30
    .BYTE $11
    .BYTE $21
    .BYTE $31
    .BYTE  $F
    .BYTE $F
    .BYTE $F
    .BYTE 5
    .BYTE  $F
    .BYTE $F
    .BYTE $F
    .BYTE 2
    .BYTE $16
    .BYTE $16
    .BYTE $26
    .BYTE $36
    .BYTE $22
    .BYTE $22
    .BYTE $22
    .BYTE $22
    .BYTE  $F
    .BYTE $28
    .BYTE $16
    .BYTE $39
byte_9356:
    .BYTE	$16
    .BYTE $2A
    .BYTE $3A
    .BYTE 0
    .BYTE $10
    .BYTE $20
    .BYTE $16
    .BYTE $10
    .BYTE 0
    .BYTE $17
    .BYTE $23
    .BYTE $33
    .BYTE 8
    .BYTE $18
    .BYTE $28
    .BYTE $20
    .BYTE $17
    .BYTE $28
    .BYTE $20
    .BYTE $16
    .BYTE $29
    .BYTE $27
    .BYTE $3B
    .BYTE $1A
    .BYTE   7
    .BYTE $27
    .BYTE $38 ;	8
    .BYTE $12
    .BYTE $16
    .BYTE $20
    .BYTE $37 ;	7
    .BYTE $10
    .BYTE $20
    .BYTE $22
    .BYTE $21
    .BYTE $30
    .BYTE $28
    .BYTE $39 ;	9
    .BYTE $2C
    .BYTE $12
    .BYTE $27
    .BYTE $38 ;	8
    .BYTE 0
    .BYTE $10
    .BYTE $20
    .BYTE $20
    .BYTE  $F
    .BYTE  $F
; ---------------------------------------------------------------------------

locret_9386:
    RTS

; =============== S U B	R O U T	I N E =======================================

sub_9387:
    LDA	    GamePaused
    BNE	    locret_9386
    LDA	    #$10
    STA	    word_A2
    LDA	    #2
    STA	    word_A2+1
    LDA	    PlayerState
    BPL	    loc_939E
    JMP	    loc_96E5
; ---------------------------------------------------------------------------

loc_939E:
    LDA	    PlayerState
    AND	    #PlayerStates_Jumping
    BNE	    loc_93A8
    JMP	    loc_93B4
; ---------------------------------------------------------------------------

loc_93A8:
    LDA	    byte_218
    AND	    #3
    BEQ	    loc_93B4
    LDX	    #2
    JMP	    loc_93DC
; ---------------------------------------------------------------------------

loc_93B4:
    LDX	    #2
    LDA	    PlayerState
    AND	    #PlayerStates_Jumping
    BNE	    loc_93C8
    LDX	    #4
    LDA	    ProbablyZoneStatusShit
    AND	    #1
    BNE	    loc_93C8
    LDX	    #0

loc_93C8:
    LDA	    Joypad_Held
    AND	    #1
    BEQ	    loc_93D2
    JMP	    loc_940D
; ---------------------------------------------------------------------------

loc_93D2:
    LDA	    Joypad_Held
    AND	    #2
    BEQ	    loc_93DC
    JMP	    loc_9438
; ---------------------------------------------------------------------------

loc_93DC:
    LDA	    PlayerSpeedX
    BNE	    loc_93E4
    JMP	    loc_9462
; ---------------------------------------------------------------------------

loc_93E4:
    TAY
    LDA	    ProbablyZoneStatusShit
    AND	    #1
    BEQ	    loc_93F3
    LDA	    byte_218
    AND	    #7
    BNE	    loc_940A

loc_93F3:
    TYA
    BPL	    loc_93FF
    INX
    CLC
    ADC	    byte_98FE,X
    BMI	    loc_9407
    BPL	    loc_9405

loc_93FF:
    CLC
    ADC	    byte_98FE,X
    BPL	    loc_9407

loc_9405:
    LDA	    #0

loc_9407:
    STA	    PlayerSpeedX

loc_940A:
    JMP	    loc_9462
; ---------------------------------------------------------------------------

loc_940D:
    INX
    LDA	    PlayerSpeedX
    CLC
    BEQ	    loc_9425
    BMI	    loc_9425
    ADC	    byte_98F8,X
    CMP	    #$18
    BMI	    loc_941F
    LDA	    #$18

loc_941F:
    STA	    PlayerSpeedX
    JMP	    loc_9462
; ---------------------------------------------------------------------------

loc_9425:
    ADC	    byte_98F8,X
    STA	    PlayerSpeedX
    BMI	    loc_9462
    LDA	    PlayerState
    AND	    #$FE
    STA	    PlayerState
    JMP	    loc_9462
; ---------------------------------------------------------------------------

loc_9438:
    LDA	    PlayerSpeedX
    CLC
    BMI	    loc_9453
    ADC	    byte_98F8,X
    STA	    PlayerSpeedX
    BEQ	    loc_9448
    BPL	    loc_9462

loc_9448:
    LDA	    PlayerState
    ORA	    #PlayerStates_FacingLeft
    STA	    PlayerState
    JMP	    loc_9462
; ---------------------------------------------------------------------------

loc_9453:
    ADC	    byte_98F8,X
    CMP	    #$E8
    BPL	    loc_945C
    LDA	    #$E8

loc_945C:
    STA	    PlayerSpeedX
    JMP	    loc_9462
; ---------------------------------------------------------------------------

loc_9462:
    LDA	    PlayerSpeedX
    BMI	    loc_9479
    CLC
    ADC	    PlayerXLo
    STA	    byte_11
    LDA	    PlayerX
    ADC	    #0
    STA	    byte_10
    JMP	    loc_9488
; ---------------------------------------------------------------------------

loc_9479:
    CLC
    ADC	    PlayerXLo
    STA	    byte_11
    LDA	    PlayerX
    ADC	    #$FF
    STA	    byte_10

loc_9488:
    LDA	    PlayerSpeedX
    BNE	    loc_9490
    JMP	    loc_94F9
; ---------------------------------------------------------------------------

loc_9490:
    BMI	    loc_94A0
    CLC
    LDA	    byte_11
    ADC	    #$40
    LDA	    byte_10
    ADC	    #0
    JMP	    loc_94AB
; ---------------------------------------------------------------------------

loc_94A0:
    SEC
    LDA	    byte_11
    SBC	    #$40
    LDA	    byte_10
    SBC	    #0

loc_94AB:
    STA	    byte_A0
    SEC
    LDA	    PlayerYLo
    SBC	    #$40
    LDA	    PlayerY
    SBC	    #0
    STA	    byte_A1
    AND	    #$40
    BEQ	    loc_94C7
    JSR	    sub_8A6C
    CMP	    #3
    BEQ	    loc_9508

loc_94C7:
    SEC
    LDA	    PlayerYLo
    SBC	    #$C0
    LDA	    PlayerY
    SBC	    #3
    STA	    byte_A1
    AND	    #$40
    BEQ	    loc_94E0
    JSR	    sub_8A6C
    CMP	    #3
    BEQ	    loc_9508

loc_94E0:
    SEC
    LDA	    PlayerYLo
    SBC	    #$40
    LDA	    PlayerY
    SBC	    #7
    STA	    byte_A1
    AND	    #$40
    BEQ	    loc_94F9
    JSR	    sub_8A6C
    CMP	    #3
    BEQ	    loc_9508

loc_94F9:
    LDA	    byte_10
    STA	    PlayerX
    LDA	    byte_11
    STA	    PlayerXLo
    JMP	    loc_951B
; ---------------------------------------------------------------------------

loc_9508:
    LDX	    #$40
    LDY	    #$FF
    LDA	    PlayerSpeedX
    BMI	    loc_9515
    LDX	    #$B0
    LDY	    #1

loc_9515:
    STX	    PlayerXLo
    STY	    PlayerSpeedX

loc_951B:
    LDA	    PlayerState
    AND	    #4
    BNE	    loc_9549
    LDA	    Joypad_Immediate
    AND	    #$80
    BNE	    loc_952C
    JMP	    loc_9592
; ---------------------------------------------------------------------------

loc_952C:
    LDA	    PlayerState
    ORA	    #PlayerStates_Jumping
    STA	    PlayerState
    LDA	    PlayerSpeedX
    CMP	    #$18
    BEQ	    loc_9544
    CMP	    #$E8
    BEQ	    loc_9544
    LDX	    #$37
    JMP	    loc_9551
; ---------------------------------------------------------------------------

loc_9544:
    LDX	    #$40
    JMP	    loc_9551
; ---------------------------------------------------------------------------

loc_9549:
    LDX	    byte_219
    DEX
    BPL	    loc_9551
    LDX	    #0

loc_9551:
    CPX	    #$20
    BMI	    loc_955D
    LDA	    Joypad_Held
    AND	    #$80
    BNE	    loc_955D
    DEX

loc_955D:
    STX	    byte_219
    LDA	    byte_9904,X
    BEQ	    loc_9587
    BMI	    loc_9577
    ASL	    A
    CLC
    ADC	    PlayerYLo
    STA	    PlayerYLo
    BCC	    loc_95A7
    INC	    PlayerY
    JMP	    loc_95A7
; ---------------------------------------------------------------------------

loc_9577:
    ASL	    A
    CLC
    ADC	    PlayerYLo
    STA	    PlayerYLo
    BCS	    loc_9584
    DEC	    PlayerY

loc_9584:
    JMP	    loc_95D5
; ---------------------------------------------------------------------------

loc_9587:
    LDA	    PlayerState
    ORA	    #PlayerStates_08
    STA	    PlayerState
    JMP	    loc_95D5
; ---------------------------------------------------------------------------

loc_9592:
    JSR	    sub_8B5D
    BNE	    loc_95A4
    LDA	    PlayerState
    ORA	    #PlayerStates_Jumping|PlayerStates_08
    STA	    PlayerState
    LDX	    #$1C
    STX	    byte_219

loc_95A4:
    JMP	    loc_962E
; ---------------------------------------------------------------------------

loc_95A7:
    LDA	    PlayerY
    BPL	    loc_95B8
    AND	    #$C0
    CMP	    #$C0
    BNE	    loc_95D2
    LDA	    #$FF
    STA	    byte_1C3
    RTS
; ---------------------------------------------------------------------------

loc_95B8:
    JSR	    sub_8B5D
    BEQ	    loc_95D2
    LDA	    PlayerY
    AND	    #$FC
    STA	    PlayerY
    LDA	    #0
    STA	    PlayerYLo
    LDA	    PlayerState
    AND	    #$F3
    STA	    PlayerState

loc_95D2:
    JMP	    loc_962E
; ---------------------------------------------------------------------------

loc_95D5:
    SEC
    LDA	    PlayerYLo
    SBC	    #$40
    LDA	    PlayerY
    SBC	    #7
    STA	    byte_A1
    AND	    #$C0
    BEQ	    loc_9611
    CLC
    LDA	    PlayerXLo
    ADC	    #$40
    LDA	    PlayerX
    ADC	    #0
    STA	    byte_A0
    JSR	    sub_8A6C
    CMP	    #3
    BEQ	    loc_9614
    SEC
    LDA	    PlayerXLo
    SBC	    #$40
    LDA	    PlayerX
    SBC	    #0
    STA	    byte_A0
    JSR	    sub_8A6C
    CMP	    #3
    BEQ	    loc_9614

loc_9611:
    JMP	    loc_962E
; ---------------------------------------------------------------------------

loc_9614:
    LDA	    PlayerY
    ORA	    #3
    STA	    PlayerY
    LDA	    #$40
    STA	    PlayerYLo
    LDA	    PlayerState
    ORA	    #PlayerStates_08
    STA	    PlayerState
    LDX	    #$20
    STX	    byte_219

loc_962E:
    LDA	    PlayerState
    AND	    #PlayerStates_ThrowingBomb|PlayerStates_Jumping
    BNE	    loc_9645
    LDA	    Joypad_Held
    AND	    #$F
    CMP	    #4
    BNE	    loc_9645
    LDA	    PlayerState
    ORA	    #PlayerStates_Ducking
    BNE	    loc_964A

loc_9645:
    LDA	    PlayerState
    AND	    #$EF

loc_964A:
    STA	    PlayerState
    LDA	    PlayerState
    AND	    #PlayerStates_ThrowingBomb
    BNE	    loc_9670
    LDA	    byte_266
    BNE	    loc_968E
    LDA	    Joypad_Immediate
    AND	    #ControllerInput_B
    BEQ	    loc_968E
    LDA	    #8
    STA	    byte_21A
    LDA	    PlayerState
    ORA	    #PlayerStates_ThrowingBomb
    STA	    PlayerState
    JMP	    loc_968E
; ---------------------------------------------------------------------------

loc_9670:
    LDY	    byte_21A
    DEY
    STY	    byte_21A
    BEQ	    loc_9683
    CPY	    #4
    BNE	    loc_968B
    JSR	    sub_9751
    JMP	    loc_968B
; ---------------------------------------------------------------------------

loc_9683:
    LDA	    PlayerState
    AND	    #$FD
    STA	    PlayerState

loc_968B:
    JMP	    loc_968E
; ---------------------------------------------------------------------------

loc_968E:
    INC	    byte_218

loc_9691:
    LDA	    #$80
    STA	    byte_214
    BEQ	    loc_9691
    LDA	    PlayerY
    STA	    byte_215
    LDA	    PlayerYLo
    ASL	    A
    ROL	    byte_215
    ASL	    A
    ROL	    byte_215
    LDA	    ProbablyZoneStatusShit
    BCC	    loc_96BA
    LDX	    PlayerY
    CPX	    #$43
    BCC	    loc_96BA
    AND	    #$7F
    JMP	    loc_96BC
; ---------------------------------------------------------------------------

loc_96BA:
    ORA	    #$80

loc_96BC:
    STA	    ProbablyZoneStatusShit
    LDA	    PlayerItem_UpArrow
    BEQ	    loc_96D0
    LDA	    Joypad_Immediate
    AND	    #ControllerInput_Up
    BEQ	    loc_96D0
    LDA	    #3
    JSR	    AwardPoints

loc_96D0:
    LDA	    PlayerItem_Microphone
    BEQ	    locret_96E4
    LDA	    UnknownTimer014A
    BNE	    locret_96E4
    JSR	    UpdateMicrophone
    BEQ	    locret_96E4
    LDA	    #125
    STA	    UnknownTimer014A

locret_96E4:
    RTS
; ---------------------------------------------------------------------------

loc_96E5:
    AND	    #$40
    BEQ	    loc_971D
    LDX	    byte_220
    DEX
    BEQ	    loc_96F5
    STX	    byte_220
    JMP	    loc_9691
; ---------------------------------------------------------------------------

loc_96F5:
    LDX	    byte_21F
    DEX
    BEQ	    loc_96FE
    STX	    byte_21F

loc_96FE:
    LDA	    byte_9904,X
    ASL	    A
    CLC
    ADC	    PlayerYLo
    STA	    PlayerYLo
    BCC	    loc_971A
    INC	    PlayerY
    LDA	    PlayerY
    CMP	    #$B0
    BCC	    loc_971A
    LDA	    #$FF
    STA	    byte_1C3

loc_971A:
    JMP	    loc_9691
; ---------------------------------------------------------------------------

loc_971D:
    LDX	    byte_220
    DEX
    BEQ	    loc_96F5
    STX	    byte_220
    CPX	    #$48
    BNE	    loc_9738
    LDY	    #2

loc_972C:
    LDA	    byte_9273,Y
    STA	    PaletteData+$19,Y
    DEY
    BPL	    loc_972C
    STY	    PaletteUpdateRequest

loc_9738:
    TXA
    AND	    #$CF
    BNE	    loc_974E
    TXA
    LSR	    A
    LSR	    A
    LSR	    A
    LSR	    A
    EOR	    #3
    TAY
    LDA	    byte_9945,Y
    STA	    PaletteData+$19,Y
    STX	    PaletteUpdateRequest

loc_974E:
    JMP	    loc_9691
; End of function sub_9387

; =============== S U B	R O U T	I N E =======================================

sub_9751:
    LDA	    #MusicTrack_ThrowBomb
    JSR	    PlayMusicTrack
    LDA	    PlayerState
    AND	    #PlayerStates_FacingLeft
    BNE	    loc_977F
    LDA	    PlayerXLo
    CLC
    ADC	    #$40
    STA	    byte_261
    LDA	    PlayerX
    ADC	    #0
    STA	    byte_260
    LDX	    #$30
    LDA	    Joypad_Held
    AND	    #4
    BEQ	    loc_9779
    LDX	    #$18

loc_9779:
    STX	    byte_269
    JMP	    loc_979E
; ---------------------------------------------------------------------------

loc_977F:
    LDA	    PlayerXLo
    SEC
    SBC	    #$40
    STA	    byte_261
    LDA	    PlayerX
    SBC	    #0
    STA	    byte_260
    LDX	    #$D0
    LDA	    Joypad_Held
    AND	    #4
    BEQ	    loc_979B
    LDX	    #$E8

loc_979B:
    STX	    byte_269

loc_979E:
    LDA	    PlayerYLo
    STA	    byte_263
    SEC
    LDA	    PlayerY
    SBC	    #6
    STA	    byte_262
    LDA	    Joypad_Held
    LDX	    #$23
    AND	    #4
    BEQ	    loc_97BE
    LDX	    #$1C
    INC	    byte_262
    INC	    byte_262

loc_97BE:
    STX	    byte_26A
    LDA	    #$FF
    STA	    byte_266
    LDA	    #$50
    STA	    byte_268

locret_97CB:
    RTS
; End of function sub_9751

; =============== S U B	R O U T	I N E =======================================

sub_97CC:
    LDA	    GamePaused
    BNE	    locret_97CB
    LDX	    byte_266
    BEQ	    locret_97CB
    LDA	    #$60
    STA	    word_A2
    LDA	    #2
    STA	    word_A2+1
    LDA	    byte_267
    AND	    #1
    BEQ	    loc_97EA
    JMP	    loc_98D6
; ---------------------------------------------------------------------------

loc_97EA:
    LDX	    byte_268
    DEX
    STX	    byte_268
    BNE	    loc_9805
    LDX	    #$F
    STX	    byte_268
    LDA	    byte_267
    ORA	    #1
    STA	    byte_267
    LDA	    #MusicTrack_BombExplode
    JSR	    PlayMusicTrack

loc_9805:
    LDX	    byte_26F
    BEQ	    loc_980F
    STA	    byte_269
    BEQ	    loc_983E

loc_980F:
    CLC
    LDA	    byte_269
    BMI	    loc_9823
    ADC	    byte_261
    STA	    byte_11
    LDA	    byte_260
    ADC	    #0
    JMP	    loc_982E
; ---------------------------------------------------------------------------

loc_9823:
    ADC	    byte_261
    STA	    byte_11
    LDA	    byte_260
    ADC	    #$FF

loc_982E:
    STA	    byte_A0
    LDA	    byte_262
    STA	    byte_A1
    JSR	    sub_8A6C
    CMP	    #3
    BNE	    loc_9859

loc_983E:
    LDA	    byte_269
    BPL	    loc_984A
    SEC
    ROR	    A
    SEC
    ROR	    A
    JMP	    loc_984E
; ---------------------------------------------------------------------------

loc_984A:
    CLC
    ROR	    A
    CLC
    ROR	    A

loc_984E:
    EOR	    #$FF
    CLC
    ADC	    #1
    STA	    byte_269
    JMP	    loc_9865
; ---------------------------------------------------------------------------

loc_9859:
    LDA	    byte_11
    STA	    byte_261
    LDA	    byte_A0
    STA	    byte_260

loc_9865:
    LDX	    byte_26A
    DEX
    BNE	    loc_986D
    LDX	    #1

loc_986D:
    STX	    byte_26A
    LDA	    byte_9904,X
    BMI	    loc_9885
    ASL	    A
    CLC
    ADC	    byte_263
    STA	    byte_13
    LDA	    byte_262
    ADC	    #0
    JMP	    loc_9892
; ---------------------------------------------------------------------------

loc_9885:
    ASL	    A
    CLC
    ADC	    byte_263
    STA	    byte_13
    LDA	    byte_262
    ADC	    #$FF

loc_9892:
    STA	    byte_A1
    LDA	    byte_260
    STA	    byte_A0
    JSR	    sub_8A6C
    CMP	    #3
    BNE	    loc_98C6
    DEC	    byte_26B
    SEC
    LDA	    byte_269
    BMI	    loc_98AC
    CLC

loc_98AC:
    ROR	    byte_269
    LDX	    #$16
    LDA	    byte_26A
    CMP	    #$20
    BPL	    loc_98C0
    LDA	    byte_26B
    CLC
    ASL	    A
    ADC	    #$2C
    TAX

loc_98C0:
    STX	    byte_26A
    JMP	    loc_98D2
; ---------------------------------------------------------------------------

loc_98C6:
    LDA	    byte_13
    STA	    byte_263
    LDA	    byte_A1
    STA	    byte_262

loc_98D2:
    JSR	    sub_8AB8
    RTS
; ---------------------------------------------------------------------------

loc_98D6:
    LDX	    byte_268
    DEX
    STX	    byte_268
    BNE	    loc_98E8
    LDA	    #$10
    LDX	    #2
    LDY	    #$60
    JMP	    ClearSomeMemory
; ---------------------------------------------------------------------------

loc_98E8:
    CPX	    #2
    BNE	    loc_98F0
    LDA	    #$FF
    BNE	    loc_98F2

loc_98F0:
    LDA	    #0

loc_98F2:
    STA	    byte_26E
    JMP	    loc_98D2
; End of function sub_97CC

; ---------------------------------------------------------------------------
byte_98F8:
    .BYTE	$F8
    .BYTE 8
    .BYTE $FF
    .BYTE 1
    .BYTE $FF
    .BYTE 1
byte_98FE:
    .BYTE	$FC
    .BYTE 4
    .BYTE 0
    .BYTE 0
    .BYTE $FE
    .BYTE 2
byte_9904:
    .BYTE	$7F
    .BYTE $7C
    .BYTE $78
    .BYTE $74
    .BYTE $70
    .BYTE $6C
    .BYTE $68
    .BYTE $64
    .BYTE $60
    .BYTE $5C
    .BYTE $58
    .BYTE $54
    .BYTE $50
    .BYTE $4C
    .BYTE $48
    .BYTE $44
    .BYTE $40
    .BYTE $3C
    .BYTE $38
    .BYTE $34
    .BYTE $30
    .BYTE $2C
    .BYTE $28
    .BYTE $24
    .BYTE $20
    .BYTE $1C
    .BYTE $18
    .BYTE $14
    .BYTE $10
    .BYTE $C
    .BYTE 8
    .BYTE 4
    .BYTE 0
    .BYTE $FC
    .BYTE $F8
    .BYTE $F4
    .BYTE $F0
    .BYTE $EC
    .BYTE $E8
    .BYTE $E4
    .BYTE $E0
    .BYTE $DC
    .BYTE $D8
    .BYTE $D4
    .BYTE $D0
    .BYTE $CC
    .BYTE $C8
    .BYTE $C4
    .BYTE $C0
    .BYTE $BC
    .BYTE $B8
    .BYTE $B4
    .BYTE $B0
    .BYTE $AC
    .BYTE $A8
    .BYTE $A4
    .BYTE $A0
    .BYTE $9C
    .BYTE $98
    .BYTE $94
    .BYTE $90
    .BYTE $8C
    .BYTE $88
    .BYTE $84
    .BYTE $81
byte_9945:
    .BYTE	0
    .BYTE $10
    .BYTE $20
    .BYTE  $F
; ---------------------------------------------------------------------------

EnemyHandler_ShitBat:
    JSR	    SetA2ToEnemyPointerFrom1C0
    LDA	    GamePaused
    BEQ	    loc_9954
    JMP	    loc_9AB4
; ---------------------------------------------------------------------------

loc_9954:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #1
    BNE	    loc_99CC
    LDY	    #$F
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    STA	    byte_20
    LDA	    byte_1C0
    ASL	    A
    ASL	    A
    ASL	    A
    CLC
    ADC	    #$50
    CMP	    byte_20
    BEQ	    loc_9979
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9979:
    LDA	    #0
    LDY	    #$F
    STA	    (word_A2),Y
    JSR	    sub_ABD3
    LDA	    PlayerX
    AND	    #1
    BEQ	    loc_99A3
    LDA	    PlayerY
    SEC
    SBC	    #7
    LDY	    #2
    STA	    (word_A2),Y
    AND	    #$40
    BNE	    loc_999A
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_999A:
    LDA	    PlayerYLo
    INY
    STA	    (word_A2),Y
    JMP	    loc_99B6
; ---------------------------------------------------------------------------

loc_99A3:
    LDA	    #$50
    LDY	    #2
    STA	    (word_A2),Y
    LDA	    #0
    INY
    STA	    (word_A2),Y
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #8
    STA	    (word_A2),Y

loc_99B6:
    LDY	    #7
    LDA	    (word_A2),Y
    STA	    byte_21
    JSR	    sub_ACFF
    LDY	    #7
    LDA	    (word_A2),Y
    CMP	    byte_21
    BEQ	    loc_99CC
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_99CC:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BEQ	    loc_99F2
; ---------------------------------------------------------------------------
    .BYTE $A0
    .BYTE   7
    .BYTE $B1
    .BYTE $A2
    .BYTE 9
    .BYTE   4
    .BYTE $91
    .BYTE $A2
    .BYTE $A9
    .BYTE $40
    .BYTE $20
    .BYTE $93
    .BYTE $AC
; ---------------------------------------------------------------------------
    LDY	    #2
    LDA	    (word_A2),Y
    BMI	    byte_99EA
    JMP	    loc_9AAB
; ---------------------------------------------------------------------------
byte_99EA:
    .BYTE	$A9
    .BYTE $15
    .BYTE $20
    .BYTE $A6
    .BYTE $84
; ---------------------------------------------------------------------------
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_99F2:
    LDA	    UnknownTimer014A
    BEQ	    loc_99FA
    JMP	    loc_9AB4
; ---------------------------------------------------------------------------

loc_99FA:
    LDA	    #$10
    JSR	    sub_AC2E
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #8
    BEQ	    loc_9A18
    INY
    LDA	    (word_A2),Y
    ASL	    A
    ASL	    A
    BNE	    loc_9A18
    LDA	    #3
    JSR	    sub_AE98
    LDA	    #$20
    STA	    unk_389,X

loc_9A18:
    JSR	    sub_ACFF
    LDA	    CurrentZone
    AND	    #1
    BNE	    loc_9A9A
    LDY	    #$D
    LDA	    (word_A2),Y
    CMP	    #8
    BMI	    loc_9A65
    SEC
    SBC	    #8
    LSR	    A
    TAY
    LDA	    byte_A5FF,Y
    STA	    byte_20
    LDY	    #3
    LDA	    (word_A2),Y
    SEC
    SBC	    byte_20
    STA	    (word_A2),Y
    DEY
    LDA	    (word_A2),Y
    SBC	    #0
    STA	    (word_A2),Y
    LDY	    #0
    LDA	    (word_A2),Y
    STA	    byte_A0
    LDY	    #2
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    STA	    byte_A1
    JSR	    sub_8A6C
    BEQ	    loc_9A9A
    LDA	    #0
    LDY	    #$D
    STA	    (word_A2),Y
    JMP	    loc_9AAB
; ---------------------------------------------------------------------------

loc_9A65:
    LSR	    A
    TAY
    LDA	    byte_A5FF,Y
    STA	    byte_20
    LDY	    #3
    LDA	    (word_A2),Y
    CLC
    ADC	    byte_20
    STA	    (word_A2),Y
    DEY
    LDA	    (word_A2),Y
    ADC	    #0
    STA	    (word_A2),Y
    LDY	    #0
    LDA	    (word_A2),Y
    STA	    byte_A0
    LDY	    #2
    LDA	    (word_A2),Y
    STA	    byte_A1
    JSR	    sub_8A6C
    BEQ	    loc_9A9A
    LDA	    #8
    LDY	    #$D
    STA	    (word_A2),Y
    JMP	    loc_9AAB
; ---------------------------------------------------------------------------

loc_9A9A:
    LDY	    #$D
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    CMP	    #$10
    BNE	    loc_9AAB
    LDA	    #0
    STA	    (word_A2),Y

loc_9AAB:
    LDY	    #8
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    STA	    (word_A2),Y

loc_9AB4:
    JSR	    sub_8AB8
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$80
    BEQ	    loc_9AC2
    JMP	    loc_ACC6
; ---------------------------------------------------------------------------

loc_9AC2:
    LDX	    #0
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BNE	    loc_9AD7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_9ADE

loc_9AD2:
    LDX	    #$40
    JMP	    loc_9ADE
; ---------------------------------------------------------------------------

loc_9AD7:
    INY
    LDA	    (word_A2),Y
    AND	    #8
    BNE	    loc_9AD2

loc_9ADE:
    STX	    byte_2A
    JSR	    sub_85E4
    LDA	    byte_2A
    ORA	    byte_FDE5,X
    ORA	    #0
    STA	    byte_2A
    JSR	    sub_AED5
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BNE	    loc_9B06
    LDY	    #8
    LDA	    (word_A2),Y
    AND	    #8
    LSR	    A
    LSR	    A
    TAY
    JMP	    loc_9B08
; ---------------------------------------------------------------------------

loc_9B06:
    LDY	    #4

loc_9B08:
    LDA	    off_A5E8,Y
    STA	    word_1A
    LDA	    off_A5E8+1,Y
    STA	    word_1A+1
    JSR	    DrawSpriteMaybe
    JSR	    sub_AF2D
    RTS
; ---------------------------------------------------------------------------

EnemyHandler_WormThing:
    JSR	    SetA2ToEnemyPointerFrom1C0
    LDA	    GamePaused
    BEQ	    loc_9B26
    JMP	    loc_9BE8
; ---------------------------------------------------------------------------

loc_9B26:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #1
    BNE	    loc_9B99
    LDY	    #$F
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    STA	    byte_20
    LDA	    byte_1C0
    ASL	    A
    ASL	    A
    ASL	    A
    CLC
    ADC	    #$20
    CMP	    byte_20
    BEQ	    loc_9B4B
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9B4B:
    LDA	    #0
    LDY	    #$F
    STA	    (word_A2),Y
    JSR	    sub_ABD3
    LDY	    #0
    LDA	    (word_A2),Y
    STA	    byte_A0
    LDA	    #0
    LDY	    #3
    STA	    (word_A2),Y
    LDA	    #$40
    STA	    byte_20

loc_9B66:
    LDA	    byte_20
    CLC
    ADC	    #4
    STA	    byte_20
    STA	    byte_A1
    JSR	    sub_8A6C
    BEQ	    loc_9B8F
    LDA	    byte_20
    SEC
    SBC	    #4
    STA	    byte_A1
    JSR	    sub_8A6C
    BNE	    loc_9B8F
    LDA	    byte_20
    LDY	    #2
    STA	    (word_A2),Y
    JMP	    loc_9B99
; ---------------------------------------------------------------------------

loc_9B8F:
    LDA	    byte_20
    CMP	    #$7C
    BNE	    loc_9B66
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9B99:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BEQ	    loc_9BB9
    LDY	    #$A
    LDA	    (word_A2),Y
    CMP	    #$1F
    BNE	    loc_9BB1
    LDA	    #$12
    JSR	    AwardPoints
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9BB1:
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    JMP	    loc_9BE8
; ---------------------------------------------------------------------------

loc_9BB9:
    LDA	    UnknownTimer014A
    BNE	    loc_9BE8
    LDA	    #8
    JSR	    sub_AC2E
    JSR	    sub_ACFF
    JSR	    sub_8B25
    BNE	    loc_9BDF
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #4
    STA	    (word_A2),Y
    LDA	    #$80
    JSR	    sub_AC93
    CMP	    #$7F
    BMI	    loc_9BDF
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9BDF:
    LDY	    #8
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    STA	    (word_A2),Y

loc_9BE8:
    JSR	    sub_8AB8
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$80
    BEQ	    loc_9BF6
    JMP	    loc_ACC6
; ---------------------------------------------------------------------------

loc_9BF6:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BNE	    loc_9C0D
    LDX	    #0
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_9C19
    LDX	    #$40
    JMP	    loc_9C19
; ---------------------------------------------------------------------------

loc_9C0D:
    LDX	    #0
    LDY	    #$A
    LDA	    (word_A2),Y
    AND	    #4
    BEQ	    loc_9C19
    LDX	    #$40

loc_9C19:
    STX	    byte_2A
    JSR	    sub_85E4
    LDA	    byte_2A
    ORA	    byte_FDE5,X
    ORA	    #0
    STA	    byte_2A
    JSR	    sub_AED5
    LDY	    #8
    LDA	    (word_A2),Y
    AND	    #8
    LSR	    A
    LSR	    A
    TAY
    LDA	    off_A603,Y
    STA	    word_1A
    LDA	    off_A603+1,Y
    STA	    word_1A+1
    JSR	    DrawSpriteMaybe
    JSR	    sub_AF2D
    RTS
; ---------------------------------------------------------------------------

EnemyHandler_Mummy:
    JSR	    SetA2ToEnemyPointerFrom1C0
    LDA	    GamePaused
    BEQ	    loc_9C54
    JMP	    loc_9D97
; ---------------------------------------------------------------------------

loc_9C54:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #1
    BNE	    loc_9CBC
    LDY	    #$F
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    STA	    byte_20
    LDA	    byte_1C0
    ASL	    A
    ASL	    A
    ASL	    A
    CLC
    ADC	    #$20
    CMP	    byte_20
    BEQ	    loc_9C79
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9C79:
    LDA	    #0
    STA	    (word_A2),Y
    JSR	    sub_ABD3
    LDA	    PlayerState
    AND	    #4
    BEQ	    loc_9C8A
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9C8A:
    LDA	    PlayerY
    LDY	    #2
    STA	    (word_A2),Y
    AND	    #$40
    BNE	    loc_9C98
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9C98:
    LDA	    PlayerYLo
    INY
    STA	    (word_A2),Y
    LDY	    #7
    LDA	    (word_A2),Y
    STA	    byte_21
    JSR	    sub_AD7B
    LDY	    #7
    LDA	    (word_A2),Y
    CMP	    byte_21
    BEQ	    loc_9CB4
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9CB4:
    JSR	    sub_AE20
    BNE	    loc_9CBC
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9CBC:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BEQ	    loc_9CF1
    LDY	    #$B
    LDA	    (word_A2),Y
    CMP	    #2
    BEQ	    loc_9CDC
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$BF
    STA	    (word_A2),Y
    JMP	    loc_9CF1
; ---------------------------------------------------------------------------

loc_9CDC:
    LDY	    #$A
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    CMP	    #$3F
    BNE	    loc_9D47
    LDA	    #$21
    JSR	    AwardPoints
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9CF1:
    LDA	    UnknownTimer014A
    BEQ	    loc_9CF9
    JMP	    loc_9D97
; ---------------------------------------------------------------------------

loc_9CF9:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #4
    BNE	    loc_9D06
    LDA	    #2
    JSR	    sub_AC2E

loc_9D06:
    JSR	    sub_AD7B
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_9D34
    LDY	    #0
    LDA	    (word_A2),Y
    STA	    byte_20
    LDA	    PlayerX
    CLC
    ADC	    #2
    SEC
    SBC	    byte_20
    BPL	    loc_9D47

loc_9D24:
    LDA	    #2
    JSR	    sub_AC2E
    LDY	    #7
    LDA	    (word_A2),Y
    EOR	    #2
    STA	    (word_A2),Y
    JMP	    loc_9D47
; ---------------------------------------------------------------------------

loc_9D34:
    LDA	    PlayerX
    STA	    byte_20
    LDY	    #0
    LDA	    (word_A2),Y
    CLC
    ADC	    #2
    SEC
    SBC	    byte_20
    BMI	    loc_9D24

loc_9D47:
    JSR	    sub_AE20
    BNE	    loc_9D7B
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #4
    BNE	    loc_9D6A
    LDA	    #1
    JSR	    sub_AE98
    LDA	    unk_382,X
    SEC
    SBC	    #6
    STA	    unk_382,X
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #4
    STA	    (word_A2),Y

loc_9D6A:
    LDY	    #$F
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    CMP	    #$50
    BMI	    loc_9D83
    LDA	    #0
    STA	    (word_A2),Y

loc_9D7B:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$FB
    STA	    (word_A2),Y

loc_9D83:
    LDY	    #$A
    LDA	    (word_A2),Y
    BEQ	    loc_9D8E
    AND	    #4
    BNE	    loc_9D97
    RTS
; ---------------------------------------------------------------------------

loc_9D8E:
    LDY	    #8
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    STA	    (word_A2),Y

loc_9D97:
    JSR	    sub_8AB8
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$80
    BEQ	    loc_9DA5
    JMP	    loc_ACC6
; ---------------------------------------------------------------------------

loc_9DA5:
    LDX	    #0
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BNE	    loc_9DB1
    LDX	    #$40

loc_9DB1:
    STX	    byte_2A
    JSR	    sub_85E4
    LDA	    byte_2A
    ORA	    byte_FDE5,X
    ORA	    #1
    STA	    byte_2A
    JSR	    sub_AED5
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BEQ	    loc_9DDD
    LDY	    #$A
    LDA	    (word_A2),Y
    LSR	    A
    LSR	    A
    LSR	    A
    LSR	    A
    CLC
    ADC	    #3
    ASL	    A
    TAY
    JMP	    loc_9DF4
; ---------------------------------------------------------------------------

loc_9DDD:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #4
    BNE	    loc_9DF2
    LDY	    #8
    LDA	    (word_A2),Y
    AND	    #$30
    LSR	    A
    LSR	    A
    LSR	    A
    TAY
    JMP	    loc_9DF4
; ---------------------------------------------------------------------------

loc_9DF2:
    LDY	    #2

loc_9DF4:
    LDA	    off_A611,Y
    STA	    word_1A
    LDA	    off_A611+1,Y
    STA	    word_1A+1
    JSR	    DrawSpriteMaybe
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BNE	    locret_9E1A
    JSR	    CheckInvulnZoneStatus_1
    CPY	    #0
    BNE	    locret_9E1A
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #$40
    STA	    (word_A2),Y

locret_9E1A:
    RTS
; ---------------------------------------------------------------------------

EnemyHandler_Skeleton:
    JSR	    SetA2ToEnemyPointerFrom1C0
    LDA	    GamePaused
    BEQ	    loc_9E26
    JMP	    loc_9F81
; ---------------------------------------------------------------------------

loc_9E26:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #1
    BEQ	    loc_9E31
    JMP	    loc_9EB9
; ---------------------------------------------------------------------------

loc_9E31:
    LDY	    #$F
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    STA	    byte_20
    LDA	    byte_1C0
    ASL	    A
    ASL	    A
    ASL	    A
    CLC
    ADC	    #$60
    CMP	    byte_20
    BEQ	    loc_9E4E
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9E4E:
    LDA	    #0
    STA	    (word_A2),Y
    LDA	    PlayerState
    AND	    #4
    BEQ	    loc_9E5C
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9E5C:
    JSR	    sub_ABD3
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_9E73
    LDY	    #0
    LDA	    (word_A2),Y
    CLC
    ADC	    #7
    STA	    (word_A2),Y
    JMP	    loc_9E7C
; ---------------------------------------------------------------------------

loc_9E73:
    LDY	    #0
    LDA	    (word_A2),Y
    SEC
    SBC	    #7
    STA	    (word_A2),Y

loc_9E7C:
    LDA	    PlayerY
    LDY	    #2
    STA	    (word_A2),Y
    AND	    #$40
    BNE	    loc_9E8A
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9E8A:
    LDA	    PlayerYLo
    INY
    STA	    (word_A2),Y
    LDY	    #7
    LDA	    (word_A2),Y
    STA	    byte_21
    JSR	    sub_AD35
    LDY	    #7
    LDA	    (word_A2),Y
    CMP	    byte_21
    BEQ	    loc_9EA6
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9EA6:
    JSR	    sub_8B25
    BNE	    loc_9EAE
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9EAE:
    LDY	    #9
    LDA	    #1
    STA	    (word_A2),Y
    DEY
    LDA	    #$10
    STA	    (word_A2),Y

loc_9EB9:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BEQ	    loc_9EDA
    LDY	    #$A
    LDA	    (word_A2),Y
    CMP	    #$20
    BEQ	    loc_9ED7
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    CMP	    #$20
    BNE	    loc_9ED7
    LDA	    #$15
    JSR	    AwardPoints

loc_9ED7:
    JMP	    loc_9F81
; ---------------------------------------------------------------------------

loc_9EDA:
    LDA	    UnknownTimer014A
    BEQ	    loc_9EE2
    JMP	    loc_9F81
; ---------------------------------------------------------------------------

loc_9EE2:
    LDY	    #9
    LDA	    (word_A2),Y
    BEQ	    loc_9EEB
    JMP	    loc_9F78
; ---------------------------------------------------------------------------

loc_9EEB:
    LDA	    #5
    JSR	    sub_AC2E
    JSR	    sub_AD35
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #4
    BNE	    loc_9F1B
    LDA	    ZoneTimer+2
    BNE	    loc_9F05
    LDA	    ZoneTimer+1
    BEQ	    loc_9F0D

loc_9F05:
    JSR	    sub_AE20
    BEQ	    loc_9F0D
    JMP	    loc_9F78
; ---------------------------------------------------------------------------

loc_9F0D:
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #4
    STA	    (word_A2),Y
    LDA	    #$40
    LDY	    #$D
    STA	    (word_A2),Y

loc_9F1B:
    LDY	    #$D
    LDA	    (word_A2),Y
    TAX
    LDA	    byte_9904,X
    BMI	    loc_9F41
    JSR	    sub_AEFF
    JSR	    sub_8B25
    BEQ	    loc_9F4F
    LDY	    #2
    LDA	    (word_A2),Y
    AND	    #$FC
    STA	    (word_A2),Y
    LDA	    #0
    INY
    STA	    (word_A2),Y
    LDY	    #$D
    STA	    (word_A2),Y
    JMP	    loc_9F4F
; ---------------------------------------------------------------------------

loc_9F41:
    JSR	    sub_AEE9
    JSR	    sub_ADE8
    BEQ	    loc_9F4F
    LDA	    #$20
    LDY	    #$D
    STA	    (word_A2),Y

loc_9F4F:
    LDY	    #$D
    LDA	    (word_A2),Y
    BEQ	    loc_9F5D
    SEC
    SBC	    #1
    STA	    (word_A2),Y
    JMP	    loc_9F78
; ---------------------------------------------------------------------------

loc_9F5D:
    JSR	    sub_8B25
    BEQ	    loc_9F6D
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$FB
    STA	    (word_A2),Y
    JMP	    loc_9F78
; ---------------------------------------------------------------------------

loc_9F6D:
    LDY	    #2
    LDA	    (word_A2),Y
    CMP	    #$80
    BMI	    loc_9F78
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_9F78:
    LDY	    #8
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    STA	    (word_A2),Y

loc_9F81:
    JSR	    sub_8AB8
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$80
    BEQ	    loc_9F8F
    JMP	    loc_ACC6
; ---------------------------------------------------------------------------

loc_9F8F:
    LDY	    #8
    LDA	    (word_A2),Y
    BNE	    loc_9FAC
    INY
    LDA	    (word_A2),Y
    BEQ	    loc_9FAC
    BMI	    loc_9FA8
    LDA	    #$80
    STA	    (word_A2),Y
    LDA	    #$10
    DEY
    STA	    (word_A2),Y
    JMP	    loc_9FAC
; ---------------------------------------------------------------------------

loc_9FA8:
    LDA	    #0
    STA	    (word_A2),Y

loc_9FAC:
    LDX	    #0
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BNE	    loc_9FB8
    LDX	    #$40

loc_9FB8:
    STX	    byte_2A
    JSR	    sub_85E4
    LDA	    byte_2A
    ORA	    byte_FDE5,X
    ORA	    #1
    STA	    byte_2A
    JSR	    sub_AED5
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BEQ	    loc_9FE3
    LDX	    #$A
    LDY	    #$A
    LDA	    (word_A2),Y
    CMP	    #$20
    BNE	    loc_9FE0
    LDX	    #$C

loc_9FE0:
    JMP	    loc_A005
; ---------------------------------------------------------------------------

loc_9FE3:
    LDX	    #6
    LDY	    #9
    LDA	    (word_A2),Y
    BEQ	    loc_9FF2
    BPL	    loc_A005
    LDX	    #8
    JMP	    loc_A005
; ---------------------------------------------------------------------------

loc_9FF2:
    LDX	    #4
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #4
    BNE	    loc_A005
    LDY	    #8
    LDA	    (word_A2),Y
    AND	    #8
    LSR	    A
    LSR	    A
    TAX

loc_A005:
    TXA
    TAY
    LDA	    off_A649,Y
    STA	    word_1A
    LDA	    off_A649+1,Y
    STA	    word_1A+1
    JSR	    DrawSpriteMaybe
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BNE	    locret_A035
    JSR	    CheckInvulnZoneStatus_2
    CPY	    #0
    BNE	    locret_A035
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #4
    BNE	    locret_A035
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #$40
    STA	    (word_A2),Y

locret_A035:
    RTS
; ---------------------------------------------------------------------------

EnemyHandler_GravityBlob:
    JSR	    SetA2ToEnemyPointerFrom1C0
    LDA	    GamePaused
    BEQ	    loc_A041
    JMP	    loc_A203
; ---------------------------------------------------------------------------

loc_A041:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #1
    BNE	    loc_A0B4
    LDY	    #$F
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    STA	    byte_20
    LDA	    byte_1C0
    ASL	    A
    ASL	    A
    ASL	    A
    CLC
    ADC	    #$40
    CMP	    byte_20
    BEQ	    loc_A066
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A066:
    LDA	    #0
    LDY	    #$F
    STA	    (word_A2),Y
    JSR	    sub_ABD3
    LDY	    #0
    LDA	    (word_A2),Y
    STA	    byte_A0
    LDA	    #0
    LDY	    #3
    STA	    (word_A2),Y
    LDA	    #$78
    STA	    byte_20

loc_A081:
    LDA	    byte_20
    SEC
    SBC	    #4
    STA	    byte_20
    STA	    byte_A1
    JSR	    sub_8A6C
    BEQ	    loc_A0AA
    LDA	    byte_20
    SEC
    SBC	    #4
    STA	    byte_A1
    JSR	    sub_8A6C
    BNE	    loc_A0AA
    LDA	    byte_20
    LDY	    #2
    STA	    (word_A2),Y

loc_A0A7:
    JMP	    loc_A0B4
; ---------------------------------------------------------------------------

loc_A0AA:
    LDA	    byte_20
    CMP	    #$40
    BNE	    loc_A081
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A0B4:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BEQ	    loc_A0D9
    LDY	    #$A
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    CMP	    #$30
    BNE	    loc_A0D1
    LDA	    #$12
    JSR	    AwardPoints
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A0D1:
    AND	    #1
    BNE	    loc_A0D6
    RTS
; ---------------------------------------------------------------------------

loc_A0D6:
    JMP	    loc_A203
; ---------------------------------------------------------------------------

loc_A0D9:
    LDA	    UnknownTimer014A
    BEQ	    loc_A0E1
    JMP	    loc_A203
; ---------------------------------------------------------------------------

loc_A0E1:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #8
    BEQ	    loc_A0EC
    JMP	    loc_A169
; ---------------------------------------------------------------------------

loc_A0EC:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #4
    BNE	    loc_A147
    LDA	    #6
    JSR	    sub_AC2E
    JSR	    sub_ACFF
    JSR	    sub_AE20
    BNE	    loc_A144
    LDY	    #0
    LDA	    (word_A2),Y
    STA	    byte_A0
    LDY	    #2
    LDA	    (word_A2),Y
    STA	    byte_20

loc_A10F:
    LDA	    byte_20
    SEC
    SBC	    #4
    STA	    byte_20
    STA	    byte_A1
    JSR	    sub_8A6C
    BNE	    loc_A132
    LDA	    byte_20
    CMP	    #$40
    BNE	    loc_A10F
    LDY	    #7
    LDA	    (word_A2),Y
    EOR	    #2
    STA	    (word_A2),Y
    JMP	    loc_A144
; ---------------------------------------------------------------------------

loc_A132:
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #4
    STA	    (word_A2),Y
    LDA	    byte_20
    CLC
    ADC	    #8
    LDY	    #$E
    STA	    (word_A2),Y

loc_A144:
    JMP	    loc_A1FA
; ---------------------------------------------------------------------------

loc_A147:
    LDY	    #2
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    STA	    (word_A2),Y
    STA	    byte_20
    LDY	    #$E
    LDA	    (word_A2),Y
    CMP	    byte_20
    BNE	    loc_A166
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$FB
    ORA	    #8
    STA	    (word_A2),Y

loc_A166:
    JMP	    loc_A203
; ---------------------------------------------------------------------------

loc_A169:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #4
    BNE	    loc_A1DA
    LDA	    #6
    JSR	    sub_AC2E
    JSR	    sub_ACFF
    LDY	    #2
    LDA	    (word_A2),Y
    STA	    byte_20
    SEC
    SBC	    #8
    STA	    (word_A2),Y
    JSR	    sub_AE20
    STA	    byte_21
    LDY	    #2
    LDA	    byte_20
    STA	    (word_A2),Y
    LDA	    byte_21
    BNE	    loc_A1FA
    LDY	    #0
    LDA	    (word_A2),Y
    STA	    byte_A0
    LDY	    #2
    LDA	    (word_A2),Y
    STA	    byte_20

loc_A1A5:
    LDA	    byte_20
    STA	    byte_A1
    JSR	    sub_8A6C
    BNE	    loc_A1C8
    LDA	    byte_20
    CLC
    ADC	    #4
    STA	    byte_20
    CMP	    #$7C
    BNE	    loc_A1A5
    LDY	    #7
    LDA	    (word_A2),Y
    EOR	    #2
    STA	    (word_A2),Y
    JMP	    loc_A1FA
; ---------------------------------------------------------------------------

loc_A1C8:
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #4
    STA	    (word_A2),Y
    LDA	    byte_20
    LDY	    #$E
    STA	    (word_A2),Y
    JMP	    loc_A1FA
; ---------------------------------------------------------------------------

loc_A1DA:
    LDY	    #2
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    STA	    byte_20
    LDY	    #$E
    LDA	    (word_A2),Y
    CMP	    byte_20
    BNE	    loc_A203
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$F3
    STA	    (word_A2),Y
    JMP	    loc_A203
; ---------------------------------------------------------------------------

loc_A1FA:
    LDY	    #8
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    STA	    (word_A2),Y

loc_A203:
    JSR	    sub_8AB8
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$80
    BEQ	    loc_A211
    JMP	    loc_ACC6
; ---------------------------------------------------------------------------

loc_A211:
    LDX	    #0
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_A21D
    LDX	    #$40

loc_A21D:
    LDA	    (word_A2),Y
    AND	    #8
    BEQ	    loc_A227
    TXA
    ORA	    #$80
    TAX

loc_A227:
    STX	    byte_2A
    JSR	    sub_85E4
    LDA	    byte_2A
    ORA	    byte_FDE5,X
    ORA	    #1
    STA	    byte_2A
    JSR	    sub_AED5
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #4
    BNE	    loc_A24E
    LDY	    #8
    LDA	    (word_A2),Y
    AND	    #8
    LSR	    A
    TAY
    JMP	    loc_A250
; ---------------------------------------------------------------------------

loc_A24E:
    LDY	    #8

loc_A250:
    STY	    byte_20
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #8
    BEQ	    loc_A264
    LDA	    byte_20
    CLC
    ADC	    #2
    STA	    byte_20

loc_A264:
    LDY	    byte_20
    LDA	    off_A680,Y
    STA	    word_1A
    LDA	    off_A680+1,Y
    STA	    word_1A+1
    JSR	    DrawSpriteMaybe
    JSR	    sub_AF2D
    RTS
; ---------------------------------------------------------------------------

EnemyHandler_Snail:
    JSR	    SetA2ToEnemyPointerFrom1C0
    LDA	    GamePaused
    BEQ	    loc_A285
    JMP	    loc_A3BC
; ---------------------------------------------------------------------------

loc_A285:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #1
    BNE	    loc_A2F8
    LDY	    #$F
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    STA	    byte_20
    LDA	    byte_1C0
    ASL	    A
    ASL	    A
    ASL	    A
    CLC
    ADC	    #$20
    CMP	    byte_20
    BEQ	    loc_A2AA
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A2AA:
    LDA	    #0
    LDY	    #$F
    STA	    (word_A2),Y
    JSR	    sub_ABD3
    LDY	    #0
    LDA	    (word_A2),Y
    STA	    byte_A0
    LDA	    #0
    LDY	    #3
    STA	    (word_A2),Y
    LDA	    #$40
    STA	    byte_20

loc_A2C5:
    LDA	    byte_20
    CLC
    ADC	    #4
    STA	    byte_20
    STA	    byte_A1
    JSR	    sub_8A6C
    BEQ	    loc_A2EE
    LDA	    byte_20
    SEC
    SBC	    #4
    STA	    byte_A1
    JSR	    sub_8A6C
    BNE	    loc_A2EE
    LDA	    byte_20
    LDY	    #2
    STA	    (word_A2),Y
    JMP	    loc_A2F8
; ---------------------------------------------------------------------------

loc_A2EE:
    LDA	    byte_20
    CMP	    #$7C
    BNE	    loc_A2C5
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A2F8:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BEQ	    loc_A34A
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$20
    BNE	    loc_A31C
    LDA	    (word_A2),Y
    ORA	    #$20
    STA	    (word_A2),Y
    LDA	    #$40
    LDY	    #$A
    STA	    (word_A2),Y
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #8
    STA	    (word_A2),Y

loc_A31C:
    LDY	    #$A
    LDA	    (word_A2),Y
    TAX
    LDA	    byte_9904,X
    BMI	    loc_A32C
    JSR	    sub_AEFF
    JMP	    loc_A32F
; ---------------------------------------------------------------------------

loc_A32C:
    JSR	    sub_AEE9

loc_A32F:
    LDY	    #$A
    LDA	    (word_A2),Y
    BEQ	    loc_A33A
    SEC
    SBC	    #2
    STA	    (word_A2),Y

loc_A33A:
    LDY	    #2
    LDA	    (word_A2),Y
    CMP	    #$C0
    BMI	    loc_A3BC
    LDA	    #$13
    JSR	    AwardPoints
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A34A:
    LDA	    UnknownTimer014A
    BNE	    loc_A3BC
    LDA	    PlayerState
    AND	    #PlayerStates_ThrowingBomb
    BEQ	    loc_A366
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #4
    BNE	    loc_A366
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #8
    STA	    (word_A2),Y

loc_A366:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #8
    BNE	    loc_A3A3
    LDA	    #4
    JSR	    sub_AC2E
    JSR	    sub_ACFF
    JSR	    sub_AE5C
    BNE	    loc_A38F
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #4
    STA	    (word_A2),Y
    LDA	    #$80
    JSR	    sub_AC93
    CMP	    #$7F
    BMI	    loc_A397
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A38F:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$FB
    STA	    (word_A2),Y

loc_A397:
    LDY	    #8
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    STA	    (word_A2),Y
    JMP	    loc_A3BC
; ---------------------------------------------------------------------------

loc_A3A3:
    LDY	    #$B
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    CMP	    #$9F
    BNE	    loc_A3BC
    LDA	    #0
    STA	    (word_A2),Y
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$F7
    STA	    (word_A2),Y

loc_A3BC:
    JSR	    sub_8AB8
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$80
    BEQ	    loc_A3CA
    JMP	    loc_ACC6
; ---------------------------------------------------------------------------

loc_A3CA:
    LDX	    #0
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_A3D6
    LDX	    #$40

loc_A3D6:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BEQ	    loc_A3EA
    LDY	    #$A
    LDA	    (word_A2),Y
    CMP	    #$20
    BPL	    loc_A3EA
    TXA
    ORA	    #$80
    TAX

loc_A3EA:
    STX	    byte_2A
    JSR	    sub_85E4
    LDA	    byte_2A
    ORA	    byte_FDE5,X
    ORA	    #3
    STA	    byte_2A
    JSR	    sub_AED5
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BEQ	    loc_A413
    LDY	    #$A
    LDA	    (word_A2),Y
    CMP	    #$20
    BPL	    loc_A426
    LDY	    #6
    JMP	    loc_A428
; ---------------------------------------------------------------------------

loc_A413:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #8
    BNE	    loc_A426
    LDY	    #8
    LDA	    (word_A2),Y
    AND	    #8
    LSR	    A
    TAY
    JMP	    loc_A428
; ---------------------------------------------------------------------------

loc_A426:
    LDY	    #2

loc_A428:
    STY	    byte_20
    LDA	    off_A6AA,Y
    STA	    word_1A
    LDA	    off_A6AA+1,Y
    STA	    word_1A+1
    JSR	    DrawSpriteMaybe
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #8
    BEQ	    loc_A448
    JSR	    sub_B393
    JMP	    locret_A457
; ---------------------------------------------------------------------------

loc_A448:
    JSR	    CheckInvulnZoneStatus_3
    CPY	    #0
    BNE	    locret_A457
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #$40
    STA	    (word_A2),Y

locret_A457:
    RTS
; ---------------------------------------------------------------------------

EnemyHandler_Fly:
    JSR	    SetA2ToEnemyPointerFrom1C0
    LDA	    GamePaused
    BEQ	    loc_A463
    JMP	    loc_A581
; ---------------------------------------------------------------------------

loc_A463:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #1
    BNE	    loc_A4B5
    LDY	    #$F
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    STA	    byte_20
    LDA	    byte_1C0
    ASL	    A
    ASL	    A
    ASL	    A
    CLC
    ADC	    #$40
    CMP	    byte_20
    BEQ	    loc_A488
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A488:
    LDA	    #0
    STA	    (word_A2),Y
    JSR	    sub_ABD3
    LDA	    PlayerY
    SEC
    SBC	    #4
    LDY	    #2
    STA	    (word_A2),Y
    LDA	    PlayerYLo
    INY
    STA	    (word_A2),Y
    LDY	    #7
    LDA	    (word_A2),Y
    STA	    byte_21
    JSR	    sub_ACFF
    LDY	    #7
    LDA	    (word_A2),Y
    CMP	    byte_21
    BEQ	    loc_A4B5
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A4B5:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BEQ	    loc_A4DB
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #4
    STA	    (word_A2),Y
    LDA	    #$40
    JSR	    sub_AC93
    LDA	    #2
    LDA	    (word_A2),Y
    BMI	    loc_A4D3
    JMP	    loc_A578
; ---------------------------------------------------------------------------

loc_A4D3:
    LDA	    #$11
    JSR	    AwardPoints
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A4DB:
    LDA	    UnknownTimer014A
    BEQ	    loc_A4E3
    JMP	    loc_A581
; ---------------------------------------------------------------------------

loc_A4E3:
    LDA	    #6
    JSR	    sub_AC2E
    LDY	    #7
    LDA	    (word_A2),Y
    STA	    byte_21
    JSR	    sub_ACFF
    LDY	    #7
    LDA	    (word_A2),Y
    CMP	    byte_21
    BEQ	    loc_A4FE
    JMP	    loc_A578
; ---------------------------------------------------------------------------

loc_A4FE:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_A524
    LDY	    #0
    LDA	    (word_A2),Y
    STA	    byte_20
    LDA	    PlayerX
    CLC
    ADC	    #4
    SEC
    SBC	    byte_20
    BNE	    loc_A537

loc_A519:
    LDY	    #7
    LDA	    (word_A2),Y
    EOR	    #2
    STA	    (word_A2),Y
    JMP	    loc_A537
; ---------------------------------------------------------------------------

loc_A524:
    LDA	    PlayerX
    STA	    byte_20
    LDY	    #0
    LDA	    (word_A2),Y
    CLC
    ADC	    #4
    SEC
    SBC	    byte_20
    BEQ	    loc_A519

loc_A537:
    LDA	    #$18
    JSR	    sub_AC93
    JSR	    sub_ADC1
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #4
    BEQ	    loc_A565
    LDY	    #2
    LDA	    (word_A2),Y
    STA	    byte_20
    LDA	    PlayerY
    CLC
    ADC	    #$10
    SEC
    SBC	    byte_20
    BNE	    loc_A578

loc_A55A:
    LDY	    #7
    LDA	    (word_A2),Y
    EOR	    #4
    STA	    (word_A2),Y
    JMP	    loc_A578
; ---------------------------------------------------------------------------

loc_A565:
    LDA	    PlayerY
    STA	    byte_20
    LDY	    #2
    LDA	    (word_A2),Y
    CLC
    ADC	    #$10
    SEC
    SBC	    byte_20
    BEQ	    loc_A55A

loc_A578:
    LDY	    #8
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    STA	    (word_A2),Y

loc_A581:
    JSR	    sub_8AB8
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$80
    BEQ	    loc_A58F
    JMP	    loc_ACC6
; ---------------------------------------------------------------------------

loc_A58F:
    LDX	    #0
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BNE	    loc_A5A4
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_A5AB

loc_A59F:
    LDX	    #$40
    JMP	    loc_A5AB
; ---------------------------------------------------------------------------

loc_A5A4:
    INY
    LDA	    (word_A2),Y
    AND	    #8
    BNE	    loc_A59F

loc_A5AB:
    STX	    byte_2A
    JSR	    sub_85E4
    LDA	    byte_2A
    ORA	    byte_FDE5,X
    ORA	    #0
    STA	    byte_2A
    JSR	    sub_AED5
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BNE	    loc_A5D3
    LDY	    #8
    LDA	    (word_A2),Y
    AND	    #8
    LSR	    A
    LSR	    A
    TAY
    JMP	    loc_A5D5
; ---------------------------------------------------------------------------

loc_A5D3:
    LDY	    #4

loc_A5D5:
    LDA	    off_A6C6,Y
    STA	    word_1A
    LDA	    off_A6C6+1,Y
    STA	    word_1A+1
    JSR	    DrawSpriteMaybe
    JSR	    sub_AF15
    RTS
; ---------------------------------------------------------------------------
off_A5E8:
    .WORD byte_A5EE
    .WORD byte_A5F3
    .WORD unk_A5F8
byte_A5EE:
    .BYTE	$4E
    .BYTE $4F
    .BYTE $3E
    .BYTE $3F
    .BYTE $FF
byte_A5F3:
    .BYTE	$6E
    .BYTE $6F
    .BYTE $5E
    .BYTE $5F
    .BYTE $FF
unk_A5F8:
    .BYTE $9E
    .BYTE $9F
    .BYTE $8E
    .BYTE $8F
    .BYTE $7E
    .BYTE $7F
    .BYTE $FF
byte_A5FF:
    .BYTE	0
    .BYTE $40
    .BYTE $80
    .BYTE $40
; ---
off_A603:
    .WORD byte_A607
    .WORD byte_A60C
byte_A607:
    .BYTE	$A4
    .BYTE $A5
    .BYTE $94
    .BYTE $95
    .BYTE $FF
byte_A60C:
    .BYTE	$A4
    .BYTE $C5
    .BYTE $B4
    .BYTE $B5
    .BYTE $FF
; ---
off_A611:
    .WORD byte_A61F
    .WORD byte_A628
    .WORD byte_A631
    .WORD byte_A628
    .WORD byte_A63A
    .WORD byte_A641
    .WORD byte_A646
byte_A61F:
    .BYTE	$C0
    .BYTE $C1
    .BYTE $B0
    .BYTE $B1
    .BYTE $A0
    .BYTE $A1
    .BYTE $90
    .BYTE $91
    .BYTE $FF
byte_A628:
    .BYTE	$A2
    .BYTE $A3
    .BYTE $92
    .BYTE $93
    .BYTE $A0
    .BYTE $A1
    .BYTE $90
    .BYTE $91
    .BYTE $FF
byte_A631:
    .BYTE	$C2
    .BYTE $C3
    .BYTE $B2
    .BYTE $B3
    .BYTE $A0
    .BYTE $A1
    .BYTE $90
    .BYTE $91
    .BYTE $FF
byte_A63A:
    .BYTE	$A2
    .BYTE $A3
    .BYTE $92
    .BYTE $93
    .BYTE $A0
    .BYTE $A1
    .BYTE $FF
byte_A641:
    .BYTE	$A2
    .BYTE $A3
    .BYTE $92
    .BYTE $93
    .BYTE $FF
byte_A646:
    .BYTE	$A2
    .BYTE $A3
    .BYTE $FF
; ---
off_A649:
    .WORD byte_A657
    .WORD byte_A65E
    .WORD byte_A665
    .WORD byte_A66C
    .WORD byte_A66F
    .WORD unk_A674
    .WORD unk_A67B
byte_A657:
    .BYTE	$F0
    .BYTE $F1
    .BYTE $E0
    .BYTE $E1
    .BYTE $D0
    .BYTE $D1
    .BYTE $FF
byte_A65E:
    .BYTE	$E4
    .BYTE $E5
    .BYTE $D4
    .BYTE $D5
    .BYTE $D0
    .BYTE $D1
    .BYTE $FF
byte_A665:
    .BYTE	$D6
    .BYTE $D7
    .BYTE $F4
    .BYTE $F5
    .BYTE $D0
    .BYTE $D1
    .BYTE $FF
byte_A66C:
    .BYTE	$D8
    .BYTE $D9
    .BYTE $FF
byte_A66F:
    .BYTE	$F8
    .BYTE $F9
    .BYTE $E8
    .BYTE $E9
    .BYTE $FF
unk_A674:
    .BYTE $E6
    .BYTE $E7
    .BYTE $F6
    .BYTE $F6
    .BYTE $D0
    .BYTE $D1
    .BYTE $FF
unk_A67B:
    .BYTE $E6
    .BYTE $E7
    .BYTE $D0
    .BYTE $D1
    .BYTE $FF
; ---
off_A680:
    .WORD byte_A68C
    .WORD byte_A691
    .WORD byte_A696
    .WORD byte_A69B
    .WORD byte_A6A0
    .WORD byte_A6A5
byte_A68C:
    .BYTE	$AE
    .BYTE $AF
    .BYTE $9C
    .BYTE $9D
    .BYTE $FF
byte_A691:
    .BYTE	$9C
    .BYTE $9D
    .BYTE $AE
    .BYTE $AF
    .BYTE $FF
byte_A696:
    .BYTE	$CE
    .BYTE $CF
    .BYTE $BE
    .BYTE $BF
    .BYTE $FF
byte_A69B:
    .BYTE	$BE
    .BYTE $BF
    .BYTE $CE
    .BYTE $CF
    .BYTE $FF
byte_A6A0:
    .BYTE	$CC
    .BYTE $CD
    .BYTE $9C
    .BYTE $9D
    .BYTE $FF
byte_A6A5:
    .BYTE	$9C
    .BYTE $9D
    .BYTE $CC
    .BYTE $CD
    .BYTE $FF
; ---
off_A6AA:
    .WORD byte_A6B2
    .WORD byte_A6B7
    .WORD byte_A6BC
    .WORD byte_A6C1
byte_A6B2:
    .BYTE	$CA
    .BYTE $CB
    .BYTE $BA
    .BYTE $BB
    .BYTE $FF
byte_A6B7:
    .BYTE	$BC
    .BYTE $BD
    .BYTE $AC
    .BYTE $AD
    .BYTE $FF
byte_A6BC:
    .BYTE	$A8
    .BYTE $A9
    .BYTE $98
    .BYTE $99
    .BYTE $FF
byte_A6C1:
    .BYTE	$AC
    .BYTE $AD
    .BYTE $BC
    .BYTE $BD
    .BYTE $FF
; ---
off_A6C6:
    .WORD byte_A6CC
    .WORD byte_A6D1
    .WORD byte_A6D5
byte_A6CC:
    .BYTE	$A6
    .BYTE $A7
    .BYTE $96
    .BYTE $97
    .BYTE $FF
byte_A6D1:
    .BYTE	$C6
    .BYTE $C7
    .BYTE $B6
    .BYTE $FF
byte_A6D5:
    .BYTE	$8A
    .BYTE $8B
    .BYTE $7A
    .BYTE $7B
    .BYTE $FF

; =============== S U B	R O U T	I N E =======================================

sub_A6DA:
    LDA	    #0
    STA	    byte_1C0

loc_A6DF:
    JSR	    sub_A6FC
    INC	    byte_1C0
    DEC	    byte_1C4
    BNE	    loc_A6DF
    RTS
; End of function sub_A6DA

; =============== S U B	R O U T	I N E =======================================

sub_A6EB:
    LDA	    #7
    STA	    byte_1C0

loc_A6F0:
    JSR	    sub_A6FC
    DEC	    byte_1C0
    DEC	    byte_1C4
    BNE	    loc_A6F0
    RTS
; End of function sub_A6EB

; =============== S U B	R O U T	I N E =======================================

sub_A6FC:
    LDX	    byte_1C0
    LDA	    EnemyPointersLo,X
    STA	    word_16
    LDA	    EnemyPointersHi,X
    STA	    word_16+1
    JMP	    (word_16)
; End of function sub_A6FC

; =============== S U B	R O U T	I N E =======================================

sub_A70E:
    LDA	    #0
    STA	    byte_1C5

loc_A713:
    JSR	    sub_A730
    INC	    byte_1C5
    DEC	    byte_1C6
    BNE	    loc_A713
    RTS
; End of function sub_A70E

; =============== S U B	R O U T	I N E =======================================

sub_A71F:
    LDA	    #3
    STA	    byte_1C5

loc_A724:
    JSR	    sub_A730
    DEC	    byte_1C5
    DEC	    byte_1C6
    BNE	    loc_A724
    RTS
; End of function sub_A71F

; =============== S U B	R O U T	I N E =======================================

sub_A730:
    LDX	    byte_1C5
    LDA	    byte_1DA,X
    ASL	    A
    TAY
    LDA	    off_B13A,Y
    STA	    word_16
    LDA	    off_B13A+1,Y
    STA	    word_16+1
    JMP	    (word_16)
; End of function sub_A730

; ---------------------------------------------------------------------------

EnemyHandler_Fishman:
    JSR	    SetA2ToEnemyPointerFrom1C0
    LDA	    GamePaused
    BEQ	    loc_A752
    JMP	    loc_A8D6
; ---------------------------------------------------------------------------

loc_A752:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #1
    BNE	    loc_A7B0
    LDY	    #$F
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    STA	    byte_20
    LDA	    byte_1C0
    ASL	    A
    ASL	    A
    ASL	    A
    ASL	    A
    CLC
    ADC	    #$80
    CMP	    byte_20
    BEQ	    loc_A778
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A778:
    LDA	    #0
    STA	    (word_A2),Y
    JSR	    sub_ABD3
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_A793
    LDY	    #0
    LDA	    (word_A2),Y
    CLC
    ADC	    #5
    STA	    (word_A2),Y
    JMP	    loc_A79C
; ---------------------------------------------------------------------------

loc_A793:
    LDY	    #0
    LDA	    (word_A2),Y
    SEC
    SBC	    #5
    STA	    (word_A2),Y

loc_A79C:
    LDY	    #2
    LDA	    #$80
    STA	    (word_A2),Y
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #4
    STA	    (word_A2),Y
    LDY	    #$D
    LDA	    #$81
    STA	    (word_A2),Y

loc_A7B0:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BEQ	    loc_A7D4
    LDA	    (word_A2),Y
    ORA	    #4
    STA	    (word_A2),Y
    LDA	    #$80
    JSR	    sub_AC93
    LDY	    #2
    LDA	    (word_A2),Y
    BMI	    loc_A7CC
    JMP	    loc_A8D6
; ---------------------------------------------------------------------------

loc_A7CC:
    LDA	    #$21
    JSR	    AwardPoints
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A7D4:
    LDA	    UnknownTimer014A
    BEQ	    loc_A7DC
    JMP	    loc_A8D6
; ---------------------------------------------------------------------------

loc_A7DC:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #4
    BNE	    loc_A82F
    LDY	    #$D
    LDA	    (word_A2),Y
    CMP	    #$40
    BPL	    loc_A80F
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$10
    BNE	    loc_A80F
    LDA	    #2
    JSR	    sub_AE98
    LDA	    #$20
    STA	    unk_389,X
    LDA	    unk_382,X
    SEC
    SBC	    #6
    STA	    unk_382,X
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #$10
    STA	    (word_A2),Y

loc_A80F:
    LDY	    #$D
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    STA	    (word_A2),Y
    BNE	    loc_A82C
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$EF
    ORA	    #4
    EOR	    #2
    STA	    (word_A2),Y
    LDY	    #$D
    LDA	    #$3C
    STA	    (word_A2),Y

loc_A82C:
    JMP	    loc_A8D6
; ---------------------------------------------------------------------------

loc_A82F:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$20
    BEQ	    loc_A83A
    JMP	    loc_A8A5
; ---------------------------------------------------------------------------

loc_A83A:
    LDY	    #$D
    LDA	    (word_A2),Y
    LSR	    A
    TAX
    LDA	    byte_9904,X
    BMI	    loc_A889
    JSR	    sub_AEFF
    JSR	    sub_8B25
    BEQ	    loc_A88C
    LDY	    #2
    LDA	    (word_A2),Y
    STA	    byte_21
    SEC
    SBC	    #4
    STA	    (word_A2),Y
    JSR	    sub_8B25
    BEQ	    loc_A868
    LDA	    byte_21
    LDY	    #2
    STA	    (word_A2),Y
    JMP	    loc_A88C
; ---------------------------------------------------------------------------

loc_A868:
    LDY	    #2
    LDA	    byte_21
    AND	    #$FC
    STA	    (word_A2),Y
    INY
    LDA	    #0
    STA	    (word_A2),Y
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$FB
    ORA	    #$20
    STA	    (word_A2),Y
    LDY	    #$D
    LDA	    #$60
    STA	    (word_A2),Y

loc_A886:
    JMP	    loc_A8D6
; ---------------------------------------------------------------------------

loc_A889:
    JSR	    sub_AEE9

loc_A88C:
    LDY	    #$D
    LDA	    (word_A2),Y
    BEQ	    loc_A89A
    SEC
    SBC	    #1
    STA	    (word_A2),Y
    JMP	    loc_A886
; ---------------------------------------------------------------------------

loc_A89A:
    LDY	    #2
    LDA	    (word_A2),Y
    CMP	    #$80
    BMI	    loc_A886
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A8A5:
    LDY	    #$D
    LDA	    (word_A2),Y
    TAX
    LDA	    byte_9904,X
    BMI	    loc_A8B5
    JSR	    sub_AEFF
    JMP	    loc_A8B8
; ---------------------------------------------------------------------------

loc_A8B5:
    JSR	    sub_AEE9

loc_A8B8:
    LDA	    #$C
    JSR	    sub_AC2E
    LDY	    #$D
    LDA	    (word_A2),Y
    BEQ	    loc_A8CB
    SEC
    SBC	    #1
    STA	    (word_A2),Y
    JMP	    loc_A8D6
; ---------------------------------------------------------------------------

loc_A8CB:
    LDY	    #2
    LDA	    (word_A2),Y
    CMP	    #$80
    BMI	    loc_A8D6
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A8D6:
    JSR	    sub_8AB8
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$80
    BEQ	    loc_A8E4
    JMP	    loc_ACC6
; ---------------------------------------------------------------------------

loc_A8E4:
    LDX	    #0
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BNE	    loc_A8F0
    LDX	    #$40

loc_A8F0:
    STX	    byte_2A
    JSR	    sub_85E4
    LDA	    byte_2A
    ORA	    byte_FDE5,X
    ORA	    #1
    STA	    byte_2A
    JSR	    sub_AED5
    LDY	    #7
    LDA	    (word_A2),Y
    LDY	    #6
    AND	    #$40
    BNE	    loc_A924
    LDY	    #7
    LDA	    (word_A2),Y
    LDY	    #0
    AND	    #4
    BNE	    loc_A924
    LDY	    #7
    LDA	    (word_A2),Y
    LDY	    #2
    AND	    #$10
    BNE	    loc_A924
    LDY	    #4

loc_A924:
    LDA	    off_AB78,Y
    STA	    word_1A
    LDA	    off_AB78+1,Y
    STA	    word_1A+1
    JSR	    DrawSpriteMaybe
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #4
    BNE	    loc_A955
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BNE	    locret_A958
    JSR	    CheckInvulnZoneStatus_1
    CPY	    #0
    BNE	    locret_A958
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #$40
    STA	    (word_A2),Y
    JMP	    locret_A958
; ---------------------------------------------------------------------------

loc_A955:
    JSR	    CheckInvulnZoneStatus_2

locret_A958:
    RTS
; ---------------------------------------------------------------------------

EnemyHandler_JumpingFish:
    JSR	    SetA2ToEnemyPointerFrom1C0
    LDA	    GamePaused
    BEQ	    loc_A964
    JMP	    loc_AA22
; ---------------------------------------------------------------------------

loc_A964:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #1
    BNE	    loc_A9B9
    LDY	    #$F
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    STA	    byte_20
    LDA	    byte_1C0
    ASL	    A
    ASL	    A
    ASL	    A
    CLC
    ADC	    #$80
    CMP	    byte_20
    BEQ	    loc_A989
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A989:
    LDY	    #0
    STA	    (word_A2),Y
    JSR	    sub_ABD3
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_A9A4
    LDY	    #0
    LDA	    (word_A2),Y
    CLC
    ADC	    #5
    STA	    (word_A2),Y
    JMP	    loc_A9AD
; ---------------------------------------------------------------------------

loc_A9A4:
    LDY	    #0
    LDA	    (word_A2),Y
    SEC
    SBC	    #5
    STA	    (word_A2),Y

loc_A9AD:
    LDY	    #2
    LDA	    #$80
    STA	    (word_A2),Y
    LDY	    #$D
    LDA	    #$81
    STA	    (word_A2),Y

loc_A9B9:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BEQ	    loc_A9DF
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #4
    STA	    (word_A2),Y
    LDA	    #$80
    JSR	    sub_AC93
    LDY	    #2
    LDA	    (word_A2),Y
    BMI	    loc_A9D7
    JMP	    loc_AA22
; ---------------------------------------------------------------------------

loc_A9D7:
    LDA	    #$13
    JSR	    AwardPoints
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_A9DF:
    LDA	    UnknownTimer014A
    BEQ	    loc_A9E7
    JMP	    loc_AA22
; ---------------------------------------------------------------------------

loc_A9E7:
    LDY	    #$D
    LDA	    (word_A2),Y
    LSR	    A
    TAX
    LDA	    byte_9904,X
    BMI	    loc_A9F8
    JSR	    sub_AEFF
    JMP	    loc_A9FB
; ---------------------------------------------------------------------------

loc_A9F8:
    JSR	    sub_AEE9

loc_A9FB:
    LDA	    #$18
    JSR	    sub_AC2E
    LDY	    #$D
    LDA	    (word_A2),Y
    BEQ	    loc_AA0E
    SEC
    SBC	    #1
    STA	    (word_A2),Y
    JMP	    loc_AA19
; ---------------------------------------------------------------------------

loc_AA0E:
    LDY	    #2
    LDA	    (word_A2),Y
    CMP	    #$80
    BMI	    loc_AA19
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_AA19:
    LDY	    #8
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    STA	    (word_A2),Y

loc_AA22:
    JSR	    sub_8AB8
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$80
    BEQ	    loc_AA30
    JMP	    loc_ACC6
; ---------------------------------------------------------------------------

loc_AA30:
    LDX	    #0
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_AA3C
    LDX	    #$40

loc_AA3C:
    STX	    byte_2A
    JSR	    sub_85E4
    LDA	    byte_2A
    ORA	    byte_FDE5,X
    ORA	    #0
    STA	    byte_2A
    JSR	    sub_AED5
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BNE	    loc_AA63
    LDY	    #8
    LDA	    (word_A2),Y
    AND	    #4
    LSR	    A
    TAY
    JMP	    loc_AA65
; ---------------------------------------------------------------------------

loc_AA63:
    LDY	    #4

loc_AA65:
    LDA	    off_ABA0,Y
    STA	    word_1A
    LDA	    off_ABA0+1,Y
    STA	    word_1A+1
    JSR	    DrawSpriteMaybe
    JSR	    sub_AF15
    RTS
; ---------------------------------------------------------------------------

EnemyHandler_Scorpion:
    JSR	    SetA2ToEnemyPointerFrom1C0
    LDA	    GamePaused
    BEQ	    loc_AA83
    JMP	    loc_AB2D
; ---------------------------------------------------------------------------

loc_AA83:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #1
    BNE	    loc_AAFD
    LDY	    #$F
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    STA	    byte_20
    LDA	    byte_1C0
    ASL	    A
    ASL	    A
    ASL	    A
    CLC
    ADC	    #$50
    CMP	    byte_20
    BNE	    loc_AAFA
    LDA	    #0
    STA	    (word_A2),Y
    JSR	    sub_ABD3
    LDA	    PlayerState
    AND	    #4
    BNE	    loc_AAFA
    LDA	    PlayerY
    LDY	    #2
    STA	    (word_A2),Y
    AND	    #$40
    BNE	    loc_AAC1
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_AAC1:
    LDA	    PlayerYLo
    INY
    STA	    (word_A2),Y
    LDY	    #7
    LDA	    (word_A2),Y
    STA	    byte_21
    JSR	    sub_ACFF
    LDY	    #7
    LDA	    (word_A2),Y
    CMP	    byte_21
    BNE	    loc_AAFA
    LDA	    (word_A2),Y
    EOR	    #2
    STA	    (word_A2),Y
    STA	    byte_21
    JSR	    sub_ACFF
    LDY	    #7
    LDA	    (word_A2),Y
    CMP	    byte_21
    BNE	    loc_AAFA
    LDA	    (word_A2),Y
    EOR	    #2
    STA	    (word_A2),Y
    JSR	    sub_8B25
    BNE	    loc_AAFD

loc_AAFA:
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_AAFD:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BEQ	    loc_AB1F
    LDY	    #$A
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    CMP	    #$30
    BNE	    loc_AB1A
    LDA	    #$11
    JSR	    AwardPoints
    JMP	    sub_ACF3
; ---------------------------------------------------------------------------

loc_AB1A:
    AND	    #1
    BNE	    loc_AB2D
    RTS
; ---------------------------------------------------------------------------

loc_AB1F:
    LDA	    UnknownTimer014A
    BNE	    loc_AB2D
    LDY	    #8
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    STA	    (word_A2),Y

loc_AB2D:
    JSR	    sub_8AB8
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$80
    BEQ	    loc_AB3B
    JMP	    loc_ACC6
; ---------------------------------------------------------------------------

loc_AB3B:
    LDX	    #0
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_AB47
    LDX	    #$40

loc_AB47:
    STX	    byte_2A
    JSR	    sub_85E4
    LDA	    byte_2A
    ORA	    byte_FDE5,X
    ORA	    #0
    STA	    byte_2A
    JSR	    sub_AED5
    LDY	    #8
    LDA	    (word_A2),Y
    AND	    #$10
    LSR	    A
    LSR	    A
    LSR	    A
    TAY
    LDA	    off_ABB5,Y
    STA	    word_1A
    LDA	    off_ABB5+1,Y
    STA	    word_1A+1
    JSR	    DrawSpriteMaybe
    JSR	    sub_AF2D
    RTS
; ---------------------------------------------------------------------------
off_AB78:
    .WORD byte_AB80
    .WORD byte_AB87
    .WORD byte_AB90
    .WORD byte_AB99
byte_AB80:
    .BYTE	$C4
    .BYTE $C5
    .BYTE $C2
    .BYTE $C3
    .BYTE $90
    .BYTE $91
    .BYTE $FF
byte_AB87:
    .BYTE	$C0
    .BYTE $C1
    .BYTE $B2
    .BYTE $B3
    .BYTE $A2
    .BYTE $A3
    .BYTE $92
    .BYTE $93
    .BYTE $FF
byte_AB90:
    .BYTE	$C0
    .BYTE $C1
    .BYTE $B0
    .BYTE $B1
    .BYTE $A0
    .BYTE $A1
    .BYTE $90
    .BYTE $91
    .BYTE $FF
byte_AB99:
    .BYTE	$C4
    .BYTE $C5
    .BYTE $A2
    .BYTE $A3
    .BYTE $92
    .BYTE $93
    .BYTE $FF
off_ABA0:
    .WORD byte_ABA6
    .WORD byte_ABAB
    .WORD byte_ABB0
byte_ABA6:
    .BYTE	$AA
    .BYTE $AB
    .BYTE $9A
    .BYTE $9B
    .BYTE $FF
byte_ABAB:
    .BYTE	$AA
    .BYTE $C9
    .BYTE $9A
    .BYTE $B9
    .BYTE $FF
byte_ABB0:
    .BYTE	$A6
    .BYTE $A7
    .BYTE $96
    .BYTE $97
    .BYTE $FF
off_ABB5:
    .WORD byte_ABB9
    .WORD byte_ABBE
byte_ABB9:
    .BYTE	$98
    .BYTE $99
    .BYTE $F6
    .BYTE $A8
    .BYTE $FF
byte_ABBE:
    .BYTE	$98
    .BYTE $B8
    .BYTE $A9
    .BYTE $B9
    .BYTE $FF

; =============== S U B	R O U T	I N E =======================================

; $0300	seems to be a 16-byte-ea array of enemies

SetA2ToEnemyPointerFrom1C0:
    LDA	    byte_1C0
    ASL	    A
    ASL	    A
    ASL	    A
    ASL	    A
    STA	    word_A2
    LDA	    #3
    STA	    word_A2+1
    RTS
; End of function SetA2ToEnemyPointerFrom1C0

; =============== S U B	R O U T	I N E =======================================

sub_ABD3:
    LDY	    #7
    LDA	    (word_A2),Y
    CLC
    ADC	    #1
    STA	    (word_A2),Y
    LDA	    Joypad_Held
    AND	    #ControllerInput_Right
    BNE	    loc_ABF1
    LDA	    Joypad_Held
    AND	    #ControllerInput_Left
    BNE	    loc_AC09
    LDA	    byte_1C0
    AND	    #1
    BNE	    loc_AC09

loc_ABF1:
    LDY	    #0
    LDA	    (word_A2),Y
    AND	    #3
    BNE	    loc_AC09
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$FD
    STA	    (word_A2),Y
    LDA	    byte_2
    CLC
    ADC	    #$14
    BNE	    loc_AC23

loc_AC09:
    LDY	    #0
    LDA	    (word_A2),Y
    AND	    #3
    BNE	    loc_ABF1
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #2
    STA	    (word_A2),Y
    LDA	    byte_2
    SEC
    SBC	    #4
    BCS	    loc_AC23
    LDA	    #0

loc_AC23:
    LDY	    #0
    STA	    (word_A2),Y
    LDA	    byte_3
    INY
    STA	    (word_A2),Y
    RTS
; End of function sub_ABD3

; =============== S U B	R O U T	I N E =======================================

sub_AC2E:
    STA	    byte_20
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_AC4E
    LDY	    #1
    LDA	    (word_A2),Y
    CLC
    ADC	    byte_20
    STA	    (word_A2),Y
    LDY	    #0
    LDA	    (word_A2),Y
    ADC	    #0
    STA	    (word_A2),Y
    JMP	    locret_AC60
; ---------------------------------------------------------------------------

loc_AC4E:
    LDY	    #1
    LDA	    (word_A2),Y
    SEC
    SBC	    byte_20
    STA	    (word_A2),Y
    LDY	    #0
    LDA	    (word_A2),Y
    SBC	    #0
    STA	    (word_A2),Y

locret_AC60:
    RTS
; End of function sub_AC2E

; ---------------------------------------------------------------------------
    STA	    byte_20
    LDA	    unk_387,X
    AND	    #$20
    BEQ	    loc_AC80
    LDA	    unk_381,X
    CLC
    ADC	    byte_20
    STA	    unk_381,X
    LDA	    unk_380,X
    ADC	    #0
    STA	    unk_380,X
    JMP	    locret_AC92
; ---------------------------------------------------------------------------

loc_AC80:
    LDA	    unk_381,X
    SEC
    SBC	    byte_20
    STA	    unk_381,X
    LDA	    unk_380,X
    SBC	    #0
    STA	    unk_380,X

locret_AC92:
    RTS

; =============== S U B	R O U T	I N E =======================================

sub_AC93:
    STA	    byte_20
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #4
    BEQ	    loc_ACB3
    LDY	    #3
    LDA	    (word_A2),Y
    CLC
    ADC	    byte_20
    STA	    (word_A2),Y
    LDY	    #2
    LDA	    (word_A2),Y
    ADC	    #0
    STA	    (word_A2),Y
    JMP	    locret_ACC5
; ---------------------------------------------------------------------------

loc_ACB3:
    LDY	    #3
    LDA	    (word_A2),Y
    SEC
    SBC	    byte_20
    STA	    (word_A2),Y
    LDY	    #2
    LDA	    (word_A2),Y
    SBC	    #0
    STA	    (word_A2),Y

locret_ACC5:
    RTS
; End of function sub_AC93

; ---------------------------------------------------------------------------

loc_ACC6:
    LDY	    #0
    LDA	    (word_A2),Y
    STA	    byte_20
    LDA	    PlayerX
    SEC
    SBC	    byte_20
    BCC	    loc_ACDD
    CMP	    #$10
    BMI	    locret_ACF2
    JMP	    loc_ACEF
; ---------------------------------------------------------------------------

loc_ACDD:
    LDA	    PlayerX
    STA	    byte_20
    LDY	    #0
    LDA	    (word_A2),Y
    SEC
    SBC	    byte_20
    CMP	    #$10
    BMI	    locret_ACF2

loc_ACEF:
    JSR	    sub_ACF3

locret_ACF2:
    RTS

; =============== S U B	R O U T	I N E =======================================

sub_ACF3:
    LDY	    #0
    LDA	    #0

loc_ACF7:
    STA	    (word_A2),Y
    INY
    CPY	    #$F
    BNE	    loc_ACF7
    RTS
; End of function sub_ACF3

; =============== S U B	R O U T	I N E =======================================

sub_ACFF:
    JSR	    sub_ADF9
    LDY	    #2
    LDA	    (word_A2),Y
    STA	    byte_20
    SEC
    SBC	    #3
    STA	    byte_A1
    JSR	    sub_8A6C
    CMP	    #3
    BEQ	    loc_AD2C
    LDY	    #3
    LDA	    (word_A2),Y
    SEC
    SBC	    #$40
    LDA	    byte_20
    SBC	    #0
    STA	    byte_A1
    JSR	    sub_8A6C
    CMP	    #3
    BNE	    locret_AD34

loc_AD2C:
    LDY	    #7
    LDA	    (word_A2),Y
    EOR	    #2
    STA	    (word_A2),Y

locret_AD34:
    RTS
; End of function sub_ACFF

; =============== S U B	R O U T	I N E =======================================

sub_AD35:
    JSR	    sub_ADF9
    LDY	    #2
    LDA	    (word_A2),Y
    STA	    byte_20
    SEC
    SBC	    #5
    STA	    byte_A1
    JSR	    sub_8A6C
    CMP	    #3
    BEQ	    loc_AD72
    LDA	    byte_20
    SEC
    SBC	    #3
    STA	    byte_A1
    JSR	    sub_8A6C
    CMP	    #3
    BEQ	    loc_AD72
    LDY	    #3
    LDA	    (word_A2),Y
    SEC
    SBC	    #$40
    LDA	    byte_20
    SBC	    #0
    STA	    byte_A1
    JSR	    sub_8A6C
    CMP	    #3
    BNE	    locret_AD7A

loc_AD72:
    LDY	    #7
    LDA	    (word_A2),Y
    EOR	    #2
    STA	    (word_A2),Y

locret_AD7A:
    RTS
; End of function sub_AD35

; =============== S U B	R O U T	I N E =======================================

sub_AD7B:
    JSR	    sub_ADF9
    LDY	    #2
    LDA	    (word_A2),Y
    STA	    byte_20
    SEC
    SBC	    #7
    STA	    byte_A1
    JSR	    sub_8A6C
    CMP	    #3
    BEQ	    loc_ADB8
    LDA	    byte_20
    SEC
    SBC	    #4
    STA	    byte_A1
    JSR	    sub_8A6C
    CMP	    #3
    BEQ	    loc_ADB8
    LDY	    #3
    LDA	    (word_A2),Y
    SEC
    SBC	    #$40

loc_ADA9:
    LDA	    byte_20
    SBC	    #0
    STA	    byte_A1
    JSR	    sub_8A6C
    CMP	    #3
    BNE	    locret_ADC0

loc_ADB8:
    LDY	    #7
    LDA	    (word_A2),Y
    EOR	    #2
    STA	    (word_A2),Y

locret_ADC0:
    RTS
; End of function sub_AD7B

; =============== S U B	R O U T	I N E =======================================

sub_ADC1:
    JSR	    sub_ADF9
    LDY	    #2
    LDA	    (word_A2),Y
    TAX
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #4
    BNE	    loc_ADD6
    TXA
    SEC
    SBC	    #4
    TAX

loc_ADD6:
    TXA
    STA	    byte_A1
    JSR	    sub_8A6C
    BEQ	    locret_ADE7
    LDY	    #7
    LDA	    (word_A2),Y
    EOR	    #4
    STA	    (word_A2),Y

locret_ADE7:
    RTS
; End of function sub_ADC1

; =============== S U B	R O U T	I N E =======================================

sub_ADE8:
    JSR	    sub_ADF9
    LDY	    #2
    LDA	    (word_A2),Y
    SEC
    SBC	    #6
    STA	    byte_A1
    JSR	    sub_8A6C
    RTS
; End of function sub_ADE8

; =============== S U B	R O U T	I N E =======================================

sub_ADF9:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_AE10
    LDY	    #1
    LDA	    (word_A2),Y
    CLC
    ADC	    #$50
    DEY
    LDA	    (word_A2),Y
    ADC	    #0
    JMP	    loc_AE1C
; ---------------------------------------------------------------------------

loc_AE10:
    LDY	    #1
    LDA	    (word_A2),Y
    SEC
    SBC	    #$60
    DEY
    LDA	    (word_A2),Y
    SBC	    #0

loc_AE1C:
    STA	    byte_A0
    RTS
; End of function sub_ADF9

; =============== S U B	R O U T	I N E =======================================

sub_AE20:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_AE37
    LDY	    #1
    LDA	    (word_A2),Y
    CLC
    ADC	    #$50
    DEY
    LDA	    (word_A2),Y
    ADC	    #0
    JMP	    loc_AE43
; ---------------------------------------------------------------------------

loc_AE37:
    LDY	    #1
    LDA	    (word_A2),Y
    SEC
    SBC	    #$60
    DEY
    LDA	    (word_A2),Y
    SBC	    #0

loc_AE43:
    STA	    byte_A0
    LDY	    #2
    LDA	    (word_A2),Y
    STA	    byte_A1
    JSR	    sub_8A6C
    CMP	    #3
    BNE	    loc_AE59
    LDA	    #$FF
    JMP	    locret_AE5B
; ---------------------------------------------------------------------------

loc_AE59:
    LDA	    #0

locret_AE5B:
    RTS
; End of function sub_AE20

; =============== S U B	R O U T	I N E =======================================

sub_AE5C:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_AE73
    LDY	    #1
    LDA	    (word_A2),Y
    SEC
    SBC	    #$50
    DEY
    LDA	    (word_A2),Y
    SBC	    #0
    JMP	    loc_AE7F
; ---------------------------------------------------------------------------

loc_AE73:
    LDY	    #1
    LDA	    (word_A2),Y
    CLC
    ADC	    #$40
    DEY
    LDA	    (word_A2),Y
    ADC	    #0

loc_AE7F:
    STA	    byte_A0
    LDY	    #2
    LDA	    (word_A2),Y
    STA	    byte_A1
    JSR	    sub_8A6C
    CMP	    #3
    BNE	    loc_AE95
    LDA	    #$FF
    JMP	    locret_AE97
; ---------------------------------------------------------------------------

loc_AE95:
    LDA	    #0

locret_AE97:
    RTS
; End of function sub_AE5C

; =============== S U B	R O U T	I N E =======================================

sub_AE98:
    STA	    byte_20
    LDX	    #3

loc_AE9D:
    LDA	    byte_1DA,X
    BEQ	    loc_AEA6
    DEX
    BPL	    loc_AE9D
    RTS
; ---------------------------------------------------------------------------

loc_AEA6:
    LDA	    byte_20
    STA	    byte_1DA,X
    TXA
    ASL	    A
    ASL	    A
    ASL	    A
    ASL	    A
    TAX
    LDY	    #0
    LDA	    (word_A2),Y
    STA	    unk_380,X
    INY
    LDA	    (word_A2),Y
    STA	    unk_381,X
    INY
    LDA	    (word_A2),Y
    STA	    unk_382,X
    INY
    LDA	    (word_A2),Y
    STA	    unk_383,X
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    STA	    unk_387,X
    RTS
; End of function sub_AE98

; =============== S U B	R O U T	I N E =======================================

sub_AED5:
    LDY	    #4
    LDA	    (word_A2),Y
    STA	    byte_28
    STA	    byte_A4
    INY
    LDA	    (word_A2),Y
    STA	    byte_29
    STA	    byte_A5
    RTS
; End of function sub_AED5

; =============== S U B	R O U T	I N E =======================================

sub_AEE9:
    ASL	    A
    STA	    byte_20
    LDY	    #3
    LDA	    (word_A2),Y
    CLC
    ADC	    byte_20
    STA	    (word_A2),Y
    DEY
    LDA	    (word_A2),Y
    ADC	    #$FF
    STA	    (word_A2),Y
    RTS
; End of function sub_AEE9

; =============== S U B	R O U T	I N E =======================================

sub_AEFF:
    ASL	    A
    STA	    byte_20
    LDY	    #3
    LDA	    (word_A2),Y
    CLC
    ADC	    byte_20
    STA	    (word_A2),Y
    DEY
    LDA	    (word_A2),Y
    ADC	    #0
    STA	    (word_A2),Y
    RTS
; End of function sub_AEFF

; =============== S U B	R O U T	I N E =======================================

sub_AF15:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BNE	    locret_AF2C
    JSR	    CheckInvulnZoneStatus_3
    CPY	    #$FF
    BEQ	    locret_AF2C
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #$40
    STA	    (word_A2),Y

locret_AF2C:
    RTS
; End of function sub_AF15

; =============== S U B	R O U T	I N E =======================================

sub_AF2D:
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #$40
    BNE	    locret_AF44
    JSR	    CheckInvulnZoneStatus_3
    CPY	    #0
    BNE	    locret_AF44
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #$40
    STA	    (word_A2),Y

locret_AF44:
    RTS
; End of function sub_AF2D

; ---------------------------------------------------------------------------

EnemyHandler_FireballSpawner:
    LDA	    GotEndingGem
    BNE	    locret_AF44
    JSR	    SetA2ToEnemyPointerFrom1C0
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #1
    BNE	    loc_AF7B
    LDA	    #1
    STA	    (word_A2),Y
    LDA	    byte_1C0
    ASL	    A
    TAX
    ASL	    A
    ASL	    A
    LDY	    #8
    STA	    (word_A2),Y
    LDY	    #0
    LDA	    FireballSpawnerPositions,X
    STA	    (word_A2),Y
    INY
    LDA	    #0
    STA	    (word_A2),Y
    INY
    LDA	    FireballSpawnerPositions+1,X
    STA	    (word_A2),Y
    LDA	    #$80
    INY
    STA	    (word_A2),Y

loc_AF7B:
    JSR	    sub_8AB8
    LDY	    #7
    LDA	    (word_A2),Y
    BMI	    locret_AFC7
    INY
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    STA	    (word_A2),Y
    AND	    #$F
    BNE	    locret_AFC7
    LDX	    #3

loc_AF92:
    LDA	    byte_1DA,X
    BEQ	    loc_AF9C
    DEX
    BNE	    loc_AF92
    BEQ	    locret_AFC7

loc_AF9C:
    LDA	    #1
    STA	    byte_1DA,X
    TXA
    ASL	    A
    ASL	    A
    ASL	    A
    ASL	    A
    TAX
    LDY	    #0

loc_AFA9:
    LDA	    (word_A2),Y
    STA	    unk_380,X
    INY
    INX
    CPY	    #4
    BNE	    loc_AFA9
    LDA	    (word_A2),Y
    CMP	    byte_214
    BCC	    loc_AFBF
    LDA	    #0
    BEQ	    loc_AFC1

loc_AFBF:
    LDA	    #2

loc_AFC1:
    INX
    INX
    INX
    STA	    unk_380,X

locret_AFC7:
    RTS
; ---------------------------------------------------------------------------
FireballSpawnerPositions:
    .BYTE $1C,$69
    .BYTE $24,$6D			; 2
    .BYTE $2C,$65			; 4
    .BYTE $34,$6D			; 6
    .BYTE $3C,$69			; 8
    .BYTE $44,$6D			; $A
    .BYTE $54,$65			; $C
    .BYTE $4C,$61			; $E
; ---------------------------------------------------------------------------

EnemyHandler_Nothing:
    RTS
; ---------------------------------------------------------------------------
ZoneEnemyTable:
    .WORD ZoneEnemies_TwoBats
    .WORD ZoneEnemies_TwoSnails		; 1
    .WORD ZoneEnemies_TwoSnailsOneFish	; 2
    .WORD ZoneEnemies_TwoBatsOneSkeleton; 3
    .WORD ZoneEnemies_TwoWorms		; 4
    .WORD ZoneEnemies_TwoBats		; 5
    .WORD ZoneEnemies_TwoFliesOneSkeleton; 6
    .WORD ZoneEnemies_TwoSnails		; 7
    .WORD ZoneEnemies_0			; 8
    .WORD ZoneEnemies_0			; 9
    .WORD ZoneEnemies_TwoWorms		; 10
    .WORD ZoneEnemies_TwoBatsOneSkeleton; 11
    .WORD ZoneEnemies_TwoWormsOneMummy	; 12
    .WORD ZoneEnemies_FourSnails	; 13
    .WORD ZoneEnemies_0			; 14
    .WORD ZoneEnemies_TwoBatsOneMummy	; 15
    .WORD ZoneEnemies_TwoSnailsOneFish	; 16
    .WORD ZoneEnemies_TwoWorms		; 17
    .WORD ZoneEnemies_TwoBlobs		; 18
    .WORD ZoneEnemies_0			; 19
    .WORD ZoneEnemies_FourSkeletons	; 20
    .WORD ZoneEnemies_0			; 21
    .WORD ZoneEnemies_TwoWormsOneSkeleton; 22
    .WORD ZoneEnemies_TwoFliesOneMummy	; 23
    .WORD ZoneEnemies_TwoBats		; 24
    .WORD ZoneEnemies_0			; 25
    .WORD ZoneEnemies_OneFishOneFishman	; 26
    .WORD ZoneEnemies_TwoWorms		; 27
    .WORD ZoneEnemies_TwoWormsOneSkeleton; 28
    .WORD ZoneEnemies_TwoBlobs		; 29
    .WORD ZoneEnemies_TwoWormsOneSkeleton; 30
    .WORD ZoneEnemies_FourSkeletons	; 31
    .WORD ZoneEnemies_TwoScorpionsOneMummy; 32
    .WORD ZoneEnemies_OneFishOneFishman	; 33
    .WORD ZoneEnemies_0			; 34
    .WORD ZoneEnemies_FourSnails	; 35
    .WORD ZoneEnemies_TwoSnailsOneFish	; 36
    .WORD ZoneEnemies_TwoBats		; 37
    .WORD ZoneEnemies_TwoFlies		; 38
    .WORD ZoneEnemies_TwoSnails		; 39
    .WORD ZoneEnemies_0			; 40
    .WORD ZoneEnemies_0			; 41
    .WORD ZoneEnemies_TwoBlobs		; 42
    .WORD ZoneEnemies_FourFlies		; 43
    .WORD ZoneEnemies_FourSnails	; 44
    .WORD ZoneEnemies_FourSnails	; 45
    .WORD ZoneEnemies_TwoFliesOneSkeleton; 46
    .WORD ZoneEnemies_TwoWorms		; 47
    .WORD ZoneEnemies_FourSkeletons	; 48
    .WORD ZoneEnemies_FourWorms		; 49
    .WORD ZoneEnemies_TwoSnailsOneFish	; 50
    .WORD ZoneEnemies_TwoFlies		; 51
    .WORD ZoneEnemies_TwoBats		; 52
    .WORD ZoneEnemies_TwoFlies		; 53
    .WORD ZoneEnemies_0			; 54
    .WORD ZoneEnemies_TwoScorpionsOneMummy; 55
    .WORD ZoneEnemies_TwoBlobsTwoSnails	; 56
    .WORD ZoneEnemies_TwoSnailsOneFishman; 57
    .WORD ZoneEnemies_TwoBats		; 58
    .WORD ZoneEnemies_FourBlobs		; 59
    .WORD ZoneEnemies_TwoBlobsTwoSnails	; 60
    .WORD ZoneEnemies_TwoWormsOneSkeleton; 61
    .WORD ZoneEnemies_0			; 62
    .WORD ZoneEnemies_0			; 63
    .WORD ZoneEnemies_TwoSnailsOneFishman; 64
    .WORD ZoneEnemies_0			; 65
    .WORD ZoneEnemies_TwoSnails		; 66
    .WORD ZoneEnemies_FourWorms		; 67
    .WORD ZoneEnemies_TwoFlies		; 68
    .WORD ZoneEnemies_FourFlies		; 69
    .WORD ZoneEnemies_0			; 70
    .WORD ZoneEnemies_ThreeMummiesTwoBats; 71
    .WORD ZoneEnemies_TwoSnailsOneFish	; 72
    .WORD ZoneEnemies_FourSkeletons	; 73
    .WORD ZoneEnemies_FourFlies		; 74
    .WORD ZoneEnemies_0			; 75
    .WORD ZoneEnemies_TwoWorms		; 76
    .WORD ZoneEnemies_FourFlies		; 77
    .WORD ZoneEnemies_ThreeFishTwoFishmanTwoSnails; 78
    .WORD ZoneEnemies_FourWorms		; 79
    .WORD ZoneEnemies_TwoBats		; 80
    .WORD ZoneEnemies_TwoFlies		; 81
    .WORD ZoneEnemies_TwoBatsOneMummy	; 82
    .WORD ZoneEnemies_FourSkeletons	; 83
    .WORD ZoneEnemies_ThreeFishTwoFishmanTwoSnails; 84
    .WORD ZoneEnemies_TwoScorpionsOneMummy; 85
    .WORD ZoneEnemies_TwoFliesOneMummy	; 86
    .WORD ZoneEnemies_0			; 87
    .WORD ZoneEnemies_TwoSnails		; 88
    .WORD ZoneEnemies_ThreeFishTwoFishmanTwoSnails; 89
    .WORD ZoneEnemies_0			; 90
    .WORD ZoneEnemies_FourBlobs		; 91
    .WORD ZoneEnemies_0			; 92
    .WORD ZoneEnemies_ThreeFishTwoFishmanTwoSnails; 93
    .WORD ZoneEnemies_TwoBlobTwoSnailTwoBat; 94
    .WORD ZoneEnemies_TwoScorpionsOneMummy; 95
    .WORD ZoneEnemies_FourFlies		; 96
    .WORD ZoneEnemies_FourWorms		; 97
    .WORD ZoneEnemies_ThreeMummiesTwoBats; 98
    .WORD ZoneEnemies_FinalZone		; 99
ZoneEnemies_0:
    .BYTE Enemy_Nothing,Enemy_End	  ;	DATA XREF: BANK0:ZoneEnemyTableo
ZoneEnemies_TwoWorms:
    .BYTE Enemy_WormThing,Enemy_WormThing,Enemy_End
ZoneEnemies_TwoFlies:
    .BYTE Enemy_Fly,Enemy_Fly,Enemy_End
ZoneEnemies_TwoBats:
    .BYTE Enemy_ShitBat,Enemy_ShitBat,Enemy_End
ZoneEnemies_TwoWormsOneSkeleton:
    .BYTE Enemy_WormThing,Enemy_WormThing,Enemy_Skeleton,Enemy_End
ZoneEnemies_TwoWormsOneMummy:
    .BYTE Enemy_WormThing,Enemy_WormThing,Enemy_Mummy,Enemy_End
ZoneEnemies_TwoScorpionsOneMummy:
    .BYTE Enemy_Scorpion,Enemy_Scorpion,Enemy_Mummy,Enemy_End
ZoneEnemies_TwoFliesOneMummy:
    .BYTE Enemy_Fly,Enemy_Fly,Enemy_Mummy,Enemy_End
ZoneEnemies_TwoBatsOneSkeleton:
    .BYTE Enemy_ShitBat,Enemy_ShitBat,Enemy_Skeleton,Enemy_End
ZoneEnemies_TwoBatsOneMummy:
    .BYTE Enemy_ShitBat,Enemy_ShitBat,Enemy_Mummy,Enemy_End
ZoneEnemies_FourWorms:
    .BYTE Enemy_WormThing,Enemy_WormThing,Enemy_WormThing,Enemy_WormThing,Enemy_End
ZoneEnemies_FourFlies:
    .BYTE Enemy_Fly,Enemy_Fly,Enemy_Fly,Enemy_Fly,Enemy_End
ZoneEnemies_FourSkeletons:
    .BYTE	Enemy_Skeleton,Enemy_Skeleton,Enemy_Skeleton,Enemy_Skeleton,Enemy_End
ZoneEnemies_ThreeMummiesTwoBats:
    .BYTE Enemy_Mummy,Enemy_Mummy,Enemy_Mummy,Enemy_ShitBat,Enemy_ShitBat,Enemy_End
ZoneEnemies_TwoFliesOneSkeleton:
    .BYTE Enemy_Fly,Enemy_Fly,Enemy_Skeleton,Enemy_End
ZoneEnemies_TwoSnails:
    .BYTE Enemy_Snail,Enemy_Snail,Enemy_End
ZoneEnemies_TwoBlobs:
    .BYTE Enemy_GravityBlob,Enemy_GravityBlob,Enemy_End
ZoneEnemies_TwoBlobsTwoSnails:
    .BYTE Enemy_GravityBlob,Enemy_GravityBlob,Enemy_Snail,Enemy_Snail,Enemy_End
ZoneEnemies_TwoSnailsOneFishman:
    .BYTE Enemy_Snail,Enemy_Snail,Enemy_Fishman,Enemy_End
ZoneEnemies_OneFishOneFishman:
    .BYTE Enemy_JumpingFish,Enemy_Fishman,Enemy_End
ZoneEnemies_Unused:
    .BYTE Enemy_Snail,Enemy_Snail,Enemy_ShitBat,Enemy_ShitBat,Enemy_End
ZoneEnemies_FourSnails:
    .BYTE Enemy_Snail,Enemy_Snail,Enemy_Snail,Enemy_Snail,Enemy_End
ZoneEnemies_FourBlobs:
    .BYTE Enemy_GravityBlob,Enemy_GravityBlob,Enemy_GravityBlob,Enemy_GravityBlob,Enemy_End
ZoneEnemies_TwoBlobTwoSnailTwoBat:
    .BYTE	Enemy_GravityBlob,Enemy_GravityBlob,Enemy_Snail,Enemy_Snail,Enemy_ShitBat,Enemy_ShitBat,Enemy_End
ZoneEnemies_ThreeFishTwoFishmanTwoSnails:
    .BYTE Enemy_JumpingFish,Enemy_JumpingFish,Enemy_JumpingFish,Enemy_Fishman,Enemy_Fishman,Enemy_Snail
    .BYTE Enemy_Snail,Enemy_End		; 6
ZoneEnemies_TwoSnailsOneFish:
    .BYTE Enemy_Snail,Enemy_Snail,Enemy_JumpingFish,Enemy_End
ZoneEnemies_FinalZone:
    .BYTE Enemy_FireballSpawner,Enemy_FireballSpawner,Enemy_FireballSpawner,Enemy_FireballSpawner,Enemy_FireballSpawner
    .BYTE Enemy_FireballSpawner,Enemy_FireballSpawner,Enemy_FireballSpawner,Enemy_End; 5
ProbablyEnemyPointers:
    .WORD EnemyHandler_Nothing
    .WORD EnemyHandler_WormThing	; 1 ; Enemy_WormThing
    .WORD EnemyHandler_ShitBat		; 2 ; Enemy_ShitBat
    .WORD EnemyHandler_Mummy		; 3 ; Enemy_Mummy
    .WORD EnemyHandler_Skeleton		; 4 ; Enemy_Skeleton
    .WORD EnemyHandler_GravityBlob	; 5 ; Enemy_GravityBlob
    .WORD EnemyHandler_Snail		; 6 ; Enemy_Snail
    .WORD EnemyHandler_Fly		; 7 ; Enemy_Fly
    .WORD EnemyHandler_Fishman		; 8 ; Enemy_Fishman
    .WORD EnemyHandler_JumpingFish	; 9 ; Enemy_JumpingFish
    .WORD EnemyHandler_Scorpion		; 10 ; Enemy_NonMovingThing
    .WORD EnemyHandler_FireballSpawner	; 11 ; Enemy_FireballSpawner
    .WORD EnemyHandler_Nothing		; 12
    .WORD EnemyHandler_Nothing		; 13
    .WORD EnemyHandler_Nothing		; 14
    .WORD EnemyHandler_Nothing		; 15
off_B13A:
    .WORD EnemyHandler_Nothing
    .WORD loc_B609
    .WORD loc_B53D
    .WORD loc_B71C

; =============== S U B	R O U T	I N E =======================================

sub_B142:
    LDA	    #3
    STA	    byte_20
    LDA	    #0
    STA	    byte_21
    LDA	    #2
    STA	    word_A2+1

loc_B151:
    LDY	    byte_21
    LDA	    unk_231,Y
    BNE	    loc_B15C
    JMP	    loc_B228
; ---------------------------------------------------------------------------

loc_B15C:
    CLC
    LDA	    #$30
    ADC	    byte_21
    STA	    word_A2
    JSR	    sub_8AB8
    LDY	    byte_21
    LDA	    unk_237,Y
    BPL	    loc_B173
    JMP	    loc_B228
; ---------------------------------------------------------------------------

loc_B173:
    LDA	    unk_234,Y
    STA	    byte_28
    LDA	    unk_235,Y
    STA	    byte_29
    LDA	    #3
    STA	    byte_2A
    LDX	    #0
    LDA	    unk_236,Y
    CMP	    #$FF
    BNE	    loc_B19C
    LDA	    unk_237,Y
    ASL	    A
    CLC
    ADC	    #4
    TAX
    LDA	    #2
    STA	    byte_2A
    BNE	    loc_B1A3

loc_B19C:
    LDA	    unk_237,Y
    BNE	    loc_B1A3
    INX
    INX

loc_B1A3:
    LDA	    off_B7C1,X
    STA	    word_1A
    LDA	    off_B7C1+1,X
    STA	    word_1A+1
    JSR	    DrawSpriteMaybe
    LDY	    byte_21
    LDA	    unk_230,Y
    CMP	    PlayerX
    BEQ	    loc_B1C0
    JMP	    loc_B228
; ---------------------------------------------------------------------------

loc_B1C0:
    LDA	    unk_232,Y
    CMP	    PlayerY
    BEQ	    loc_B1CB
    JMP	    loc_B228
; ---------------------------------------------------------------------------

loc_B1CB:
    LDA	    unk_237,Y
    TAX
    LDA	    unk_236,Y
    CMP	    #$FF
    BEQ	    loc_B211
    TXA
    BEQ	    loc_B228
    LDA	    unk_236,Y
    AND	    #7
    TAX
    LDA	    byte_9068,X
    STA	    byte_24
    LDA	    unk_236,Y
    LSR	    A
    LSR	    A
    LSR	    A
    TAX
    LDA	    unk_400,X
    ORA	    byte_24
    STA	    unk_400,X
    LDA	    unk_237,Y
    TAX
    LDA	    #0
    STA	    unk_237,Y
    TXA
    AND	    #$7F
    PHA
    LDA	    #MusicTrack_Treasure
    JSR	    PlayMusicTrack
    PLA
    JSR	    AwardPoints2
    INC	    PlayerChestsOpened
    JMP	    loc_B228
; ---------------------------------------------------------------------------

loc_B211:
    TXA
    AND	    #7
    TAX
    LDA	    #$FF
    STA	    PlayerItem_Lightbulb,X
    LDA	    #MusicTrack_Treasure
    JSR	    PlayMusicTrack
    LDY	    #7
    LDA	    #0

loc_B223:
    STA	    (word_A2),Y
    DEY
    BPL	    loc_B223

loc_B228:
    CLC
    LDA	    byte_21
    ADC	    #8
    STA	    byte_21
    DEC	    byte_20
    BMI	    locret_B239
    JMP	    loc_B151
; ---------------------------------------------------------------------------

locret_B239:
    RTS
; End of function sub_B142

; =============== S U B	R O U T	I N E =======================================

CheckInvulnZoneStatus_1:
    LDA	    PlayerItem_Invulnerable
    BNE	    loc_B24E
    LDA	    ProbablyZoneStatusShit
    BMI	    loc_B24E
    LDA	    byte_A5
    CMP	    #$F0
    BCS	    loc_B24E
    JSR	    sub_B2A7

loc_B24E:
    JMP	    sub_B32D
; End of function CheckInvulnZoneStatus_1

; =============== S U B	R O U T	I N E =======================================

CheckInvulnZoneStatus_2:
    LDA	    PlayerItem_Invulnerable
    BNE	    loc_B265
    LDA	    ProbablyZoneStatusShit
    BMI	    loc_B265
    LDA	    byte_A5
    CMP	    #$F0
    BCS	    loc_B265
    JSR	    sub_B27F

loc_B265:
    JMP	    loc_B353
; End of function CheckInvulnZoneStatus_2

; =============== S U B	R O U T	I N E =======================================

CheckInvulnZoneStatus_3:
    LDA	    PlayerItem_Invulnerable
    BNE	    loc_B27C
    LDA	    ProbablyZoneStatusShit
    BMI	    loc_B27C
    LDA	    byte_A5
    CMP	    #$F0
    BCS	    loc_B27C
    JSR	    sub_B305

loc_B27C:
    JMP	    sub_B393
; End of function CheckInvulnZoneStatus_3

; =============== S U B	R O U T	I N E =======================================

sub_B27F:
    LDA	    byte_A4
    CMP	    #$89
    BPL	    locret_B2F0
    CMP	    #$77
    BMI	    locret_B2F0
    LDA	    byte_215
    SEC
    SBC	    byte_A5
    TAX
    BPL	    loc_B2BC
    LDA	    PlayerState
    AND	    #PlayerStates_Jumping
    BNE	    loc_B2A1
    CPX	    #$FA
    BMI	    locret_B2F0
    BPL	    loc_B2CF

loc_B2A1:
    CPX	    #$EF
    BMI	    locret_B2F0
    BPL	    loc_B2CF
; End of function sub_B27F

; =============== S U B	R O U T	I N E =======================================

sub_B2A7:
    LDA	    byte_A4
    CMP	    #$89
    BPL	    locret_B2F0
    CMP	    #$77
    BMI	    locret_B2F0
    LDA	    byte_215
    SEC
    SBC	    byte_A5
    TAX
    BMI	    loc_B2F1

loc_B2BC:
    LDA	    PlayerState
    AND	    #PlayerStates_Ducking
    BNE	    loc_B2C9
    CPX	    #$1A
    BPL	    locret_B2F0
    BMI	    loc_B2CF

loc_B2C9:
    CPX	    #$10
    BPL	    locret_B2F0
    BMI	    loc_B2CF

loc_B2CF:
    LDA	    PlayerState
    BMI	    locret_B2F0
    ORA	    #PlayerStates_Dead
    STA	    PlayerState
    LDA	    #$49
    STA	    byte_220
    LDA	    #$21
    STA	    byte_21F
    LDA	    #0
    STA	    PlayerItem_SlowTimer
    STA	    PlayerItem_Invulnerable
    LDA	    #MusicTrack_Death
    JSR	    PlayMusicTrack

locret_B2F0:
    RTS
; ---------------------------------------------------------------------------

loc_B2F1:
    LDA	    PlayerState
    AND	    #PlayerStates_Jumping
    BNE	    loc_B2FE
    CPX	    #$E3
    BMI	    locret_B304
    BPL	    loc_B2CF

loc_B2FE:
    CPX	    #$E8
    BMI	    locret_B304
    BPL	    loc_B2CF

locret_B304:
    RTS
; End of function sub_B2A7

; =============== S U B	R O U T	I N E =======================================

sub_B305:
    LDA	    byte_A4
    CMP	    #$8B
    BPL	    locret_B304
    CMP	    #$75
    BMI	    locret_B304
    LDA	    byte_215
    SEC
    SBC	    byte_A5
    TAX
    BPL	    loc_B2BC
    LDA	    PlayerState
    AND	    #PlayerStates_Jumping
    BNE	    loc_B327
    CPX	    #$F4
    BMI	    locret_B304
    BPL	    loc_B2CF

loc_B327:
    CPX	    #$FC
    BMI	    locret_B304
    BPL	    loc_B2CF
; End of function sub_B305

; =============== S U B	R O U T	I N E =======================================

sub_B32D:
    LDY	    #$FF
    LDA	    byte_266
    BEQ	    locret_B352
    LDA	    byte_26E
    BEQ	    loc_B33C
    JMP	    loc_B3B7
; ---------------------------------------------------------------------------

loc_B33C:
    LDA	    byte_26F
    BNE	    locret_B352
    LDA	    byte_265
    SEC
    SBC	    byte_A5
    TAX
    BMI	    loc_B34E
    JMP	    loc_B38D
; ---------------------------------------------------------------------------

loc_B34E:
    CPX	    #$E1
    BPL	    loc_B378

locret_B352:
    RTS
; ---------------------------------------------------------------------------

loc_B353:
    LDY	    #$FF
    LDA	    byte_266
    BEQ	    locret_B352
    LDA	    byte_26E
    BEQ	    loc_B362
    JMP	    loc_B3CE
; ---------------------------------------------------------------------------

loc_B362:
    LDA	    byte_26F
    BNE	    locret_B352
    LDA	    byte_265
    SEC
    SBC	    byte_A5
    TAX
    BMI	    loc_B374
    JMP	    loc_B38D
; ---------------------------------------------------------------------------

loc_B374:
    CPX	    #$E9
    BMI	    locret_B352

loc_B378:
    SEC
    LDA	    byte_264
    SBC	    byte_A4
    CMP	    #5
    BCC	    loc_B387
    CMP	    #$FB
    BCC	    locret_B38C

loc_B387:
    STY	    byte_26F
    LDY	    #1

locret_B38C:
    RTS
; ---------------------------------------------------------------------------

loc_B38D:
    CPX	    #3
    BMI	    loc_B378
    BPL	    locret_B38C
; End of function sub_B32D

; =============== S U B	R O U T	I N E =======================================

sub_B393:
    LDY	    #$FF
    LDA	    byte_266
    BEQ	    locret_B38C
    LDA	    byte_26E
    BEQ	    loc_B3A2
    JMP	    loc_B3FC
; ---------------------------------------------------------------------------

loc_B3A2:
    LDA	    byte_26F
    BNE	    locret_B38C
    LDA	    byte_265
    SEC
    SBC	    byte_A5
    TAX
    BPL	    loc_B38D
    CPX	    #$F1
    BPL	    loc_B378
    BMI	    locret_B38C

loc_B3B7:
    LDA	    PlayerItem_SuperBomb
    BNE	    loc_B3F3
    LDA	    byte_265
    SEC
    SBC	    byte_A5
    TAX
    BMI	    loc_B3C9
    JMP	    loc_B3F6
; ---------------------------------------------------------------------------

loc_B3C9:
    CPX	    #$D6
    BPL	    loc_B3E4

locret_B3CD:
    RTS
; ---------------------------------------------------------------------------

loc_B3CE:
    LDA	    PlayerItem_SuperBomb
    BNE	    loc_B3F3
    LDA	    byte_265
    SEC
    SBC	    byte_A5
    TAX
    BMI	    loc_B3E0
    JMP	    loc_B3F6
; ---------------------------------------------------------------------------

loc_B3E0:
    CPX	    #$DE
    BMI	    locret_B3CD

loc_B3E4:
    SEC
    LDA	    byte_264
    SBC	    byte_A4
    CMP	    #$10
    BCC	    loc_B3F3
    CMP	    #$F0
    BCC	    locret_B3F5

loc_B3F3:
    LDY	    #0

locret_B3F5:
    RTS
; ---------------------------------------------------------------------------

loc_B3F6:
    CPX	    #$B
    BMI	    loc_B3E4
    BPL	    locret_B3F5

loc_B3FC:
    LDA	    PlayerItem_SuperBomb
    BNE	    loc_B3F3
    LDA	    byte_265
    SEC
    SBC	    byte_A5
    TAX
    BPL	    loc_B3F6
    CPX	    #$E6
    BPL	    loc_B3E4
    BMI	    locret_B3F5
; End of function sub_B393

; =============== S U B	R O U T	I N E =======================================

sub_B411:
    JSR	    sub_B41A
    JSR	    sub_B453
    JMP	    loc_B48E
; End of function sub_B411

; =============== S U B	R O U T	I N E =======================================

sub_B41A:
    LDA	    byte_264
    STA	    byte_A4
    LDA	    byte_265
    STA	    byte_A5
    JSR	    sub_B503
    BNE	    locret_B44C
    LDA	    byte_26E
    BEQ	    loc_B44D
    LDA	    PlayerState
    ORA	    #PlayerStates_40|PlayerStates_Dead
    STA	    PlayerState
    LDA	    #8
    STA	    byte_220
    LDA	    #$21
    STA	    byte_21F
    LDA	    #0
    STA	    PlayerItem_Lightbulb
    LDA	    #MusicTrack_Death
    JSR	    PlayMusicTrack

locret_B44C:
    RTS
; ---------------------------------------------------------------------------

loc_B44D:
    LDA	    #$FF
    STA	    byte_26F
    RTS
; End of function sub_B41A

; =============== S U B	R O U T	I N E =======================================

sub_B453:
    LDA	    PlayerState
    AND	    #$C0
    CMP	    #$80
    BEQ	    locret_B44C
    LDX	    #0

loc_B45E:
    LDA	    ZoneDoors,X
    BPL	    loc_B485
    AND	    #$A
    BEQ	    loc_B485
    LDA	    ZoneDoors+1,X
    CMP	    PlayerX
    BNE	    loc_B485
    LDA	    ZoneDoors+2,X
    ORA	    #$40
    CMP	    PlayerY
    BNE	    loc_B485
    LDA	    ZoneDoors+3,X
    STA	    LastDoorEntered
    LDA	    #$FF
    STA	    TriggerZoneChange
    RTS
; ---------------------------------------------------------------------------

loc_B485:
    INX
    INX
    INX
    INX
    CPX	    #$10
    BNE	    loc_B45E
    RTS
; End of function sub_B453

; ---------------------------------------------------------------------------

loc_B48E:
    LDA	    byte_26E
    BEQ	    locret_B4BA
    LDX	    #0

loc_B495:
    LDA	    ZoneDoors,X
    BPL	    loc_B4B2
    AND	    #5
    BEQ	    loc_B4B2
    LDA	    ZoneDoors+1,X
    CMP	    byte_260
    BNE	    loc_B4B2
    LDA	    ZoneDoors+2,X
    ORA	    #$40
    TAY
    DEY
    CPY	    byte_262
    BEQ	    loc_B4BB

loc_B4B2:
    INX
    INX
    INX
    INX
    CPX	    #$10
    BNE	    loc_B495

locret_B4BA:
    RTS
; ---------------------------------------------------------------------------

loc_B4BB:
    LDA	    ZoneDoors,X
    AND	    #1
    BEQ	    loc_B4C8
    LDA	    #$82
    LDY	    #4
    BNE	    loc_B4CC

loc_B4C8:
    LDA	    #$81
    LDY	    #0

loc_B4CC:
    STY	    byte_A8
    STA	    ZoneDoors,X
    JMP	    loc_8BA5

; =============== S U B	R O U T	I N E =======================================

sub_B4D5:
    JSR	    sub_B503
    LDA	    PlayerItem_Invulnerable
    BNE	    locret_B502
    CPY	    #0
    BNE	    locret_B502
    LDA	    PlayerState
    BMI	    locret_B502
    ORA	    #$C0
    STA	    PlayerState
    LDA	    #8
    STA	    byte_220
    LDA	    #$21
    STA	    byte_21F
    LDA	    #0
    STA	    PlayerItem_Shoes
    STA	    PlayerItem_UpArrow
    LDA	    #MusicTrack_Death
    JSR	    PlayMusicTrack

locret_B502:
    RTS
; End of function sub_B4D5

; =============== S U B	R O U T	I N E =======================================

sub_B503:
    LDA	    ProbablyZoneStatusShit
    BMI	    loc_B533
    LDA	    byte_A4
    CMP	    #$85
    BCS	    loc_B533
    CMP	    #$7B
    BCC	    loc_B533
    LDA	    byte_215
    SEC
    SBC	    byte_A5
    TAX
    BCC	    loc_B533
    LDA	    PlayerState
    AND	    #4
    BEQ	    loc_B528
    CPX	    #4
    BCC	    loc_B533

loc_B528:
    LDA	    PlayerState
    AND	    #$10
    BNE	    loc_B536
    CPX	    #$20
    BCC	    loc_B53A

loc_B533:
    LDY	    #$FF
    RTS
; ---------------------------------------------------------------------------

loc_B536:
    CPX	    #$12
    BCS	    loc_B533

loc_B53A:
    LDY	    #0
    RTS
; End of function sub_B503

; ---------------------------------------------------------------------------

loc_B53D:
    JSR	    sub_B7A7
    LDA	    GamePaused
    BNE	    loc_B58B
    LDY	    #7
    LDA	    (word_A2),Y
    LDY	    #1
    AND	    #2
    BEQ	    loc_B560
    LDA	    (word_A2),Y
    CLC
    ADC	    #$28
    STA	    (word_A2),Y
    DEY
    LDA	    (word_A2),Y
    ADC	    #0
    STA	    (word_A2),Y
    JMP	    loc_B56E
; ---------------------------------------------------------------------------

loc_B560:
    LDA	    (word_A2),Y
    SEC
    SBC	    #$28
    STA	    (word_A2),Y
    DEY
    LDA	    (word_A2),Y
    SBC	    #0
    STA	    (word_A2),Y

loc_B56E:
    LDY	    #9
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    BEQ	    loc_B579
    STA	    (word_A2),Y

loc_B579:
    TAX
    LDA	    byte_9904,X
    LSR	    A
    LDY	    #3
    ADC	    (word_A2),Y
    STA	    (word_A2),Y
    DEY
    LDA	    (word_A2),Y
    ADC	    #0
    STA	    (word_A2),Y

loc_B58B:
    JSR	    sub_8AB8
    LDY	    #7
    LDA	    (word_A2),Y
    BPL	    loc_B59D

loc_B594:
    LDX	    byte_1C5
    LDA	    #0
    STA	    byte_1DA,X
    RTS
; ---------------------------------------------------------------------------

loc_B59D:
    LDX	    byte_155
    LDY	    #5
    LDA	    (word_A2),Y
    STA	    byte_A5
    SEC
    SBC	    #4
    STA	    SpriteData,X
    STA	    SpriteData+4,X
    DEY
    LDA	    (word_A2),Y
    STA	    byte_A4
    STA	    SpriteData+7,X
    SEC
    SBC	    #8
    STA	    SpriteData+3,X
    LDY	    #7
    LDA	    (word_A2),Y
    AND	    #2
    BEQ	    loc_B5D5
    LDY	    #$40
    LDA	    #$C7
    STA	    SpriteData+1,X
    LDA	    #$C6
    STA	    SpriteData+5,X
    BNE	    loc_B5E1

loc_B5D5:
    LDY	    #0
    LDA	    #$C6
    STA	    SpriteData+1,X
    LDA	    #$C7
    STA	    SpriteData+5,X

loc_B5E1:
    STY	    byte_25
    LDY	    #0
    LDA	    (word_A2),Y
    JSR	    sub_85E8
    LDA	    byte_FDE5,X
    ORA	    byte_25
    LDX	    byte_155
    STA	    SpriteData+2,X
    STA	    SpriteData+6,X
    TXA
    CLC
    ADC	    #8
    STA	    byte_155
    JSR	    sub_B4D5
    CPY	    #0
    BEQ	    loc_B594
    RTS
; ---------------------------------------------------------------------------

loc_B609:
    JSR	    sub_B7A7
    LDA	    GamePaused
    BNE	    loc_B65D
    LDY	    #8
    SEC
    LDA	    (word_A2),Y
    SBC	    #1
    STA	    (word_A2),Y
    DEY
    LDA	    (word_A2),Y
    AND	    #$40
    BEQ	    loc_B624
    JMP	    loc_B70B
; ---------------------------------------------------------------------------

loc_B624:
    LDA	    (word_A2),Y
    LDY	    #1
    AND	    #2
    BEQ	    loc_B63B
    LDA	    (word_A2),Y
    CLC
    ADC	    #$2F
    STA	    (word_A2),Y
    DEY
    LDA	    (word_A2),Y
    ADC	    #0
    JMP	    loc_B647
; ---------------------------------------------------------------------------

loc_B63B:
    LDA	    (word_A2),Y
    SEC
    SBC	    #$2F
    STA	    (word_A2),Y
    DEY
    LDA	    (word_A2),Y
    SBC	    #0

loc_B647:
    STA	    (word_A2),Y
    STA	    byte_A0
    LDY	    #2
    LDA	    (word_A2),Y
    STA	    byte_A1
    JSR	    sub_8A6C
    CMP	    #3
    BNE	    loc_B65D
    JSR	    sub_B6FC

loc_B65D:
    JSR	    sub_8AB8
    LDY	    #0
    LDA	    (word_A2),Y
    JSR	    sub_85E8
    LDA	    byte_FDE5,X
    STA	    byte_2A
    LDY	    #7
    LDA	    (word_A2),Y
    BPL	    loc_B676
    JMP	    loc_B594
; ---------------------------------------------------------------------------

loc_B676:
    LDX	    byte_155
    AND	    #$40
    BNE	    loc_B6B4
    LDY	    #5
    LDA	    (word_A2),Y
    SEC
    SBC	    #4
    STA	    SpriteData,X
    STA	    byte_A5
    DEY
    LDA	    (word_A2),Y
    SEC
    SBC	    #4
    STA	    SpriteData+3,X
    STA	    byte_A4
    LDY	    #8
    LDA	    (word_A2),Y
    AND	    #6
    LSR	    A
    TAY
    LDA	    byte_B7B9,Y
    ORA	    byte_2A
    STA	    SpriteData+2,X
    LDA	    byte_B7BD,Y
    STA	    SpriteData+1,X
    INX
    INX
    INX
    INX
    JMP	    loc_B6F2
; ---------------------------------------------------------------------------

loc_B6B4:
    LDY	    #5
    LDA	    (word_A2),Y
    STA	    byte_A5
    DEY
    LDA	    (word_A2),Y
    STA	    byte_A4
    LDY	    #0

loc_B6C3:
    LDA	    byte_BB42,Y
    STA	    SpriteData+1,X
    CLC
    LDA	    byte_A5
    ADC	    byte_BB43,Y
    STA	    SpriteData,X
    LDA	    byte_BB44,Y
    ORA	    byte_2A
    STA	    SpriteData+2,X
    CLC
    LDA	    byte_A4
    ADC	    byte_BB45,Y
    STA	    SpriteData+3,X
    INX
    INX
    INX
    INX
    INY
    INY
    INY
    INY
    CPY	    #$10
    BNE	    loc_B6C3

loc_B6F2:
    STX	    byte_155
    JSR	    sub_B4D5
    CPY	    #0
    BNE	    locret_B70A

; =============== S U B	R O U T	I N E =======================================

sub_B6FC:
    LDY	    #7
    LDA	    (word_A2),Y
    ORA	    #$40
    STA	    (word_A2),Y
    LDA	    #4
    LDY	    #9
    STA	    (word_A2),Y

locret_B70A:
    RTS
; End of function sub_B6FC

; ---------------------------------------------------------------------------

loc_B70B:
    LDY	    #9
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    STA	    (word_A2),Y
    BEQ	    loc_B719
    JMP	    loc_B65D
; ---------------------------------------------------------------------------

loc_B719:
    JMP	    loc_B594
; ---------------------------------------------------------------------------

loc_B71C:
    JSR	    sub_B7A7
    LDA	    GamePaused
    BNE	    loc_B759
    LDY	    #9
    LDA	    (word_A2),Y
    SEC
    SBC	    #1
    BEQ	    loc_B72F
    STA	    (word_A2),Y

loc_B72F:
    TAX
    LDA	    byte_9904,X
    ASL	    A
    LDY	    #3
    ADC	    (word_A2),Y
    STA	    (word_A2),Y
    DEY
    LDA	    (word_A2),Y
    ADC	    #0
    STA	    (word_A2),Y
    CMP	    #$C0
    BCS	    loc_B756
    STA	    byte_A1
    LDY	    #0
    LDA	    (word_A2),Y
    STA	    byte_A0
    JSR	    sub_8A6C
    CMP	    #3
    BNE	    loc_B759

loc_B756:
    JMP	    loc_B594
; ---------------------------------------------------------------------------

loc_B759:
    JSR	    sub_8AB8
    LDY	    #7
    LDA	    (word_A2),Y
    BMI	    loc_B756
    LDY	    #0
    LDA	    (word_A2),Y
    JSR	    sub_85E8
    LDA	    byte_FDE5,X
    STA	    byte_2A
    LDX	    byte_155
    LDY	    #5
    LDA	    (word_A2),Y
    STA	    byte_A5
    CLC
    SBC	    #4
    STA	    SpriteData,X
    LDA	    #$2F
    STA	    SpriteData+1,X
    LDA	    byte_2A
    ORA	    #3
    STA	    SpriteData+2,X
    DEY
    LDA	    (word_A2),Y
    STA	    byte_A4
    CLC
    SBC	    #4
    STA	    SpriteData+3,X
    INX
    INX
    INX
    INX
    STX	    byte_155
    JSR	    sub_B4D5
    CPY	    #0
    BEQ	    loc_B756
    RTS

; =============== S U B	R O U T	I N E =======================================

sub_B7A7:
    LDA	    byte_1C5
    ASL	    A
    ASL	    A
    ASL	    A
    ASL	    A
    ADC	    #$80
    STA	    word_A2
    LDA	    #3
    STA	    word_A2+1
    RTS
; End of function sub_B7A7

; ---------------------------------------------------------------------------
byte_B7B9:
    .BYTE	$C2
    .BYTE $C2
    .BYTE 2
    .BYTE 2
byte_B7BD:
    .BYTE	$2D
    .BYTE $2E
    .BYTE $2D
    .BYTE $2E
off_B7C1:
    .WORD Sprite_Chest
    .WORD Sprite_ChestOpen
IntermissionItemSpriteTiles:
    .WORD Sprite_ItemLightbulb
    .WORD Sprite_Shoes			; 1 ; Pointers to the tiles for	item sprites
    .WORD Sprite_SuperBomb		; 2 ; 02 03
    .WORD Sprite_UpArrow		; 3 ; 00 01
    .WORD Sprite_DoubleScore		; 4
    .WORD Sprite_SlowTimer		; 5
    .WORD Sprite_Microphone		; 6
    .WORD Sprite_Invulnerable		; 7
Sprite_Chest:
    .BYTE $E2,$E3,$D2,$D3
    .BYTE $FF				; 4
Sprite_ChestOpen:
    .BYTE $E2,$E3,$F2,$F3
    .BYTE $FF				; 4
Sprite_ItemLightbulb:
    .BYTE $DA,$DB,$CA,$CB
    .BYTE $FF				; 4
Sprite_Shoes:
    .BYTE $FA,$FB,$EA,$EB
    .BYTE $FF				; 4
Sprite_SuperBomb:
    .BYTE $DE,$DF,$CE,$CF
    .BYTE $FF				; 4
Sprite_UpArrow:
    .BYTE $DC,$DD,$CC,$CD
    .BYTE $FF				; 4
Sprite_DoubleScore:
    .BYTE $BA,$BB,$AA,$AB
    .BYTE $FF				; 4
Sprite_SlowTimer:
    .BYTE $BC,$BD,$AC,$AD
    .BYTE $FF				; 4
Sprite_Microphone:
    .BYTE	$FC,$FD,$EC,$ED
    .BYTE $FF				; 4
Sprite_Invulnerable:
    .BYTE $FE,$F7,$EE,$EF
    .BYTE $FF				; 4 ; Uses $F7 here because $FF	is the terminator
EndingGemSpritePointers:
    .WORD Sprite_UnusedCoin
    .WORD Sprite_UnusedCrown
    .WORD Sprite_UnusedSword
    .WORD Sprite_EndingGem
    .WORD Sprite_UnusedRing
Sprite_UnusedCoin:
    .BYTE	$8C,$8D,$7C,$7D
    .BYTE $FF				; 4 ; Shares CHR bank with the gem, so is replacable
Sprite_UnusedCrown:
    .BYTE $BE,$BF,$AE,$AF
    .BYTE $FF				; 4 ; Requires alternate sprite	set
Sprite_UnusedSword:
    .BYTE $C8,$C9,$66,$67
    .BYTE $FF				; 4 ; Requires alternate sprite	set
Sprite_EndingGem:
    .BYTE $B6,$B7,$B4,$B5
    .BYTE $FF				; 4 ; Sprite tiles for the gem in the ending
Sprite_UnusedRing:
    .BYTE	$9C,$9D,$9A,$9B
    .BYTE $FF				; 4 ; Requires alternate sprite	set

; =============== S U B	R O U T	I N E =======================================

sub_B82A:
    LDX	    byte_155
    LDA	    #$64
    STA	    byte_2C
    STX	    byte_2B
    CLC
    TXA
    ADC	    byte_1C1
    TAX
    LDY	    #1

loc_B83D:
    LDA	    #$14
    STA	    SpriteData,X
    INX
    LDA	    PlayerScore,Y
    STA	    SpriteData,X
    INX
    LDA	    #2
    STA	    SpriteData,X
    INX
    LDA	    byte_2C
    STA	    SpriteData,X
    INX
    CLC
    LDA	    byte_2C
    ADC	    #8
    STA	    byte_2C
    CLC
    LDA	    byte_1C1
    ADC	    #4
    CMP	    #$1C
    BNE	    loc_B870
    LDA	    byte_2B
    TAX
    LDA	    #0

loc_B870:
    STA	    byte_1C1
    INY
    CPY	    #8
    BNE	    loc_B83D
    CLC
    ADC	    #4
    CMP	    #$1C
    BNE	    loc_B881
    LDA	    #0

loc_B881:
    STA	    byte_1C1
    LDA	    byte_2B
    CLC
    ADC	    #$1C
    STA	    byte_155

locret_B88D:
    RTS
; End of function sub_B82A

; =============== S U B	R O U T	I N E =======================================

sub_B88E:
    LDA	    ProbablyZoneStatusShit
    BMI	    locret_B88D
    LDY	    byte_214
    STY	    byte_28
    LDY	    byte_215
    STY	    byte_29
    LDA	    PlayerX
    JSR	    sub_85E8
    LDY	    #$43
    LDA	    PlayerState
    AND	    #1
    BNE	    loc_B8B0
    LDY	    #3

loc_B8B0:
    TYA
    ORA	    byte_FDE5,X
    STA	    byte_2A
    LDA	    PlayerState
    TAY
    BMI	    loc_B8FE

loc_B8BD:
    TYA
    AND	    #2
    BNE	    loc_B8F1
    TYA
    AND	    #$10
    BNE	    loc_B8DF
    TYA
    AND	    #4
    BNE	    loc_B8E3
    LDA	    PlayerSpeedX
    BEQ	    loc_B8DB
    LDA	    byte_218
    AND	    #$C
    LSR	    A
    TAY
    JMP	    loc_B90F
; ---------------------------------------------------------------------------

loc_B8DB:
    LDY	    #8
    BNE	    loc_B90F

loc_B8DF:
    LDY	    #$C
    BNE	    loc_B90F

loc_B8E3:
    LDA	    byte_29
    CLC
    ADC	    byte_4
    STA	    byte_29
    LDY	    #$A
    BNE	    loc_B90F

loc_B8F1:
    LDY	    #$10
    LDA	    byte_21A
    CMP	    #2
    BPL	    loc_B90F
    INY
    INY
    BNE	    loc_B90F

loc_B8FE:
    AND	    #$40
    BNE	    loc_B90D
    LDA	    byte_2A
    AND	    #$FE
    STA	    byte_2A
    JMP	    loc_B8BD
; ---------------------------------------------------------------------------

loc_B90D:
    LDY	    #$E

loc_B90F:
    LDA	    PlayerSpritePointers,Y
    STA	    word_1A
    LDA	    PlayerSpritePointers+1,Y
    STA	    word_1A+1
; End of function sub_B88E

; =============== S U B	R O U T	I N E =======================================

DrawSpriteMaybe:
    LDX	    byte_155
    LDY	    #0

loc_B920:
    LDA	    (word_1A),Y
    CMP	    #$FF
    BEQ	    loc_B965
    STA	    SpriteData+1,X
    LDA	    byte_2A
    STA	    SpriteData+2,X
    AND	    #$40
    BNE	    loc_B939
    LDA	    byte_BACE,Y
    JMP	    loc_B93C
; ---------------------------------------------------------------------------

loc_B939:
    LDA	    byte_BACF,Y

loc_B93C:
    CLC
    BMI	    loc_B948
    ADC	    byte_28
    CMP	    #$FC
    BCS	    loc_B969
    BCC	    loc_B951

loc_B948:
    ADC	    byte_28
    BCS	    loc_B951
    CMP	    #$FC
    BCC	    loc_B969

loc_B951:
    STA	    SpriteData+3,X
    LDA	    byte_BAC6,Y
    CLC
    ADC	    byte_29
    STA	    SpriteData,X
    INY
    INX
    INX
    INX
    INX
    BNE	    loc_B920

loc_B965:
    STX	    byte_155
    RTS
; ---------------------------------------------------------------------------

loc_B969:
    INY
    BNE	    loc_B920
    LDX	    byte_155
    LDY	    #0

loc_B971:
    LDA	    (word_1A),Y
    CMP	    #$FF
    BEQ	    loc_B99B
    STA	    SpriteData+1,X
    INY
    LDA	    (word_1A),Y
    CLC
    ADC	    byte_29
    STA	    SpriteData,X
    INY
    INX
    INX
    LDA	    (word_1A),Y
    STA	    SpriteData,X
    INY
    INX
    LDA	    (word_1A),Y
    CLC
    ADC	    byte_28
    STA	    SpriteData,X
    INY
    INX
    BNE	    loc_B971

loc_B99B:
    STX	    byte_155
    RTS
; End of function DrawSpriteMaybe

; =============== S U B	R O U T	I N E =======================================

sub_B99F:
    LDX	    byte_155
    LDY	    #2

loc_B9A4:
    LDA	    #$D4
    STA	    SpriteData,X
    INX
    LDA	    ZoneTimer,Y
    STA	    SpriteData,X
    INX
    LDA	    #2
    STA	    SpriteData,X
    INX
    LDA	    byte_B9C5,Y
    STA	    SpriteData,X
    INX
    DEY
    BPL	    loc_B9A4
    STX	    byte_155

locret_B9C4:
    RTS
; End of function sub_B99F

; ---------------------------------------------------------------------------
byte_B9C5:
    .BYTE	$74
    .BYTE $7C
    .BYTE $84

; =============== S U B	R O U T	I N E =======================================

sub_B9C8:
    LDA	    byte_266
    BEQ	    locret_B9C4
    LDA	    byte_260
    JSR	    sub_85E8
    LDA	    byte_FDE5,X
    STA	    byte_25
    LDX	    byte_155
    LDA	    byte_267
    BMI	    locret_B9C4
    AND	    #1
    BNE	    loc_BA14
    LDA	    byte_265
    SEC
    SBC	    #4
    STA	    SpriteData,X
    LDA	    byte_268
    AND	    #6
    LSR	    A
    TAY
    LDA	    SpriteBomb,Y
    STA	    SpriteData+1,X
    LDA	    byte_25
    ORA	    #2
    STA	    SpriteData+2,X
    LDA	    byte_264
    SEC
    SBC	    #4
    STA	    SpriteData+3,X
    INX
    INX
    INX
    INX

loc_BA10:
    STX	    byte_155
    RTS
; ---------------------------------------------------------------------------

loc_BA14:
    LDA	    byte_268
    AND	    #$C
    LSR	    A
    LSR	    A
    TAY
    LDA	    byte_BB3E,Y
    TAY

loc_BA20:
    LDA	    byte_BB42,Y
    CMP	    #$FF
    BEQ	    loc_BA10
    STA	    SpriteData+1,X
    LDA	    byte_BB45,Y
    CLC
    BMI	    loc_BA3B
    ADC	    byte_264
    BCS	    loc_BA5E
    CMP	    #$FC
    BCS	    loc_BA5E
    BCC	    loc_BA44

loc_BA3B:
    ADC	    byte_264
    BCS	    loc_BA44
    CMP	    #$FC
    BCC	    loc_BA5E

loc_BA44:
    STA	    SpriteData+3,X
    LDA	    byte_BB43,Y
    CLC
    ADC	    byte_265
    STA	    SpriteData,X
    LDA	    byte_BB44,Y
    ORA	    byte_25
    STA	    SpriteData+2,X
    INX
    INX
    INX
    INX

loc_BA5E:
    INY
    INY
    INY
    INY
    JMP	    loc_BA20
; End of function sub_B9C8

; =============== S U B	R O U T	I N E =======================================

sub_BA65:
    LDY	    byte_276
    DEY
    BMI	    locret_BAC1
    STY	    byte_276
    LDX	    byte_155
    LDY	    byte_278

loc_BA74:
    LDA	    byte_275
    STA	    SpriteData,X
    LDA	    byte_279,Y
    STA	    SpriteData+1,X
    LDA	    #2
    STA	    SpriteData+2,X
    TYA
    ASL	    A
    ASL	    A
    ASL	    A
    ADC	    byte_274
    STA	    SpriteData+3,X
    INX
    INX
    INX
    INX
    DEY
    BPL	    loc_BA74
    LDA	    PlayerItem_DoubleScore
    BEQ	    loc_BABE
    LDY	    #1

loc_BA9D:
    LDA	    byte_275
    SEC
    SBC	    #9
    STA	    SpriteData,X
    LDA	    Sprite_x2,Y
    STA	    SpriteData+1,X
    LDA	    #2
    STA	    SpriteData+2,X
    LDA	    byte_BAC4,Y
    STA	    SpriteData+3,X
    INX
    INX
    INX
    INX
    DEY
    BPL	    loc_BA9D

loc_BABE:
    STX	    byte_155

locret_BAC1:
    RTS
; End of function sub_BA65

; ---------------------------------------------------------------------------
Sprite_x2:
    .BYTE	$23,  2
byte_BAC4:
    .BYTE	$7D
    .BYTE $85
byte_BAC6:
    .BYTE	$F7
    .BYTE $F7
    .BYTE $EF
    .BYTE $EF
    .BYTE $E7
    .BYTE $E7
    .BYTE $DF
    .BYTE $DF
byte_BACE:
    .BYTE	$F8
byte_BACF:
    .BYTE	0
    .BYTE $F8
    .BYTE 0
    .BYTE $F8
    .BYTE 0
    .BYTE $F8
    .BYTE 0
    .BYTE $F8
PlayerSpritePointers:
    .WORD SpritePlayer_0_Walk0
    .WORD SpritePlayer_1_Walk1
    .WORD SpritePlayer_0_Walk0
    .WORD SpritePlayer_0_Walk2
    .WORD SpritePlayer_4
    .WORD SpritePlayer_5_Jump
    .WORD SpritePlayer_6_Ducking
    .WORD SpritePlayer_7_Death
    .WORD SpritePlayer_8_Throw0
    .WORD SpritePlayer_9_Throw1
SpritePlayer_1_Walk1:
    .BYTE $60,$61
    .BYTE $50,$51			; 2
    .BYTE $40,$41			; 4
    .BYTE $30,$31			; 6
    .BYTE $FF				; 8
SpritePlayer_0_Walk0:
    .BYTE $52,$53
    .BYTE $42,$43			; 2
    .BYTE $32,$33			; 4
    .BYTE $30,$31			; 6
    .BYTE $FF				; 8
SpritePlayer_0_Walk2:
    .BYTE $82,$83
    .BYTE $72,$73			; 2
    .BYTE $62,$63			; 4
    .BYTE $30,$31			; 6
    .BYTE $FF				; 8
SpritePlayer_4:
    .BYTE $54,$55
    .BYTE $44,$45			; 2
    .BYTE $34,$35			; 4
    .BYTE $30,$31			; 6
    .BYTE $FF				; 8
SpritePlayer_5_Jump:
    .BYTE $84,$85
    .BYTE $74,$75			; 2
    .BYTE $64,$65			; 4
    .BYTE $30,$31			; 6
    .BYTE $FF				; 8
SpritePlayer_6_Ducking:
    .BYTE $80,$81
    .BYTE $70,$71			; 2
    .BYTE $30,$31			; 4
    .BYTE $FF				; 6
SpritePlayer_7_Death:
    .BYTE $56,$57
    .BYTE $46,$47			; 2
    .BYTE $36,$37			; 4
    .BYTE $30,$31			; 6
    .BYTE $FF				; 8
SpritePlayer_8_Throw0:
    .BYTE $82,$83			  ;	DATA XREF: BANK0:BAE7o
    .BYTE $48,$49			; 2
    .BYTE $38,$39			; 4
    .BYTE $58,$31			; 6
    .BYTE $FF				; 8
SpritePlayer_9_Throw1:
    .BYTE $88,$89			  ;	DATA XREF: BANK0:BAE9o
    .BYTE $78,$79			; 2
    .BYTE $68,$69			; 4
    .BYTE $30,$59			; 6
    .BYTE $FF				; 8
SpriteBomb:
    .BYTE $76,$87,$77,$86
byte_BB3E:
    .BYTE	$5B
    .BYTE $36
    .BYTE $11
    .BYTE 0
byte_BB42:
    .BYTE	$5D
byte_BB43:
    .BYTE	$F8
byte_BB44:
    .BYTE	2
byte_BB45:
    .BYTE	$F8
    .BYTE $5D
    .BYTE 0
    .BYTE $C2
    .BYTE 0
    .BYTE $5D
    .BYTE 0
    .BYTE $82
    .BYTE $F8
    .BYTE $5D
    .BYTE $F8
    .BYTE $42
    .BYTE 0
    .BYTE $FF
    .BYTE $3A
    .BYTE $F4
    .BYTE 2
    .BYTE $F4
    .BYTE $3A
    .BYTE 4
    .BYTE $C2
    .BYTE 4
    .BYTE $3A
    .BYTE 4
    .BYTE $82
    .BYTE $F4
    .BYTE $3A
    .BYTE $F4
    .BYTE $42
    .BYTE 4
    .BYTE $3B
    .BYTE $F4
    .BYTE 2
    .BYTE $FC
    .BYTE $3B
    .BYTE 4
    .BYTE $C2
    .BYTE $FC
    .BYTE $4A
    .BYTE $FC
    .BYTE $42
    .BYTE 4
    .BYTE $4A
    .BYTE $FC
    .BYTE $82
    .BYTE $F4
    .BYTE $4B
    .BYTE $FC
    .BYTE 2
    .BYTE $FC
    .BYTE $FF
    .BYTE $3C
    .BYTE $F4
    .BYTE 2
    .BYTE $F4
    .BYTE $3C
    .BYTE 4
    .BYTE $C2
    .BYTE 4
    .BYTE $3C
    .BYTE 4
    .BYTE $82
    .BYTE $F4
    .BYTE $3C
    .BYTE $F4
    .BYTE $42
    .BYTE 4
    .BYTE $3D
    .BYTE $F4
    .BYTE 2
    .BYTE $FC
    .BYTE $3D
    .BYTE 4
    .BYTE $C2
    .BYTE $FC
    .BYTE $4C
    .BYTE $FC
    .BYTE 2
    .BYTE 4
    .BYTE $4C
    .BYTE $FC
    .BYTE $C2
    .BYTE $F4
    .BYTE $4D
    .BYTE $FC
    .BYTE 2
    .BYTE $FC
    .BYTE $FF
    .BYTE $5A
    .BYTE $F0
    .BYTE 2
    .BYTE $F0
    .BYTE $5A
    .BYTE 8
    .BYTE $C2
    .BYTE 8
    .BYTE $5A
    .BYTE $F0
    .BYTE $42
    .BYTE 8
    .BYTE $5A
    .BYTE 8
    .BYTE $82
    .BYTE $F0
    .BYTE $6A
    .BYTE 0
    .BYTE $42
    .BYTE 8
    .BYTE $6A
    .BYTE $F8
    .BYTE $82
    .BYTE $F0
    .BYTE $5B
    .BYTE $F0
    .BYTE $42
    .BYTE 0
    .BYTE $5B
    .BYTE 8
    .BYTE $C2
    .BYTE $F8
    .BYTE $6D
    .BYTE 0
    .BYTE $42
    .BYTE $F0
    .BYTE $5C
    .BYTE $F0
    .BYTE 2
    .BYTE $F8
    .BYTE $6D
    .BYTE $F8
    .BYTE 2
    .BYTE 8
    .BYTE $5C
    .BYTE 8
    .BYTE $82
    .BYTE 0
    .BYTE $6B
    .BYTE $F8
    .BYTE 2
    .BYTE $F8
    .BYTE $6C
    .BYTE 0
    .BYTE $42
    .BYTE 0
    .BYTE $6C
    .BYTE 0
    .BYTE 2
    .BYTE $F8
    .BYTE $6B
    .BYTE $F8
    .BYTE $C2
    .BYTE 0
    .BYTE $FF

; =============== S U B	R O U T	I N E =======================================

; Old partial disassembly says this does it

DrawTitleScreen:
    JSR	    ClearPaletteToBlack
    JSR	    ClearNametable2000
    JSR	    ClearNametable2400
    JSR	    ClearSprites
    LDA	    #$34
    JSR	    SetCHRBanks
    JSR	    ResetPPUScroll
    LDA	    #$20
    STA	    byte_20
    LDA	    #$81
    STA	    byte_21
    LDY	    #$81
    LDX	    #0

loc_BC00:
    LDA	    byte_20
    STA	    PPUADDR
    LDA	    byte_21
    STA	    PPUADDR

loc_BC0C:
    LDA	    PPU_TitleScreenLogo,X
    CMP	    #$80
    BEQ	    loc_BC23
    STA	    PPUDATA
    INX
    INY
    BNE	    loc_BC0C
    STY	    byte_21
    INC	    byte_20
    JMP	    loc_BC00
; ---------------------------------------------------------------------------

loc_BC23:
    LDA	    #$B0
    STA	    byte_21
    LDA	    #$50
    STA	    byte_22
    LDX	    #$24
    LDY	    byte_155

loc_BC32:
    LDA	    byte_22
    STA	    SpriteData,Y
    INY
    TXA
    STA	    SpriteData,Y
    INY
    LDA	    #0
    STA	    SpriteData,Y
    INY
    LDA	    byte_21
    STA	    SpriteData,Y
    INY
    INX
    LDA	    byte_21
    CLC
    ADC	    #8
    STA	    byte_21
    CMP	    #$C8
    BNE	    loc_BC32
    LDA	    #$B0
    STA	    byte_21
    LDA	    byte_22
    CLC
    ADC	    #8
    STA	    byte_22
    CMP	    #$68
    BNE	    loc_BC32
    STY	    byte_155
    LDA	    #PPUStringIndex_PushStartButton
    LDX	    #$22
    LDY	    #$26
    JSR	    PrintStringToPPU
    LDA	    #PPUStringIndex_HiScore
    LDX	    #$22
    LDY	    #$88
    JSR	    PrintStringToPPU
    LDA	    #PPUStringIndex_HighScoreInMemory
    LDX	    #$22
    LDY	    #$92
    JSR	    PrintStringToPPU
    LDA	    #PPUStringIndex_C1986Sunsoft
    LDX	    #$23
    LDY	    #$A
    JSR	    PrintStringToPPU
    LDA	    #PPUStringIndex_SunElecCorp
    LDX	    #$23
    LDY	    #$46
    JSR	    PrintStringToPPU
    LDX	    #$23
    LDY	    #$C0
    JSR	    SetPPUAddrAndUpdateScroll
    LDA	    #$55
    LDY	    #$20

loc_BCA6:
    STA	    PPUDATA
    DEY
    BNE	    loc_BCA6
    LDA	    #$AA
    LDY	    #$10

loc_BCB0:
    STA	    PPUDATA
    DEY
    BNE	    loc_BCB0
    LDA	    #$FF
    LDY	    #$10

loc_BCBA:
    STA	    PPUDATA
    DEY
    BNE	    loc_BCBA
    LDY	    #$20
    LDA	    #$F

loc_BCC4:
    STA	    PaletteData,Y
    DEY
    BNE	    loc_BCC4
    LDY	    #$F

loc_BCCC:
    LDA	    TitleScreenPalettes,Y
    STA	    PaletteData+4,Y
    DEY
    BPL	    loc_BCCC
    JSR	    EnableNMI
    RTS
; End of function DrawTitleScreen

; ---------------------------------------------------------------------------
TitleScreenPalettes:
    .BYTE  $F,	7,$17, $F
    .BYTE  $F,$18,$28,$38		; 4 ; Loaded as	BG palette 1-3 and sprite palette 0
    .BYTE  $F,$18,$28,$38		; 8 ; (???)
    .BYTE  $F,$18, $F,	8		; $C
; ---------------------------------------------------------------------------
    RTS					; ??? Spurious RTS

; =============== S U B	R O U T	I N E =======================================

IntermissionScreenFirst:
    JSR	    ClearPaletteToBlack
    JSR	    ResetMostPPUStuff
    JSR	    PrintZoneNumberToPPU
    JSR	    PrintLivesToPPU
    LDX	    #$22
    LDY	    #$24
    LDA	    #PPUStringIndex_MysteryAdventureStart
    JSR	    PrintStringToPPU
    JMP	    EnableNMI
; End of function IntermissionScreenFirst

; =============== S U B	R O U T	I N E =======================================

IntermissionScreen:
    JSR	    ClearPaletteToBlack
    JSR	    ResetMostPPUStuff
    JSR	    PrintScoreToPPU
    JSR	    PrintZoneNumberToPPU
    JSR	    PrintLivesToPPU
    LDA	    #7
    STA	    byte_20

loc_BD16:
    LDX	    byte_20			; Show the items on the	intermission screen
    LDA	    PlayerItem_Lightbulb,X
    BEQ	    loc_BD41
    LDA	    IntermissionItemXPos,X
    STA	    byte_28
    LDA	    IntermissionItemYPos,X
    STA	    byte_29
    TXA
    ASL	    A
    TAY
    LDA	    IntermissionItemSpriteTiles,Y
    STA	    word_1A
    LDA	    IntermissionItemSpriteTiles+1,Y
    STA	    word_1A+1
    LDA	    #2
    STA	    byte_2A
    JSR	    DrawSpriteMaybe

loc_BD41:
    DEC	    byte_20
    BPL	    loc_BD16
    JMP	    EnableNMI
; End of function IntermissionScreen

; =============== S U B	R O U T	I N E =======================================

PrintScoreToPPU:
    LDA	    #PPUStringIndex_Score
    LDX	    #$20
    LDY	    #$C9
    JSR	    PrintStringToPPU
    LDA	    #$80
    STA	    byte_1B8			; PPU string terminator	after the score	value
    LDX	    #$20
    LDY	    #$D1
    LDA	    #PPUStringIndex_ScoreInMemory
    JMP	    PrintStringToPPU
; End of function PrintScoreToPPU

; =============== S U B	R O U T	I N E =======================================

; Prints "###th	ZONE !"	to the PPU for intermissions
;
; BUG: ordinal suffixes	only work for zones 1-3;
; every	zone after that	will use "TH"

PrintZoneNumberToPPU:
    LDY	    CurrentZone
    INY
    TYA
    JSR	    HexToPPUDecimal
    LDX	    #0
    LDA	    CurrentZone
    BEQ	    loc_BD8E			; If zone 1, jump ahead	(X = 0)
    INX
    CMP	    #1
    BEQ	    loc_BD8E			; If zone 2, jump ahead	(X = 1)
    INX
    CMP	    #2
    BEQ	    loc_BD8E			; If zone 3, jump ahead	(X = 2)
    INX
    CMP	    #99				; Is this zone 100?
    BNE	    loc_BD8E			; If not, skip ahead (X	= 3)
					; Otherwise, replace with "FIN"AL
    LDA	    #$F				; First	digit =	F
    STA	    byte_20
    LDA	    #$12			; Second digit = I
    STA	    byte_21
    LDA	    #$17			; Third	digit =	N
    STA	    byte_22
    INX

loc_BD8E:
    LDA	    OrdinalSuffixes1,X		; Ordinal based	on value of X above
					; 0 - ST
					; 1 - ND
					; 2 - RD
					; 3 - TH
					; 4 - AL (FIN"AL")
    STA	    byte_23
    LDA	    OrdinalSuffixes2,X
    STA	    byte_24
    LDA	    #$80
    STA	    byte_25
    LDX	    #$21
    LDY	    #$67
    LDA	    #PPUStringIndex_0020
    JSR	    PrintStringToPPU
    LDX	    #$21
    LDY	    #$6D
    LDA	    #PPUStringIndex_Zone
    JMP	    PrintStringToPPU
; End of function PrintZoneNumberToPPU

; =============== S U B	R O U T	I N E =======================================

PrintLivesToPPU:
    LDA	    #$28
    STA	    byte_20
    LDA	    #$FF			; blank	space
    STA	    byte_21
    LDY	    PlayerLives
    INY
    STY	    byte_22			; lives
    LDA	    #$80
    STA	    byte_23			; terminator
    LDX	    #$23
    LDY	    #$16
    LDA	    #PPUStringIndex_0020
    JSR	    PrintStringToPPU
    LDA	    #$A0
    STA	    byte_214
    LDA	    #$D0
    STA	    byte_215
    JMP	    sub_B88E
; End of function PrintLivesToPPU

; =============== S U B	R O U T	I N E =======================================

; Converts the value in	$0022 to decimal at $0020-0022
; (one number per byte), sets $0023 to $80 (str	terminator)

HexToPPUDecimal:
    STA	    byte_22
    LDA	    #0
    TAX
    TAY
    LDA	    byte_22

loc_BDE7:
    CMP	    #100			; First, count hundreds
    BMI	    loc_BDF2
    INX					; X = hundreds
    SEC
    SBC	    #100
    JMP	    loc_BDE7
; ---------------------------------------------------------------------------

loc_BDF2:
    CMP	    #10				; Then,	count tens
    BMI	    loc_BDFD
    INY					; Y = tens
    SEC
    SBC	    #10
    JMP	    loc_BDF2
; ---------------------------------------------------------------------------

loc_BDFD:
    CPX	    #0				; If X (100s) is 0, set	to $FF instead (blank space)
    BNE	    loc_BE09
    LDX	    #$FF
    CPY	    #0				; If Y (10s) is	0, set to $FF instead (blank space)
    BNE	    loc_BE09
    LDY	    #$FF

loc_BE09:
    STX	    byte_20			; X (100s)
    STY	    byte_21			; Y (10s)
    STA	    byte_22			; A (1s)
    LDA	    #$80
    STA	    byte_23
    RTS
; End of function HexToPPUDecimal

; =============== S U B	R O U T	I N E =======================================

DrawGameOverScreen:
    JSR	    ClearPaletteToBlack
    JSR	    ResetMostPPUStuff
    JSR	    PrintScoreToPPU
    LDA	    PlayerChestsOpened
    JSR	    HexToPPUDecimal
    LDX	    #$23
    LDY	    #$30
    LDA	    #PPUStringIndex_0020
    JSR	    PrintStringToPPU
    LDA	    #$76
    STA	    byte_28
    LDA	    #$CC
    STA	    byte_29
    LDA	    #3
    STA	    byte_2A
    LDA	    off_B7C1
    STA	    word_1A
    LDA	    off_B7C1+1
    STA	    word_1A+1
    JSR	    DrawSpriteMaybe
    LDX	    #$22
    LDY	    #$C
    LDA	    #PPUStringIndex_GameOver
    JSR	    PrintStringToPPU
    LDA	    #$F
    LDY	    #$1C

loc_BE5B:
    STA	    PaletteData,Y
    DEY
    DEY
    DEY
    DEY
    BPL	    loc_BE5B
    LDA	    #0
    STA	    PaletteData+$D
    LDA	    #$30
    STA	    PaletteData+$F
    STA	    PaletteUpdateRequest
    JMP	    EnableNMI
; End of function DrawGameOverScreen

; =============== S U B	R O U T	I N E =======================================

ResetMostPPUStuff:
    JSR	    ClearSprites
    JSR	    ClearNametable2000
    LDA	    #$34
    JSR	    SetCHRBanks
    JMP	    ResetPPUScroll
; End of function ResetMostPPUStuff

; =============== S U B	R O U T	I N E =======================================

; X/Y: PPU address to start writing
; A: index of string to	write
;
; $80 terminates string

PrintStringToPPU:
    PHA
    JSR	    SetPPUAddrAndUpdateScroll
    PLA
    ASL	    A
    TAX
    LDA	    WriteToPPUStrings,X
    STA	    word_1E
    INX
    LDA	    WriteToPPUStrings,X
    STA	    word_1E+1
    LDY	    #0

loc_BE98:
    LDA	    (word_1E),Y
    CMP	    #$80
    BEQ	    locret_BEA5
    STA	    PPUDATA
    INY
    JMP	    loc_BE98
; ---------------------------------------------------------------------------

locret_BEA5:
    RTS
; End of function PrintStringToPPU

; ---------------------------------------------------------------------------
ZoneASMPointerTable:
    .WORD ZoneASM_01
    .WORD ZoneASM_0			; 1
    .WORD ZoneASM_0			; 2
    .WORD ZoneASM_0			; 3
    .WORD ZoneASM_0			; 4
    .WORD ZoneASM_0			; 5
    .WORD ZoneASM_0			; 6
    .WORD ZoneASM_0			; 7
    .WORD ZoneASM_0			; 8
    .WORD ZoneASM_0			; 9
    .WORD ZoneASM_0			; 10
    .WORD ZoneASM_0			; 11
    .WORD ZoneASM_0			; 12
    .WORD ZoneASM_0			; 13
    .WORD ZoneASM_0			; 14
    .WORD ZoneASM_0			; 15
    .WORD ZoneASM_0			; 16
    .WORD ZoneASM_0			; 17
    .WORD ZoneASM_0			; 18
    .WORD ZoneASM_20_NagoyaSecret	; 19
    .WORD ZoneASM_0			; 20
    .WORD ZoneASM_0			; 21
    .WORD ZoneASM_0			; 22
    .WORD ZoneASM_0			; 23
    .WORD ZoneASM_0			; 24
    .WORD ZoneASM_0			; 25
    .WORD ZoneASM_0			; 26
    .WORD ZoneASM_Dark			; 27
    .WORD ZoneASM_0			; 28
    .WORD ZoneASM_IcePhysics		; 29
    .WORD ZoneASM_0			; 30
    .WORD ZoneASM_0			; 31
    .WORD ZoneASM_0			; 32
    .WORD ZoneASM_WaterPaletteAnim	; 33
    .WORD ZoneASM_0			; 34
    .WORD ZoneASM_DarkAutoBlink		; 35
    .WORD ZoneASM_0			; 36
    .WORD ZoneASM_Dark			; 37
    .WORD ZoneASM_0			; 38
    .WORD ZoneASM_IcePhysics		; 39
    .WORD ZoneASM_0			; 40
    .WORD ZoneASM_PaletteBlinkRed	; 41
    .WORD ZoneASM_0			; 42
    .WORD ZoneASM_0			; 43
    .WORD ZoneASM_0			; 44
    .WORD ZoneASM_0			; 45
    .WORD ZoneASM_0			; 46
    .WORD ZoneASM_Dark			; 47
    .WORD ZoneASM_0			; 48
    .WORD ZoneASM_0			; 49
    .WORD ZoneASM_IcePhysics		; 50
    .WORD ZoneASM_WaterPaletteAnim	; 51
    .WORD ZoneASM_0			; 52
    .WORD ZoneASM_0			; 53
    .WORD ZoneASM_0			; 54
    .WORD ZoneASM_0			; 55
    .WORD ZoneASM_ObnoxiousGreenFlashing; 56
    .WORD ZoneASM_PaletteBlinkRed	; 57
    .WORD ZoneASM_0			; 58
    .WORD ZoneASM_0			; 59
    .WORD ZoneASM_IcePhysics		; 60
    .WORD ZoneASM_0			; 61
    .WORD ZoneASM_0			; 62
    .WORD ZoneASM_0			; 63
    .WORD ZoneASM_IcePhysics		; 64
    .WORD ZoneASM_0			; 65
    .WORD ZoneASM_IcePhysics		; 66
    .WORD ZoneASM_Dark			; 67
    .WORD ZoneASM_69_PyramidSecret	; 68
    .WORD ZoneASM_0			; 69
    .WORD ZoneASM_IcePhysicsWaterPalAnim; 70
    .WORD ZoneASM_IcePhysics		; 71
    .WORD ZoneASM_0			; 72
    .WORD ZoneASM_0			; 73
    .WORD ZoneASM_0			; 74
    .WORD ZoneASM_0			; 75
    .WORD ZoneASM_0			; 76
    .WORD ZoneASM_0			; 77
    .WORD ZoneASM_RedWaterPaletteAnim	; 78
    .WORD ZoneASM_0			; 79
    .WORD ZoneASM_0			; 80
    .WORD ZoneASM_0			; 81
    .WORD ZoneASM_0			; 82
    .WORD ZoneASM_0			; 83
    .WORD ZoneASM_AltWaterPaletteAnim	; 84
    .WORD ZoneASM_DarkIcePhysics	; 85
    .WORD ZoneASM_0			; 86
    .WORD ZoneASM_Dark			; 87
    .WORD ZoneASM_DarkIcePhysics	; 88
    .WORD ZoneASM_0			; 89
    .WORD ZoneASM_0			; 90
    .WORD ZoneASM_0			; 91
    .WORD ZoneASM_0			; 92
    .WORD ZoneASM_ObnoxiousRedFlashing	; 93
    .WORD ZoneASM_0			; 94
    .WORD ZoneASM_0			; 95
    .WORD ZoneASM_0			; 96
    .WORD ZoneASM_0			; 97
    .WORD ZoneASM_99_DoorBackToZone6	; 98
    .WORD ZoneASM_100_FinalZone		; 99
; ---------------------------------------------------------------------------

ZoneASM_0:
    RTS
; ---------------------------------------------------------------------------

ZoneASM_DarkIcePhysics:
    JSR	    sub_C12B
    JSR	    ZoneASM_IcePhysics
    JMP	    JustRTS
; ---------------------------------------------------------------------------

ZoneASM_Dark:
    JSR	    sub_C12B
    JMP	    JustRTS
; ---------------------------------------------------------------------------

ZoneASM_01:
    LDA	    byte_3C7
    BNE	    ZoneASM_0
    LDA	    byte_3C6
    BNE	    loc_BF96
    LDY	    #3

loc_BF8A:
    LDA	    byte_C4A5,Y
    STA	    byte_3C0,Y
    DEY
    BPL	    loc_BF8A
    STY	    byte_3C6

loc_BF96:
    LDA	    #$C0
    STA	    word_A2
    LDA	    #3
    STA	    word_A2+1
    LDA	    GamePaused
    BNE	    loc_BFB3
    SEC
    LDA	    byte_3C3
    SBC	    #$24
    STA	    byte_3C3
    BCS	    loc_BFB3
    DEC	    byte_3C2

loc_BFB3:
    JSR	    sub_8AB8
    LDA	    byte_3C7
    BMI	    locret_BFEC
    LDX	    byte_155
    LDY	    #$19

loc_BFC0:
    LDA	    byte_3C5
    SEC
    SBC	    byte_C4A9,Y
    BCC	    loc_BFE6
    STA	    SpriteData,X
    LDA	    byte_C4C3,Y
    STA	    SpriteData+1,X
    LDA	    byte_C4DD,Y
    STA	    SpriteData+2,X
    LDA	    byte_3C4
    CLC
    ADC	    byte_C4F7,Y
    STA	    SpriteData+3,X
    INX
    INX
    INX
    INX

loc_BFE6:
    DEY
    BPL	    loc_BFC0
    STX	    byte_155

locret_BFEC:
    RTS
; ---------------------------------------------------------------------------

ZoneASM_69_PyramidSecret:
    LDA	    GamePaused
    BNE	    locret_C01C
    LDA	    PlayerX
    CMP	    #$83
    BNE	    locret_C01C
    LDA	    PlayerY
    CMP	    #$70
    BNE	    locret_C01C
    LDA	    Joypad_Immediate
    AND	    #ControllerInput_Down
    BEQ	    locret_C01C
    LDX	    byte_3CF
    INX
    STX	    byte_3CF
    CPX	    #50
    BNE	    locret_C01C
    LDA	    #$C0
    STA	    LastDoorEntered
    LDA	    #$FF
    STA	    TriggerZoneChange

locret_C01C:
    RTS

; =============== S U B	R O U T	I N E =======================================

ZoneASM_IcePhysics:
					; DATA XREF: ...
    LDA	    ProbablyZoneStatusShit
    ORA	    #1
    STA	    ProbablyZoneStatusShit
    RTS
; End of function ZoneASM_IcePhysics

; =============== S U B	R O U T	I N E =======================================

ZoneASM_100_PaletteAnim:
    LDA	    GotEndingGem
    BNE	    locret_C03A
    JSR	    sub_C090
    LDA	    FinalZonePaletteCycle1,X
    STA	    PaletteData+7
    LDA	    FinalZonePaletteCycle2,X
    STA	    PaletteData+$F

locret_C03A:
    RTS
; End of function ZoneASM_100_PaletteAnim

; ---------------------------------------------------------------------------

ZoneASM_WaterPaletteAnim:
    JSR	    sub_C090
    LDA	    WaterAnimPaletteCycle1,X
    STA	    PaletteData+7
    LDA	    WaterAnimPaletteCycle2,X
    STA	    PaletteData+5
    RTS
; ---------------------------------------------------------------------------

ZoneASM_IcePhysicsWaterPalAnim:
    JSR	    ZoneASM_IcePhysics
    JSR	    sub_C090
    LDA	    WaterAnimPaletteCycle2,X
    STA	    PaletteData+6
    LDA	    WaterAnimPaletteCycle1,X
    STA	    PaletteData+7
    RTS
; ---------------------------------------------------------------------------

ZoneASM_AltWaterPaletteAnim:
    JSR	    sub_C090
    LDA	    AltWaterAnimPaletteCycle1,X
    STA	    PaletteData+$D
    LDA	    AltWaterAnimPaletteCycle2,X
    STA	    PaletteData+$F
    RTS
; ---------------------------------------------------------------------------

ZoneASM_RedWaterPaletteAnim:
    JSR	    sub_C090
    LDA	    AltWaterAnimPaletteCycle1,X
    STA	    PaletteData+5
    LDA	    AltWaterAnimPaletteCycle2,X
    STA	    PaletteData+7
    RTS
; ---------------------------------------------------------------------------

ZoneASM_ObnoxiousGreenFlashing:
    JSR	    sub_C090
    LDA	    ObnoxiousGreenFlashingPalette,X
    JMP	    loc_C0A3
; ---------------------------------------------------------------------------

ZoneASM_ObnoxiousRedFlashing:
    JSR	    sub_C090
    LDA	    ObnoxiousRedFlashingPalette,X
    JMP	    loc_C0A3

; =============== S U B	R O U T	I N E =======================================

sub_C090:
    LDA	    byte_140
    AND	    #3
    BNE	    loc_C09F
    LDA	    byte_140
    AND	    #$1C
    DEC	    PaletteUpdateRequest

loc_C09F:
    LSR	    A
    LSR	    A
    TAX
    RTS
; End of function sub_C090

; ---------------------------------------------------------------------------

loc_C0A3:
    LDY	    #$1C

loc_C0A5:
    STA	    PaletteData,Y
    DEY
    DEY
    DEY
    DEY
    BPL	    loc_C0A5
    RTS

; =============== S U B	R O U T	I N E =======================================

sub_C0AF:
    STY	    UnknownTimer014B
    STA	    PaletteData,X
    LDX	    #$FF
    STX	    PaletteUpdateRequest
    RTS
; End of function sub_C0AF

; ---------------------------------------------------------------------------

ZoneASM_PaletteBlinkRed:
    LDY	    #5
    LDA	    byte_140
    AND	    #$3F
    BEQ	    loc_C0EA
    LDA	    PlayerItem_Lightbulb
    BEQ	    loc_C0CE
    LDA	    byte_26E
    BNE	    loc_C0E8

loc_C0CE:
    LDA	    UnknownTimer014B
    BEQ	    loc_C0F6
    CMP	    #3
    BCS	    loc_C0F6
    LDY	    #0
    LDA	    #$F
    LDX	    #$B
    JSR	    sub_C0AF
    LDX	    #$F
    JSR	    sub_C0AF
    JMP	    loc_C0F6
; ---------------------------------------------------------------------------

loc_C0E8:
    LDY	    #7

loc_C0EA:
    LDA	    #5
    LDX	    #$B
    JSR	    sub_C0AF
    LDX	    #$F
    JSR	    sub_C0AF

loc_C0F6:
    JSR	    JustRTS
    RTS
; ---------------------------------------------------------------------------

ZoneASM_DarkAutoBlink:
    LDA	    byte_140
    BEQ	    loc_C11E
    LDA	    PlayerItem_Lightbulb
    BEQ	    loc_C109
    LDA	    byte_26E
    BNE	    loc_C11E

loc_C109:
    LDA	    UnknownTimer014B
    BEQ	    loc_C127
    CMP	    #3
    BCS	    loc_C127
    LDY	    #0
    LDA	    #$F
    LDX	    #3
    JSR	    sub_C0AF
    JMP	    loc_C127
; ---------------------------------------------------------------------------

loc_C11E:
    LDY	    #$A
    LDA	    #5
    LDX	    #3
    JSR	    sub_C0AF

loc_C127:
    JSR	    JustRTS
    RTS

; =============== S U B	R O U T	I N E =======================================

sub_C12B:
    LDA	    PlayerItem_Lightbulb
    BEQ	    locret_C16B
    LDA	    byte_26E
    BNE	    loc_C154
    LDA	    UnknownTimer014B
    BEQ	    locret_C16B
    CMP	    #3
    BCS	    locret_C16B
    LDY	    #0
    LDA	    #$F
    LDX	    #3
    JSR	    sub_C0AF
    LDX	    #7
    JSR	    sub_C0AF
    LDX	    #$B
    JSR	    sub_C0AF
    JMP	    locret_C16B
; ---------------------------------------------------------------------------

loc_C154:
    LDY	    #$C
    LDA	    #1
    LDX	    #3
    JSR	    sub_C0AF
    LDA	    #5
    LDX	    #7
    JSR	    sub_C0AF
    LDA	    #9
    LDX	    #$B
    JSR	    sub_C0AF

locret_C16B:
    RTS
; End of function sub_C12B

; =============== S U B	R O U T	I N E =======================================

sub_C16C:
    LDA	    GotEndingGem
    BNE	    locret_C16B
    LDA	    #<byte_3C0
    STA	    word_A2
    LDA	    #>byte_3C0
    STA	    word_A2+1
    LDA	    byte_3C7
    AND	    #1
    BNE	    loc_C18D
    LDY	    #3

loc_C184:
    LDA	    byte_C1EA,Y
    STA	    byte_3C0,Y
    DEY
    BPL	    loc_C184

loc_C18D:
    DEC	    byte_3C8
    JSR	    sub_8AB8
    LDA	    byte_3C7
    BMI	    locret_C1E9
    LDY	    #6
    LDA	    EndingGemSpritePointers,Y
    STA	    word_1A
    LDA	    EndingGemSpritePointers+1,Y
    STA	    word_1A+1
    LDA	    #0
    STA	    byte_2A
    LDA	    byte_3C4
    STA	    byte_28
    LDA	    byte_3C5
    STA	    byte_29
    JSR	    DrawSpriteMaybe
    LDX	    PlayerX
    CPX	    byte_3C0
    BEQ	    loc_C1C8
    INX
    CPX	    byte_3C0
    BNE	    locret_C1E9

loc_C1C8:
    LDX	    PlayerY
    CPX	    byte_3C2
    BNE	    locret_C1E9
    LDA	    #$FF
    STA	    GotEndingGem
    LDA	    #1
    STA	    byte_19D
    LDA	    #$19
    STA	    byte_289
    LDY	    #3
    LDA	    #0

loc_C1E3:
    STA	    byte_1DA
    DEY
    BPL	    loc_C1E3

locret_C1E9:
    RTS
; End of function sub_C16C

; ---------------------------------------------------------------------------
byte_C1EA:
    .BYTE	$4C
    .BYTE 0
    .BYTE $69
    .BYTE 0

; =============== S U B	R O U T	I N E =======================================

; Calls	to this	might have been	meant to go to the below
; disabled feature, given the nature of	jumping	to a RTS

JustRTS:
    RTS
; End of function JustRTS

; =============== S U B	R O U T	I N E =======================================

; Unused zone ASM feature.
; - Makes enemy	palettes black with one	white color
; - Bombing makes one of the other colors gray temporarily
;
; The white color is generally used for	the eyes or other
; shiny	parts of an enemy sprite. One bug with this is that
; the enemies will look	normal until the first bomb, but
; this might've been solved with a different palette

ZoneASM_UnusedDarkEnemies:
    LDA	    PPUCtrl
    BEQ	    locret_C227
    LDA	    byte_267
    AND	    #1
    CMP	    byte_3CE
    BEQ	    locret_C227
    LDX	    #4
    TAY
    BEQ	    loc_C204
    INX

loc_C204:
    LDA	    byte_C228,X
    STA	    byte_21
    TXA
    LSR	    A
    TAY
    LDA	    byte_21
    STA	    PaletteData+$11,Y
    STA	    PaletteData+$15,Y
    DEX
    DEX
    BPL	    loc_C204
    LDA	    #$FF
    STA	    PaletteUpdateRequest
    LDA	    byte_3CE
    EOR	    #1
    STA	    byte_3CE

locret_C227:
    RTS
; End of function ZoneASM_UnusedDarkEnemies

; ---------------------------------------------------------------------------
byte_C228:
    .BYTE	$20
    .BYTE $20
    .BYTE $F
    .BYTE 0
    .BYTE $F
    .BYTE $F
; ---------------------------------------------------------------------------

ZoneASM_100_FinalZone:
    LDA	    LastDoorEntered
    CMP	    #$E8
    BEQ	    loc_C241
    JSR	    ZoneASM_100_PaletteAnim
    JSR	    ZoneASM_100_ProbablySomethingIkki
    JSR	    sub_C16C
    JMP	    ZoneASM_100_ShowCongratulations
; ---------------------------------------------------------------------------

loc_C241:
    JMP	    ZoneASM_100_SecretArea

; =============== S U B	R O U T	I N E =======================================

ZoneASM_100_ProbablySomethingIkki:
    LDA	    #$80
    STA	    word_A2
    LDA	    #2
    STA	    word_A2+1
    LDA	    byte_287
    AND	    #1
    BNE	    loc_C27A
    LDA	    #$FF
    STA	    PaletteUpdateRequest
    LDA	    #1
    STA	    byte_287
    LDY	    #3

loc_C261:
    LDA	    byte_C311,Y
    STA	    unk_280,Y
    DEY
    BPL	    loc_C261
    LDA	    byte_19D
    BEQ	    loc_C27A
    LDY	    #3

loc_C271:
    LDA	    unk_C30D,Y
    STA	    PaletteData+$14,Y
    DEY
    BNE	    loc_C271

loc_C27A:
    DEC	    byte_288
    JSR	    sub_8AB8
    LDA	    byte_287
    BMI	    locret_C227
    LDA	    byte_19D
    BEQ	    loc_C2AE
    BMI	    loc_C2AE
    LDX	    byte_289
    DEX
    STX	    byte_289
    TXA
    AND	    #$18
    BEQ	    loc_C2A9
    LSR	    A
    LSR	    A
    LSR	    A
    TAX
    LDA	    unk_C30D,X
    STA	    PaletteData+$14,X
    LDA	    #$FF
    STA	    PaletteUpdateRequest
    BNE	    loc_C2AE

loc_C2A9:
    LDA	    #$FF
    STA	    byte_19D

loc_C2AE:
    LDX	    byte_155
    LDY	    #7

loc_C2B3:
    LDA	    byte_C557,Y
    CLC
    ADC	    byte_285
    STA	    SpriteData,X
    LDA	    byte_C54F,Y
    STA	    SpriteData+2,X
    LDA	    byte_19D
    AND	    #2
    BEQ	    loc_C2E3
    LDA	    byte_288
    AND	    #8
    BEQ	    loc_C2D7
    LDA	    byte_C567,Y
    JMP	    loc_C2DA
; ---------------------------------------------------------------------------

loc_C2D7:
    LDA	    byte_C56F,Y

loc_C2DA:
    STA	    SpriteData+1,X
    LDA	    byte_C577,Y
    JMP	    loc_C2EC
; ---------------------------------------------------------------------------

loc_C2E3:
    LDA	    byte_C547,Y
    STA	    SpriteData+1,X
    LDA	    byte_C55F,Y

loc_C2EC:
    CLC
    ADC	    byte_284
    STA	    SpriteData+3,X
    INX
    INX
    INX
    INX
    DEY
    BPL	    loc_C2B3
    STX	    byte_155
    LDA	    byte_284
    STA	    byte_A4
    LDA	    byte_285
    STA	    byte_A5
    JSR	    sub_B32D
    RTS
; End of function ZoneASM_100_ProbablySomethingIkki

; ---------------------------------------------------------------------------
unk_C30D:
    .BYTE	$F
    .BYTE $F
    .BYTE $1A
    .BYTE $37
byte_C311:
    .BYTE	$49
    .BYTE $20
    .BYTE $70
    .BYTE 0
; ---------------------------------------------------------------------------

ZoneASM_100_ShowCongratulations:
    LDA	    GotEndingGem
    BEQ	    locret_C359
    LDX	    byte_155
    LDY	    #$D

loc_C31F:
    LDA	    EndingCongratulations_YPos,Y
    STA	    SpriteData,X
    LDA	    EndingCongratulations_SpriteIndex,Y
    STA	    SpriteData+1,X
    LDA	    #2
    STA	    SpriteData+2,X
    LDA	    EndingCongratulations_XPos,Y
    STA	    SpriteData+3,X
    INX
    INX
    INX
    INX
    DEY
    BPL	    loc_C31F
    STX	    byte_155
    LDA	    byte_3CC
    AND	    #1
    BNE	    loc_C351
    LDA	    byte_3CD
    BNE	    loc_C351
    LDA	    #MusicTrack_TitleScreen
    JSR	    PlayMusicTrack

loc_C351:
    DEC	    byte_3CD
    BNE	    locret_C359
    DEC	    byte_3CC

locret_C359:
    RTS
; ---------------------------------------------------------------------------
EndingCongratulations_YPos:
    .BYTE $5F,$5E,$5D,$5C,$5B,$5A,$59
    .BYTE $58,$57,$56,$55,$54,$53,$52	; 7
EndingCongratulations_XPos:
    .BYTE $48,$50,$58,$60,$68,$70,$78
    .BYTE $80,$88,$90,$98,$A0,$A8,$B0	; 7
EndingCongratulations_SpriteIndex:
    .BYTE	 $C,$18,$17,$10,$1B, $A,$1D
    .BYTE $1E,$15, $A,$1D,$12,$18,$17	; 7
; ---------------------------------------------------------------------------

ZoneASM_20_NagoyaSecret:
    LDA	    byte_26E
    CMP	    #$FF
    BNE	    locret_C3BD
    LDX	    PlayerX
    CPX	    #$19
    BNE	    loc_C395
    INC	    byte_3CD

loc_C395:
    CPX	    #$1B
    BNE	    loc_C39C
    INC	    byte_3CE

loc_C39C:
    CPX	    #$1D
    BNE	    loc_C3A3
    INC	    byte_3CF

loc_C3A3:
    LDA	    byte_1A0
    BNE	    locret_C3BD
    LDX	    #2

loc_C3AA:
    LDA	    byte_3CD,X
    CMP	    NagoyaSecretNumbers,X
    BNE	    locret_C3BD
    DEX
    BPL	    loc_C3AA
    LDA	    #$E8
    STA	    LastDoorEntered
    STA	    TriggerZoneChange

locret_C3BD:
    RTS
; ---------------------------------------------------------------------------
NagoyaSecretNumbers:
    .BYTE   7,	5,  8			; ---------------------------------------------------------------------------

ZoneASM_99_DoorBackToZone6:
    LDA	    GotEndingGem
    BEQ	    locret_C3D6
    LDA	    byte_3CE
    BNE	    locret_C3D6
    LDY	    #3

loc_C3CD:
    LDA	    Zone99DoorToBefore,Y
    STA	    ZoneDoors+$C,Y
    DEY
    BPL	    loc_C3CD

locret_C3D6:
    RTS
; ---------------------------------------------------------------------------
Zone99DoorToBefore:
    .BYTE $82,$9F,$2C,  3	       ; =============== S U B	R O U T	I N E =======================================

ZoneASM_100_SecretArea:
    LDA	    #$90
    STA	    word_A2
    LDA	    #2
    STA	    word_A2+1
    LDA	    byte_29F
    BNE	    loc_C3F8
    DEC	    byte_29F
    LDY	    #3

loc_C3EF:
    LDA	    byte_C461,Y
    STA	    unk_290,Y
    DEY
    BPL	    loc_C3EF

loc_C3F8:
    JSR	    sub_8AB8
    LDX	    byte_155
    LDA	    #0
    STA	    byte_2B
    LDA	    #5
    STA	    byte_2D

loc_C408:
    LDA	    #5
    STA	    byte_2C

loc_C40D:
    LDY	    byte_2D
    LDA	    byte_C53B,Y
    CLC
    ADC	    byte_295
    STA	    SpriteData,X
    LDY	    byte_2B
    LDA	    byte_C511,Y
    STA	    SpriteData+1,X
    LDY	    byte_2C
    LDA	    byte_C535,Y
    STA	    SpriteData+2,X
    LDA	    byte_C541,Y
    CLC
    ADC	    byte_294
    STA	    SpriteData+3,X
    INX
    INX
    INX
    INX
    INC	    byte_2B
    DEC	    byte_2C
    BPL	    loc_C40D
    DEC	    byte_2D
    BPL	    loc_C408
    STX	    byte_155
    LDA	    byte_1A0
    BNE	    locret_C460
    LDA	    PlayerX
    CMP	    #$6B
    BNE	    locret_C460
    LDA	    #$FF
    STA	    byte_1A0
    LDA	    #$64
    JSR	    AwardPoints2

locret_C460:
    RTS
; End of function ZoneASM_100_SecretArea

; ---------------------------------------------------------------------------
byte_C461:
    .BYTE	$6C
    .BYTE 0
    .BYTE $5C
    .BYTE 0
FinalZonePaletteCycle1:
    .BYTE 2
    .BYTE $12
    .BYTE $22
    .BYTE $32
    .BYTE $32
    .BYTE $22
    .BYTE $12
    .BYTE 2
FinalZonePaletteCycle2:
    .BYTE $26
    .BYTE $36
    .BYTE $36
    .BYTE $26
    .BYTE $16
    .BYTE 6
    .BYTE 6
    .BYTE $16
WaterAnimPaletteCycle1:
    .BYTE 1
    .BYTE 1
    .BYTE $11
    .BYTE $11
    .BYTE 1
    .BYTE 1
    .BYTE $11
    .BYTE $11
WaterAnimPaletteCycle2:
    .BYTE $22
    .BYTE $12
    .BYTE $22
    .BYTE $12
    .BYTE $22
    .BYTE $12
    .BYTE $22
    .BYTE $12
AltWaterAnimPaletteCycle1:
    .BYTE	$32
    .BYTE $21
    .BYTE $31
    .BYTE $22
    .BYTE $31
    .BYTE $22
    .BYTE $31
    .BYTE $32
AltWaterAnimPaletteCycle2:
    .BYTE	$16
    .BYTE 6
    .BYTE 5
    .BYTE $16
    .BYTE 6
    .BYTE 5
    .BYTE 6
    .BYTE $16
ObnoxiousGreenFlashingPalette:
    .BYTE $1A
    .BYTE $2A
    .BYTE $3A
    .BYTE $3A
    .BYTE $2A
    .BYTE $1A
    .BYTE $A
    .BYTE $A
ObnoxiousRedFlashingPalette:
    .BYTE 7
    .BYTE $17
    .BYTE 7
    .BYTE $17
    .BYTE 7
    .BYTE $17
    .BYTE 7
    .BYTE $17
byte_C4A5:
    .BYTE	$2F
    .BYTE $A0
    .BYTE $58
    .BYTE 0
byte_C4A9:
    .BYTE	$40
    .BYTE $40
    .BYTE $40
    .BYTE $40
    .BYTE $38
    .BYTE $38
    .BYTE $38
    .BYTE $38
    .BYTE $30
    .BYTE $30
    .BYTE $30
    .BYTE $30
    .BYTE $28
    .BYTE $28
    .BYTE $28
    .BYTE $28
    .BYTE $28
    .BYTE $28
    .BYTE $20
    .BYTE $20
    .BYTE $18
    .BYTE $18
    .BYTE $10
    .BYTE $10
    .BYTE 8
    .BYTE 8
byte_C4C3:
    .BYTE	$D7
    .BYTE $D8
    .BYTE $D9
    .BYTE $D7
    .BYTE $E7
    .BYTE $E8
    .BYTE $E8
    .BYTE $E9
    .BYTE $F7
    .BYTE $E8
    .BYTE $E8
    .BYTE $F7
    .BYTE $F8
    .BYTE $D9
    .BYTE $D9
    .BYTE $F8
    .BYTE $F9
    .BYTE $F9
    .BYTE $F9
    .BYTE $F9
    .BYTE $F9
    .BYTE $F9
    .BYTE $D6
    .BYTE $D6
    .BYTE $E6
    .BYTE $E6
byte_C4DD:
    .BYTE	1
    .BYTE 1
    .BYTE 1
    .BYTE $41
    .BYTE 1
    .BYTE 1
    .BYTE $41
    .BYTE 1
    .BYTE 1
    .BYTE $81
    .BYTE $C1
    .BYTE $41
    .BYTE 1
    .BYTE $C1
    .BYTE $81
    .BYTE $41
    .BYTE 3
    .BYTE $43
    .BYTE 3
    .BYTE $43
    .BYTE 3
    .BYTE $43
    .BYTE 3
    .BYTE $43
    .BYTE 3
    .BYTE $43
byte_C4F7:
    .BYTE	$F0
    .BYTE $F8
    .BYTE 0
    .BYTE 8
    .BYTE $F0
    .BYTE $F8
    .BYTE 0
    .BYTE 8
    .BYTE $F0
    .BYTE $F8
    .BYTE 0
    .BYTE 8
    .BYTE $F0
    .BYTE $F8
    .BYTE 0
    .BYTE 8
    .BYTE $EE
    .BYTE $A
    .BYTE $F0
    .BYTE 8
    .BYTE $F2
    .BYTE 6
    .BYTE $F8
    .BYTE 0
    .BYTE $F8
    .BYTE 0
byte_C511:
    .BYTE	$DA,$DB,$DC,$DC,$DB,$DA
    .BYTE $EA,$EB,$EC,$EC,$EB,$EA	; 6
    .BYTE $FA,$FB,$FC,$FC,$FB,$FA	; $C
    .BYTE $D4,$D5,$D1,$D1,$D5,$D4	; $12
    .BYTE $E4,$E5,$E1,$E1,$E5,$E4	; $18
    .BYTE $F4,$F5,$F1,$F1,$F5,$F4	; $1E
byte_C535:
    .BYTE	0
    .BYTE 0
    .BYTE 0
    .BYTE $40
    .BYTE $40
    .BYTE $40
byte_C53B:
    .BYTE	$D
    .BYTE 5
    .BYTE $FD
    .BYTE $F5
    .BYTE $ED
    .BYTE $E5
byte_C541:
    .BYTE	$E8
    .BYTE $F0
    .BYTE $F8
    .BYTE 0
    .BYTE 8
    .BYTE $10
byte_C547:
    .BYTE	$DE
    .BYTE $EE
    .BYTE $FD
    .BYTE $FD
    .BYTE $ED
    .BYTE $ED
    .BYTE $DD
    .BYTE $DD
byte_C54F:
    .BYTE	1
    .BYTE $41
    .BYTE 1
    .BYTE $41
    .BYTE 1
    .BYTE $41
    .BYTE 1
    .BYTE $41
byte_C557:
    .BYTE	$F8
    .BYTE $F8
    .BYTE $F0
    .BYTE $F0
    .BYTE $E8
    .BYTE $E8
    .BYTE $E0
    .BYTE $E0
byte_C55F:
    .BYTE	$F9
    .BYTE 0
    .BYTE $F9
    .BYTE 0
    .BYTE $F9
    .BYTE 0
    .BYTE $F9
    .BYTE 0
byte_C567:
    .BYTE	$DE
    .BYTE $DE
    .BYTE $FF
    .BYTE $FF
    .BYTE $EF
    .BYTE $EF
    .BYTE $DF
    .BYTE $DF
byte_C56F:
    .BYTE	$DE
    .BYTE $DE
    .BYTE $FF
    .BYTE $FF
    .BYTE $FE
    .BYTE $FE
    .BYTE $DF
    .BYTE $DF
byte_C577:
    .BYTE	$F8
    .BYTE 0
    .BYTE $F8
    .BYTE 0
    .BYTE $F8
    .BYTE 0
    .BYTE $F8
    .BYTE 0
WriteToPPUStrings:
    .WORD	HighScore+1
    .WORD PPUString_PushStartButton	; 1 ; The last three entries in	this are not used
    .WORD PPUString_HiScore		; 2
    .WORD PPUString_C1986Sunsoft	; 3
    .WORD PPUString_SunElectronicsCorp	; 4
    .WORD PPUString_GameOver		; 5
    .WORD byte_20			; 6
    .WORD PPUString_Score		; 7
    .WORD PlayerScore+1			; 8
    .WORD PPUString_Zone		; 9
    .WORD PPUString_MysteyAdventureStart; $A
    .WORD PPUString_OK			; $B
    .WORD PPUString_Out			; $C
    .WORD PPUString_Warp		; $D
PPUString_PushStartButton:
    .BYTE	$26,$19,$1E,$1C,$11,$FF,$1C,$1D
    .BYTE  $A,$1B,$1D,$FF, $B,$1E,$1D,$1D; 8 ; "-PUSH START BUTTON!-"
    .BYTE $18,$17,$25,$26,$80		; $10
PPUString_HiScore:
    .BYTE	$11,$12,$26		      ; "HI-"	(falls through to SCORE)
PPUString_Score:
    .BYTE $1C, $C,$18,$1B, $E,$80	    ; "SCORE"
PPUString_C1986Sunsoft:
    .BYTE $27,$FF,  1,  9,  8,  6,$FF,$F6
    .BYTE $F7,$F8,$F9,$FA,$FB,$80	; 8 ; "(C) 1986	SUNSOFT"
PPUString_SunElectronicsCorp:
    .BYTE $1C,$1E,$17,$FF, $E,$15, $E,	$C
    .BYTE $1D,$1B,$18,$17,$12, $C,$1C,$FF; 8 ; "SUN ELECTRONICS	CORP."
    .BYTE  $C,$18,$1B,$19,$24,$80	; $10
PPUString_GameOver:
    .BYTE $10, $A,$16, $E,$FF,$18,$1F, $E
    .BYTE $1B,$80			; 8 ; "GAME OVER"
PPUString_Zone:
    .BYTE $23,$18,$17, $E,$FF,$25,$80   ; "ZONE	!"
PPUString_MysteyAdventureStart:
    .BYTE $16,$22,$1C,$1D, $E,$1B,$22,$FF
    .BYTE  $A, $D,$1F, $E,$17,$1D,$1E,$1B; 8 ; "MYSTERY	ADVENTURE START.."
    .BYTE  $E,$FF,$1C,$1D, $A,$1B,$1D,$24; $10
    .BYTE $24,$80			; $18
PPUString_OK:
    .BYTE $18,$14,$FF,$25,$80		 ; "OK !" (unused)
PPUString_Out:
    .BYTE $18,$1E,$1D,$FF,$25,$80	  ;	DATA XREF: BANK0:WriteToPPUStringso
					; "OUT !" (unused)
PPUString_Warp:
    .BYTE $20, $A,$1B,$19,$FF,$25,$80   ; "WARP	!" (unused)
IntermissionItemXPos:
    .BYTE $3A,$4E,$62,$76,$8A,$9E,$B2,$C6
IntermissionItemYPos:
    .BYTE $A0,$9C,$98,$94,$90,$8C,$88,$84
OrdinalSuffixes1:
    .BYTE $1C,$17,$1B,$1D,	$A	     ; Ordinal suffixes for the "#TH	ZONE!" messages.
					; ST ND	RD TH AL (from FINAL)
OrdinalSuffixes2:
    .BYTE $1D, $D,	$D,$11,$15
PPU_TitleScreenLogo:
    .BYTE $FF,$B0,$FD,$C8,$FD,$C1,$D0,$B8,$FD,$FD,$B1,$C0,$C8,$B5,$B4,$FD,$FD,$BA,$B2,$C8,$B5,$FF,$B2,$C3,$E7,$BB,$BC,$C3,$E9,$FF,$FF,$FF
    .BYTE $FF,$FF,$B0,$B1,$D0,$B8,$B1,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$B4,$B5,$FF,$FF,$B4,$B5,$BE,$BD,$BD,$BF,$CB,$CC,$D3,$D0,$D1,$FF,$FF; $20
    .BYTE $FF,$FF,$C0,$B9,$B1,$C0,$C1,$D0,$C8,$FD,$C1,$FF,$FF,$FF,$B4,$C8,$FD,$D3,$FF,$B4,$B5,$FF,$CD,$CE,$CF,$EF,$DC,$FD,$B1,$FF,$FF,$FF; $40
    .BYTE $FF,$FF,$D0,$C9,$D7,$D0,$D9,$FF,$FF,$D0,$D1,$FF,$FF,$C8,$FF,$B4,$B5,$FF,$FF,$B4,$B5,$FF,$DD,$DE,$DF,$D3,$B2,$D8,$FD,$D3,$FF,$FF; $60
    .BYTE $FF,$B0,$B1,$FF,$B0,$B1,$B2,$B3,$B0,$B1,$FF,$FF,$FF,$FD,$FF,$B4,$B5,$FF,$FF,$B4,$B5,$FF,$ED,$EE,$EF,$C2,$B3,$D0,$FD,$EB,$FF,$FF; $80
    .BYTE $FF,$B6,$B7,$FF,$C0,$C1,$FF,$FF,$B6,$B7,$FF,$FF,$E0,$B1,$FF,$E1,$E2,$FF,$FF,$E1,$BA,$FF,$C2,$FD,$FD,$E8,$C3,$B2,$FD,$EC,$B3,$C4; $A0
    .BYTE $C5,$C6,$C7,$FF,$D0,$D1,$C4,$C5,$C6,$C7,$C4,$C5,$FD,$E5,$C5,$FD,$E6,$FF,$C5,$FD,$CA,$DB,$D2,$D3,$C2,$C3,$F0,$F1,$F2,$F3,$F4,$D4; $C0
    .BYTE $D5,$D6,$FF,$B0,$B1,$FF,$D4,$D5,$D6,$FF,$D4,$D5,$E3,$FF,$C9,$E4,$FF,$FF,$C9,$E4,$DA,$B5,$FF,$B2,$C8,$D3,$D0,$F5,$FD,$C8,$C1,$80; $E0

; =============== S U B	R O U T	I N E =======================================

InitSoundEngine:
    LDX	    #$40
    LDA	    #$FF

loc_C738:
    STA	    byte_2F,X
    DEX
    BNE	    loc_C738
    STX	    byte_B
    STX	    SND_CHN
    RTS
; End of function InitSoundEngine

; =============== S U B	R O U T	I N E =======================================

PlayMusicTrack:
    ASL	    A
    TAX
    LDA	    MusicPointerTable,X
    STA	    word_1E
    LDA	    MusicPointerTable+1,X
    STA	    word_1E+1
    LDY	    #0
    LDA	    (word_1E),Y
    STA	    byte_2E

loc_C75A:
    INY
    LDA	    (word_1E),Y
    TAX
    LDA	    #1
    STA	    unk_54,X
    LDA	    #$FF
    STA	    unk_60,X

loc_C768:
    INY
    LDA	    (word_1E),Y
    STA	    unk_30,X
    TXA
    CLC
    ADC	    #6
    TAX
    CPX	    #$24
    BCC	    loc_C768
    DEC	    byte_2E
    BNE	    loc_C75A

locret_C77C:
    RTS
; End of function PlayMusicTrack

; =============== S U B	R O U T	I N E =======================================

RunMusicEngine:
    LDA	    #0
    LDX	    #3

loc_C781:
    STA	    unk_6C,X
    DEX
    BPL	    loc_C781
    LDX	    #5

loc_C789:
    JSR	    sub_C78F
    DEX
    BNE	    loc_C789
; End of function RunMusicEngine

; =============== S U B	R O U T	I N E =======================================

sub_C78F:
    LDA	    unk_42,X
    CMP	    #$FF
    BEQ	    locret_C77C
    DEC	    unk_54,X
    BEQ	    loc_C7A3
    LDA	    #$F
    STA	    byte_22
    JMP	    loc_C8AE
; ---------------------------------------------------------------------------

loc_C7A3:
    LDA	    #0
    STA	    word_1A+1
    LDA	    unk_42,X
    ASL	    A
    ROL	    word_1A+1
    CLC
    ADC	    unk_30,X
    STA	    word_1A
    LDA	    word_1A+1
    ADC	    unk_36,X
    STA	    word_1A+1
    LDY	    #0

loc_C7C1:
    LDA	    (word_1A),Y
    CMP	    #$FF
    BNE	    loc_C7DC
    STA	    unk_42,X
    STA	    unk_5A,X
    LDA	    unk_3C,X
    TAY
    LDA	    #0
    STA	    unk_6C,Y
    JSR	    sub_C8F3
    JMP	    loc_C8ED
; ---------------------------------------------------------------------------

loc_C7DC:
    STA	    byte_25
    INY
    LDA	    (word_1A),Y
    STA	    byte_26
    LDA	    byte_25
    CMP	    #$C0
    BCS	    loc_C84A
    CMP	    #$B0
    BCS	    loc_C813
    CMP	    #$A0
    BCC	    loc_C84A
    AND	    #1
    BNE	    loc_C801
    LDA	    byte_26
    STA	    unk_4E,X
    JMP	    loc_C807
; ---------------------------------------------------------------------------

loc_C801:
    LDA	    byte_26
    STA	    unk_48,X

loc_C807:
    INY
    INC	    unk_42,X
    LDA	    #$FF
    STA	    unk_60,X
    JMP	    loc_C7C1
; ---------------------------------------------------------------------------

loc_C813:
    CMP	    #$BF
    BNE	    loc_C820
    LDA	    byte_26
    STA	    unk_42,X
    JMP	    loc_C7A3
; ---------------------------------------------------------------------------

loc_C820:
    LDA	    unk_5A,X
    BEQ	    loc_C840
    CMP	    #$FF
    BEQ	    loc_C82F
    DEC	    unk_5A,X
    JMP	    loc_C837
; ---------------------------------------------------------------------------

loc_C82F:
    LDA	    byte_25
    AND	    #$F
    STA	    unk_5A,X

loc_C837:
    LDA	    byte_26
    STA	    unk_42,X
    JMP	    loc_C7A3
; ---------------------------------------------------------------------------

loc_C840:
    DEC	    unk_5A,X
    INC	    unk_42,X
    INY
    JMP	    loc_C7C1
; ---------------------------------------------------------------------------

loc_C84A:
    INC	    unk_42,X
    LDA	    unk_3C,X
    CMP	    #3
    BEQ	    loc_C884
    LDA	    byte_25
    AND	    #$F
    CMP	    #$C
    BCS	    loc_C882
    ASL	    A
    TAY
    LDA	    MusicNoteScale+1,Y
    STA	    byte_22
    LDA	    MusicNoteScale,Y
    STA	    byte_23
    LDA	    byte_25
    AND	    #$F0
    CMP	    #$A0
    LSR	    A
    LSR	    A
    LSR	    A
    LSR	    A
    TAY

loc_C877:
    LSR	    byte_23
    ROR	    byte_22
    DEY
    BPL	    loc_C877
    BMI	    loc_C88C

loc_C882:
    LDA	    #$F

loc_C884:
    STA	    byte_22
    LDA	    #0
    STA	    byte_23

loc_C88C:
    LDA	    byte_26
    AND	    #$1F
    TAY
    LDA	    MusicNoteLength,Y
    STA	    unk_54,X
    LDA	    byte_26
    TAY
    AND	    #$F
    ASL	    A
    ASL	    A
    ASL	    A
    ASL	    A
    ORA	    byte_23
    CPY	    #$F0
    BCS	    loc_C8AB
    ORA	    #8

loc_C8AB:
    STA	    byte_23

loc_C8AE:
    LDA	    unk_3C,X
    TAY
    LDA	    unk_6C,Y
    BNE	    loc_C8ED
    LDA	    #$FF
    STA	    unk_6C,Y
    LDA	    byte_22
    CMP	    #$F
    BEQ	    locret_C8EC
    JSR	    sub_C900
    TYA
    ASL	    A
    ASL	    A
    TAY
    LDA	    unk_60,X
    BEQ	    loc_C8DB
    LDA	    unk_48,X
    STA	    SQ1_SWEEP,Y
    LDA	    unk_4E,X
    STA	    SQ1_VOL,Y

loc_C8DB:
    LDA	    byte_22
    STA	    SQ1_LO,Y
    LDA	    byte_23
    STA	    SQ1_HI,Y
    LDA	    #0
    STA	    unk_60,X

locret_C8EC:
    RTS
; ---------------------------------------------------------------------------

loc_C8ED:
    LDA	    #$FF
    STA	    unk_60,X
    RTS
; End of function sub_C78F

; =============== S U B	R O U T	I N E =======================================

sub_C8F3:
    LDA	    byte_B
    AND	    byte_C949,Y
    STA	    byte_B
    STA	    SND_CHN
    RTS
; End of function sub_C8F3

; =============== S U B	R O U T	I N E =======================================

sub_C900:
    LDA	    byte_B
    ORA	    byte_C945,Y
    STA	    byte_B
    STA	    SND_CHN
    RTS
; End of function sub_C900

