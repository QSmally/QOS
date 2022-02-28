@PAGE 0 1
@ADDRESSABLE kernel.panic

// If any catastrophic event happens, burn!

.call_trace:
    CPL
    PST zero, @port.io
    BRH #!zero, .call_trace
.spin_lock:
    JMP zero, .spin_lock