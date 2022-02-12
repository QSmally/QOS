@PAGE 1 0

// The gateway of kernel/OS calls which are made with 'ENT', automatically enters
// kernel mode and swaps to the right call page.

.main:
    PPL
    RSH 0
    PPS 0
    BRH #underflow, .syscall
    @CALL kernel.swap
.syscall:
    PPL
    MMU @mmu.kernel_intermediate_load