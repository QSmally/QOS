@PAGE 2 4
@ADDRESSABLE kernel.func.call

// Calls to subroutine on another segment and requires the permission to be granted
// by that node.

// Type: returnable
// Arguments: subroutine parameters, target address
// Returns: defined by subroutine

// TODO: filesystem permissions

.main:
    @MMUDYNAMICARG MLD .kernel.proc.current!
    @MMU @mmu.context_snapshot
; branch to segment
    @MMUDYNAMICARG PPL
    @MMUDYNAMICARG PPL
    @MMU @mmu.exit_intermediate_load