;***************************
;local variable
;
; fp-100: int my_board[5][5]
; fp-200: int enemy_board[5][5]
; fp-300: int select_board[25]
; fp-304: int my_line
; fp-308: int emeny_line
;

	AREA  Program,CODE, READONLY ; name this block of code
SWI_Exit EQU 0x11 ; tidy finish
SWI_Clock EQU 0x61
SWI_Open EQU 0x66
SWI_Close EQU 0x68
SWI_Write EQU 0x69
SWI_RdStr EQU 0x6a
write_only EQU 4 ; mode 4 = open to write
read_only  EQU 1

	IMPORT 	read_file
	IMPORT 	ui_draw_all_board
	IMPORT 	bingo_init_board
	IMPORT 	init_1dArray
	IMPORT 	init_2dArray
	IMPORT 	set_order_1dArray
	IMPORT 	c_bingo_circle
	IMPORT 	c_get_select_number
	IMPORT 	tc_get_select_number
	IMPORT 	c_enemy_select_number
	IMPORT 	tc_enemy_select_number
	IMPORT 	bingo_enemy_select_number
	IMPORT 	printf_dec
	IMPORT 	bingo_detect_line
	IMPORT 	cursor_store
	IMPORT 	cursor_restore
	IMPORT cursor_set_none	
	IMPORT 	ui_draw_static
	IMPORT 	sleep

	ENTRY 	; mark first instruction

Main

	MOV 	fp, sp

	MOV 	r0, #0 
	MOV 	r1, #5
	MOV 	r2, #5
	BL 	init_2dArray

	MOV 	r0, #0 
	MOV 	r1, #5
	MOV 	r2, #5
	BL 	init_2dArray

	MOV 	r0, #0 
	MOV 	r1, #25
	BL 	init_1dArray

	MOV 	r0, #0
	STMFD 	sp!, {r0}
	MOV 	r0, #0
	STMFD 	sp!, {r0}

	LDR 	r0, =clear
	SWI 	&2

	LDR 	r0, =clear
	SWI 	&2

	LDR 	r0, =filename2
	MOV 	r1, sp	
	LDR 	r2, 	=&0000b52
	BL 	read_file

	SUB 	r0, fp, #100
	BL 	bingo_init_board
	SUB 	r0, fp, #200
	BL 	bingo_init_board

	SUB 	r0, fp, #300
	MOV 	r1, #25
	MOV 	r2, #1
	BL 	set_order_1dArray

	SUB 	r0, fp, #100
	SUB 	r1, fp, #200
	BL 	ui_draw_all_board

	MOV 	r5, #0
Loop
	CMP 	r5, #11
	BEQ 	EndLoop
	
	;------user select-----
	SUB 	r0, fp, #300
	BL 	tc_get_select_number

	MOV 	r3, r0
	SUB 	r0, fp, #100
	SUB 	r1, fp, #200
	SUB 	r2, fp, #300
	BL 	c_bingo_circle

	;------show static
	BL 	cursor_store
	SUB 	r0, fp, #100
	BL 	bingo_detect_line
	STR 	r0, [fp, #-304]
	MOV 	r1, #11
	MOV 	r2, #3
	MOV 	r3, #0
	BL 	ui_draw_static

	SUB 	r0, fp, #200
	BL 	bingo_detect_line
	STR 	r0, [fp, #-308]
	MOV 	r1, #48
	MOV 	r2, #3
	MOV 	r3, #1
	BL 	ui_draw_static
	BL 	cursor_restore

	LDR 	r0, [fp, #-304]
	LDR 	r1, [fp, #-308]
	CMP 	r0, #5
	BGE 	Summarize
	CMP 	r1, #5
	BGE 	Summarize

	;------enemy select-----
	SUB 	r0, fp, #300
	BL 	tc_enemy_select_number

	MOV 	r3, r0
	SUB 	r0, fp, #100
	SUB 	r1, fp, #200
	SUB 	r2, fp, #300
	BL 	c_bingo_circle

	;------show static
	BL 	cursor_store
	SUB 	r0, fp, #100
	BL 	bingo_detect_line
	STR 	r0, [fp, #-304]
	MOV 	r1, #11
	MOV 	r2, #3
	MOV 	r3, #0
	BL 	ui_draw_static

	SUB 	r0, fp, #200
	BL 	bingo_detect_line
	STR 	r0, [fp, #-308]
	MOV 	r1, #48
	MOV 	r2, #3
	MOV 	r3, #1
	BL 	ui_draw_static
	BL 	cursor_restore

	LDR 	r0, [fp, #-304]
	LDR 	r1, [fp, #-308]
	CMP 	r0, #5
	BGE 	Summarize
	CMP 	r1, #5
	BGE 	Summarize
	
	ADD 	r5, r5, #1
	B 	Loop
EndLoop
	B 	Tie

Summarize
	CMP 	r0, r1
	BEQ 	Tie
	BLT 	Lose

	LDR 	r0, =clear
	SWI 	&2
	LDR 	r0, =filenameWin
	MOV 	r1, sp	
	LDR 	r2, 	=&00000e41
	BL 	read_file

	B 	EndGame
Tie 	
	LDR 	r0, =clear
	SWI 	&2
	LDR 	r0, =filenameTie
	MOV 	r1, sp	
	LDR 	r2, 	=&00000dc4
	BL 	read_file
	B 	EndGame
Lose
	LDR 	r0, =clear
	SWI 	&2
	LDR 	r0, =filenameLose
	MOV 	r1, sp	
	LDR 	r2, 	=&00000fb8
	BL 	read_file
	B 	EndGame
 	
	

	;SUB 	r0, fp, #100
	;BL 	bingo_detect_line
	;BL 	printf_dec
	;LDR 	r0, =MyBoardline
	;SWI 	&2

	;SUB 	r0, fp, #200
	;BL 	bingo_detect_line
	;BL 	printf_dec
	;LDR 	r0, =EnemyBoardline
	;SWI 	&2

EndGame
	MOV 	r0, #2
	BL 	sleep
	LDR 	r0, =clear
	SWI 	&2
	LDR 	r0, =filenameEnd
	MOV 	r1, sp	
	LDR 	r2, 	=&00000be2
	BL 	read_file
	BL 	cursor_set_none

	SWI 	&4
	SWI 	SWI_Exit

	AREA  Data1, DATA
filename = "src/binga.txt",0
filename2 = "src/game.txt",0
filenameWin = "src/win.txt",0
filenameLose = "src/lose.txt",0
filenameTie = "src/tie.txt",0
filenameEnd = "src/end.txt",0
String1 = "\033[6A\033[37C",0
add_number = "\033[5A\033[11C23\0"
add_number2 = "\033[05A\033[14C20\0"
shine = "\033[5m\0"
clear = "\033c",0
store = "\033[s",0
restore = "\033[u",0
set_color = "\033[36;47m\0"
MyBoardline = " <-- My board line\n\0"
EnemyBoardline = " <-- Enemy board line\n\0"
WinStr = "----Win Win Win----\n\0"
LoseStr = "----Lose Lose Lose----\n\0"
TieStr = "----Tie Tie Tie----\n\0"
	END


