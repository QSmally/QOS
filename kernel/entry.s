@PAGE 1 0

// The gateway of kernel/OS calls which are made with 'ENT', automatically enters
// kernel mode.

@CALL kernel.swap
PPL
@MMUARG
@MMU @mmu.intermediate_load