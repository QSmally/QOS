@PAGE 1 1
@ADDRESSABLE kernel.swap

@MAKEPAGE context_store_0 1 4
@MAKEPAGE context_store_1 1 5
@MAKEPAGE context_store_2 1 6
@MAKEPAGE context_store_3 1 7

// An internal callable which pushes the CPU registers onto the context store. The
// block of memory is determined by the process id: the lower two bits being the
// page, and upper two bits (shifted to the left) is the write head.

// Type: returnable (1 byte)
// Arguments: empty tuple
// Returns: empty tuple

@DECLARE base_location 1

.main:
    PPS 1
    MMU @mmu.pid_load
    BSL 4
    RST @base_location
; swap
    PPL
    MST @base_location, 0x81
    AST 2
    MST @base_location, 0x82
    AST 3
    MST @base_location, 0x83
    AST 4
    MST @base_location, 0x84
    AST 5
    MST @base_location, 0x85
    AST 6
    MST @base_location, 0x86
    AST 7
    MST @base_location, 0x87
; return
    @RETURN