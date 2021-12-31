@PAGE 1 3
@ADDRESSABLE kernel.context_store

// An internal function which returns the page address and uses register 1 for the
// base location of the pointer.

// Type: returnable (1 byte)
// Arguments: empty tuple
// Returns: upper index without OR 4

@DECLARE pid 1
@DECLARE base_location 1

.main:
    @MMU @mmu.pid_load
    RST @pid
    @BYTE 0 0x03
    AND @pid
    PPS
    POI 0
    DLS
    4
; calculate start position
    @BYTE 0 0x0C
    AND @pid
    RST @base_location
    ADD @base_location
    RST @base_location
; return
    @RETURN