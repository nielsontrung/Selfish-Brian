;==================================================================
;   print_character_set.asm
;==================================================================
;   the following file prints our custom character set
;   screen code mem starts at 7168 screen mem starts at 7680
;   MAX # of custom characters for 8x8  7680 - 7168 = 512 
;   MAX # of custom characters for 16x8 (7680 - 7168) / 2 = 256 
;==================================================================
;   basic stub
;==================================================================
	processor 6502
	org     $1001
	dc.w    endstub
	dc.w    12345
	dc.b    158, "4109"
	dc.b	0
endstub
	dc.w    0
;==================================================================
;   end of basic stub
;==================================================================
PLAYER_SCREEN_MEM equ 7724
PLAYER_COLOUR_MEM equ PLAYER_SCREEN_MEM+30720
PLAYER_X		  equ 56
GROUND_SCREEN_MEM equ PLAYER_SCREEN_MEM+242
GROUND_COLOUR_MEM equ GROUND_SCREEN_MEM+30720
init
    lda #0
    sta PLAYER_X
    ; switch to hi res 16x8 
    lda #%00010111
	sta 36867
    ; use custom character set
    lda #255            		; load 255 into accumulator
	sta 36869           		; store at 36869 (character information) to use custom characterset
    ; jsr clear_screen
    ; jsr draw_player_idle

clear_screen					; fill the screen
	ldx #00
clear_screen_loop
	lda #0						; screen code
	sta PLAYER_SCREEN_MEM,x
    lda #05
    sta PLAYER_COLOUR_MEM,x
	inx
	cpx #255
	bne clear_screen_loop
    
draw_screen_codes
    ldx #00
    ldy #00
draw_screen_codes_loop
    tya
    sta PLAYER_SCREEN_MEM,x
    inx 
    iny
    cpx #255
    bne draw_screen_codes_loop
	rts

colour_screen
    ldx #00
    lda #05
colour_screen_loop
    sta PLAYER_COLOUR_MEM,x
    inx 
    cpx #255
    bne colour_screen_loop
	rts

    include "character_set.asm"