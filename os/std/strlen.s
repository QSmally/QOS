@PAGE 4 2
@ADDRESSABLE std.strlen

// Counts the number of bytes in an array in memory and must end with a null-byte.

// Type: returnable (2 bytes)
// Arguments: lower address
// Returns: array length

@DECLARE location 1
@DECLARE start_location 2

; main
    PPL
    RST @location
    RST @start_location
.loop:
    MLI @location, 0
    BRH #!zero, .loop
; return
    DEC @location
    SUB @start_location
    PPS acc
    @QOS @kernel.return