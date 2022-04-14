;==============================================
; in c:
;==============================================
;
; ui_draw_board(int &2darray[0][0], int start_x, int start_y)
;
; r0: &2darray[0][0]
; r1: start_x
; r2: start_y



SWI_Write0	EQU	&2

	AREA	UiDrawBoard,CODE,READWRITE
	EXPORT 	ui_draw_board
	IMPORT 	ui_draw_number
	
ui_draw_board	
	STMFD 	sp!,{r0-r8,LR}
	BL 	cursor_store
	MOV 	r4, r0 	;2darray
	MOV 	r5, r1 	;start_x
	MOV 	r6, r2 	;start_y
	
	MOV 	r0, r5
	MOV 	r1, r6
	BL 	cursor_relative_move

	MOV 	r0, r4
	BL 	printf_dec

	BL 	cursor_restore

	LDMFD 	sp!,{r0-r8,PC}

	AREA  Data, DATA
cursor_restore_str = "\033[u\0"
	END



