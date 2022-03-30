@PAGE 2 5

// Instantiates and schedules a new task, generically, and requires it to exit
// by using the 'interrupt return' system call.

// Type: @QOSSUBROUTINE
// Arguments: segment address, lower address, task priority
// Returns: empty tuple

@DECLARE segment_address 1

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