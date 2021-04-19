;==================================================================
;   screens.asm screen & border color: pg 265
;==================================================================
;   screens used in our game
;==================================================================
;   macros: pg 184
;==================================================================
CHROUT			equ $ffd2   ; user callable subroutines
RESET			equ $fd22   ; user callable subroutines
GETIN			equ $ffe4   ; user callable subroutines
CLRSCRN			equ $e55f   ; user callable subroutines
SCRCOLOR		equ $900f
TXTCOLOR		equ $0286
SCREE_ORIGIN_H	equ	36864   ; horizontal position of screen pg 213
SCREE_ORIGIN_V  equ	36865   ; vertical position of screen pg 214
;==================================================================
;   macros
;==================================================================
normal_character_set
    lda #%00101100              ; bit 0 sets low/hi res graphics bits 1-6 #rows pg 175
    sta 36867                   ; set character size back to 8x8 pg 215
    lda #240            		; 240 use upper case graphics pg 83
                                ; bits 0-3 start of character memory pg 175
								; bits 4-7 is rest of video address
	sta 36869           		; store at 36869 (character information) pg 215
    rts

shake_screen
    lda #4
    sta SCREE_ORIGIN_H
    jsr timer
    lda #6
    sta SCREE_ORIGIN_H
    jsr timer
    lda #5
    sta SCREE_ORIGIN_H
    jsr timer
    rts

setup_screen
    jsr normal_character_set
	jsr CLRSCRN						; clear screen
    lda #$40                		; load new text colour
    sta TXTCOLOR            		; change text colour
    lda #$19                		; load new background colour
    sta SCRCOLOR            		; change background and border colours    								
    ldy #00			                ; initialize counter at 0
    rts

title                               ; call when game starts
	jsr setup_screen
title_loop							
    lda title_screen,y
    jsr CHROUT
    iny
    cpy #96                		; 110 characters in the title screen
    bne title_loop
    jsr title_wait
    rts
title_wait
    jsr GETIN            			; pressing any input ends title screen
    beq title_wait
    rts
title_screen
	dc.b $0d, $0d
	dc.b "    SELFISH  BRIAN", $0d
	dc.b $0d, $0d, $0d, $0d
    dc.b "      RONAN RN", $0d, $0d
	dc.b "        ALFA Z", $0d, $0d
	dc.b "      NIELSON T", $0d, $0d, $0d, $0d, $0d
	dc.b "   PRESS ANY BUTTON"
    rts
;------------------------------------------------------------------
;   death screen
;------------------------------------------------------------------
gameover                            ; called if player dies
    jsr clear_screen
    jsr setup_screen		        ; initialize counter at 0
gameover_loop							
    lda gameover_screen,y
    jsr CHROUT
    iny
    cpy #105                		; 110 characters in the title screen
    bne gameover_loop
    jsr gameover_wait
gameover_wait
    jsr reset_key_scan
    jsr GETIN            			; pressing any input ends title screen
    beq gameover_wait
    rts
gameover_screen
    dc.b "    SELFISH  BRIAN", $0d, $0d
	dc.b "      YOU  DIED", $0d, $0d,
    dc.b "      RONAN RN", $0d, $0d
	dc.b "        ALFA Z", $0d, $0d
	dc.b "      NIELSON T", $0d, $0d
	dc.b "   PRESS ANY BUTTON"
    rts
;------------------------------------------------------------------
;   victory screen
;------------------------------------------------------------------
victory                             ; called if player wins
    jsr setup_screen
victory_loop							
    lda victory_screen,y
    jsr CHROUT
    iny
    cpy #69                 		; 85 characters in victory screen
    bne victory_loop
    jsr victory_wait
victory_wait
    jsr GETIN            			; pressing any input ends title screen
    beq victory_wait
    rts
victory_screen
	dc.b $0d, $0d
	dc.b "       YOU  WIN", $0d
	dc.b $0d, $0d, $0d, $0d
	dc.b "      RONAN RN", $0d, $0d
    dc.b "        ALFA Z", $0d, $0d
    dc.b "      NIELSON T"
    rts