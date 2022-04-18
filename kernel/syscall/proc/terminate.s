@PAGE 2 2

// Terminates the process which is currently active. It must be called with the
// unaddressed syscall header.

// Type: @QOS
// Arguments: empty tuple
// Returns: empty tuple

@DECLARE current_proc_index 1
@DECLARE segment_address 1

; main
    @PREFETCH kernel.proc!

; generate address
    MMU @mmu.pid_load
    BSL 1
    RST @current_proc_index
; remove entry
    IMM acc, 0
    MST @current_proc_index, .kernel.proc! 0x00
    MST @current_proc_index, .kernel.proc! 0x01

; next task
    @GOTO kernel.next_task

.create_task(12):
    // Instantiates and schedules a new task, generically, and requires it to exit
    // by using the 'interrupt return' system call.

    // Type: @QOSSUBROUTINE
    // Arguments: segment address, lower address, task priority
    // Returns: empty tuple

; main
    PPL
    RST @segment_address
    PPL
    CPS acc
    CPS @segment_address
    @CALL kernel.schedule
; continue
    IMM acc, .kernel.restore+
    MMU @mmu.instruction_target
    @GOTO kernel.restore