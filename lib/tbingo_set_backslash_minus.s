
;=========================================
;	tbingo_set_backslash_minus(int 2darray[5][5])
;	{
; 		for(int i=0;i<5;i++)
;		{
;			2darray[i][COL-i]=-1;
;		}
;	}
;	
;=========================================
; tbingo_set_backslash_minus(2darray)
; r0: 2darray
; 



	AREA  TBingoSetBackSlashMinus, CODE, READWRITE ; name this block of code

	EXPORT 	tbingo_set_backslash_minus
	IMPORT 	set_2dArray

tbingo_set_backslash_minus

	STMFD 	sp!,{r1-r8,LR}

	MOV 	r2, #0
	MOV 	r3, #-1

Loop 	
	CMP 	r2, #5
	BGE 	EndLoop

	STR 	r0, [sp, #-12] 	
	STR 	r3, [sp, #-16]
	STR 	r2, [sp, #-20]
	MOV 	r0, #4
	SUB 	r0, r0, r2
	STR 	r0, [sp, #-24]
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

