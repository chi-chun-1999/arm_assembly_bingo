
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


;	STMFD 	sp!,{r1-r8,LR}
;
;	MOV 	r2, r0 	;r2: address of 1darray
;
;	MOV 	r3, r1 	;r3: length
;	MOV 	r4, #0 	;r4: int i for loop
;
;	MOV 	r5, #4 	;4byte
;	MOV 	r6, #0 	;address index
;
;forLoop 
;	CMP 	r4, r3
;	BGE 	endfunc
;
;	;int r = rand()%(25-i)+i
;	BL 	rand 	;r0 = rand()
;	SUB 	r1, r3, r4
;	BL 	__rt_udiv 	;r1 = rand()%(length-i)
;	ADD 	r1, r1, r4
;
;
;	;swap(array[i],array[r])
;	MUL 	r6, r4, r5
;	ADD 	r0, r6, r2
;	MUL 	r6, r1, r5
;	ADD 	r1, r6, r2
;	BL 	swap
;
;	ADD 	r4, r4, #1
;	BL 	forLoop
;		
;
;endfunc
;	LDMFD 	sp!,{r1-r8,PC}



	SWI 	SWI_Exit

	END
