@PAGE 2 2

// Terminates the process which is currently active. It must be called with the
// unaddressed syscall header.

// Type: non-returnable (@QOS)
// Arguments: empty tuple
// Returns: empty tuple

@DECLARE current_proc_index 1

; main
    IMM acc, .kernel.proc!+
    MMU @mmu.kernel_data_target
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
    PPI, 0x00
    @GOTO kernel.swap_point