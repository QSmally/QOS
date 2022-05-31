@PAGE 0 0
@ADDRESSABLE kernel.boot

// The first thing QCPU sees when booting up.

@DECLARE string_iterator 1

; main
    IMM @string_iterator, .qos_string
.load_char:
    MLI @string_iterator, 0
    PRT zer, @port.terminal_push
    BRH #!zero, .load_char
; start os
    IMM acc, .os.login+
    MMU @mmu.instruction_target
    IMM acc, 0x01
    MMU @mmu.pid_register
    MMU @mmu.kernel_exit
    @GOTO os.login

.qos_string:
    $QOS, 0x0A
    0x00