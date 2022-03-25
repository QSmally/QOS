@PAGE 3 2

// Calls to subroutine on another segment and requires the permission to be granted
// by that node.

// Type: returnable (@QOSSUBROUTINE)
// Arguments: subroutine parameters, upper address, lower address
// Returns: defined by subroutine

// TODO: filesystem permissions

; main
    PPL
    MMU @mmu.instruction_target
    MMU @mmu.kernel_exit
    PPL
    JMP acc, 0