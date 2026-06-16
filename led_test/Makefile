LOCAL_TOOLCHAIN = .toolchain/usr

ifneq ($(wildcard $(LOCAL_TOOLCHAIN)/bin/alpha-linux-gnu-as),)
TOOL_ENV = LD_LIBRARY_PATH=$(abspath $(LOCAL_TOOLCHAIN)/lib/x86_64-linux-gnu)
AS      = $(abspath $(LOCAL_TOOLCHAIN)/bin/alpha-linux-gnu-as)
LD      = $(abspath $(LOCAL_TOOLCHAIN)/bin/alpha-linux-gnu-ld)
OBJCOPY = $(abspath $(LOCAL_TOOLCHAIN)/bin/alpha-linux-gnu-objcopy)
OBJDUMP = $(abspath $(LOCAL_TOOLCHAIN)/bin/alpha-linux-gnu-objdump)
else
TOOL_ENV =
AS      = alpha-linux-gnu-as
LD      = alpha-linux-gnu-ld
OBJCOPY = alpha-linux-gnu-objcopy
OBJDUMP = alpha-linux-gnu-objdump
endif

LOAD_ADDR ?= 0x00200000

ASFLAGS = -m21064 -I.
LDFLAGS = -T link.ld --defsym LOAD_ADDR=$(LOAD_ADDR) -Map=ledmsg.map -nostdlib

.PHONY: all clean

all: ledmsg.bin ledmsg.dis

ledmsg.o: ledmsg.S config.inc
	$(TOOL_ENV) $(AS) $(ASFLAGS) -o $@ $<

ledmsg.elf: ledmsg.o link.ld
	$(TOOL_ENV) $(LD) $(LDFLAGS) -o $@ ledmsg.o

ledmsg.bin: ledmsg.elf
	$(TOOL_ENV) $(OBJCOPY) -O binary $< $@

ledmsg.dis: ledmsg.elf
	$(TOOL_ENV) $(OBJDUMP) -D $< > $@

clean:
	rm -f ledmsg.o ledmsg.elf ledmsg.bin ledmsg.map ledmsg.dis
