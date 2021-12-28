@PAGE 1 1
@ADDRESSABLE kernel.swap

// An internal callable which pushes the CPU registers onto the context stack, in
// ascending order. It's required to pull them in reversed order out of the stack.

@DECLARE pid 1
@DECLARE base_location 1

.main:
    POI 1
    CPS
; load page
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
; swap
    POI @base_location
    CPL
    MST 1
    POI @base_location
    AST 2
    MST 2
    POI @base_location
    AST 3
    MST 3
    POI @base_location
    AST 4
    MST 4
    POI @base_location
    AST 5
    MST 5
    POI @base_location
    AST 6
    MST 6
    POI @base_location
    AST 7
    MST 7
; store page
    PPL
    POI 0
    DSS
    4
    @RETURN