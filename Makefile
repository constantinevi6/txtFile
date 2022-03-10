CC		:= gcc
CXX		:= g++
AR      := ar
CXXFLAGS := -std=c++17 -Wall -Wextra -g
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
INC	:= -I$(INCDIR) $(shell $(INC_PC))

LIB_PC	?= pkg-config --libs $(PKG)
LIB		:= -Llib64 $(shell $(LIB_PC))
LDFLAGS := 

SRCS	:= $(wildcard $(SRCDIR)/*.cpp)
OBJS 	:= $(patsubst %.cpp,%.o,$(SRCS))

ifeq ($(OS),Windows_NT)
TARGET	:= $(LIBDIR)/$(PROJECT).lib

else
TARGET	:= $(LIBDIR)/$(PROJECT).a

endif

$(TARGET): $(OBJS)
	@mkdir -p $(@D)
	$(AR) $(LINKFLAGS) $@ $^

%.o: %.cpp
	${CXX} -c -o $@ $< ${CXXFLAGS} ${INC}

all: $(TARGET)
	@make clear

clear:
	$(RM) -rf $(SRCDIR)/*.o
	
clean: clear
	$(RM) -rf $(TARGET)
	
install: $(PREFIX)/$(LIBDIR)/$(TARGET)
	cp $(TARGET) $(PREFIX)/$(LIBDIR)/$(TARGET)
		
remove: $(PREFIX)/$(LIBDIR)/$(TARGET)
	$(RM) -rf $(PREFIX)/$(LIBDIR)/$(TARGET)

