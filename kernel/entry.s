@PAGE 1 0

// The gateway of kernel/OS calls which are made with 'ENT', automatically enters
// kernel mode.

.main:
    @CALL kernel.swap
    PPL
    PST @port.mmu
    @MMU @mmu.intermediate_load