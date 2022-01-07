@PAGE 2 3

// Calls to subroutine on another segment and requires the permission to be granted
// by that node.

// Type: returnable
// Arguments: subroutine parameters, upper address, lower address
// Returns: defined by subroutine

// TODO: filesystem permissions

.main:
    @MMUDYNAMICARG PPL
    @MMUDYNAMICARG PPL
    @MMU @mmu.exit_intermediate_load