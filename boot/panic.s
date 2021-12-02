@PAGE 0 1
@ADDRESSABLE kernel.panic

// If any catastrophic event happens, burn!

.main:
    CND #true
    JMP .main