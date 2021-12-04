@PAGE 1 0

// The gateway of kernel/OS calls which are made with 'ENT', automatically enters
// kernel mode and swaps to the right call page.

.main:
    @CALL kernel.swap
    @MMUDYNAMICARG PPL
    @MMU @mmu.kernel_intermediate_load