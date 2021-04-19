;==================================================================
;   collision.asm
;==================================================================
;   this file contains player collision subroutines
;------------------------------------------------------------------
player_collision_offset
	dc.b #2, #22, #23
;------------------------------------------------------------------
;   horizontal collision subroutines
;------------------------------------------------------------------
empty_space_collision
	lda #00
	sta SCREEN_CODE
	rts
damage_collision
	jsr spike_collision
	rts
update_health
	ldx PLAYER_HEALTH
	dex
	stx PLAYER_HEALTH
	jsr erase_player_health
	jsr draw_player_health
	rts
take_damage
	ldx GOD_MODE
	cpx #1
	beq take_damage_end
	ldx IFRAME
	cpx #0
	beq damage
take_damage_end
	rts
damage
	lda #3						; reset the iframe after taking damage
	sta IFRAME				; iframe is decremented in game.asm in gameloop
	jsr damage_sound
	jsr shake_screen
	jsr update_health
	rts
spike_collision
	lda #18
	sta SCREEN_CODE
	jsr get_player_pos
	lda SCREEN_MEM,x+22
	cmp SCREEN_CODE
	beq take_damage
	lda SCREEN_MEM,x+23
	cmp SCREEN_CODE
	beq take_damage
	rts
update_score
	ldx SCORE_1
	inx  
	stx SCORE_1
	rts
left_collision
	ldx PLAYER_X
	cpx #00							; if at left side of screen return
	beq collision_true
	jsr get_player_pos
	dex
	lda SCREEN_MEM,x
	cmp SCREEN_CODE
	bne collision_true
	jsr collision_false
	rts
right_collision
	lda PLAYER_X
	cmp #20							; if at left side of screen return
	bne right_collision_continue	; go to the next level
	jsr next_level
	rts
right_collision_continue
	jsr get_player_pos
	lda SCREEN_MEM,x+2
	cmp SCREEN_CODE
	bne collision_true
	jsr collision_false
	rts
;------------------------------------------------------------------
;   player collision subroutines
;------------------------------------------------------------------
collision_false
	lda #0
	rts
collision_true
	lda #1
	rts
;------------------------------------------------------------------
;   vertical collision subroutines
;------------------------------------------------------------------
top_collision
	lda PLAYER_Y
	cmp #00
	beq collision_true
	jsr get_player_pos
	jsr subtract
	lda SCREEN_MEM,x
	cmp SCREEN_CODE
	bne collision_true
	lda SCREEN_MEM,x+1
	cmp SCREEN_CODE
	bne collision_true
	jsr collision_false
	rts
bottom_collision
	jsr get_player_pos
	lda SCREEN_MEM,x+22
	cmp SCREEN_CODE
	bne collision_true
	lda SCREEN_MEM,x+23
	cmp SCREEN_CODE
	bne collision_true
	jsr collision_false
	rts
