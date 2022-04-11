@PAGE 4 3
@ADDRESSABLE std.strcpy

// Allocates a new array with the contents of the source array.

// Type: returnable (2 bytes)
// Arguments: source lower address, destination lower address
// Returns: empty tuple

// TODO:
// Implement string pipelining by appending the entire memory array to the stack,
// mitigates cache thrashing.

@DECLARE source_location 1
@DECLARE copy_location 2

; main
    PPL
    RST @copy_location
    PPL
    RST @source_location
    JMP zer, .first_iteration_loop
.loop:
    INC @copy_location
.first_iteration_loop:
    MLI @source_location, 0
    MST @copy_location, 0
    BRH #!zero, .loop
; return
    @QOS @kernel.return