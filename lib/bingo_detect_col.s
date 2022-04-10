;===============================
; in c:
;int bingo_detect_row(int 2dArray[ROW][COL])
;{
;	int cols_static = 0;
;
;	for(int i=0; i < ROW; i++)
;	{
;		int per_col_static=0;
;
;		for(int j = 0; j < COL ; j++)
;		{
;			if(2dArray[i][j]==-1)
;			{
;				per_col_static++;
;			}
;			else
;			{
;				break;
;			}
;		}
;
;		if(per_col_static==5)
;		{
;			col_static++;
;
;		}
;	}
;
;	return cols_static;
;}
;===============================
;
;bingo_detect_col(2dArray)
; r0: &2dArray[0][0]
;
; return r0:rows_static
;***************************
; local variable:
; fp-4: cols_static
 


	AREA  BingoDetectCol,CODE, READWRITE ; name this block of code

ROW_LENGTH 	EQU 5
COL_LENGTH 	EQU 5

	EXPORT 	bingo_detect_col
	IMPORT 	get_2dArray

bingo_detect_col
	STMFD 	sp!, {r1,FP,LR}

	MOV 	fp, sp
	MOV 	r1, r0 	; r1: &2dArray[0][0]
	MOV 	r0, #0

	STMFD	sp!, {r0} ;int k=0

	STMFD 	sp!,{r2-r8}

	MOV 	r2, #0 	;Loop1 int i=0;

Loop1
	CMP 	r2, #5
	BGE 	EndLoop1
	MOV 	r3, #0 	;Loop1 int per_col_static=0;
 	MOV 	r4, #0 	;Loop2 int j=0;

Loop2 
	CMP 	r4, #5
	BGE 	EndLoop2

	STR 	r1, [sp, #-12]
	MOV 	r0, r4
	STR 	r0, [sp, #-16]
	MOV 	r0, r2
	STR 	r0, [sp, #-20]
	MOV 	r0, #ROW_LENGTH
	STR 	r0, [sp, #-24]
	MOV 	r0, #COL_LENGTH
	STR 	r0, [sp, #-28]
	BL 	get_2dArray

	CMP 	r0, #-1
	BNE 	EndLoop2
	ADD 	r3, r3, #1
	ADD 	r4, r4, #1
	B 	Loop2

EndLoop2
	ADD 	r2, r2, #1
	CMP 	r3, #ROW_LENGTH
	BNE 	Loop1
	LDR 	r0,[fp, #-4]
	ADD 	r0, r0, #1
	STR 	r0,[fp, #-4]
	B 	Loop1

EndLoop1
	LDMFD 	sp!,{r2-r8}
	LDR 	r0,[fp, #-4]

	MOV 	sp, fp
	LDMFD 	sp!, {r1,FP,PC}

	END

