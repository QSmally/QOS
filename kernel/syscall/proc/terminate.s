@PAGE 2 2

// Terminates the process which is currently active. It must be called with the
// unaddressed syscall header.

// Type: non-returnable
// Arguments: empty tuple
// Returns: empty tuple

@DECLARE current_proc_index 1

.main:
    IMM acc, .kernel.proc+
    MMU @mmu.kernel_data_target
    MMU @mmu.pid_load
    BSL 1
    RST @current_proc_index
    IMM acc, 0
    MST @current_proc_index, 0x40
    MST @current_proc_index, 0x41
; continue
    @GOTO kernel.swap_point