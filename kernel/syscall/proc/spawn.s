@PAGE 2 0
@OVERFLOWABLE

// Spawns a new process and immediately starts executing the zero-page of it. This
// kernel call should be called with the snapshot QOS header, as its context and
// application address will be stored as a snapshot.

// Type: @QOSSUBROUTINE
// Arguments: segment address
// Returns: empty tuple

// TODO:
// Filesystem permissions.

@DECLARE new_proc_index 1
@DECLARE stride_constant 2

; main
    @PREFETCH kernel.proc!
    IMM @new_proc_index, 0
    IMM @stride_constant, 2

.find_empty_iteration:
    AST @new_proc_index
    ADD @stride_constant
    RST @new_proc_index
    MLD @new_proc_index, .kernel.proc!
    BRH #!zero, .find_empty_iteration

; place parent pid
    MMU @mmu.pid_load
    MST @new_proc_index, .kernel.proc! + 0x01
; place target segment
    PPK
    MST @new_proc_index, .kernel.proc! + 0x00

; schedule old task
    PPI, 5
    @CALL kernel.schedule

; configure new pid
    AST @new_proc_index
    BSR 1
    MMU @mmu.pid_register

; continue
    PPL
    MMU @mmu.instruction_target
    MMU @mmu.kernel_exit
    JMP zer, 0x00