@PAGE 2 5

// Instantiates and schedules a new task, generically, and requires it to exit
// by using the 'interrupt return' system call.

// Type: @QOSSUBROUTINE
// Arguments: priority, segment address, lower address
// Returns: empty tuple

; return
    IMM acc, .kernel.restore+
    MMU @mmu.instruction_target
    @GOTO kernel.restore