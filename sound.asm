;==================================================================
; 	sound.asm	sound & music: notes pg 266 sound & music pg 95-106
;==================================================================
;   the following file contains subroutines 
;	related to/for playing music and sounds in our game
;==================================================================
;   macros
;==================================================================
SPEAKER1			equ $900a
SPEAKER2			equ $900b
SPEAKER3			equ $900c
NOISE				equ $900d
VOLUME				equ $900e
;==================================================================
;   macros
;==================================================================
play_music					; called by game loop play music
	lda MUSIC				; what music to play
	cmp #00					; if MUISC==0 play game music
	beq play_game_music
	cmp #01					; if MUISC==1 play boss music
	beq play_boss_music
	cmp #02					; if MUISC==2 play death music
	beq play_death_music
	cmp #03					; if MUISC==3 play victory music
	beq play_victory_music
	rts
play_game_music				; play the main music
	ldx NOTE2				; index of note being played in the song
	lda game_music,x		; get the note
	sta SPEAKER2
	inx
	stx NOTE2
	cpx #42					; number of notes in game music
	beq reset_music
	rts
play_boss_music
	ldx NOTE2				; index of note being played in the song
	lda boss_music,x 		; get the note
	sta SPEAKER2
	inx
	stx NOTE2
	cpx #42					; number of notes in boss music
	beq reset_music			; if playing last note reset music
	rts
play_death_music			; play death music if player dies :)
	ldx NOTE2				; index of note being played in the song
	lda death_music,x 		; get the current note from 
	sta SPEAKER2
	inx
	stx NOTE2
	cpx #42					; number of notes in death music
	beq reset_music
	rts
play_victory_music			; play victory music if player wins
	ldx NOTE2				; index of note being played in the song
	lda victory_music,x 	; get the note
	sta SPEAKER2
	inx
	stx NOTE2
	cpx #42					; number of notes in victory music
	beq reset_music
	rts
reset_music					; called by play_<>_music subroutines
	lda #00					; to reset the note index of the song
	sta NOTE2
	rts
;------------------------------------------------------------------
;	player action sound
;------------------------------------------------------------------
move_sound					; called when the player does something
	lda #195				; load B into NOTE1
	sta NOTE1				; the note duration will be equal to 
	sta SPEAKER3
	rts						; one gameloop cycle
jump_sound					; called when the player does something
	lda #195				; load B into NOTE1
	sta NOTE1				; the note duration will be equal to 
	sta SPEAKER3
	rts						; one gameloop cycle
damage_sound
	lda #195				; load B into NOTE1
	sta NOTE1				; the note duration will be equal to 
	sta SPEAKER1
	lda #200				; load B into NOTE1
	sta NOTE3				; the note duration will be equal to 
	sta SPEAKER3
	rts
reset_sound					; called to reset player sound
	lda #00
	sta NOTE1
	sta NOTE3
	sta SPEAKER1
	sta SPEAKER3
	rts
;------------------------------------------------------------------
;	sound & music data
;------------------------------------------------------------------
game_music
	dc.b #195, #195, #215, #215, #219, #219, #215, #209, #209, #207, #207, #201, #201, #195, #215, #215, #209, #209, #207, #207, #201, #215, #215, #209, #209, #207, #207, #201, #195, #195, #215, #215, #219, #219, #215, #209, #209, #209, #207, #207, #201, #201, #195
boss_music
death_music
victory_music