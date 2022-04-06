;=========================================
;	for(int i=0;i<25;i++)
;	{
;		int r = rand()%(25-i)+i;
;		int tmp = array[i];
;		array[i]=array[r];
;		array[r]=tmp;
;	}
;=========================================
; bingo_shuffle_1darray(1darray, length)
; r0: 1darray
; r1: length



	AREA  BingoShuffle1dArray,CODE, READWRITE ; name this block of code
	IMPORT 	__rt_udiv
	IMPORT 	rand
	IMPORT 	swap
	EXPORT 	bingo_shuffle_1darray

bingo_shuffle_1darray

	STMFD 	sp!,{r1-r8,LR}

	MOV 	r2, r0 	;r2: address of 1darray

	MOV 	r3, r1 	;r3: length
	MOV 	r4, #0 	;r4: int i for loop

	MOV 	r5, #4 	;4byte
	MOV 	r6, #0 	;address index

forLoop 
	CMP 	r4, r3
	BGE 	endfunc

	;int r = rand()%(25-i)+i
	BL 	rand 	;r0 = rand()
	SUB 	r1, r3, r4
	BL 	__rt_udiv 	;r1 = rand()%(length-i)
	ADD 	r1, r1, r4


	;swap(array[i],array[r])
	MUL 	r6, r4, r5
	ADD 	r0, r6, r2
	MUL 	r6, r1, r5
	ADD 	r1, r6, r2
	BL 	swap

	ADD 	r4, r4, #1
	BL 	forLoop
		

endfunc
	LDMFD 	sp!,{r1-r8,PC}

	END

