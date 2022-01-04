@PAGE 0 1
@ADDRESSABLE kernel.panic

// If any catastrophic event happens, burn!

.main:
    CND #!zero
.call_trace:
    CPL
    PST @port.io
    BRH 0, .call_trace
.spin_lock:
    JMP 0, .spin_lock