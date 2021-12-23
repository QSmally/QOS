@PAGE 1 0

// The gateway of kernel/OS calls which are made with 'ENT', automatically enters
// kernel mode and swaps to the right call page.

@DECLARE call_id 1

.main:
    PPL
    RSH 0
    RST @call_id
    CND #underflow
    JMP .syscall
    @CALL kernel.swap
.syscall:
    @MMUDYNAMICARG AST @call_id
    @MMU @mmu.kernel_intermediate_load