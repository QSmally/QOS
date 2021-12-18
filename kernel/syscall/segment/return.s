@PAGE 2 5
@ADDRESSABLE kernel.func.return

// Restores and returns from the most recent privileged subroutine.

// Type: non-returnable
// Arguments: subroutine return values
// Returns: empty tuple

.main:
    @MMUDYNAMICARG MLD .kernel.proc.current!
    @MMU @mmu.context_restore
; branch to segment
    @MMU16LABEL kernel.restore
    @MMU @mmu.intermediate_load