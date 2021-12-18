@PAGE 1 0

// The gateway of kernel/OS calls which are made with 'ENT', automatically enters
// kernel mode and swaps to the right call page.

@DECLARE call_id 1

.main:
; temporarily always load the 'proc' data block to retrieve the current PID, will
; probably be automatcially loaded on privilege swaps in the future.
    @MMU16LABEL kernel.proc
    @MMU @mmu.data_load
; the LSB indicates no context store
    PPL
    RSH 0
    RST @call_id
    CND #underflow
    JMP .syscall
    @CALL kernel.swap
.syscall:
    @MMUDYNAMICARG AST @call_id
    @MMU @mmu.kernel_intermediate_load