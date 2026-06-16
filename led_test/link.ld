OUTPUT_ARCH(alpha)
ENTRY(_start)

SECTIONS
{
  . = DEFINED(LOAD_ADDR) ? LOAD_ADDR : 0x00200000;

  .text : {
    *(.text*)
    *(.rodata*)
  }

  . = ALIGN(8);
  .data : {
    *(.data*)
  }

  . = ALIGN(8);
  .bss : {
    *(.bss*)
    *(COMMON)
  }

  /DISCARD/ : {
    *(.note*)
    *(.comment*)
    *(.eh_frame*)
  }
}
