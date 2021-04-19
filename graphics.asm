;==================================================================
;   graphics.asm	color codes: pg 270	screen & border color: pg 265
;==================================================================
;   the following file contains graphical subroutines 
;		used for rendering graphics in our game
;------------------------------------------------------------------
;	general purpose
;------------------------------------------------------------------
erase
	lda #00
	sta SCREEN_MEM,x
	sta COLOUR_MEM,x
	rts
clear_screen					; clear the screen
	ldx #00
clear_screen_loop
	lda #00						; screen code empty block
	sta SCREEN_MEM,x
	lda #01
	sta COLOUR_MEM,x
	inx
	cpx #242
	bne clear_screen_loop
	rts
;------------------------------------------------------------------
;	player subroutines
;------------------------------------------------------------------
player_offset
	dc.b #0, #1, #22, #23
erase_player
	jsr get_player_pos
	lda #00						; screen code for empty block
	sta SCREEN_MEM,x			; erase player's previous screen location
	sta SCREEN_MEM,x+1			; erase player's previous screen location
	; lda #01						; screen code for empty block
	; sta COLOUR_MEM,x			; erase player's previous screen location
	; sta COLOUR_MEM,x+1			; erase player's previous screen location
	rts
colour_player
	lda PLAYER_COLOR						; load colour code #00 = black
	sta COLOUR_MEM,x			; erase player's previous screen location
	sta COLOUR_MEM,x+1			; erase player's previous screen location
	rts
draw_player_move_left
	jsr get_player_pos
	lda #2	 
	sta SCREEN_MEM,x
	lda #3
	sta SCREEN_MEM,x+1
	jsr colour_player
	rts
draw_player_move_right
	jsr get_player_pos
	lda #4
	sta SCREEN_MEM,x
	lda #5
	sta SCREEN_MEM,x+1
	jsr colour_player
	rts
draw_player_jump
	jsr get_player_pos
	lda PLAYER_DIR
	cmp #00
	beq draw_player_jump_left
	cmp #01
	beq draw_player_jump_right
	rts
draw_player_jump_left
	jsr get_player_pos
	lda #6
	sta SCREEN_MEM,x
	lda #7
	sta SCREEN_MEM,x+1
	jsr colour_player		
	rts
draw_player_jump_right
	jsr get_player_pos
	lda #8	
	sta SCREEN_MEM,x
	lda #9
	sta SCREEN_MEM,x+1
	jsr colour_player			
	rts
draw_player_fall
	lda PLAYER_DIR
	cmp #0
	beq draw_player_fall_left
	cmp #1
	beq draw_player_fall_right
	rts
draw_player_fall_left
	jsr get_player_pos
	lda #10
	sta SCREEN_MEM,x
	lda #11
	sta SCREEN_MEM,x+1
	jsr colour_player
	rts
draw_player_fall_right
	jsr get_player_pos
	lda #12
	sta SCREEN_MEM,x
	lda #13
	sta SCREEN_MEM,x+1
	jsr colour_player
	rts
erase_player_health
	lda #00
	sta SCREEN_MEM,x
	sta SCREEN_MEM,x+1
	sta SCREEN_MEM,x+2
	lda #01
	sta COLOUR_MEM,x
	sta COLOUR_MEM,x+1
	sta COLOUR_MEM,x+2
	rts
draw_player_health
					; screen code for heart
	ldy #00
draw_player_health_loop
	ldx hearts,y	
	lda #1
	sta SCREEN_MEM,x	; draw first heart
	lda #2
	sta COLOUR_MEM,x	; draw first heart
	iny
	cpy PLAYER_HEALTH
	bne draw_player_health_loop
	rts
hearts
	dc.b #0, #1, #2
inx_iny
	inx
	iny
	rts
print_score
	; print current score
	clc
	lda SCORE_1
	cmp #10
	beq score_add_10
	
	lda SCORE_2
	adc #20
	ldx #20
	sta SCREEN_MEM,x
	lda SCORE_1
	adc #20
	inx
	sta SCREEN_MEM,x
	rts

score_add_10
	clc
	lda SCORE_2
	adc #1
	sta SCORE_2
	lda #0
	sta SCORE_1
	rts
;------------------------------------------------------------------
;   world subroutines
;------------------------------------------------------------------

draw_jungle_00
	jsr jungle_platform
	ldy #00
draw_jungle_00_loop
	ldx platform_jungle_1,y
	jsr draw_platform
	cpy #22
	bne draw_jungle_00_loop

draw_jungle_00_banana
	JSR collectible_code
	LDY #22
draw_jungle_00_banana_loop
	LDX platform_jungle_1,y
	JSR draw_platform
	CPY #23
	BNE draw_jungle_00_banana_loop
	rts	

draw_jungle_01
	jsr jungle_platform
	ldy #00
draw_jungle_01_loop
	ldx platform_jungle_2,y
	jsr draw_platform
	cpy #27
	bne draw_jungle_01_loop
	rts

draw_jungle_02
	jsr jungle_platform
	ldy #00

draw_jungle_02_loop
	ldx platform_jungle_3,y
	jsr draw_platform
	cpy #19
	bne draw_jungle_02_loop
	JSR draw_row_spikes
	JSR collectible_code
	ldy #19
draw_jungle_02_banana_loop
	LDX platform_jungle_3,y
	jsr draw_platform
	cpy #20
	BNE draw_jungle_02_banana_loop
	rts

draw_jungle_03
	jsr jungle_platform
	ldy #00
draw_jungle_03_loop
	ldx platform_jungle_4,y
	jsr draw_platform
	cpy #15
	bne draw_jungle_03_loop
	jsr	draw_row_spikes
	JSR collectible_code
	ldy #15
draw_jungle_03_banana_loop
	LDX platform_jungle_4,y
	jsr draw_platform
	cpy #16
	BNE draw_jungle_03_banana_loop
	rts

draw_jungle_04
	jsr jungle_platform
	ldy #00
draw_jungle_04_loop
	ldx platform_jungle_5,y
	jsr draw_platform
	cpy #20
	bne draw_jungle_04_loop
	rts	


; DESERT

draw_desert_00
	jsr desert_platform
	ldy #00
draw_desert_00_loop
	ldx platform_desert_00,y
	jsr draw_platform
	cpy #24
	bne draw_desert_00_loop
	jsr spike_platform
	ldy #24
draw_desert_00_spikes_loop
	ldx platform_desert_00,y
	jsr draw_platform
	cpy #26
	bne draw_desert_00_spikes_loop
	jsr collectible_code
	ldy #26
draw_desert_00_bananas_loop
	ldx platform_desert_00,y
	jsr draw_platform
	cpy #28
	bne draw_desert_00_bananas_loop
	rts

draw_desert_01
	jsr desert_platform
	ldy #00
draw_desert_01_loop
	ldx platform_desert_01,y
	jsr draw_platform
	cpy #23
	bne draw_desert_01_loop
	jsr spike_platform
	ldy #23
draw_desert_01_spikes_loop
	ldx platform_desert_01,y
	jsr draw_platform
	cpy #25
	bne draw_desert_01_spikes_loop
	jsr collectible_code
	ldy #25
draw_desert_01_bananas_loop
	ldx platform_desert_01,y
	jsr draw_platform
	cpy #26
	bne draw_desert_01_bananas_loop
	rts

draw_desert_02
	jsr desert_platform
	ldy #00
draw_desert_02_loop
	ldx platform_desert_02,y
	jsr draw_platform
	cpy #17
	bne draw_desert_02_loop
	jsr spike_platform
	ldy #17
draw_desert_02_spikes_loop
	ldx platform_desert_02,y
	jsr draw_platform
	cpy #19
	bne draw_desert_02_spikes_loop
	jsr collectible_code
	ldy #19
draw_desert_02_bananas_loop
	ldx platform_desert_02,y
	jsr draw_platform
	cpy #21
	bne draw_desert_02_bananas_loop
	rts
	

draw_desert_03
	jsr desert_platform
	ldy #00
draw_desert_03_loop
	ldx platform_desert_03,y
	jsr draw_platform
	cpy #15
	bne draw_desert_03_loop
	jsr spike_platform
	ldy #15
draw_desert_03_spikes_loop
	ldx platform_desert_03,y
	jsr draw_platform
	cpy #17
	bne draw_desert_03_spikes_loop
	jsr collectible_code
	ldy #17
draw_desert_03_bananas_loop
	ldx platform_desert_03,y
	jsr draw_platform
	cpy #19
	bne draw_desert_03_bananas_loop
	rts
	
draw_desert_04
	jsr desert_platform
	ldy #00
draw_desert_04_loop
	ldx platform_desert_04,y
	jsr draw_platform
	cpy #17
	bne draw_desert_04_loop
	jsr spike_platform
	ldy #17
draw_desert_04_spikes_loop
	ldx platform_desert_04,y
	jsr draw_platform
	cpy #22
	bne draw_desert_04_spikes_loop
	jsr collectible_code
	ldy #22
draw_desert_04_bananas_loop
	ldx platform_desert_04,y
	jsr draw_platform
	cpy #23
	bne draw_desert_04_bananas_loop
	rts

; ICE

draw_ice_00
	lda #1
	sta COLOUR_CODE
	jsr draw_row_spikes
	jsr ice_platform
	ldy #00
draw_ice_00_loop
	ldx platform_ice_1,y
	jsr draw_platform
	cpy #24
	bne draw_ice_00_loop
	JSR collectible_code
	ldy #24
draw_ice_00_banana_loop
	ldx platform_ice_1,y
	jsr draw_platform
	cpy #25
	bne draw_ice_00_banana_loop
	rts

draw_ice_01
	lda #1
	sta COLOUR_CODE
	jsr draw_row_spikes
	jsr ice_platform
	ldy #00
draw_ice_01_loop
	ldx platform_ice_2,y
	jsr draw_platform
	cpy #19
	bne draw_ice_01_loop
	JSR collectible_code
	ldy #19
draw_ice_01_banana_loop
	ldx platform_ice_2,y
	jsr draw_platform
	cpy #20
	bne draw_ice_01_banana_loop
	rts

draw_ice_02
	jsr ice_platform
	ldy #00
draw_ice_02_loop
	ldx platform_ice_3,y
	jsr draw_platform
	cpy #12
	bne draw_ice_02_loop
	jsr draw_row_spikes
	JSR collectible_code
	ldy #12
draw_ice_02_banana_loop
	ldx platform_ice_3,y
	jsr draw_platform
	cpy #13
	bne draw_ice_02_banana_loop
	rts

draw_ice_03
	jsr ice_platform
	ldy #00
draw_ice_03_loop
	ldx platform_ice_4,y
	jsr draw_platform
	cpy #8
	bne draw_ice_03_loop
	jsr draw_row_spikes
	JSR collectible_code
	ldy #8
draw_ice_03_banana_loop
	ldx platform_ice_4,y
	jsr draw_platform
	cpy #9
	bne draw_ice_03_banana_loop
	rts

draw_ice_04
	jsr ice_platform
	ldy #00
draw_ice_04_loop
	ldx platform_ice_5,y
	jsr draw_platform
	cpy #8
	bne draw_ice_04_loop
	jsr draw_row_spikes
	rts


; LAVA

draw_lava_00
	lda #2
	sta COLOUR_CODE
	jsr draw_row_spikes
	jsr lava_platform
	ldy #00
draw_lava_00_loop
	ldx platform_lava_00,y
	jsr draw_platform
	cpy #10
	bne draw_lava_00_loop
	lda #00
	sta SCREEN_MEM+237
	jsr collectible_code
	ldy #10
	ldx platform_lava_00,y
	jsr draw_platform
	rts

draw_lava_01
	jsr lava_platform
	ldy #00
draw_lava_01_loop
	ldx platform_lava_01,y
	jsr draw_platform
	cpy #14
	bne draw_lava_01_loop
	lda #2
	sta COLOUR_CODE
	jsr draw_row_spikes
	rts

draw_lava_02
	jsr lava_platform
	ldy #00
draw_lava_02_loop
	ldx platform_lava_02,y
	jsr draw_platform
	cpy #7
	bne draw_lava_02_loop
	lda #2
	sta COLOUR_CODE
	jsr draw_row_spikes
	rts

draw_lava_03
	jsr lava_platform
	ldy #00
draw_lava_03_loop
	ldx platform_lava_03,y
	jsr draw_platform
	cpy #7
	bne draw_lava_03_loop
	lda #2
	sta COLOUR_CODE
	jsr draw_row_spikes
	rts
	
draw_lava_04
	jsr lava_platform
	ldy #00
draw_lava_04_loop
	ldx platform_lava_04,y
	jsr draw_platform
	cpy #06
	bne draw_lava_04_loop
	lda #2
	sta COLOUR_CODE
	jsr draw_row_spikes
	rts

; FULL ROW OF SPIKES
draw_row_spikes
    jsr spike_platform
    ldx #220
draw_spikes_loop
    jsr draw_platform
    inx
    cpx #242
    bne draw_spikes_loop
    rts

draw_platform
	lda SCREEN_CODE
	sta SCREEN_MEM,x
	lda COLOUR_CODE
	sta COLOUR_MEM,x
	iny
	rts
