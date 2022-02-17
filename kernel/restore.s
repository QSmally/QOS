@PAGE 1 2
@ADDRESSABLE kernel.restore

// Moves back the captured context to registers and immediately branches to the two
// bytes popped from the call stack.

// Type: non-returnable
// Arguments: empty tuple
// Returns: never

@DECLARE base_location 1
@DECLARE base_context_store 0x80

; main
    MMU @mmu.pid_load
    BSL 4
    RST @base_location
; swap
    MLD @base_location
    @base_context_store 0x07
    RST 7
    MLD @base_location
    @base_context_store 0x06
    RST 6
    MLD @base_location
    @base_context_store 0x05
    RST 5
    MLD @base_location
    @base_context_store 0x04
    RST 4
    MLD @base_location
    @base_context_store 0x03
    RST 3
    MLD @base_location
    @base_context_store 0x02
    RST 2
    MLD @base_location
    @base_context_store 0x01
    RST 1
; return
    CPL
    MMU @mmu.instruction_target
    MMU @mmu.kernel_exit
    @RETURN