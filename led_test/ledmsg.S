        .include "config.inc"

        .set    noreorder

        .text
        .globl  _start
        .ent    _start
_start:
        br      $29, 1f
1:
        lda     $30, stack_top - 1b($29)
        lda     $8, PCI_IO_CPU_BASE_HIGH_NIBBLE($31)
        sll     $8, 28, $8                     /* 0x1c0000000: PCI I/O */
        ldah    $1, MOD_DISP_CPU_OFFSET_HI($31)
        lda     $1, MOD_DISP_CPU_OFFSET_LO($1)
        addq    $8, $1, $8                     /* MOD_DISP_REG sparse addr */
        lda     $9, message - 1b($29)          /* current message char */

scroll_loop:
        ldbu    $13, 0($9)                     /* ASCII char */
        beq     $13, restart_message
        bsr     $26, write_display
        bsr     $26, delay
        lda     $9, 1($9)
        br      $31, scroll_loop

restart_message:
        lda     $9, message - 1b($29)
        br      $31, scroll_loop
        .end    _start

/*
 * in: $13 ASCII character.  AXPvme display accepts the ASCII-compatible
 *     character code in bits <6:0>; bit <7> selects bright intensity.
 */
        .ent    write_display
write_display:
        and     $13, 0x7f, $1
        .if     DISPLAY_BRIGHT
        bis     $1, 0x80, $1
        .endif
        stl     $1, 0($8)
        mb
        ret     $31, ($26), 1
        .end    write_display

        .ent    delay
delay:
        ldiq    $1, DELAY_COUNT
delay_loop:
        subq    $1, 1, $1
        bne     $1, delay_loop
        ret     $31, ($26), 1
        .end    delay

message:
        .ascii  " HELLO AXPVME230 "
        .byte   0

        .align  3
stack:
        .space  1024
stack_top:
