@PAGE 1 0

// The gateway of kernel/OS calls which are made with 'ENT', automatically enters
// kernel mode and swaps to the right call page.

.main:
    @CALL kernel.swap
    PPL
    PST @port.mmu
    @MMUSTATICARG 2
    @MMU @mmu.intermediate_load