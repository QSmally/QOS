@PAGE 0 0
@ADDRESSABLE kernel.boot

// The first thing QCPU sees when booting up.

@DECLARE string_iterator 1

.main:
    DLS
    .kernel.str*
    @BYTE @string_iterator .kernel.str.qos
.load_char:
    POI @string_iterator
    MLD 0
    CND #!zero
    JMP .print_char
; start os
    @MMU16LABEL os.main
    @MMU @mmu.exit_intermediate_load
.print_char:
    PST @port.io
    INC @string_iterator
    CND #true
    JMP .load_char