@PAGE 0 0
@ADDRESSABLE kernel.boot

// The first thing QCPU sees when booting up.

@DECLARE string_iterator 1

; main
    IMM @string_iterator, .qos_string
.load_char:
    MLD @string_iterator, 0
    BRH #!zero, .print_char
; start os
    IMM acc, .os.login+
    MMU @mmu.instruction_target
    MMU @mmu.kernel_exit
    @GOTO os.login
.print_char:
    PST zer, @port.io
    INC @string_iterator
    JMP zer, .load_char

.qos_string:
    $QOS, 0x0A
    0x00