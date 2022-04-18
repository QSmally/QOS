@PAGE 2 4

// Schedules an interrupt to be ran at some point, and requires it to run the
// 'task_return' system call to exit.

// Type: @QOSSUBROUTINE
// Arguments: interrupt type
// Returns: empty tuple

@DECLARE new_int_index 1
@DECLARE stride_constant 2

; main
    @PREFETCH kernel.interrupts!
    IMM @new_int_index, 0
    IMM @stride_constant, 2

.find_empty_iteration:
    MLD @new_int_index, .kernel.interrupts! 0x00
    BRH #zero, .add_interrupt
; increment frame pointer
    AST @new_int_index
    ADD @stride_constant
    RST @new_int_index
    JMP zer, .find_empty_iteration

.add_interrupt:
    PPL
    MST @new_int_index, .kernel.interrupts! 0x00
; segment address
    CPL
    MST @new_int_index, .kernel.interrupts! 0x01
; lower address
    CPL
    MST @new_int_index, .kernel.interrupts! 0x02

; next task
    @GOTO kernel.next_task