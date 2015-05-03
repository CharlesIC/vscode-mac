DMCS=/usr/local/bin/dmcs
HOST=/usr/local/bin/mono
NUGET=$(HOST) ~/Library/developer/nuget/nuget.exe

SRCFILES=$(shell find src/main -name '*.cs')
TSTFILES=$(shell find src/test -name '*.cs')
BUILDOUTPUT=target
APP=$(BUILDOUTPUT)/App.exe

clean:
	rm -rf $(BUILDOUTPUT)
	mkdir -p $(BUILDOUTPUT)

restore:
	$(NUGET) restore -o packages
	
build: clean
	$(DMCS) -out:$(APP) -debug  $(SRCFILES)
	$(DMCS) -out:$(APP).dll -debug -target:library -reference:$(APP) $(TSTFILES)

test:
	$(NUNIT) 

run: build
	$(HOST) $(APP)
