;==================================================================
;   levels.asm screen & border color: pg 265
;==================================================================	
next_level
	lda LEVEL
	cmp #19
	bne next_level_continue
	jsr victory
	jmp init
	rts
next_level_continue
	ldx LEVEL
	inx	
	stx	LEVEL 
	jsr clear_screen	
	jsr load_level
	jsr draw_player_health
	jsr print_score
	ldx #00
	dex
	stx PLAYER_X
	jsr draw_player_move_right
	rts
load_level
	lda LEVEL
	cmp #0
	beq load_screen_1
	cmp #1
	beq load_screen_2
	cmp #2
	beq load_screen_3
	cmp #3
	beq load_screen_4
	cmp #4
	beq load_screen_5
	cmp #5
	beq load_screen_6
	cmp #6
	beq load_screen_7
	cmp #7
	beq load_screen_8
	cmp #8
	beq load_screen_9
	cmp #9
	beq load_screen_10
	cmp #10
	beq load_screen_11
	cmp #11
	beq load_screen_12
	cmp #12
	beq load_screen_13
	cmp #13
	beq load_screen_14
	cmp #14
	beq load_screen_15
	cmp #15
	beq load_screen_16
	cmp #16
	beq load_screen_17
	cmp #17
	beq load_screen_18
	cmp #18
	beq load_screen_19
	cmp #19
	beq load_screen_20
	rts
load_screen_1
	jsr draw_jungle_00
	rts
load_screen_2
	jsr draw_jungle_01
	rts
load_screen_3
	jsr draw_jungle_02
	rts
load_screen_4
	jsr draw_jungle_03
	rts
load_screen_5
	jsr draw_jungle_04
	rts
load_screen_6
	lda #143
	sta $900f
	jsr draw_desert_00
	rts
load_screen_7
	jsr draw_desert_01
	rts
load_screen_8
	jsr draw_desert_02
	rts
load_screen_9
	jsr draw_desert_03
	rts
load_screen_10
	jsr draw_desert_04
	rts
load_screen_11
	lda #187					
	sta $900f
	jsr draw_ice_00
	rts
load_screen_12
	jsr draw_ice_01
	rts
load_screen_13
	jsr draw_ice_02
	rts
load_screen_14
	jsr draw_ice_03
	rts
load_screen_15
	jsr draw_ice_04
	rts
load_screen_16
	lda #168
	sta $900f
	lda #0
	sta PLAYER_COLOR
	jsr draw_lava_00
	rts
load_screen_17
	jsr draw_lava_01
	rts
load_screen_18
	jsr draw_lava_02
	rts
load_screen_19
	jsr draw_lava_03
	rts
load_screen_20
	jsr draw_lava_04
	rts
;==================================================================
;	platform data
;==================================================================
jungle_platform
	lda #14
	sta SCREEN_CODE
	lda #05
	sta COLOUR_CODE
	rts
ice_platform
	lda #15
	sta SCREEN_CODE
	lda #1
	sta COLOUR_CODE
	rts
desert_platform
	lda #16
	sta SCREEN_CODE
	lda #7
	sta COLOUR_CODE
	rts
lava_platform
	lda #17
	sta SCREEN_CODE
	lda #0
	sta COLOUR_CODE
	rts
spike_platform
	lda #18
	sta SCREEN_CODE
	;lda #5
	;sta COLOUR_CODE
	rts
collectible_code
	lda #19
	sta SCREEN_CODE
	lda #7
	sta COLOUR_CODE
	rts
;==================================================================
;	platform data
;==================================================================
platform_jungle_1
	dc.b #197, #196, #195, #194, #176, #177, #66, #67, #68, #69, #70, #118, #119, #120, #121, #122, #123, #124, #125, #87, #86, #85 ; 22 platform
	dc.b #154  ; 1 banana

platform_jungle_2
	dc.b #47, #46, #45, #44, #72, #73, #74, #75, #76, #77, #78, #79, #80, #129, #130, #131, #169, #168, #167, #166, #165, #181, #180, #133, #132, #182, #81

platform_jungle_3
	dc.b #110, #111, #113, #112, #160, #161, #162, #163, #164, #101, #102, #103, #53, #52, #54, #63, #64, #65, #62 ; 19 platform
	dc.b #31 ;	1 banana
    
platform_jungle_4
    dc.b #44, #45, #46, #47, #131, #130, #141, #95, #94, #142, #78, #79, #169, #170, #61, #39 ; 16
    
platform_jungle_5
	dc.b #110, #178, #179, #180, #181, #65, #105, #103, #104, #118, #77, #71, #87, #109, #131, #153, #175, #197, #219, #241 ; 20

platform_ice_1
	dc.b #220, #221, #227, #228, #222, #223, #224, #225, #226, #241, #219, #197, #175, #153, #152, #174, #196, #218, #240, #187, #188, #140, #93, #170 
	dc.b #71; 24

platform_ice_2
	dc.b #132, #133, #154, #176, #220, #177, #199, #155, #159, #86, #87, #85, #198, #221, #182, #143, #103, #216, #191 
	dc.b #128; 19

platform_ice_3
	dc.b #201, #202, #219, #218, #161, #114, #52, #56, #103, #62, #144, #171
	dc.b #30 ; 12

platform_ice_4
	dc.b #201, #161, #162, #122, #123, #53, #83, #87 
	dc.b #31; 8

platform_ice_5
	dc.b #87, #203, #163, #164, #94, #55, #125, #61 ; 8

;LAVA
platform_lava_00
	dc.b #178, #138, #91, #51, #100, #60, #148, #192, #238, #197 ; 10
	dc.b #170 ; 1 banana
	
platform_lava_01
	dc.b #176, #177, #113, #114, #49, #50, #112, #205, #141, #142, #146, #150, #151, #153 ; 14
platform_lava_02
	dc.b #198, #203, #163, #101, #215, #175, #168 ; 7
platform_lava_03
	dc.b #89, #202, #139, #76, #213, #217, #153 ; 7
platform_lava_04
	dc.b #203, #176, #208, #213, #173, #131 ; 6

platform_desert_00
	dc.b #198, #199, #200, #135, #136, #73, #74, #183, #184, #209, #210, #211, #77, #78, #79, #215, #216, #103, #104, #85, #86, #87, #197, #196
	dc.b #240, #241 ; 24, 2 spikes
	dc.b #221, #239 ; 2 bananas
platform_desert_01
	dc.b #132, #133, #134, #203, #204, #205, #206, #207, #208, #209, #210, #211, #212, #202, #95, #96, #99, #100, #171, #172, #173, #153, #152
	dc.b #240, #241 ; 23, 2 spikes
	dc.b #74 ; 1 banana
platform_desert_02
	dc.b #132, #133, #134, #135, #136, #137, #184, #185, #186, #187, #190, #191, #192, #195, #196, #153, #125
	dc.b #224, #225 ; 17, 2 spikes
	dc.b #220, #103 ; 1 banana
platform_desert_03
	dc.b #132, #178, #179, #180, #206, #207, #208, #141, #78, #197, #196, #195, #194, #192, #193
	dc.b #236, #237 ; 15, 2 spikes
	dc.b #56, #119 ; 2 bananas
platform_desert_04
	dc.b #182, #183, #116, #51, #52, #53, #99, #100, #56, #101, #59, #60, #61, #62, #63, #64, #65
	dc.b #232, #234, #236, #238, #240 ; 18, 5 spikes
	dc.b #78 ; 1 banana
