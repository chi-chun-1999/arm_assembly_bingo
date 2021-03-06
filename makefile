

KEIL_PATH = C:\Users\User\Desktop\ARM251

ARMCC = $(KEIL_PATH)\Bin\armcc.exe
ARMASM = $(KEIL_PATH)\Bin\armasm.exe
ARMAR = $(KEIL_PATH)\Bin\armar.exe
ARMLINK = $(KEIL_PATH)\Bin\armlink.exe
FROMELF = $(KEIL_PATH)\Bin\fromelf.exe

#################################################
# 編譯選項
#################################################
CFLAGS := -c --cpu Cortex-M3 -D__MICROLIB -g -O0 --apcs=interwork
CMACRO :=
ASMFLAGS := -CPU ARM6  -g #--apcs=interwork --pd "__MICROLIB SETA 1"
LINKFLAGS := 
MAP := --autoat --summary_stderr --info summarysizes --map --xref --callgraph --symbols 
INFO := --info sizes --info totals --info unused --info veneers

#--cpu Cortex-M3 *.o --library_type=microlib --strict --scatter "TEST.sct" 
#--autoat --summary_stderr --info summarysizes --map --xref --callgraph --symbols 
#--info sizes --info totals --info unused --info veneers 
#--list ".\TEST.map" 
#-o "TEST.axf" 

OUTPUT_DIR = build
TARGET = ./build/main 
OBJMAP := .\output\*.map
OBJHTM := .\output\*.htm
OBJAXF := .\output\*.axf

OBJS = deps\swap\swap.o \
       .\deps\read_file\read_file.o \
       deps\divide\divide.o \
       .\deps\cursor\cursor_relative_move.o .\deps\cursor\cursor_store.o .\deps\cursor\cursor_restore.o .\deps\cursor\cursor_set_color.o .\deps\cursor\cursor_set_none.o .\deps\cursor\clear.o\
       deps\random\rand.o \
       deps\sleep\sleep.o \
       deps\printf\printf_dec.o deps\printf\printf_hex.o \
       deps\scanf\scanf_dec.o \
       deps\1darray\init_1dArray.o deps\1darray\set_1dArray.o deps\1darray\set_order_1dArray.o deps\1darray\set_all_1dArray.o deps\1darray\get_1dArray.o \
       deps\2darray\init_2dArray.o deps\2darray\set_2dArray.o deps\2darray\get_2dArray.o \
      lib\bingo_shuffle_1darray.o lib\bingo_init_board.o lib\bingo_extract_not_selected_num.o lib\bingo_enemy_select_number.o lib\bingo_set_minus_1.o lib\bingo_detect_line.o lib\bingo_detect_row.o lib\bingo_detect_backslash.o lib\bingo_detect_col.o lib\bingo_detect_slash.o\
	lib\ui\ui_draw_number.o lib\ui\ui_draw_board.o lib\ui\ui_draw_all_board.o lib\ui\ui_draw_circle.o lib\ui\ui_draw_board_circle.o lib\ui\ui_draw_select_board_circle.o lib\ui\ui_draw_static.o\
	lib\cmb\c_bingo_circle.o lib\cmb\c_get_select_number.o lib\cmb\c_enemy_select_number.o lib\cmb\tc_get_select_number.o lib\cmb\tc_enemy_select_number.o\
       main.o

#BUILD_OBJS_TARGET= $(foreach n, $(OBJS),build\$(n))
BUILD_OBJS_TARGET= $(addprefix $(OUTPUT_DIR)/, $(OBJS))
###########################################
#test_shuffle
###########################################
TEST_NAME = test_auto_game
TEST_TARGET1 = .\build\test\$(TEST_NAME)
#OBJS_TEST_TARGET1 = deps\swap\swap.o \
       deps\divide\divide.o \
       deps\random\rand.o \
       deps\printf\printf_dec.o deps\printf\printf_hex.o \
       deps\1darray\init_1dArray.o deps\1darray\set_1dArray.o deps\1darray\set_order_1dArray.o deps\1darray\get_1dArray.o \
       deps\2darray\init_2dArray.o deps\2darray\set_2dArray.o deps\2darray\get_2dArray.o \
       lib\bingo_shuffle_1darray.o lib\bingo_init_board.o  lib\bingo_set_minus_1.o lib\bingo_detect_row.o lib\tbingo_set_row_minus.o lib\bingo_detect_col.o lib\tbingo_set_col_minus.o  lib\bingo_detect_slash.o lib\tbingo_set_slash_minus.o lib\bingo_detect_backslash.o lib\tbingo_set_backslash_minus.o  lib\bingo_detect_line.o\
       test\$(TEST_NAME).o

OBJS_TEST_TARGET1 = deps\swap\swap.o \
       .\deps\read_file\read_file.o \
       deps\divide\divide.o \
       .\deps\cursor\cursor_relative_move.o .\deps\cursor\cursor_store.o .\deps\cursor\cursor_restore.o .\deps\cursor\cursor_set_color.o .\deps\cursor\cursor_set_none.o\
       deps\random\rand.o \
       deps\sleep\sleep.o \
       deps\printf\printf_dec.o deps\printf\printf_hex.o \
       deps\scanf\scanf_dec.o \
       deps\1darray\init_1dArray.o deps\1darray\set_1dArray.o deps\1darray\set_order_1dArray.o deps\1darray\set_all_1dArray.o deps\1darray\get_1dArray.o \
       deps\2darray\init_2dArray.o deps\2darray\set_2dArray.o deps\2darray\get_2dArray.o \
      lib\bingo_shuffle_1darray.o lib\bingo_init_board.o lib\bingo_extract_not_selected_num.o lib\bingo_enemy_select_number.o lib\bingo_set_minus_1.o lib\bingo_detect_line.o lib\bingo_detect_row.o lib\bingo_detect_backslash.o lib\bingo_detect_col.o lib\bingo_detect_slash.o\
	lib\ui\ui_draw_number.o lib\ui\ui_draw_board.o lib\ui\ui_draw_all_board.o lib\ui\ui_draw_circle.o lib\ui\ui_draw_board_circle.o lib\ui\ui_draw_select_board_circle.o lib\ui\ui_draw_static.o\
	lib\cmb\c_bingo_circle.o lib\cmb\c_get_select_number.o lib\cmb\c_enemy_select_number.o lib\cmb\tc_get_select_number.o lib\cmb\tc_enemy_select_number.o\
       test\$(TEST_NAME).o

#BUILD_OBJS_TEST_TARGET1= $(foreach n, $(OBJS_TEST_TARGET1),build\$(n))
BUILD_OBJS_TEST_TARGET1= $(addprefix $(OUTPUT_DIR)/, $(OBJS_TEST_TARGET1))

#all : main $(TEST_NAME)
all : $(OUTPUT_DIR)/main $(OUTPUT_DIR)/test/$(TEST_NAME)
#INC += -I.\system\delay
#INC += -I.\system\sys
#INC += -I.\system\usart
#INC += -I.\hardware\key
#INC += -I.\hardware\led
#INC += -I$(KEIL_PATH)\INC\St\STM32F10x
#INC += -I$(KEIL_PATH)\RV31\INC
INC += -I..\

#%.o:%.c
#	$(ARMCC) $(CFLAGS) $(INC) $(CMACRO) $< -o $@

#$(info INC is $(dir $(BUILD_OBJS_TARGET)))
$(OUTPUT_DIR)/main: $(BUILD_OBJS_TARGET) 
#armlink ../hello-1.o -Output $@
	$(ARMLINK) $(LINKFLAGS) $^ -Output $@

$(OUTPUT_DIR)/test/$(TEST_NAME): $(BUILD_OBJS_TEST_TARGET1) 
#armlink ../hello-1.o -Output $@
	$(ARMLINK) $(LINKFLAGS) $^ -Output $@

$(OUTPUT_DIR)/%.o: %.s
	
	@if not exist "$(@D)" mkdir "$(@D)"
	$(ARMASM) $(ASMFLAGS) $(INC) $< -o $@ 	
	


#armasm hello-1.s -o hello-1.o


#arm7:$(OBJS)
#	$(ARMLINK) $(LINKFLAGS) --libpath "$(KEIL_PATH)\RV31\LIB" --scatter start.sct $(MAP) $(INFO) --list $(TARGET).map $^ -o $(TARGET).axf
#	$(FROMELF) --bin -o $(TARGET).bin $(TARGET).axf
#	$(FROMELF) --i32 -o $(TARGET).hex $(TARGET).axf
#	del $(OBJHTM) $(OBJAXF) $(OBJS)

#   若只是生成LIB庫，只需要以下一條命令就可以了 
#	$(ARMAR) $(APPNAME).lib -r $(OBJS)
		
.PHONY : clean

clean:
	del  $(BUILD_OBJS_TEST_TARGET1) $(BUILD_OBJS_TARGET)
