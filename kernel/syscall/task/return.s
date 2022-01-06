@PAGE 2 5

// Restores and returns from the most recent privileged subroutine.

// Type: non-returnable
// Arguments: subroutine return values
// Returns: empty tuple

.main:
    @MMU16LABEL kernel.restore
    @MMU @mmu.intermediate_load