@PAGE 2 3

// Switches contexts to another process by rescheduling the current task and
// selecting a new task from the top of the queue.

// Type: @QOSSUBROUTINE
// Arguments: empty tuple
// Returns: empty tuple

// TODO:
// Task priority override as parameter.

@DECLARE queue_head 1
@DECLARE stride_constant 1

; reschedule task
    PPI, 5
    @CALL kernel.schedule

.&kernel.next_task:
    IMM @stride_constant, 4
    MLD zer, .kernel.nodes.task_queue_head!
    SUB @stride_constant
    RST @queue_head
    MST zer, .kernel.nodes.task_queue_head!
; lower address
    MLD @queue_head, .kernel.task_queue! 0x01
    CPS acc
; pid
    MLD @queue_head, .kernel.task_queue! 0x02
    BSR 4
    MMU @mmu.pid_register
; segment address
    MLD @queue_head, .kernel.task_queue! 0x00
    CPS acc
; continue
    IMM acc, .kernel.restore+
    MMU @mmu.instruction_target
    @GOTO kernel.restore