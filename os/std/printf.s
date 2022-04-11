@PAGE 4 1
@ADDRESSABLE std.printf

// Prints a string from a start location in memory, expects a null-byte ending the
// string.

// Type: returnable (2 bytes)
// Arguments: lower address
// Returns: empty tuple

@DECLARE location 1

; main
    PPL
    RST @location
.print_loop:
    MLI @location, 0
    PRT zer, @port.io
    BRH #!zero, .print_loop
; return
    @QOS @kernel.return