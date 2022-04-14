;===============================
; in c:
;bingo_set_minus_1(int 2dArray[ROW][COL], int set_minus_1)
;{
;
;	for(int i=0;i < 25; i++)
;	{
;		if(*(2dArray+i)==set_minus_1)
;		{
;			*(2dArray+1)=-1;
;			return;
;		}
;	}
;}
;===============================
;
;bingo_set_minus_1(2dArray, set_minus_1)
; r0: &2dArray[0][0]
; r1: set_minus_1
;
; return r0:&2dArray[0][0]
;***************************


	AREA  BingoSetMinus1,CODE, READWRITE ; name this block of code

ARRAY_LENGTH 	EQU 25

	EXPORT 	bingo_set_minus_1
	IMPORT 	get_2dArray
	IMPORT 	set_2dArray

bingo_set_minus_1

	STMFD 	sp!,{r2-r8,LR}
;
;	MOV 	r2, r0 	;r2: address of 2darray
;	MOV 	r3, #0 	;r3: int i=0
;
;	MOV 	r4, #ARRAY_LENGTH
;	MOV 	r5, #0
;	MOV 	r6, #-1
;
;ForLoop 
;	CMP 	r3, r4
;	BGE 	EndFunc
;
;	LDR 	r5, [r2, #4] !
;	CMP 	r1, r5
;	BEQ 	SetMinus
;
;	ADD 	r3, r3, #1
;	BL 	ForLoop
;
;SetMinus
;	STR 	r6, [r2]
;	MOV 	r1, r2

	MOV 	r4, r0 	;2darray

	MOV 	r5, #0 	;int i=0

Loop1
	CMP 	r5, #5
	BGE 	EndLoop1
	MOV 	r6, #0 ;int j=0

Loop2 
	CMP 	r6, #5
	BGE 	EndLoop2

	STR 	r4, [sp, #-12]
	MOV 	r0, r5
	STR 	r0, [sp, #-16]
	MOV 	r0, r6
	STR 	r0, [sp, #-20]
	MOV 	r0, #5
	STR 	r0, [sp, #-24]
	MOV 	r0, #5
	STR 	r0, [sp, #-28]
	BL 	get_2dArray
	CMP 	r0, r1
	BEQ 	SetMinus

	ADD 	r6, r6, #1
	B 	Loop2

EndLoop2
	ADD 	r5, r5, #1
	B 	Loop1

EndLoop1

	MOV 	r0, #-1
	MOV 	r1, #-1
	LDMFD 	sp!,{r2-r8,PC}

SetMinus
	STR 	r4, [sp, #-12]
	MOV 	r0, #-1
	STR 	r0, [sp, #-16]
	STR 	r5, [sp, #-20]
	STR 	r6, [sp, #-24]
	MOV 	r0, #5
	STR 	r0, [sp, #-28]
	MOV 	r0, #5
	STR 	r0, [sp, #-32]
	BL 	set_2dArray

	MOV 	r0, r5
	MOV 	r1, r6
	
	LDMFD 	sp!,{r2-r8,PC}
	END

