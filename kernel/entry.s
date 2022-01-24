@PAGE 1 0

// The gateway of kernel/OS calls which are made with 'ENT', automatically enters
// kernel mode and swaps to the right call page.

.main:
    PPL
    RSH 0
    PPS 0
    CND #underflow
    BRH 0, .syscall
    @CALL kernel.swap
.syscall:
    PPL
    MMU @mmu.kernel_intermediate_load