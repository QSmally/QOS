@PAGE 4 4
@ADDRESSABLE std.strchr

// Finds and returns the index of a character in a string.

// Type: returnable (2 bytes)
// Arguments: character, lower address
// Returns: character index

@DECLARE location 1
@DECLARE character 2

; main
    PPL
    RST @location
    PPL
    RST @character
.loop:
    MLI @location, 0
    BRH #zero, .not_found
    SUB @character
    BRH #!zero, .loop
; found
    DEC @location
    PPS acc
    @QOS @kernel.return
.not_found:
    PPI, 0x00
    @QOS @kernel.return