
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
    ADC	    #$50
    STA	    word_14
    LDA	    word_14+1
    ADC	    #$EA
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
    ADC	    #$50
    STA	    word_16
    LDA	    word_16+1
    ADC	    #$DE
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
    ADC	    #$50
    STA	    word_18
    LDA	    word_18+1
    ADC	    #$DE
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
    ADC	    #$C0
    STA	    word_1A
    LDA	    word_1A+1
    ADC	    #$F3
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
    ADC	    #$C0
    STA	    word_1A
    LDA	    word_1A+1
    ADC	    #$F3
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
    ADC	    #$50
    STA	    word_1E
    LDA	    word_1E+1
    ADC	    #$E6
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
    ADC	    #$50
    STA	    word_1E
    LDA	    word_1E+1
    ADC	    #$E6
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

; ---------------------------------------------------------------------------
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
; ------ Starting here,	not logged in CDL ------
    .BYTE $FF
    .BYTE $32 ;	2
    .BYTE $7F
    .BYTE $7F
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $7F
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $FE
    .BYTE   2
    .BYTE $F7
    .BYTE   2
    .BYTE $7F
    .BYTE $22
    .BYTE $FE
    .BYTE   2
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE $82
    .BYTE $FB
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   0
    .BYTE $FB
    .BYTE $82
    .BYTE $FB
    .BYTE $FF
    .BYTE $82
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FB
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   2
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $FD
    .BYTE   0
    .BYTE $77
    .BYTE   2
    .BYTE $F7
    .BYTE   8
    .BYTE $F7
    .BYTE   8
    .BYTE $FD
    .BYTE   0
    .BYTE $FD
    .BYTE $12
    .BYTE $FF
    .BYTE $FF
    .BYTE   0
    .BYTE $75
    .BYTE   0
    .BYTE $F7
    .BYTE   0
    .BYTE $FF
    .BYTE $80
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $FB
    .BYTE   8
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   2
    .BYTE $7F
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $77
    .BYTE   2
    .BYTE $7F
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $F7
    .BYTE   0
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE   2
    .BYTE $FD
    .BYTE   0
    .BYTE $FD
    .BYTE   0
    .BYTE $FF
    .BYTE   8
    .BYTE $FF
    .BYTE $40
    .BYTE $F5
    .BYTE   0
    .BYTE $F9
    .BYTE $80
    .BYTE $FF
    .BYTE  $A
    .BYTE $FF
    .BYTE $FF
    .BYTE   0
    .BYTE $7D
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $7F
    .BYTE  $A
    .BYTE   0
    .BYTE $7D
    .BYTE   2
    .BYTE $FD
    .BYTE   2
    .BYTE $F5
    .BYTE $10
    .BYTE $FD
    .BYTE   0
    .BYTE $FD
    .BYTE $20
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE $20
    .BYTE $FD
    .BYTE $7D
    .BYTE $10
    .BYTE $F5
    .BYTE   0
    .BYTE $F5
    .BYTE   0
    .BYTE $7D
    .BYTE   0
    .BYTE $7D
    .BYTE   0
    .BYTE $FD
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $FD
    .BYTE   0
    .BYTE $12
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $F7
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $F7
    .BYTE $12
    .BYTE $F7
    .BYTE $12
    .BYTE $FF
    .BYTE   2
    .BYTE $F7
    .BYTE $FF
    .BYTE   0
    .BYTE $7F
    .BYTE $92
    .BYTE $FF
    .BYTE $22
    .BYTE $7F
    .BYTE $12
    .BYTE $FF
    .BYTE $10
    .BYTE $FE
    .BYTE   0
    .BYTE $FF
    .BYTE $92
    .BYTE $7F
    .BYTE   2
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $7F
    .BYTE   2
    .BYTE $7E
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $F7
    .BYTE   4
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE $22
    .BYTE $F7
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $7F
    .BYTE   2
    .BYTE $77
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $B7
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE $12
    .BYTE $A2
    .BYTE $FF
    .BYTE $12
    .BYTE $7F
    .BYTE   2
    .BYTE $77
    .BYTE $22
    .BYTE $FF
    .BYTE   2
    .BYTE $7F
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $7F
    .BYTE   2
    .BYTE $7E
    .BYTE $7F
    .BYTE   2
    .BYTE $7F
    .BYTE   2
    .BYTE $FF
    .BYTE   0
    .BYTE $FE
    .BYTE   2
    .BYTE $FE
    .BYTE   2
    .BYTE $7F
    .BYTE $20
    .BYTE $7F
    .BYTE   0
    .BYTE $3E
    .BYTE $86
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FB
    .BYTE $10
    .BYTE $FF
    .BYTE   0
    .BYTE $FB
    .BYTE   2
    .BYTE $FF
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   2
    .BYTE   0
    .BYTE $77
    .BYTE   8
    .BYTE $7D
    .BYTE   0
    .BYTE $FD
    .BYTE   0
    .BYTE $3F
    .BYTE $80
    .BYTE $7F
    .BYTE $10
    .BYTE $FB
    .BYTE   8
    .BYTE $77
    .BYTE $C0
    .BYTE $FD
    .BYTE $7F
    .BYTE   0
    .BYTE $F7
    .BYTE   2
    .BYTE $F7
    .BYTE   0
    .BYTE $7D
    .BYTE $82
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $F7
    .BYTE   2
    .BYTE $F7
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE $82
    .BYTE $FF
    .BYTE $FF
    .BYTE   2
    .BYTE $FB
    .BYTE   2
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   2
    .BYTE $F7
    .BYTE   2
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $BF
    .BYTE   2
    .BYTE   0
    .BYTE $F7
    .BYTE   0
    .BYTE $FF
    .BYTE $10
    .BYTE $F7
    .BYTE   2
    .BYTE $7F
    .BYTE   2
    .BYTE $FB
    .BYTE   8
    .BYTE $FF
    .BYTE   8
    .BYTE $B7
    .BYTE  $A
    .BYTE $FF
    .BYTE $7F
    .BYTE   0
    .BYTE $F3
    .BYTE   0
    .BYTE $F7
    .BYTE   0
    .BYTE $F7
    .BYTE $82
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $7F
    .BYTE $40
    .BYTE   2
    .BYTE $FF
    .BYTE   6
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $7F
    .BYTE   0
    .BYTE $7F
    .BYTE   0
    .BYTE $FF
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $FF
    .BYTE   6
    .BYTE $FF
    .BYTE   2
    .BYTE $F7
    .BYTE   4
    .BYTE $7F
    .BYTE   0
    .BYTE $7F
    .BYTE   2
    .BYTE $82
    .BYTE $FF
    .BYTE   2
    .BYTE $7F
    .BYTE   2
    .BYTE $FF
    .BYTE   0
    .BYTE $FF
    .BYTE   2
    .BYTE $FD
    .BYTE $82
    .BYTE $7F
    .BYTE   2
    .BYTE $7F
    .BYTE $12
    .BYTE $7F
    .BYTE $77
    .BYTE   2
    .BYTE $F7
    .BYTE   2
    .BYTE $7E
    .BYTE   0
    .BYTE $77
    .BYTE $82
    .BYTE $7F
    .BYTE   2
    .BYTE $F7
    .BYTE   2
    .BYTE $FF
    .BYTE   2
    .BYTE $7F
    .BYTE   2
    .BYTE   2
    .BYTE $FD
    .BYTE   2
    .BYTE $FD
    .BYTE $12
    .BYTE $F5
    .BYTE   0
    .BYTE $FD
    .BYTE   0
    .BYTE $FD
    .BYTE   0
    .BYTE $FF
    .BYTE   0
    .BYTE $F7
    .BYTE $10
    .BYTE $FD
    .BYTE $F5
    .BYTE   0
    .BYTE $FD
    .BYTE $10
    .BYTE $FD
    .BYTE $82
    .BYTE $FD
    .BYTE   0
    .BYTE $FD
    .BYTE   0
    .BYTE $FF
    .BYTE $80
    .BYTE $F5
    .BYTE   0
    .BYTE $FD
    .BYTE $80
; ------ Ending	here, not logged in CDL	------
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
stru_EA50:
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

; =============== S U B	R O U T	I N E =======================================

    ; public IRQ
IRQ:
    RTI
; End of function IRQ

; ---------------------------------------------------------------------------
    .WORD NMI
    .WORD RESET
    .WORD IRQ
; end of 'BANK0'
; End
