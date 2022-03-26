@PAGE 2 2

// Terminates the process which is currently active. It must be called with the
// unaddressed syscall header.

// Type: @QOS
// Arguments: empty tuple
// Returns: empty tuple

@DECLARE current_proc_index 1

; main
    PRF .kernel.proc-

; generate address
    MMU @mmu.pid_load
    BSL 1
    RST @current_proc_index
; remove entry
    IMM acc, 0
    MST @current_proc_index, .kernel.proc! 0x00
    MST @current_proc_index, .kernel.proc! 0x01

; continue
    @GOTO kernel.next_task