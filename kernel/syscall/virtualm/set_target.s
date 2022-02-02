@PAGE 2 6

// Targets another segment, granted this process has permissions for that, for the
// data memory. It will automatically reset this when switching contexts to another
// process. However, not when entering privileged subroutines.

// Type: returnable
// Arguments: upper address
// Returns: empty tuple

// TODO: filesystem permissions

.main:
    PPL
    MMU @mmu.data_target
    IMM 0, .kernel.restore+
    MMU @mmu.instruction_target
    JMP 0, .kernel.restore