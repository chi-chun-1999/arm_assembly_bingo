
;==============================================
; in c:
;==============================================
;
; ui_draw_select_board_circle(int number)
;
; r0: number



SWI_Write0	EQU	&2

	AREA	UiDrawSelectBoardCircle,CODE,READWRITE
SELECT_BOARD_START_X 	EQU	&0 	;(hex base)
SELECT_BOARD_START_Y 	EQU	&14
	EXPORT 	ui_draw_select_board_circle
	IMPORT 	cursor_store
	IMPORT 	cursor_restore
	IMPORT 	ui_draw_circle
	IMPORT 	cursor_set_color
	IMPORT 	cursor_set_none
	
ui_draw_select_board_circle	
	STMFD 	sp!,{r0-r8,LR}
	MOV 	r6, r0

	MOV 	r4, #SELECT_BOARD_START_X
	MOV 	r5, #SELECT_BOARD_START_Y
	SUB 	r6, r6, #1
Draw 
	MOV 	r8, #3
	MUL 	r0, r6, r8
	ADD 	r0, r0, r4

	MOV  	r1, r5

	BL 	ui_draw_circle

	LDMFD 	sp!,{r0-r8,PC}

	END



