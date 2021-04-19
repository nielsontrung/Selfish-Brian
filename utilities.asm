;==================================================================
;   utilities.asm
;==================================================================
;   the following file contains general purpose subroutines 
;	used in our game logic
;------------------------------------------------------------------
subtract
	sec
	sbc #22
	tax
	rts
add
	clc
	adc #22
	tax
	rts
get_player_pos
	clc	
	lda PLAYER_Y
	adc PLAYER_X
	sta PLAYER_POS
	tax
	rts
timer
	ldy #00
timer_loop_1
	iny	
    ldx #00
timer_loop_2
	inx
	cpx #100
	bne timer_loop_2
	cpy	#100
	bne timer_loop_1
	rts