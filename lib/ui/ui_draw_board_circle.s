
;==============================================
; in c:
;==============================================
;
; ui_draw_circle(int row, int col,mode)
;
; r0: row
; r1: col
; r2: mode



SWI_Write0	EQU	&2

	AREA	UiDrawBoardCircle,CODE,READWRITE
MY_START_X 	EQU	&0b 	;(hex base)
MY_START_Y 	EQU	&5
ENEMY_START_X 	EQU	&30 	;(hex base)
ENEMY_START_Y 	EQU	&5
	EXPORT 	ui_draw_board_circle
	IMPORT 	cursor_store
	IMPORT 	cursor_restore
	IMPORT 	ui_draw_circle
	IMPORT 	cursor_set_color
	IMPORT 	cursor_set_none
	
ui_draw_board_circle	
	STMFD 	sp!,{r0-r8,LR}
	MOV 	r6, r0
	MOV 	r7, r1

	CMP 	r2, #1
	BEQ 	EnemyMode
	MOV 	r4, #MY_START_X
	MOV 	r5, #MY_START_Y
	B 	Draw

EnemyMode
	MOV 	r4, #ENEMY_START_X
	MOV 	r5, #ENEMY_START_Y

Draw 
	MOV 	r8, #3
	MUL 	r0, r6, r8
	ADD 	r0, r0, r4

	MOV 	r8, #2
	MUL 	r1, r7, r8 
	ADD 	r1, r1, r5

	BL 	ui_draw_circle

	LDMFD 	sp!,{r0-r8,PC}

	END



