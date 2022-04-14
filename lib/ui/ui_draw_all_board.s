;==============================================
;
; ui_draw_all_board(int &myboard[0][0],int &enemyboard[0][0])
;
; r0: &myboard[0][0]
; r1: &enemyboard[0][0]
; *****************

	AREA	UiDrawAllBoard,CODE,READWRITE
	EXPORT 	ui_draw_all_board
	IMPORT 	ui_draw_board
	IMPORT 	cursor_set_color
	IMPORT 	cursor_set_none

MY_START_X 	EQU	&0b 	;(hex base)
MY_START_Y 	EQU	&5
ENEMY_START_X 	EQU	&30 	;(hex base)
ENEMY_START_Y 	EQU	&5
	
ui_draw_all_board	

	STMFD 	sp!,{r0-r8,lr}
	MOV 	r4, r0
	MOV 	r5, r1

	MOV 	r0, #35
	MOV 	r1, #47
	BL 	cursor_set_color
	
	MOV 	r0, r4
	MOV 	r1, #MY_START_X
	MOV 	r2, #MY_START_Y
	BL 	ui_draw_board

	MOV 	r0, #36
	MOV 	r1, #47
	BL 	cursor_set_color

	MOV 	r0, r5
	MOV 	r1, #ENEMY_START_X
	MOV 	r2, #ENEMY_START_Y
	BL 	ui_draw_board

	BL 	cursor_set_none
	

	LDMFD 	sp!,{r0-r8,pc}

	END



