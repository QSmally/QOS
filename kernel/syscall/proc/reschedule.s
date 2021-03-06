@PAGE 2 3

// Switches contexts to another process by rescheduling the current task and
// selecting a new task from the top of the queue.

// Type: @QOSSUBROUTINE
// Arguments: empty tuple
// Returns: empty tuple

// TODO:
// Task priority override as parameter.

@DECLARE stride_constant 1
@DECLARE queue_head 7

; reschedule task
    MMU @mmu.pid_load
    BSL 1, FWD
    MLD fwd, .kernel.proc! + 0x01
    BSR 4
    PPS acc
    @CALL kernel.schedule

.&kernel.next_task(9):
    IMM @stride_constant, 4
    MLD zer, .kernel.nodes.task_queue_head!
    SUB @stride_constant
    RST @queue_head
    MST zer, .kernel.nodes.task_queue_head!
; lower address
    MLD @queue_head, .kernel.task_queue! + 0x01
    CPS acc
; pid
    MLD @queue_head, .kernel.task_queue! + 0x02
    BSR 4
    MMU @mmu.pid_register
; segment address
    MLD @queue_head, .kernel.task_queue! + 0x00
    CPS acc
; continue
    IMM acc, .kernel.restore+
    MMU @mmu.instruction_target
    @GOTO kernel.restore