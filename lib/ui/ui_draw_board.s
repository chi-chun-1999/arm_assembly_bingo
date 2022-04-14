;==============================================
; in c:
; ui_draw_board(int &2darray[0][0], int start_x, int start_y)
;{
;	int draw_x;
;	int draw_y;
;	for(int i=0;i<5;i++)
;	{
;		for(int j=0;j<5;j++)
;		{
;			set_number=2darray[i][j]
;			draw_x=start_x+i*3;
;			draw_y=start_y+j*2;
;			ui_draw_number(set_number,draw_x,draw_y);
;		}
;	}
;}

;==============================================
;
; ui_draw_board(int &2darray[0][0], int start_x, int start_y)
;
; r0: &2darray[0][0]
; r1: start_x
; r2: start_y
; *****************
; local variable:
; fp-4: start_x
; fp-8: start_y



SWI_Write0	EQU	&2

	AREA	UiDrawBoard,CODE,READWRITE
	EXPORT 	ui_draw_board
	IMPORT 	ui_draw_number
	IMPORT 	get_2dArray
	
ui_draw_board	
	STMFD 	sp!,{fp, lr}
	MOV 	fp, sp
	STMFD 	sp!,{r1} ;start_x
	STMFD 	sp!,{r2} ;start_y

	STMFD 	sp!,{r0-r8}
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

	LDR 	r1, [fp, #-4]
	MOV 	r7, #3
	MUL 	r3, r5, r7
	ADD 	r1, r1, r3
	 	
	LDR 	r2, [fp, #-8]
	MOV 	r7, #2
	MUL 	r3, r6, r7
	ADD 	r2, r2, r3
	BL 	ui_draw_number

	ADD 	r6, r6, #1
	B 	Loop2

EndLoop2
	ADD 	r5, r5, #1
	B 	Loop1

EndLoop1
	LDMFD 	sp!,{r0-r8}
	MOV 	sp, fp
	LDMFD 	sp!,{fp,pc}

	END



