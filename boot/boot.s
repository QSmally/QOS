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
    IMM acc, .os.main+
    MMU @mmu.instruction_target
    MMU @mmu.kernel_exit
    JMP zer, .os.main
.print_char:
    PST zer, @port.io
    INC @string_iterator
    JMP zer, .load_char

.qosstring:
    $QOS, 0x0A
    $login >
    0x00