@PAGE 2 6

// Restores and returns from the most recent privileged subroutine.

// Type: non-returnable
// Arguments: subroutine return values
// Returns: empty tuple

.main:
    IMM acc, .kernel.restore!+
    MMU @mmu.instruction_target
    JMP zer, .kernel.restore!