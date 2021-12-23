@PAGE 2 2
@ADDRESSABLE kernel.func.terminate

// Terminates the process which is currently active. It must be called with the
// unaddressed syscall header.

// Type: non-returnable
// Arguments: empty tuple
// Returns: empty tuple

@DECLARE current_proc_index 1

.main:
    @MMU16LABEL kernel.proc
    @MMU @mmu.data_load
    @MMU @mmu.pid_load
    RST @current_proc_index
    @BYTE 0 0
    POI @current_proc_index
    MST 0
    POI @current_proc_index
    MST 1
; decrement process count
    MLD .kernel.proc.count!
    INC 0
    MST .kernel.proc.count!
; continue
    @GOTO kernel.func.swap_point