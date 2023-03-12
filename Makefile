########################################################################
####################### Makefile Template ##############################
########################################################################

# Compiler settings - Can be customized.
CC = g++
CXXFLAGS = -std=c++17 -Wall -static-libstdc++ -static-libgcc -Wwrite-strings -g -lm -lzmq -lpthread
LDFLAGS = --disable-stdcall-fixup

# Makefile settings - Can be customized.
APPNAME = RaspiComms
EXT = .cpp
SRCDIR = src
OBJDIR = obj

############## Do not change anything from here downwards! #############
SRC = $(wildcard $(SRCDIR)/*$(EXT))
OBJ = $(SRC:$(SRCDIR)/%$(EXT)=$(OBJDIR)/%.o)
DEP = $(OBJ:$(OBJDIR)/%.o=%.d)
# UNIX-based OS variables & settings
RM = rm
DELOBJ = $(OBJ)
# Windows OS variables & settings
DEL = del
EXE = .exe
WDELOBJ = $(SRC:$(SRCDIR)/%$(EXT)=$(OBJDIR)\\%.o)

########################################################################
####################### Targets beginning here #########################
########################################################################

all: comms_control comms_img

comms_control: $(SRCDIR)/comms_control.cpp
	$(CPP) $(CXXFLAGS) $(SRCDIR)/comms_control.cpp -o $(OBJDIR)/comms_control.o -c

comms_img: $(SRCDIR)/comms_img.cpp
	$(CPP) $(CXXFLAGS) $(SRCDIR)/comms_img.cpp -o $(OBJDIR)/comms_img.o -c

install:
	sudo cp src/headers/* /usr/include

# # Builds the app
# $(APPNAME): $(OBJ)
# 	$(CC) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)
#
# # Creates the dependecy rules
# %.d: $(SRCDIR)/%$(EXT)
# 	@$(CPP) $(CFLAGS) $< -MM -MT $(@:%.d=$(OBJDIR)/%.o) >$@
#
# # Includes all .h files
# -include $(DEP)
#
# # Building rule for .o files and its .c/.cpp in combination with all .h
# $(OBJDIR)/%.o: $(SRCDIR)/%$(EXT)
# 	$(CC) $(CXXFLAGS) -o $@ -c $<
#
# ################### Cleaning rules for Unix-based OS ###################
# # Cleans complete project
# .PHONY: clean
# clean:
# 	$(RM) $(DELOBJ) $(DEP) $(APPNAME)
#
# # Cleans only all files with the extension .d
# .PHONY: cleandep
# cleandep:
# 	$(RM) $(DEP)
#
# #################### Cleaning rules for Windows OS #####################
# # Cleans complete project
# .PHONY: cleanw
# cleanw:
# 	$(DEL) $(WDELOBJ) $(DEP) $(APPNAME)$(EXE)
#
# # Cleans only all files with the extension .d
# .PHONY: cleandepw
# cleandepw:
# 	$(DEL) $(DEP)
