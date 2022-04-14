
;==============================================
;
; c_get_select_number()
;
; return r0: select_number 
; *****************

	AREA	CGetSelectNumber,CODE,READWRITE

	EXPORT 	c_get_select_number
	IMPORT 	scanf_dec
	IMPORT 	cursor_store
	IMPORT 	cursor_restore
	IMPORT 	cursor_relative_move
	IMPORT 	cursor_set_color
	IMPORT 	cursor_set_none

	
c_get_select_number	

	STMFD 	sp!,{r1-r4,lr}
	BL 	cursor_store
	

	MOV 	r0, #30
	MOV 	r1, #47
	BL 	cursor_set_color

	MOV 	r0, #18
	MOV 	r1, #39
	BL 	cursor_relative_move

	LDR 	r0, =select_ui_data
	SWI 	&2
	BL 	cursor_restore

	BL 	cursor_store
	MOV 	r0, #93
	MOV 	r1, #47
	BL 	cursor_set_color

	MOV 	r0, #18
	MOV 	r1, #44
	BL 	cursor_relative_move

	BL 	scanf_dec
	MOV 	r4, r0

	BL 	cursor_set_none
	BL 	cursor_restore

	MOV 	r0, r4
	LDMFD 	sp!,{r1-r4,pc}

	AREA  Data1, DATA
select_ui_data = "___________\0"

	END




