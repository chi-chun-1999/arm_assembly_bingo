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
	IMPORT 	ui_draw_circle
	IMPORT 	ui_draw_number
	IMPORT 	bingo_init_board
	IMPORT 	init_2dArray
	IMPORT 	c_bingo_circle
	IMPORT 	c_get_select_number

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

	LDR 	r0, =clear
	SWI 	&2


	;start game
	;LDR 	r0, =filename
	;MOV 	r1, sp	
	;LDR 	r2, 	=&00013e1
	;BL 	read_file
	;LDR 	r0, =String1
	;SWI 	&2
	;LDR 	r0, =shine
	;SWI 	&2
	;SWI 	&4

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

	SUB 	r0, fp, #100
	SUB 	r1, fp, #200
	BL 	ui_draw_all_board

	BL 	c_get_select_number


	MOV 	r2, r0
	SUB 	r0, fp, #100
	SUB 	r1, fp, #200
	BL 	c_bingo_circle

	BL 	c_get_select_number


	MOV 	r2, r0
	SUB 	r0, fp, #100
	SUB 	r1, fp, #200
	BL 	c_bingo_circle
	
	SWI 	SWI_Exit

	AREA  Data1, DATA
filename = "src/binga.txt",0
filename2 = "src/game.txt",0
String1 = "\033[6A\033[37C",0
add_number = "\033[5A\033[11C23\0"
add_number2 = "\033[05A\033[14C20\0"
shine = "\033[5m\0"
clear = "\033c",0
store = "\033[s",0
restore = "\033[u",0
set_color = "\033[36;47m\0"
String = "",&0a,&0d
	END

