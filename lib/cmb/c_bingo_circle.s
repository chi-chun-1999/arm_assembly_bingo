
;==============================================
;
; c_bingo_circle(int &myboard[0][0],int &enemyboard[0][0],int &select_board[0] int detect_num)
;
; r0: &myboard[0][0]
; r1: &enemyboard[0][0]
; r2: &select_board[0]
; r3: detect_num
; *****************

	AREA	CBingoCircle,CODE,READWRITE
	EXPORT 	c_bingo_circle
	IMPORT 	bingo_set_minus_1
	IMPORT 	ui_draw_board_circle
	IMPORT 	ui_draw_select_board_circle
	IMPORT 	set_1dArray

	
c_bingo_circle	

	STMFD 	sp!,{r0-r8,lr}
	MOV 	r4, r0
	MOV 	r5, r1
	MOV 	r6, r3
	MOV 	r7, r2

	MOV 	r0, r4
	MOV 	r1, r6
	BL 	bingo_set_minus_1

	MOV 	r2, #0
	BL 	ui_draw_board_circle

	MOV 	r0, r5
	MOV 	r1, r6
	BL 	bingo_set_minus_1

	MOV 	r2, #1
	BL 	ui_draw_board_circle

	MOV 	r0, r7
	SUB 	r1, r6, #1
	MOV 	r2, #-1
	BL 	set_1dArray

	MOV 	r0, r6
	BL 	ui_draw_select_board_circle

	LDMFD 	sp!,{r0-r8,pc}

	END





