;=========================================
;	tbingo_set_row_minus(int 2darray[5][5], int row)
;	{
; 		for(int i=0;i<5;i++)
;		{
;			2darray[row][i]=-1;
;		}
;	}
;	
;=========================================
; tbingo_set_row_minus(2darray, row)
; r0: 2darray
; r1: row



	AREA  TBingoSetRowMinus, CODE, READWRITE ; name this block of code

	EXPORT 	tbingo_set_row_minus
	IMPORT 	set_2dArray

tbingo_set_row_minus

	STMFD 	sp!,{r1-r8,LR}

	MOV 	r2, #0
	MOV 	r3, #-1

Loop 	
	CMP 	r2, #5
	BGE 	EndLoop

	STR 	r0, [sp, #-12] 	
	STR 	r3, [sp, #-16]
	STR 	r1, [sp, #-20]
	STR 	r2, [sp, #-24]
	MOV 	r0, #5
	STR 	r0, [sp, #-28]
	MOV 	r0, #5
	STR 	r0, [sp, #-32]
	ADD 	r6, r6, #1
	BL 	set_2dArray

 	ADD 	r2, r2, #1
	B 	Loop
		
EndLoop
	LDMFD 	sp!,{r1-r8,PC}

	END

