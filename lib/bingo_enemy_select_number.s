;===============================
; in c:
;int bingo_enemy_select_number(int select_board[25])
;{
;	int extract_select_board[25];
;	int extract_select_board_num=bingo_extract_not_selected_num(select_board,extract_select_board);
;	if(extract_select_board_num==0)
;	{
;		return -1;
;	}
;	
;	int randon_value=randon()%extract_select_board_num+1;
;
;	int enemy_select_number=extract_select_board[randon_value];
;
;	return enemy_select_number;
;}
;===============================
;
;bingo_enemy_select_number(select_board)
; r0: &select_board[0]
;
; return: r0: -1(when enemy_select_number=0) or enemy_select_number
;***************************
;local variable
;
; fp-100: int array[25]
; fp-104: int extract_select_board_num
; fp-108: int randon_value
;


	AREA  BingoInitBoard,CODE, READWRITE ; name this block of code

ARRAY_LENGTH 	EQU 25

	IMPORT 	set_order_1dArray
	IMPORT 	set_2dArray
	IMPORT 	init_1dArray
	IMPORT 	get_1dArray
	IMPORT 	bingo_shuffle_1darray
	IMPORT 	rand
	IMPORT 	__rt_udiv
	IMPORT 	bingo_extract_not_selected_num
	EXPORT 	bingo_enemy_select_number

bingo_enemy_select_number

	STMFD 	sp!, {r4,FP,LR}

	MOV 	fp, sp
	MOV 	r4, r0 	; r4: &2dArray[0]
	MOV 	r1, #ARRAY_LENGTH
	BL 	init_1dArray ;r0:  &array[0]
	MOV 	r0, #0
	STMFD	sp!, {r0} ;int extract_select_board_num=0
	MOV 	r0, #0
	STMFD	sp!, {r0} ;int randon_value=0

	STMFD 	sp!,{r1-r8}

	MOV 	r0, r4
	SUB 	r1, fp, #100
	BL 	bingo_extract_not_selected_num

	CMP 	r0, #0 
	BEQ 	ReturnError

	STR 	r0, [fp, #-104]
	MOV 	r1, r0
	BL 	rand
	BL 	__rt_udiv

	STR 	r1, [fp, #-108]


	SUB 	r0, fp, #100
	LDR 	r5, [r0, r1, LSL#2]; 	r5: enemy_select_number=extract_select_board[randon_value]

	MOV 	r0, r5
	B 	Return

ReturnError 
	MOV 	r0, #-1

Return
	LDMFD 	sp!,{r1-r8}

	MOV 	sp, fp
	LDMFD 	sp!, {r4,FP,PC}

	END

