@PAGE 2 0
@OVERFLOWABLE

// Spawns a new process and immediately starts executing the zero-page of it. This
// kernel call should be called with the snapshot QOS header, as its context and
// application address will be stored as a snapshot.

// Type: @QOSSUBROUTINE
// Arguments: segment address, action
// Returns: empty tuple

// TODO:
// Filesystem permissions.

// Action:
// 0x00: no reschedule
// 0x01: reschedule self
// 0x02: terminate self (todo)

@DECLARE reschedule 1
@DECLARE stride_constant 2
@DECLARE new_proc_index 7

; main
    @PREFETCH kernel.proc!
    PPL
    RST @reschedule
    IMM @stride_constant, 2
    IMM @new_proc_index, 0

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

; optionally schedule old task
    AST @reschedule
    BRH #zero, .configure_pid
    PPI, 5
    @CALL kernel.schedule

.configure_pid:
    AST @new_proc_index
    BSR 1
    MMU @mmu.pid_register

; continue
    PPL
    MMU @mmu.instruction_target
    MMU @mmu.kernel_exit
    JMP zer, 0x00