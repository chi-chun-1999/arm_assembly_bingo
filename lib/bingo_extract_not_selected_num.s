
;===============================
; in c:
;bingo_extract_not_selected_num(int select_board[25],int extract_select_board[25])
;{
;	set_all_1dArray(extract_select_board,25,-1);
;	
;	int extract_select_board_num=0;
;	for(int i =0;i<25;i++)
;	{
;		if(select_board[i]!=-1)
;		{
;			extract_select_board[extract_select_board_num]=select_board[i];
;			extract_select_board_num++;
;
;		}
;
;	}
;
;}
;===============================
;
;bingo_extract_not_selected_num(select_board, extract_select_board)
; r0: &select_board[0]
; r1: &extract_select_board[0]
;
; return: r0: extract_select_board_num
;***************************
;local variable
;
; fp-4: int extract_select_board_num
;


	AREA  BingoExtractNotSelectedNum,CODE, READWRITE ; name this block of code

ARRAY_LENGTH 	EQU 25

	IMPORT 	set_order_1dArray
	IMPORT 	set_all_1dArray
	IMPORT 	init_1dArray
	IMPORT 	get_1dArray
	IMPORT 	printf_dec
	IMPORT 	bingo_shuffle_1darray
	EXPORT 	bingo_extract_not_selected_num

bingo_extract_not_selected_num

	STMFD 	sp!, {r4, FP,LR}

	MOV 	fp, sp
	MOV 	r4, r0 	;&select_board[0]

	MOV 	r0, #0
	STMFD	sp!, {r0} ;int k=0

	STMFD 	sp!,{r1-r8}

	MOV 	r5, r1 	;&extract_select_board[0]
	MOV 	r6, #0 	;for loop int i

	MOV 	r0, r5
	MOV 	r1, #ARRAY_LENGTH 
	MOV 	r2, #-1
	BL 	set_all_1dArray	

	MOV 	r7, #0

Loop
	CMP 	r7, #ARRAY_LENGTH
	BGE 	Return

	LDR 	r0, [r4, r7, LSL#2]

	ADD 	r7, r7, #1

	CMP 	r0, #-1
	BEQ 	Loop
	LDR 	r1, [fp, #-4]
	STR 	r0, [r5, r1, LSL#2]
	ADD 	r1, r1, #1
	STR 	r1, [fp, #-4]
	
	B 	Loop


Return
	MOV 	r0, r1
	LDMFD 	sp!,{r1-r8}

	MOV 	sp, fp
	LDMFD 	sp!, {r4, FP,PC}

	END

