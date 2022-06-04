@PAGE 0 1
@ADDRESSABLE kernel.panic

// If any catastrophic event happens, burn!

@DECLARE string_iterator 1

; main
    PRT zer, @port.terminal_newline
    IMM @string_iterator, .kernel_panic_string
.load_char:
    MLI @string_iterator, 0
    PRT zer, @port.terminal_push
    BRH #!zero, .load_char
.call_trace:
    CPL
    PRT zer, @port.integer
    BRH #!zero, .call_trace
.spin_lock:
    @GOTO spin_lock

.kernel_panic_string:
    $Kernel panic
    0x00