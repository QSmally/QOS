@PAGE 2 7

// Sets the segment for data memory to the instruction segment address.

// Type: returnable
// Arguments: empty tuple
// Returns: empty tuple

.main:
    @MMU @mmu.reset_data_target
    @MMU16LABEL kernel.restore
    @MMU @mmu.intermediate_load