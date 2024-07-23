# Platform specific definitions for Makefiles

!ifdef __UNIX__
SEP=/
CP = cp
!else
SEP=\
CP = copy
!endif

!ifdef __MSDOS__
LTOOLS = ..$(SEP)ltools$(SEP)dos
WASM = jwasmr
!else ifdef __NT__
LTOOLS = ..$(SEP)ltools$(SEP)win32
WASM = jwasm
!else ifdef __UNIX__
LTOOLS = ..$(SEP)ltools$(SEP)unix
WASM = jwasm
!else
!error Unsupported host operating system.
!endif

WASM_FLAGS = -q
WLINK = wlink
EXE2BIN = exe2bin

WCC = wcc
WMAKE = wmake -h

COMPBIOS = $(LTOOLS)$(SEP)compbios
COMPBDOS = $(LTOOLS)$(SEP)compbdos
ROUND = $(LTOOLS)$(SEP)round
