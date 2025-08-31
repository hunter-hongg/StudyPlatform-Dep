TARGETNAME = FFI_D_AncientJuanZeng
TARGETDIR = target

all: 
	mkdir -p $(TARGETDIR)
	gdc -shared -fPIC -o $(TARGETDIR)/lib$(TARGETNAME).so *.d
copy:
	cp $(TARGETDIR)/lib$(TARGETNAME).so ../test/lib