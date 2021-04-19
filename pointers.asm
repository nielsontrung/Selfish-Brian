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
;   basic stub
;==================================================================
; address equ 7168
    ; lda #$00
    ; sta $01

    ; sta $fe
    ; lda #$1e
    ; sta $02

    ; lda #$96
    ; sta $ff
    ; ldy #$00
    ; lda #$66

    ; sta ($01),y

    ; lda #$0a
    ; sta ($fe),y

    ; iny
    ; cpy
    ; bne $1210
    ; brk
    lda label1
    sta $06
    lda label1
    sta $07
    ldx #$01
    lda ($00,x)

;     lda 300    
;     inc

labels
    dc.w label1, label2

label1
    dc.b #1, #2, #3

label2
    dc.b #4, #5, #6