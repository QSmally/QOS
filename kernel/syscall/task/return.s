@PAGE 2 7

// Restores and returns from the most recent privileged subroutine.

// Type: non-returnable (@QOS)
// Arguments: subroutine return values
// Returns: empty tuple

; main
    IMM acc, .kernel.restore!+
    MMU @mmu.instruction_target
    JMP zer, .kernel.restore!