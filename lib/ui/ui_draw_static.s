;==============================================
; in c:
;==============================================
;
; ui_draw_static(int number,int start_x, int start_y,mode)
;
; r0: number
; r1: start_x
; r2: start_y
; r3: mode (0: me, 1: ememy)



SWI_Write0	EQU	&2

	AREA	UiDrawStatic,CODE,READWRITE
	EXPORT 	ui_draw_static
	IMPORT 	cursor_store
	IMPORT 	cursor_restore
	IMPORT 	cursor_relative_move
	IMPORT 	cursor_set_color
	IMPORT 	cursor_set_none
	
ui_draw_static	
	STMFD 	sp!,{r0-r8,LR}

	BL 	cursor_store
	MOV 	r6, r0
	MOV 	r4, r1 	;start_x
	MOV 	r5, r2 	;start_y

	MOV 	r0, r5
	MOV 	r1, r4
	BL 	cursor_relative_move

	MOV 	r7, #0

	CMP 	r3, #1
	BEQ 	SetEnemyColor
	MOV 	r0, #93
	MOV 	r1, #47
	BL 	cursor_set_color
	B 	Loop


SetEnemyColor
	MOV 	r0, #34
	MOV 	r1, #47
	BL 	cursor_set_color


Loop 
	CMP 	r7, r6
	BGE 	EndLoop

	CMP 	r3, #1
	BEQ 	SetEnemyStr
	LDR 	r0, =MyStaticStr
	B 	Draw

SetEnemyStr
	LDR 	r0, =EnemyStaticStr

Draw
	SWI 	&2

	ADD 	r7, r7, #1
	B 	Loop


EndLoop
	BL 	cursor_restore

	LDMFD 	sp!,{r0-r8,PC}

	AREA  UiDrawStaticData, DATA
MyStaticStr = "O  \0"
EnemyStaticStr = "X  \0"

	END



