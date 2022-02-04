@PAGE 2 4

// Restores and returns from the most recent privileged subroutine.

// Type: non-returnable
// Arguments: subroutine return values
// Returns: empty tuple

.main:
    IMM 0, .kernel.restore!+
    MMU @mmu.instruction_target
    JMP 0, .kernel.restore!