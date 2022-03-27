@PAGE 2 3

// Switches contexts to another process by rescheduling the current task and
// selecting a new task from the top of the queue.

// Type: @QOSSUBROUTINE
// Arguments: empty tuple
// Returns: empty tuple

// TODO:
// Task priority override as parameter.

@DECLARE queue_head 1
@DECLARE next_lower_address 2
@DECLARE stride_constant 3

; reschedule task
    @CALL kernel.schedule

.&kernel.next_task:
    IMM @stride_constant, 4
    MLD zer, .kernel.nodes.task_queue_head!
    RST @queue_head
; lower address
    MLD acc, .kernel.task_queue! 0x01
    CPS acc
; pid
    MLD @queue_head, .kernel.task_queue! 0x02
    BSR 4
    MMU @mmu.pid_register
; segment address
    MLD @queue_head, .kernel.task_queue! 0x00
    CPS acc
; decrement queue frame pointer
    AST @queue_head
    SUB @stride_constant
    MST zer, .kernel.nodes.task_queue_head!
; continue
    IMM acc, .kernel.restore+
    MMU @mmu.instruction_target
    @GOTO kernel.restore