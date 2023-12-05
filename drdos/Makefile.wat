.EXTENSIONS: .a86
.ERASE

WASM = jwasm
WASM_FLAGS = -q -Zm -Zg
EXE2BIN = exe2bin
WLINK = wlink

LTOOLS = ..\ltools
RASM = $(LTOOLS)\rasm86.exe
RASM_SH = $(LTOOLS)\rasm_sh.exe
RASM_FLAGS =

objs  = bin/buffers.obj bin/dirs.obj bin/fdos.obj bin/fcbs.obj bin/bdevio.obj
objs += bin/cdevio.obj bin/fioctl.obj bin/redir.obj bin/header.obj
objs += bin/pcmif.obj bin/cio.obj bin/disk.obj bin/ioctl.obj bin/misc.obj
objs += bin/support.obj bin/dosmem.obj bin/error.obj bin/process.obj
objs += bin/network.obj bin/int2f.obj bin/history.obj bin/cmdline.obj
objs += bin/dos7.obj bin/lfn.obj

bin/drdos.sys: bin/drdos.inp version.inc $(objs) .SYMBOLIC
	cd bin
	..\$(LTOOLS)\linkcmd.exe drdos[i]
	cd ..
	$(LTOOLS)\bin2asc -ob -s128 .\bin\drdos.tmp .\bin\drdos.sys
	$(LTOOLS)\compbdos .\bin\drdos.sys

version.inc: ../version.inc
	copy ..\version.inc .

bin/drdos.inp: drdos.inp
	copy drdos.inp bin\drdos.inp

bin/buffers.obj: buffers.a86 fdos.equ bdos.equ doshndl.def
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS) $$szpz  /DDELWATCH /DDOS5

bin/dirs.obj: dirs.a86 bdos.equ mserror.equ fdos.equ
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS) $$szpz  /DDELWATCH

bin/fdos.obj: fdos.a86 version.inc psp.def modfunc.def fdos.equ rh.equ msdos.equ mserror.equ doshndl.def driver.equ f52data.def  bdos.equ funcs.fdo utils.fdo
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS) $szpz /DDELWATCH /DKANJI /DDOS5 /DPASSWORD /DJOIN /DUNDELETE /Dshortversion

bin/fcbs.obj: fcbs.a86 mserror.equ fdos.equ driver.equ doshndl.def
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS) $$szpz

bin/bdevio.obj: bdevio.a86 fdos.equ msdos.equ mserror.equ doshndl.def bdos.equ rh.equ
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS) $$szpz /DDELWATCH /DDOS5 /DJOIN

bin/cdevio.obj: cdevio.a86 psp.def modfunc.def fdos.equ mserror.equ doshndl.def driver.equ rh.equ cmdline.equ
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS) $$szpz /DDOS5

bin/fioctl.obj: fioctl.a86 fdos.equ rh.equ msdos.equ mserror.equ doshndl.def driver.equ f52data.def
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS) $$szpz /DPASSWORD /DJOIN /DDOS5

bin/redir.obj: redir.a86 psp.def fdos.equ msdos.equ mserror.equ doshndl.def f52data.def redir.equ
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS) $$szpz /DKANJI /DDOS5 /DJOIN

bin/header.obj: header.a86 pcmode.equ vectors.def cmdline.equ doshndl.def driver.equ exe.def f52data.def fdos.equ mserror.equ psp.def reqhdr.equ country.def
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS) $$szpz /DDOS5

bin/pcmif.obj: pcmif.a86 pcmode.equ fdos.def vectors.def msdos.equ mserror.equ psp.def fdos.equ
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS) $$szpz /DDOS5

bin/cio.obj: cio.a86 pcmode.equ driver.equ reqhdr.equ msdos.equ fdos.equ psp.def mserror.equ char.def redir.equ doshndl.def
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS)

bin/disk.obj: disk.a86 pcmode.equ fdos.def doshndl.def fdos.equ psp.def msdos.equ mserror.equ redir.equ
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS) $$szpz /DDELWATCH

bin/ioctl.obj: ioctl.a86 pcmode.equ fdos.def msdos.equ mserror.equ cmdline.equ driver.equ reqhdr.equ psp.def
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS) $$szpz /DPASSWORD /DDOS5

bin/misc.obj: misc.a86 version.inc pcmode.equ msdos.equ mserror.equ psp.def driver.equ char.def country.def doshndl.def redir.equ fdos.equ
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS) $$szpz /DDOS5

bin/support.obj: support.a86 pcmode.equ fdos.def mserror.equ doshndl.def
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS)

bin/dosmem.obj: dosmem.a86 pcmode.equ msdos.equ mserror.equ
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS)

bin/error.obj: error.a86 pcmode.equ fdos.def msdos.equ mserror.equ psp.def char.def reqhdr.equ
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS)

bin/process.obj: process.a86 pcmode.equ fdos.def psp.def mserror.equ vectors.def msdos.equ exe.def char.def redir.equ doshndl.def
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS) $$szpz /DDOS5

bin/network.obj: network.a86 pcmode.equ mserror.equ redir.equ doshndl.def
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS)

bin/int2f.obj: int2f.a86 pcmode.equ msdos.equ mserror.equ driver.equ psp.def doshndl.def redir.equ
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS) $szpz /DDOS5 /DDELWATCH

bin/history.obj: history.a86 pcmode.equ msdos.equ char.def cmdline.equ
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS)

bin/cmdline.obj: cmdline.a86 pcmode.equ msdos.equ char.def cmdline.equ reqhdr.equ driver.equ
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS)

bin/dos7.obj: dos7.asm pcmode.equ fdos.equ fdos.def dos7.equ
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS)

bin/lfn.obj: lfn.asm bdos.equ fdos.equ pcmode.equ doshndl.def lfn.equ fdos.def mserror.equ
	$(RASM_SH) $(RASM) . .\$[. .\$^@ $(RASM_FLAGS)


clean: .SYMBOLIC
	rm -f bin/drdos.sys
	rm -f bin/*.obj
	rm -f bin/*.lst
	rm -f bin/*.sym
	rm -f bin/*.tmp
	rm -f bin/*.map
	rm -f bin/*.inp
	rm -f version.inc
