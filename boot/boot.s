@PAGE 0 0
@ADDRESSABLE kernel.boot

// The first thing QCPU sees when booting up.

@DECLARE string_iterator 1

.main:
    IMM @string_iterator, .kernel.str.qos-
    CND #!zero
.load_char:
    MLD @string_iterator, 0
    BRH 0, .print_char-
; start os
    @MMU16LABEL os.main
    @MMU @mmu.exit_intermediate_load
.print_char:
    PST @port.io
    INC @string_iterator
    JMP 0, .load_char-