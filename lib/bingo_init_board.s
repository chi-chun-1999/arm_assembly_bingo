;===============================
; in c:
;init_board(2dArray[ROW][COL])
;{
;	int array[25];
;
;	for(int i=0;i<25;i++)
;	{
;		array[i]=i+1;
;	}
; 	
; 	bingo_shuffle_1darray();
;
;	int k = 0;
; 	
; 	for(int i=0; i < ROW ; i++)
; 	{
;		for(int j=0; j < COL;j++)
;		{
;			2dArray[i][j]=array[k];
;			k++;
;		}
; 	}
;}
;===============================
;
;bingo_init_board(2dArray,)
; r0: &2dArray[0][0]
;
;
;***************************
;local variable
;
; fp-100: int array[25]
; fp-104: int k
;


	AREA  BingoInitBoard,CODE, READWRITE ; name this block of code

ARRAY_LENGTH 	EQU 25

	IMPORT 	set_order_1dArray
	IMPORT 	set_2dArray
	IMPORT 	init_1dArray
	IMPORT 	get_1dArray
	IMPORT 	bingo_shuffle_1darray
	EXPORT 	bingo_init_board

bingo_init_board

	STMFD 	sp!, {r4,FP,LR}

	MOV 	fp, sp
	MOV 	r4, r0 	; r4: &2dArray[0]
	MOV 	r1, #ARRAY_LENGTH
	BL 	init_1dArray ;r0:  &array[0]
	MOV 	r0, #0
	STMFD	sp!, {r0} ;int k=0

	STMFD 	sp!,{r1-r8}


	SUB 	r0, fp, #100
	MOV 	r1, #ARRAY_LENGTH 
	MOV 	r2, #1
	BL 	set_order_1dArray	

	SUB 	r0, fp, #100
	MOV 	r1, #ARRAY_LENGTH
	MOV 	r2, r4
	BL 	bingo_shuffle_1darray


	MOV 	r5, #0 		;for loop int i = 0

Loop1
	ADD 	r5, r5, #1
	MOV 	r6, #0 		;for loop int j = 0
	CMP 	r5, #5
	BGT 	Return

Loop2
	CMP 	r6, #5
	BGE 	Loop1

	MOV 	r0, r4  	;let r0 = &array[0]
	STR 	r0, [sp, #-12] 	

	;2dArray[i][j]=array[k]
	SUB 	r0, fp, #100
	LDR 	r1, [fp, #-104] ;get value of k from memory
	BL 	get_1dArray 	;get array[k]
	STR 	r0, [sp, #-16]

	SUB 	r0, r5, #1
	STR 	r0, [sp, #-20]
	STR 	r6, [sp, #-24]
	MOV 	r0, #5
	STR 	r0, [sp, #-28]
	MOV 	r0, #5
	STR 	r0, [sp, #-32]
	ADD 	r6, r6, #1
	BL 	set_2dArray

	;k++
	LDR 	r1, [fp, #-104] ;get value of k from memory
	ADD 	r1, r1, #1
	STR 	r1, [fp, #-104] ;get value of k from memory

	BL 	Loop2

Return
	LDMFD 	sp!,{r1-r8}

	MOV 	sp, fp
	LDMFD 	sp!, {r4,FP,PC}

	END

