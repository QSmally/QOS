@PAGE 0 0
@ADDRESSABLE kernel.boot

// The first thing QCPU sees when booting up.

@DECLARE string_iterator 1

; main
    IMM @string_iterator, .qosstring
.load_char:
    MLD @string_iterator, 0
    BRH #!zero, .print_char
; start os
    IMM accumulator, .os.main+
    MMU @mmu.instruction_target
    MMU @mmu.kernel_exit
    JMP zero, .os.main
.print_char:
    PST zero, @port.io
    INC @string_iterator
    JMP zero, .load_char

.qosstring(24):
    $login >
    0x00