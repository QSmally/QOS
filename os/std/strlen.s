@PAGE 4 2
@ADDRESSABLE std.strlen

// Counts the number of bytes in an array in memory and must end with a null-byte.

// Type: returnable (2 bytes)
// Arguments: lower address
// Returns: array length

@DECLARE location 1
@DECLARE count 2

.main:
    PPL
    RST @location
    IMM @count, 0
    CND #zero
.byte_loop:
    MLD @location, 0
    BRH 0, .return
    INC @location
    INC @count
    JMP 0, .byte_loop
.return:
    PPS @count
    @QOS @kernel.return