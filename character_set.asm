;==================================================================
;   character_set.asm pg 175
;==================================================================
;   the following file contains custom 
;   character bit maps designed and used in our game
;   screen code mem starts at 7168 screen mem starts at 7680
;   only 64 programable characters
;------------------------------------------------------------------
   org 7168                       
character_set                       ;   code  character
;==================================================================
;   misc
;==================================================================
    hex 00 00 00 00 00 00 00 00     ;   0     empty block
    hex 00 00 00 00 00 00 00 00     ;         empty block
    hex 00 44 ee fe fe 7c 38 10     ;   1     heart
    hex 00 00 00 00 00 00 00 00     ;         empty block
;==================================================================
;   brian
;==================================================================
    hex 05 03 07 08 0d 08 04 6f     ;   2 moving-rightside reverse
    hex 7f 7b 33 07 0f 0c 0e 06
    hex 00 80 c0 e0 60 60 40 f0     ;   3 moving-leftside reverse
    hex f8 dc cc c0 e0 f8 38 00
    hex 00 01 03 07 06 06 02 0f     ;   4 moving-rightside
    hex 1f 3b 33 03 07 1f 1c 00
    hex a0 c0 e0 10 b0 10 20 f6     ;   5 moving-leftside
    hex fe de cc e0 f0 30 70 60
    hex 05 03 07 08 0d 68 74 3f     ;   6 jumping-leftside reverse
    hex 1f 07 03 07 0f 0e 07 03
    hex 00 80 c0 e0 60 60 40 f0     ;   7 jumping-rightside reverse
    hex f8 dc cc e0 f0 38 1e 06
    hex 00 01 03 07 06 06 02 0f     ;   8 jumping-leftside
    hex 1f 3b 33 07 0f 1c 78 60
    hex a0 c0 e0 10 b0 16 2e fc     ;   9 jumping-rightside
    hex f8 e0 c0 e0 f0 70 e0 c0
    hex 05 03 07 08 6d 68 74 3f     ;   10 falling-leftside reverse
    hex 1f 0f 07 0f 1f 1c 38 70
    hex 00 80 c0 e0 6c 6c 5c f8     ;   11 falling-rightside reverse
    hex f0 e0 c0 e0 f0 70 38 1c
    hex 00 01 03 07 36 36 3a 1f     ;   12 falling-leftside
    hex 0f 07 03 07 0f 0e 1c 38
    hex a0 c0 e0 10 b6 16 2e fc     ;   13 falling-rightside
    hex f8 f0 e0 f0 f8 38 1c 0e
;==================================================================
;   platforms
;==================================================================
    hex 00 00 00 bf 98 ef 37 f8     ;   14  jungle		color: 05
    hex 00 00 00 00 00 00 00 00     ;       
    hex ff a9 85 81 c5 83 91 ff     ;   15  ice			color: 06
    hex 00 00 00 00 00 00 00 00     ;       
    hex ff 81 82 f1 21 cf 89 84     ;   16	desert		color: 07
    hex e3 a1 3f 00 00 00 00 00     ;   
	hex 8f eb aa be be b6 f4 d4     ;	17	lava		color: 02
	hex d0 c0 c0 80 80 80 00 00     
    hex 00 00 00 00 00 00 00 00     ;   18  spike
    hex 00 08 08 18 1c 1c 3c ff     ;
;==================================================================
;   collectibles
;==================================================================
    hex 00 00 30 18 0c 0e 0e 0e     ;   19  banana 
    hex 0e 1c 3c 38 60 00 00 00 
;==================================================================
;   numbers & text
;==================================================================
	hex 00 3c 46 4a 5a 52 62 3c 	;	20	number "0"
	hex 00 00 00 00 00 00 00 00
	hex 00 08 38 08 08 08 08 3e 	;	21	number "1"
	hex 00 00 00 00 00 00 00 00
	hex 00 1c 22 02 04 08 10 3e  	;	22	number "2"
	hex 00 00 00 00 00 00 00 00
	hex 00 3e 02 0c 02 02 22 1c   	;	23	number "3"
	hex 00 00 00 00 00 00 00 00
	hex 00 04 0c 14 24 3e 04 04   	;	24	number "4"
	hex 00 00 00 00 00 00 00 00
	hex 00 3e 20 20 3c 02 22 1c   	;	25	number "5"
	hex 00 00 00 00 00 00 00 00
	hex 00 1c 22 20 3c 22 22 1c   	;	26	number "6"
	hex 00 00 00 00 00 00 00 00
	hex 00 3e 02 04 08 08 10 10   	;	27	number "7"
	hex 00 00 00 00 00 00 00 00
	hex 00 38 44 44 38 44 44 38   	;	28	number "8"
	hex 00 00 00 00 00 00 00 00
	hex 00 38 44 44 3c 04 44 38   	;	29	number "9"
	hex 00 00 00 00 00 00 00 00
