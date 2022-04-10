

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

TARGET = ./build/main 
OBJMAP := .\output\*.map
OBJHTM := .\output\*.htm
OBJAXF := .\output\*.axf

OBJS = .\deps\swap\swap.o \
       .\deps\divide\divide.o \
       .\deps\random\rand.o \
       .\deps\1darray\init_1dArray.o .\deps\1darray\set_1dArray.o .\deps\1darray\set_order_1dArray.o\
       .\lib\bingo_shuffle_1darray.o main.o

BUILD_OBJS_TARGET= $(foreach n, $(OBJS),build\$(n))

###########################################
#test_shuffle
###########################################
TEST_NAME = test_set_minus_1
TEST_TARGET1 = .\build\test\$(TEST_NAME)
OBJS_TEST_TARGET1 = deps\swap\swap.o \
       deps\divide\divide.o \
       deps\random\rand.o \
       deps\printf\printf_dec.o deps\printf\printf_hex.o \
       deps\1darray\init_1dArray.o deps\1darray\set_1dArray.o deps\1darray\set_order_1dArray.o deps\1darray\get_1dArray.o \
       deps\2darray\init_2dArray.o deps\2darray\set_2dArray.o deps\2darray\get_2dArray.o \
       lib\bingo_shuffle_1darray.o lib\bingo_init_board.o  lib\bingo_set_minus_1.o\
       test\$(TEST_NAME).o

BUILD_OBJS_TEST_TARGET1= $(foreach n, $(OBJS_TEST_TARGET1),build\$(n))


all : main $(TEST_NAME)
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

$(info INC is $(notdir $(CURDIR)))
main: $(OBJS) 
#armlink ../hello-1.o -Output $@
	$(ARMLINK) $(LINKFLAGS)  $(BUILD_OBJS_TARGET) -Output $(TARGET)

$(TEST_NAME): $(OBJS_TEST_TARGET1) 
#armlink ../hello-1.o -Output $@
	$(ARMLINK) $(LINKFLAGS) $(BUILD_OBJS_TEST_TARGET1) -Output $(TEST_TARGET1)

%.o: %.s
	
	@if not exist build\$(@D) mkdir build\$(@D)
	$(ARMASM) $(ASMFLAGS) $(INC) $< -o .\build\$@ 	
	


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
