CFLAGS=-lgphobos -lm -g -funittest -Wall -fdebug
# https://stackoverflow.com/questions/5618615/check-if-a-program-exists-from-a-makefile

MATH_SRC=$(shell find szymanowski/math -type f -name "*.d")
MAIN_SRC=szymanowski/main.d

a.out : math.o $(MAIN_SRC)
	$(CC) $(CFLAGS) $^

math.o : $(MATH_SRC) 
	$(CC) $(CFLAGS) -c -o $@ $^

clean :
	rm -rf $(wildcard *.o) html latex

docs :
	doxygen