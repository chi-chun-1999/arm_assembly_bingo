;===============================
; in c:
;int bingo_detect_line(int 2dArray[ROW][COL])
;{
;	int line_sum = 0;
;	int tmp=0;
;
;	tmp=bingo_detect_row();
;	line_sum = line_sum+tmp;
;
;	tmp=bingo_detect_col();
;	line_sum = line_sum+tmp;
;
;	tmp=bingo_detect_slash();
;	line_sum = line_sum+tmp;
;
;	tmp=bingo_detect_backslash();
;	line_sum = line_sum+tmp;
;
;
;	return line_sum;
;}
;===============================
;
;bingo_detect_line(2dArray)
; r0: &2dArray[0][0]
;
; return r0:line_sum

	AREA  BingoDetectLine,CODE, READWRITE ; name this block of code

ROW_LENGTH 	EQU 5
COL_LENGTH 	EQU 5

	EXPORT 	bingo_detect_line

	IMPORT 	bingo_detect_row
	IMPORT 	bingo_detect_col
	IMPORT 	bingo_detect_slash
	IMPORT 	bingo_detect_backslash

bingo_detect_line
	STMFD 	sp!,{r1-r8,LR}
	MOV  	r2, r0
	MOV 	r1, #0

	BL 	bingo_detect_col
	ADD 	r1, r1, r0
	
	MOV  	r0, r2
	BL 	bingo_detect_row
	ADD 	r1, r1, r0

	MOV  	r0, r2
	BL 	bingo_detect_slash
	ADD 	r1, r1, r0

	MOV  	r0, r2
	BL 	bingo_detect_backslash
	ADD 	r1, r1, r0

	MOV 	r0, r1

	LDMFD 	sp!,{r1-r8,PC}

	END
