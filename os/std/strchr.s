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
    MLD @location, 0
    BRH #zero, .not_found
    SUB @character
    BRH #zero, .found
    INC @location
    JMP zero, .loop
.found:
    PPS @location
    @QOS @kernel.return
.not_found:
    PPI, 0x00
    @QOS @kernel.return