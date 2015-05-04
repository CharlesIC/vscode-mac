DMCS=/usr/local/bin/dmcs
HOST=/usr/local/bin/mono
NUGET=$(HOST) ~/Library/developer/nuget/nuget.exe
NUNIT=$(HOST) packages/NUnit.Runners.2.6.4/tools/nunit-console.exe

SRCFILES=$(shell find src/main -name '*.cs')
TSTFILES=$(shell find src/test -name '*.cs')
BUILDOUTPUT=target
APP=$(BUILDOUTPUT)/App.exe
DLLS=$(shell find packages -name '*.dll')

clean:
	rm -rf $(BUILDOUTPUT)
	mkdir -p $(BUILDOUTPUT)

restore:
	$(NUGET) restore -o packages
	
build: clean
	$(DMCS) -out:$(APP) -debug \
        $(foreach dll, $(DLLS), $(addprefix -reference:, $(dll))) \
        $(SRCFILES)

	$(DMCS) -out:$(APP).dll -debug -target:library -reference:$(APP) \
        $(foreach dll, $(DLLS), $(addprefix -reference:, $(dll))) \
        $(TSTFILES)
		
	find packages -name '*.dll' -not -path 'packages/NUnit.Runners.*' -exec cp {} $(BUILDOUTPUT) \;

test:
	$(NUNIT) -result=$(BUILDOUTPUT)/TestResult.xml $(APP).dll

run: build
	$(HOST) $(APP)
