@PAGE 3 1

// Sets the segment for data memory to the instruction segment address.

// Type: returnable
// Arguments: empty tuple
// Returns: empty tuple

; main
    MMU @mmu.instruction_target_load
    MMU @mmu.data_target
; return
    IMM acc, .kernel.restore+
    MMU @mmu.instruction_target
    @GOTO kernel.restore