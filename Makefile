CC		:= gcc
CXX		:= g++
AR      := ar
CXXFLAGS := -std=c++17 -Wall -Wextra -g -fopenmp
LINKFLAGS := rcs

PROJECT     := txtFile
BINDIR		:= bin
LIBDIR		:= lib
INCDIR   	:= $(PROJECT)
SRCDIR		:= $(PROJECT)
PREFIX      := ./$(LIBDIR)

PKG     :=
ifeq ($(PKG),)
	INC_PC	:=
	LIB_PC	:=
endif

INC_PC	?= pkg-config --cflags $(PKG)
INC	:= -I$(INCLUDEDIR) $(shell $(INC_PC))

LIB_PC	?= pkg-config --libs $(PKG)
LIB		:= -Llib64 $(shell $(LIB_PC))
LDFLAGS := -lstdc++fs

ifeq ($(OS),Windows_NT)
TARGET	:= $(PROJECT).lib

else
TARGET	:= $(PROJECT).a

endif

$(LIBDIR)/$(TARGET): $(SRCDIR)/$(PROJECT).o
	@mkdir -p $(@D)
	$(AR) $(LINKFLAGS) $@ $<
	@make clear

%.o: %.cpp $(INCDIR)/*.hpp
	${CXX} -c -o $@ $< ${CXXFLAGS} ${INC} ${LIB} $(LDFLAGS)


all: $(BINDIR)/$(EXECUTABLE)

clear:
	$(RM) -rf $(SRCDIR)/*.o
	
clean: clear
	$(RM) -rf $(BINDIR)/$(EXECUTABLE)
	
install: $(PREFIX)/$(TARGET)
	cp $(LIBDIR)/$(TARGET) $(PREFIX)/$(TARGET)
		
remove: $(PREFIX)/$(TARGET)
	$(RM) -rf $(PREFIX)/$(TARGET)
	
run: all
	./$(BINDIR)/$(EXECUTABLE)
