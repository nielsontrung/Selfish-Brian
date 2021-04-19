;==================================================================
;   game.asm
;==================================================================
;   the following file contains subroutines 
;	related to/for our game logic and loop
;------------------------------------------------------------------
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
;   game state macros	memory maps pg 115, 170
;==================================================================
SCREEN_MEM			equ 7680			; beginning of screen memory
COLOUR_MEM			equ 7680 + 30720	; beginning of colour memory
PLAYER_POS			equ 43				; player's screen memory offset
PLAYER_X				equ 44				; player's x offset
PLAYER_Y				equ 45				; player's y offset
PLAYER_DIR			equ 46				; player's horizontal diretion
PLAYER_HEALTH		equ 47				
PLAYER_COLOR		equ 48
JUMP						equ 49				; game loop variable determines if player is jumping
SCORE 					equ 50				
SCORE_1					equ 51
SCORE_2					equ 52
LEVEL						equ 53 				; current game level
NUM							equ 54				; number of platforms in a level
SCREEN_CODE			equ 55				; screen code used in collision and graphical subroutines
COLOUR_CODE			equ 56				; colour code used in graphical subroutines
NOTE1						equ 57 				; note in speaker 1
NOTE2						equ 58				; note in speaker 2
NOTE3						equ 59				; note in speaker 3
MUSIC						equ 60				; music to play: game, boss, game over...
IFRAME					equ 61				; invincibility frame
GOD_MODE				equ 62				; 1 god mode on / 0 god mode off
JUMP_HEIGHT			equ	63				; default 3 number of spaces player can jump
HORIZONTAL_VELOCITY	equ 64		; number of spaces player moves horizontally 
GRAVITY					equ #22				; 22 
;==================================================================
;   game state macros	memory maps pg 115, 170
;==================================================================
;==================================================================
;   initialize game states
;==================================================================
init
	; initialize game state variables
	jsr title					; load title screen 
	lda #44
	sta PLAYER_Y			; store offset in ram
	lda #00						; load zero
	sta PLAYER_X			; store offset in ram
	sta PLAYER_DIR		; 
	sta NOTE1					; initialize the note1 iterator
	sta NOTE2					; initialize the note2 iterator
	sta NOTE3					; initialize the note3 iterator
	sta MUSIC					; initialize current song
	sta JUMP
	sta SCORE
	sta SCORE_1				; initialize score to 00
	sta SCORE_2
	sta LEVEL					; update level memory
	sta IFRAME				; invisibility frame lasts 3 game loops after taking damage
	sta GOD_MODE			; god mode is disabled
	sta PLAYER_COLOR
	lda #1						; volume setting (0-15)
	sta VOLUME				; initialize volume
	sta HORIZONTAL_VELOCITY
	lda #3						; load
	sta JUMP_HEIGHT		; number of rows player jumps
	sta PLAYER_HEALTH	; player starts with 3 lives
	; enable 8x16 charactersize hi res graphics
	lda #%00010111		; bit 0 sets low/hi res graphics bits 1-6 #rows pg 175
	sta 36867					; switch from 8x8 to 8x16 character size
	; enable custom character set
	lda #255       		; store 255 36869 point character memory to 7168
	sta 36869     		; bits 0-3 start of character memory pg 175
										; bits 4-7 is rest of video address
	jsr CLRSCRN				; clear screen
	lda #141					; load light orange screen green border code pg 265
	sta $900F 				; set screen and border colour
	; intialize first level
	jsr clear_screen
	jsr load_level
	jsr draw_player_health
	jsr print_score
	jsr play_music
	jsr draw_player_move_right
	jmp game_loop	
;==================================================================
;   GAME LOOP
;==================================================================
game_loop
	jsr scan_key
	jsr gravity
	jsr timer
	jsr damage_collision
	jsr update_iframe
	jsr reset_sound
	jsr play_music
	jsr game_over
	jmp game_loop
endgame
	rts
;==================================================================
;   player subroutines
;==================================================================	
;   vertical movement subroutines
;------------------------------------------------------------------
update_iframe
	ldx IFRAME
	cpx #0
	bne decrement_iframe
	rts
decrement_iframe
	dex
	stx IFRAME
	rts
game_over
	lda PLAYER_HEALTH
	cmp #00
	beq goto_gameover
	rts
goto_gameover
	jsr gameover
	jsr init
	rts
got_collectible
	jsr update_score
	jsr print_score
	rts
gravity
	lda JUMP
	cmp #0
	bne jump
	jsr collectible_code
	jsr bottom_collision
	cmp #0
	beq gravity_continue_update_score
	jsr empty_space_collision
	jsr bottom_collision
	cmp #0
	beq gravity_continue
	rts
gravity_continue_update_score
	jsr got_collectible
gravity_continue
	jsr erase_player
	lda PLAYER_Y
	clc
	adc #GRAVITY
	sta PLAYER_Y
	jsr draw_player_fall
	rts
heal
	lda #03
	sta PLAYER_HEALTH
	jsr draw_player_health
	rts
move_up
	lda PLAYER_Y
	sec
	sbc #22
	sta PLAYER_Y
	rts
jump
	ldx JUMP
	cpx #0
	beq jump_up_end
	dex
	stx JUMP
	ldx NOTE1
	dex
	stx NOTE1
	jsr collectible_code
	jsr top_collision
	cmp #1
	bne jump_continue_update_score
	jsr empty_space_collision
	jsr top_collision
	cmp #1
	bne jump_continue
jump_up_end
	lda #0
	sta JUMP
	rts
jump_continue_update_score
	jsr got_collectible
jump_continue
	jsr move_sound
	jsr erase_player
	jsr move_up
	jsr draw_player_jump
	jsr timer
	rts
player_jump
	lda JUMP
	cmp #00
	beq player_jump_continue
	rts
player_jump_continue
	jsr reset_key_scan
	jsr empty_space_collision
	jsr bottom_collision
	cmp #0
	beq jump_up_end
	jsr jump_sound
	lda JUMP_HEIGHT
	sta JUMP
	rts
kill
	lda #0
	sta PLAYER_HEALTH
	rts
;------------------------------------------------------------------
;   get key press codes pg 179
;------------------------------------------------------------------
scan_key
	lda $c5                         ; check keypress mem location
	cmp #43
	beq heal
	cmp #32							; if 'Space' jump left/right
	beq player_jump
	cmp #44
	beq kill
	cmp #17                         ; if 'A' move left
	beq player_move_left
	cmp #18                         ; if 'D' move right
	beq player_move_right			
	cmp #36
	beq mute_sound_music
	cmp #19
	beq enable_god_mode
	rts
reset_key_scan
	lda #$00                        ; load 0
	sta $c5                         ; reset keypress memory
	sta $c6                         ; reset keyboard buffer memory
	rts
;------------------------------------------------------------------
;   horizontal movement subroutines
;------------------------------------------------------------------
player_move_left
	jsr reset_key_scan
	jsr collectible_code
	jsr left_collision
	cmp #0
	beq move_left_continue_update_score
	jsr empty_space_collision
	jsr left_collision
	cmp #0
	beq player_move_left_continue
	rts
move_left_continue_update_score
	jsr got_collectible
player_move_left_continue
	jsr erase_player				; erase the players previous position before drawing
	jsr move_left
	lda #00
	sta PLAYER_DIR
	jsr draw_player_move_left		; draw player moving left
	rts
player_move_right
	jsr reset_key_scan
	jsr collectible_code
	jsr right_collision
	cmp #0
	beq move_right_continue_update_score
	jsr empty_space_collision
	jsr right_collision
	cmp #0
	beq player_move_right_continue
	rts
move_right_continue_update_score
	jsr got_collectible
player_move_right_continue
	jsr erase_player				; erase the players previous position before drawing
	jsr move_right
	lda #01
	sta PLAYER_DIR
	jsr draw_player_move_right
	rts
mute_sound_music
	jsr reset_key_scan
	lda VOLUME
	cmp #0
	bne mute
	lda #1
	sta VOLUME
	rts 
enable_god_mode
	lda #1
	sta GOD_MODE
	lda #6
	sta JUMP_HEIGHT
	rts
mute
	lda #0
	sta VOLUME
	rts
move_left 
	lda PLAYER_X
	sec
	sbc HORIZONTAL_VELOCITY			; increment by horizontal velocity
	sta PLAYER_X					; update the player's new position
	rts
move_right
	clc
	lda PLAYER_X
	adc	HORIZONTAL_VELOCITY		; update players offset 
	sta PLAYER_X
	rts
;------------------------------------------------------------------
;   combat subroutines
;------------------------------------------------------------------
scan_combat_key
	lda $c5
	rts
attack
attack_left
attack_right
;==================================================================
;   include subroutines from other files
;==================================================================
	include "levels.asm"
	include "utilities.asm"
	include "collision.asm"
	include "screens.asm"
	include "graphics.asm"
	include "sound.asm"

	; check the remaining bytes in memory
	echo "Bytes remaining in program"
	echo $1c00-.

	include "character_set.asm"
