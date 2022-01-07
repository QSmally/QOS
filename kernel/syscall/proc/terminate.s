@PAGE 2 1

// Terminates the process which is currently active. It must be called with the
// unaddressed syscall header.

// Type: non-returnable
// Arguments: empty tuple
// Returns: empty tuple

@DECLARE current_proc_index 1

.main:
    @MMUSTATICARG .kernel.proc+
    @MMU @mmu.kernel_data_target
    @MMU @mmu.pid_load
    RST @current_proc_index
    IMM 0, 0
    MST @current_proc_index, 0
    MST @current_proc_index, 1
; decrement process count
    MLD 0, .kernel.proc.count!
    INC 0
    MST 0, .kernel.proc.count!
; continue
    @GOTO kernel.calls.swap_point