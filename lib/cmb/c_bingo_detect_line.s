


;==============================================
;
; c_bingo_detect_line(int &select_board[0])
; r0: &select_board[0]
;
; return: r0: -1(when enemy_select_number=0) or enemy_select_number
; *****************

	AREA	CEnemySelectNumber,CODE,READWRITE

	EXPORT 	c_enemy_select_number
	IMPORT 	bingo_enemy_select_number
	IMPORT 	printf_dec
	IMPORT 	cursor_store
	IMPORT 	cursor_restore
	IMPORT 	cursor_relative_move
	IMPORT 	cursor_set_color
	IMPORT 	cursor_set_none
	IMPORT 	sleep

	
c_enemy_select_number	

	STMFD 	sp!,{r1-r6,lr}
	MOV 	r5, r0
	BL 	cursor_store
	
	
	;set init
	MOV 	r0, #30
	MOV 	r1, #47
	BL 	cursor_set_color

	MOV 	r0, #18
	MOV 	r1, #39
	BL 	cursor_relative_move

	LDR 	r0, =select_ui_data
	SWI 	&2
	BL 	cursor_restore

	;show show arrow
	BL 	cursor_store

	MOV 	r0, #34
	MOV 	r1, #47
	BL 	cursor_set_color

	MOV 	r0, #9
	MOV 	r1, #35
	BL 	cursor_relative_move
	MOV 	r0, #'-'
	SWI 	&0
	MOV 	r0, #'-'
	SWI 	&0
	MOV 	r0, #'-'
	SWI 	&0
	MOV 	r0, #'-'
	SWI 	&0
	MOV 	r0, #'>'
	SWI 	&0
	BL 	cursor_restore
	
	;show enemy select
	BL 	cursor_store
	MOV 	r0, #34
	MOV 	r1, #47
	BL 	cursor_set_color

	MOV 	r0, #18
	MOV 	r1, #44
	BL 	cursor_relative_move

	MOV 	r0, #1
	BL 	sleep

	MOV 	r0, r5
	BL 	bingo_enemy_select_number
	MOV 	r6, r0

	BL 	printf_dec
	BL 	cursor_set_none
	BL 	cursor_restore

	MOV 	r0, #1
	BL 	sleep
	MOV 	r0, r6
	LDMFD 	sp!,{r1-r6,pc}

	AREA  Data1, DATA
select_ui_data = "___________\0"

	END




