/*
 * AXPvme front-panel display configuration.
 *
 * AXPvme Single-Board Computer Technical Description:
 *   MOD_DISP_REG = PCI I/O address 2400h
 *
 * DECchip 21066 sparse PCI I/O byte addressing:
 *   CPU physical address = 0x1c0000000 + (PCI byte address << 5)
 *
 * MOD_DISP_REG is byte-wide.  The display character is bits <6:0>; bit <7>
 * selects bright intensity.
 */
PCI_IO_CPU_BASE_HIGH_NIBBLE = 0x1c
MOD_DISP_REG = 0x2400
MOD_DISP_CPU_OFFSET = MOD_DISP_REG << 5
MOD_DISP_CPU_OFFSET_HI = (MOD_DISP_CPU_OFFSET + 0x8000) >> 16
MOD_DISP_CPU_OFFSET_LO = MOD_DISP_CPU_OFFSET - (MOD_DISP_CPU_OFFSET_HI << 16)

DISPLAY_BRIGHT = 1

/* Delay loop count between scroll steps. */
DELAY_COUNT = 0x00100000
