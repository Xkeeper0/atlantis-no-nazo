; -----------------------------------------
; Atlantis no Nazo (JP)  disassembly
; https://github.com/xkeeper0/atlantis-no-nazo/
; -----------------------------------------

; -----------------------------------------
; Add iNES header

	.db "NES", $1a	; iNES header
	.db 2			; 16KB PRG-ROM pages
	.db 2			; 8KB CHR-ROM pages
	.db $81
	.db $B0
	.dsb 8, $00		; Reserved


; -----------------------------------------
; Add macros
.include "src/macros.asm"

; Add definitions
.enum $0000
.include "src/defs.asm"
.ende

; Add RAM definitions
.enum $0000
.include "src/ram.asm"
.include "src/registers.asm"
.ende


; -----------------------------------------
; Program code
.base $8000
.include "src/prg.asm"

; Mostly data
.include "src/data.asm"


;.pad $FFFF, $FF

; IRQ is stored just before vectors
IRQ:
	RTI
; ---------------------------------------------------------------------------
; CPU vectors
.word NMI
.word RESET
.word IRQ


; Pad empty space

; -----------------------------------------
; Include CHR-ROM
.incbin "src/atlantis-no-nazo.chr"
