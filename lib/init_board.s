;
;
;
;init_board(2dArray[ROW][COL])
;{
;	int array[25];
;
;	for(int i=0;i<25;i++)
;	{
;		array[i]=i+1;
;	}
;
;	for(int i=0;i<25;i++)
;	{
;		int r = rand()%(25-i)+i;
;		int tmp = array[i];
;		array[i]=array[r];
;		array[r]=tmp;
;	}
;
;
;	
;
;}


	AREA  InitBoard,CODE, READWRITE ; name this block of code
	IMPORT 	set_order_1dArray
	IMPORT 	init_1dArray

init_board

	STMFD 	sp!,{r1-r4,LR}

	MOV 	r3,r0  ;r3 is the &array[0]	
	MOV 	r4,r1  ;r4 is length
	MOV 	r1,#0

	
SET 	BL 	set_1dArray
	ADD 	r1,r1,#1
	ADD 	r2,r2,#1
	SUB 	r4,r4,#1
	CMP 	r4,#0
	BNE 	SET

	MOV 	r0,r3
	LDMFD 	sp!,{r1-r4,PC}

	END

