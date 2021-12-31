@PAGE 0 1
@ADDRESSABLE kernel.panic

// If any catastrophic event happens, burn!

.call_trace:
    CND #!zero
    CPL
    PST @port.io
    JMP .call_trace
    CND #true
.spin_lock:
    JMP .spin_lock