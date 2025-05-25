.ignorenl
; ---------------------------------------------------------------------------

; enum PPUMaskBitmask (bitfield)
PPUMask_Grayscale =  1
PPUMask_ShowLeft8Pixels_BG =  %10
PPUMask_ShowLeft8Pixels_SPR =  %100
PPUMask_ShowBackground =  %1000
PPUMask_ShowSprites =  %10000
PPUMask_RedEmphasis =  %100000
PPUMask_GreenEmphasis =  %1000000
PPUMask_BlueEmphasis = 	%10000000

; ---------------------------------------------------------------------------

; enum PPUControl (bitfield)
PPUCtrl_BaseAddress		   = 3
PPUCtrl_BaseAddr2000 = 	0
PPUCtrl_BaseAddr2400 = 	1
PPUCtrl_BaseAddr2800 = 	2
PPUCtrl_BaseAddr2C00 = 	3
PPUCtrl_WriteIncrementHorizontal =  0
PPUCtrl_WriteIncrementVertical =  4
PPUCtrl_SpritePatternTable0000 =  0
PPUCtrl_SpritePatternTable1000 =  8
PPUCtrl_BackgroundPatternTable0000 =  0
PPUCtrl_BackgroundPatternTable1000 =  $10
PPUCtrl_SpriteSize8x8 =  0
PPUCtrl_SpriteSize8x16 =  $20
PPUControl_NMIDisabled =  0
PPUControl_NMIEnabled =  $80

; ---------------------------------------------------------------------------

; enum PPUSTatusMask (bitfield)
PPUStatus_SpriteOverflow =  %100000
PPUStatus_SpriteZeroHit =  %1000000
PPUStatus_VBlank =  %10000000

; ---------------------------------------------------------------------------

; enum ControllerInput (bitfield)
ControllerInput_Right =  1
ControllerInput_Left = 	2
ControllerInput_Down = 	4
ControllerInput_Up =  8
ControllerInput_Start =  $10
ControllerInput_Select =  $20
ControllerInput_B =  $40
ControllerInput_A =  $80

; ---------------------------------------------------------------------------

; enum PlayerStates (bitfield) (width 1	byte)
PlayerStates_FacingLeft =  1
PlayerStates_ThrowingBomb =  %10
PlayerStates_Jumping = 	%100
PlayerStates_08 =  %1000		; ??? Around apex of jump-ish
PlayerStates_Ducking = 	%10000
PlayerStates_20 =  %100000
PlayerStates_40 =  %1000000
PlayerStates_Dead =  %10000000

; ---------------------------------------------------------------------------

; enum DoorFlags (bitfield) (width 1 byte)
DoorFlags_Closed =  1
DoorFlags_Open =  %10
DoorFlags_Hidden =  %100
DoorFlags_Invisible =  %1000

; ---------------------------------------------------------------------------

; enum MusicTrack
MusicTrack_ZoneTheme1 =  1
MusicTrack_ZoneTheme2 =  2
MusicTrack_ZoneTheme3 =  3
MusicTrack_TitleScreen =  4
MusicTrack_ZoneStart = 	5
MusicTrack_GameOver =  6
MusicTrack_Death =  7
MusicTrack_Pause =  8
MusicTrack_ExtraLife = 	9
MusicTrack_Treasure =  $A
MusicTrack_ThrowBomb = 	$B
MusicTrack_BombExplode =  $C
MusicTrack_Pause2 =  $D

; ---------------------------------------------------------------------------

; enum Enemy
Enemy_Nothing =  0
Enemy_WormThing =  1
Enemy_ShitBat =  2
Enemy_Mummy =  3
Enemy_Skeleton =  4
Enemy_GravityBlob =  5
Enemy_Snail =  6
Enemy_Fly =  7
Enemy_Fishman =  8
Enemy_JumpingFish =  9
Enemy_Scorpion =  $A
Enemy_FireballSpawner =  $B
Enemy_End =  $FF

; ---------------------------------------------------------------------------

; enum PPUStringIndex
PPUStringIndex_HighScoreInMemory =  0
PPUStringIndex_PushStartButton =  1
PPUStringIndex_HiScore =  2
PPUStringIndex_C1986Sunsoft =  3
PPUStringIndex_SunElecCorp =  4
PPUStringIndex_GameOver =  5
PPUStringIndex_0020 =  6
PPUStringIndex_Score = 	7
PPUStringIndex_ScoreInMemory = 	8
PPUStringIndex_Zone =  9
PPUStringIndex_MysteryAdventureStart = 	$A
PPUStringIndex_OK =  $B
PPUStringIndex_Out =  $C
PPUStringIndex_Warp =  $D


; ---------------------------------------------------------------------------
; collision types
__ = 0	; empty
H_ = 2	; "half-solid ledge" (requires boot or you fall through)
SB = 3	; "solid block"

.endinl
