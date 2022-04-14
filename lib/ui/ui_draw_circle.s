;==============================================
; in c:
;==============================================
;
; ui_draw_circle(int relative_x, int relative_y)
;
; r0: relative_x
; r0: relative_y



SWI_Write0	EQU	&2

	AREA	UiDrawCircle,CODE,READWRITE
	EXPORT 	ui_draw_circle
	IMPORT 	cursor_store
	IMPORT 	cursor_restore
	IMPORT 	cursor_relative_move
	IMPORT 	cursor_set_color
	IMPORT 	cursor_set_none
	
ui_draw_circle	
	STMFD 	sp!,{r0-r6,LR}
	BL 	cursor_store


	
	MOV 	r5, r0 	;x
	MOV 	r6, r1 	;y

	MOV 	r0, #91
	MOV 	r1, #47
	BL 	cursor_set_color
	
	MOV 	r0, r6
	MOV 	r1, r5
	BL 	cursor_relative_move

	MOV 	r0, #'-'
	SWI 	&0
	MOV 	r0, #'-'
	SWI 	&0
	BL 	cursor_set_none

	BL 	cursor_restore

	LDMFD 	sp!,{r0-r6,PC}

	END



