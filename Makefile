CC= gcc -Wall
LDFLAGS= -lfl
HEADER_FILES_DIR = .
INCLUDES = -I $(HEADER_FILES_DIR)
MAIN= ejecucion
SRCS = main.c lex.yy.c ejemplo.tab.c funciones.c
DEPS = $(HEADER_FILES_DIR)/lex.yy.h define.h ejemplo.tab.h funciones.h
OBJS = $(SRCS:.c=.o) 
$(MAIN): $(OBJS)
	$(CC) -o $(MAIN) $(OBJS) -g -lm
	rm -f *.o *~
%.o: %.c $(DEPS)
	$(CC) -c $< $(INCLUDES)
cleanall: clean
	rm -f $(MAIN)
clean:
	rm -f *.o *~
