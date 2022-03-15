@PAGE 4 0
@ADDRESSABLE std.prints

// Print 'stack' outputs the contents of the stack for some amount of bytes.

// Type: returnable (2 bytes)
// Arguments: bytes..., amount of bytes
// Returns: empty tuple

@DECLARE amount 1

; main
    PPL
    RST @amount
.print_loop:
    AST @amount
    BRH #zero, .return
    PPL
    PST zer, @port.io
    DEC @amount
    JMP zer, .print_loop
.return:
    @QOS @kernel.return