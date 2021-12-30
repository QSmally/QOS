@PAGE 1 2
@ADDRESSABLE kernel.restore

// Moves back the captured context to registers and immediately branches to the two
// bytes popped from the call stack.

// Type: non-returnable
// Arguments: empty tuple
// Returns: never

@DECLARE pid 1
@DECLARE base_location 1

.main:
    @MMU @mmu.pid_load
    RST @pid
    @BYTE 0 0x03
    AND @pid
    POI 0
    DLS
    4
; calculate start position
    @BYTE 0 0x0C
    AND @pid
    RST @base_location
    ADD @base_location
    RST @base_location
; swap
    POI @base_location
    MLD 7
    RST 7
    POI @base_location
    MLD 6
    RST 6
    POI @base_location
    MLD 5
    RST 5
    POI @base_location
    MLD 4
    RST 4
    POI @base_location
    MLD 3
    RST 3
    POI @base_location
    MLD 2
    RST 2
    POI @base_location
    MLD 1
    RST 1
; return
    @MMUDYNAMICARG CPL
    @MMUDYNAMICARG CPL
    @MMU @mmu.exit_intermediate_load