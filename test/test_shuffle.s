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
	IMPORT 	init_1dArray
	IMPORT 	set_order_1dArray
	IMPORT 	bingo_shuffle_1darray
	IMPORT 	__rt_udiv
	IMPORT 	rand
	IMPORT 	swap


Main
	MOV 	fp,sp
	MOV 	r0, sp
	MOV 	r1, #ARRAY_LENGTH
	BL 	init_1dArray	

	MOV 	r1, #ARRAY_LENGTH 
	MOV 	r2, #1
	BL 	set_order_1dArray	

	MOV 	r1, #ARRAY_LENGTH
	BL 	bingo_shuffle_1darray


	SWI 	SWI_Exit

	END
