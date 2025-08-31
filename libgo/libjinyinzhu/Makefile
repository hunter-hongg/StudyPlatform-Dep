COMPILER = go
COMMAND = build
FLAG = -buildmode=c-shared
TARGETDIR = target
TARGETNAME = FFI_Go_AncientJinYinZhu
COPYDIR = ../test2

all:
	mkdir $(TARGETDIR) -p
	$(COMPILER) $(COMMAND) $(FLAG) -o $(TARGETDIR)/lib$(TARGETNAME).so *.go
copy:
	cp $(TARGETDIR)/lib$(TARGETNAME).so $(COPYDIR)/lib
	cp $(TARGETDIR)/lib$(TARGETNAME).h $(COPYDIR)/include
clean: 
	rm -rf $(TARGETDIR)