
;***************************
;local variable
;
; fp-100: int select_board[25]
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

ARRAY_LENGTH EQU 25

	ENTRY 	; mark first instruction
	IMPORT 	set_order_1dArray
	IMPORT 	set_all_1dArray
	IMPORT 	set_1dArray
	IMPORT 	init_1dArray
	IMPORT 	printf_dec
	IMPORT 	bingo_enemy_select_number


Main
	MOV 	fp,sp

	;init select_board
	MOV 	r0, #0 
	MOV 	r1, #ARRAY_LENGTH
	BL 	init_1dArray

	SUB 	r0, fp, #100
	MOV 	r1, #ARRAY_LENGTH
	MOV 	r2, #1
	BL 	set_order_1dArray

	SUB 	r0, fp, #100
	MOV 	r1, #20
	MOV 	r2, #-1
	BL 	set_1dArray

	SUB 	r0, fp, #100
	MOV 	r1, #10
	MOV 	r2, #-1
	BL 	set_1dArray

	SUB 	r0, fp, #100
	MOV 	r1, #2
	MOV 	r2, #-1
	BL 	set_1dArray

	SUB 	r0, fp, #100
	MOV 	r1, #ARRAY_LENGTH
	MOV 	r2, #-1 
	BL 	set_all_1dArray

	SUB 	r0, fp, #100
	MOV 	r1, #2
	MOV 	r2, #1
	BL 	set_1dArray

	SUB 	r0, fp, #100
	MOV 	r1, #4
	MOV 	r2, #2
	BL 	set_1dArray

	SUB 	r0, fp, #100
	MOV 	r1, #3
	MOV 	r2, #3
	BL 	set_1dArray

	SUB 	r0, fp, #100
	BL 	bingo_enemy_select_number

	BL 	printf_dec



	SWI 	SWI_Exit

	END

