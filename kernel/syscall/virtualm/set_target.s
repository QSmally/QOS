@PAGE 2 6

// Targets another segment, granted this process has permissions for that, for the
// data memory. It will automatically reset this when switching contexts to another
// process. However, not when entering privileged subroutines.

// Type: returnable
// Arguments: upper address
// Returns: empty tuple

// TODO: filesystem permissions

.main:
    @MMUDYNAMICARG PPL
    @MMU @mmu.data_target
    @MMU16LABEL kernel.restore
    @MMU @mmu.intermediate_load