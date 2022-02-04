@PAGE 3 1

// Sets the segment for data memory to the instruction segment address.

// Type: returnable
// Arguments: empty tuple
// Returns: empty tuple

.main:
    MMU @mmu.instruction_target_load
    MMU @mmu.instruction_target
    IMM 0, .kernel.restore+
    MMU @mmu.instruction_target
    JMP 0, .kernel.restore