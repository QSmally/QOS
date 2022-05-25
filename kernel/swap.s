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
@DECLARE base_context_store 0x80

; main
    PPS 1
    MMU @mmu.pid_load
    BSL 3
    RST @base_location
; swap
    PPL
    MST @base_location
    @base_context_store | 0x01
    AST 2
    MST @base_location
    @base_context_store | 0x02
    AST 3
    MST @base_location
    @base_context_store | 0x03
    AST 4
    MST @base_location
    @base_context_store | 0x04
    AST 5
    MST @base_location
    @base_context_store | 0x05
    AST 6
    MST @base_location
    @base_context_store | 0x06
    AST 7
    MST @base_location
    @base_context_store | 0x07
; return
    @RETURN