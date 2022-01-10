@PAGE 1 2
@ADDRESSABLE kernel.restore

// Moves back the captured context to registers and immediately branches to the two
// bytes popped from the call stack.

// Type: non-returnable
// Arguments: empty tuple
// Returns: never

@DECLARE base_location 1

.main:
    @MMU @mmu.pid_load
    BSL 4
    RST @base_location
; swap
    MLD @base_location, 0x87
    RST 7
    MLD @base_location, 0x86
    RST 6
    MLD @base_location, 0x85
    RST 5
    MLD @base_location, 0x84
    RST 4
    MLD @base_location, 0x83
    RST 3
    MLD @base_location, 0x82
    RST 2
    MLD @base_location, 0x81
    RST 1
; return
    @MMUDYNAMICARG CPL
    @MMUDYNAMICARG CPL
    @MMU @mmu.exit_intermediate_load