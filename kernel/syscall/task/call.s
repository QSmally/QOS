@PAGE 2 3

// Calls to subroutine on another segment and requires the permission to be granted
// by that node.

// Type: returnable
// Arguments: subroutine parameters, upper address, lower address
// Returns: defined by subroutine

// TODO: filesystem permissions

.main:
    PPL
    MMU @mmu.instruction_segment
    MMU @mmu.kernel_exit
    PPL
    JMP 7, 0