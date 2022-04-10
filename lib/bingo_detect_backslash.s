;===============================
; in c:
;int bingo_detect_backslash(int 2dArray[ROW][COL])
;{
;	int backslash_static = 0;
;	int per_backslash_static = 0;
;
;
;	for(int j = 0; j < COL ; j++)
;	{
;		if(2dArray[j][COL-j]==-1)
;		{
;			per_backslash_static++;
;		}
;		else
;		{
;			break;
;		}
;	}
;
;	if(per_backslash_static==5)
;	{
;		backslash_static++;
;
;	}
;
;	return backslash_static;
;}
;===============================
;
;bingo_detect_backslash(2dArray)
; r0: &2dArray[0][0]
;
; return r0:rows_static
;***************************
; local variable:
; fp-4: backslash_static
 


	AREA  BingoDetectBackSlash,CODE, READWRITE ; name this block of code

ROW_LENGTH 	EQU 5
COL_LENGTH 	EQU 5

	EXPORT 	bingo_detect_backslash
	IMPORT 	get_2dArray

bingo_detect_backslash
	STMFD 	sp!, {r1,FP,LR}

	MOV 	fp, sp
	MOV 	r1, r0 	; r1: &2dArray[0][0]
	MOV 	r0, #0

	STMFD	sp!, {r0} ;int k=0

	STMFD 	sp!,{r2-r8}


	MOV 	r3, #0 	;Loop1 int per_backslash_static=0;
 	MOV 	r4, #0 	;Loop2 int j=0;

Loop2 
	CMP 	r4, #5
	BGE 	EndLoop2

	STR 	r1, [sp, #-12]
	MOV 	r0, r4
	STR 	r0, [sp, #-16]
	MOV 	r0, #4
	SUB 	r0, r0, r4
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
	CMP 	r3, #ROW_LENGTH
	BNE 	Return
	LDR 	r0,[fp, #-4]
	ADD 	r0, r0, #1
	STR 	r0,[fp, #-4]

Return
	LDMFD 	sp!,{r2-r8}
	LDR 	r0,[fp, #-4]

	MOV 	sp, fp
	LDMFD 	sp!, {r1,FP,PC}

	END

