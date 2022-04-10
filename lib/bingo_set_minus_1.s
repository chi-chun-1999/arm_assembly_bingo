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

bingo_set_minus_1

	STMFD 	sp!,{r2-r8,LR}

	MOV 	r2, r0 	;r2: address of 2darray
	MOV 	r3, #0 	;r3: int i=0

	MOV 	r4, #ARRAY_LENGTH
	MOV 	r5, #0
	MOV 	r6, #-1

ForLoop 
	CMP 	r3, r4
	BGE 	EndFunc

	LDR 	r5, [r2, #4] !
	CMP 	r1, r5
	BEQ 	SetMinus

	ADD 	r3, r3, #1
	BL 	ForLoop

SetMinus
	STR 	r6, [r2]
	MOV 	r1, r2
EndFunc
	LDMFD 	sp!,{r2-r8,PC}

	END

