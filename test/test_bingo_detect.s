	AREA  Program,CODE, READONLY ; name this block of code
SWI_Exit EQU 0x11 ; tidy finish
SWI_Clock EQU 0x61
SWI_Open EQU 0x66
SWI_Close EQU 0x68
SWI_Write EQU 0x69
SWI_RdStr EQU 0x6a
write_only EQU 4 ; mode 4 = open to write
read_only  EQU 1

ARRAY_LENGTH EQU 25

	IMPORT 	bingo_init_board
	IMPORT 	init_2dArray
	IMPORT 	get_2dArray
	IMPORT 	printf_dec

	IMPORT 	tbingo_set_row_minus
	IMPORT 	tbingo_set_col_minus
	IMPORT 	tbingo_set_slash_minus
	IMPORT 	tbingo_set_backslash_minus
	IMPORT 	bingo_detect_line
	IMPORT 	bingo_detect_backslash
	ENTRY 	; mark first instruction

Main
	MOV 	fp,sp
	MOV 	r0, #0 
	MOV 	r1, #5
	MOV 	r2, #5
	BL 	init_2dArray

	SUB 	r0, fp, #100
	BL 	bingo_init_board

	SUB 	r0, fp, #100
	STR 	r0, [sp, #-12]
	MOV 	r0, #1
	STR 	r0, [sp, #-16]
	MOV 	r0, #1
	STR 	r0, [sp, #-20]
	MOV 	r0, #5
	STR 	r0, [sp, #-24]
	MOV 	r0, #5
	STR 	r0, [sp, #-28]
	BL 	get_2dArray

	BL 	printf_dec

	MOV 	r4, #16

	SUB 	r0, fp, #100
	MOV 	r1, #0
	BL 	tbingo_set_col_minus

	SUB 	r0, fp, #100
	MOV 	r1, #1
	BL 	tbingo_set_col_minus

	;SUB 	r0, fp, #100
	;MOV 	r1, #2
	;BL 	tbingo_set_col_minus

	;SUB 	r0, fp, #100
	;MOV 	r1, #3
	;BL 	tbingo_set_col_minus

	SUB 	r0, fp, #100
	BL 	tbingo_set_backslash_minus

	SUB 	r0, fp, #100
	BL 	bingo_detect_line
	BL 	printf_dec

	SWI 	SWI_Exit

	END
