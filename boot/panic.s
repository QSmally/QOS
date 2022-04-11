@PAGE 0 1
@ADDRESSABLE kernel.panic

// If any catastrophic event happens, burn!

.call_trace:
    CPL
    PRT zer, @port.io
    BRH #!zero, .call_trace
.spin_lock:
    JMP zer, .spin_lock