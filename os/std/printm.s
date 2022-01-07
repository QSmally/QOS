@PAGE 4 1
@ADDRESSABLE std.printm

// Prints a string from a start location in memory, expects a null-byte ending the
// string.

// Type: returnable (2 bytes)
// Arguments: lower address
// Returns: empty tuple

@DECLARE location 1

.main:
    PPL
    RST @location
    CND #zero
.print_loop:
    MLD @location, 0
    BRH 0, .return
    PST 0, @port.io
    INC @location
    JMP 0, .print_loop
.return:
    @QOS @kernel.return