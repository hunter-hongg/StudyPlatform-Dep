DC = gdc
TARGET = test
SRCS = test.d
COPYDIR = ../test/lib
all:
	$(DC) $(SRCS) -o lib$(TARGET).so -shared -fPIC
clean:
	rm -f lib$(TARGET).so
copy:
	cp lib$(TARGET).so $(COPYDIR)