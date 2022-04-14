
;==============================================
; in c:
;==============================================
;
; ui_draw_number(int number, int relative_x, int relative_y)
;
; r0: number
; r1: relative_x
; r2: relative_y



SWI_Write0	EQU	&2

	AREA	UiDrawNumber,CODE,READWRITE
	EXPORT 	ui_draw_number
	IMPORT 	cursor_store
	IMPORT 	cursor_restore
	IMPORT 	cursor_relative_move
	IMPORT 	printf_dec
	
ui_draw_number	
	STMFD 	sp!,{r0-r6,LR}
	BL 	cursor_store
	MOV 	r4, r0 	;set number
	MOV 	r5, r1 	;x
	MOV 	r6, r2 	;y
	
	MOV 	r0, r5
	MOV 	r1, r6
	BL 	cursor_relative_move

	MOV 	r0, r4
	BL 	printf_dec

	BL 	cursor_restore

	LDMFD 	sp!,{r0-r6,PC}

	AREA  Data, DATA
cursor_restore_str = "\033[u\0"
	END



