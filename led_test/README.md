# AXPvme230 front panel LED test

This is a small bare Alpha AXP program intended to be loaded from SRM and
executed on a DEC AXPvme230.  It scrolls an ASCII message on the front-panel
5x7 dot-matrix alphanumeric display.

## Required tools

Install GNU binutils for Alpha:

```sh
sudo apt-get install binutils-alpha-linux-gnu
```

The host `as`/`ld` on x86_64 cannot assemble Alpha instructions.  The Makefile
uses:

- `alpha-linux-gnu-as`
- `alpha-linux-gnu-ld`
- `alpha-linux-gnu-objcopy`

## Hardware Notes

The AXPvme documentation describes the display as a single 5x7 dot-matrix
intelligent display at:

- PCI I/O address `MOD_DISP_REG = 0x2400`
- bits `<6:0>`: display character
- bit `<7>`: bright intensity

The DECchip 21066 PCI I/O window starts at CPU physical address `0x1c0000000`.
For sparse byte access, the CPU physical address is:

```text
0x1c0000000 + (pci_io_byte_address << 5)
```

So this program writes `stl` to CPU physical address `0x1c0048000`, asserting
only the byte lane for PCI I/O byte address `0x2400`.

Set `DISPLAY_BRIGHT = 0` in `config.inc` if normal brightness is preferred.

## Build

```sh
make
```

Outputs:

- `ledmsg.elf`: ELF image with symbols.
- `ledmsg.bin`: flat binary for SRM loading.
- `ledmsg.map`: link map.
- `ledmsg.dis`: disassembly.

Override the load address if needed:

```sh
make LOAD_ADDR=0x00200000
```

## SRM

The exact SRM command depends on your console firmware and boot medium.  The
important part is that the binary must be loaded at the same address used for
`LOAD_ADDR`, and execution must start at that address.

Example shape:

```text
>>> load -addr 200000 ledmsg.bin
>>> go 200000
```

Confirm the exact syntax with `help load` and `help go` on the AXPvme230 SRM.

Before running the binary, you can verify the display register from SRM:

```text
>>> deposit -b pciio:2400 d7
>>> show led
```

The first command should display a bright `W`, matching the hardware manual's
example.
