CFLAGS=-lgphobos -lgdruntime -g -funittest -Wall -Isrc -fdebug
# https://stackoverflow.com/questions/5618615/check-if-a-program-exists-from-a-makefile

FEDORA_UBUNTU := $(shell command -v gdc-12 2> /dev/null)
ifdef $(FEDORA_UBUNTU)
CC=gdc-12
else
CC=cc
endif

MATH_SRC=$(shell find szymanowski/math -type f -name "*.d")

math.o : $(MATH_SRC)
	$(CC) $(CFLAGS) -c -o $@ $^

clean :
	rm -rf $(wildcard *.o) html latex

docs :
	doxygen