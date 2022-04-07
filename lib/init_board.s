


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


	AREA  InitBoard,CODE, READWRITE ; name this block of code
	IMPORT 	set_order_1dArray
	IMPORT 	init_1dArray

init_board

	STMFD 	sp!,{r1-r4,LR}

	MOV 	r3,r0  ;r3 is the &array[0]	
	MOV 	r4,r1  ;r4 is length
	MOV 	r1,#0

	
Set	BL 	set_1dArray
	ADD 	r1,r1,#1
	ADD 	r2,r2,#1
	SUB 	r4,r4,#1
	CMP 	r4,#0
	BNE 	Set

	MOV 	r0,r3
	LDMFD 	sp!,{r1-r4,PC}

	END

