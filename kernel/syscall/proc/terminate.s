@PAGE 2 2
@ADDRESSABLE kernel.func.terminate

// Terminates the process which is currently active. It must be called with the
// unaddressed syscall header.

@DECLARE current_proc_index 1

.main:
    MLD .kernel.proc.current!
    POI 0
    MST 0
    POI 0
    MST 1
; decrement process count
    MLD .kernel.proc.count!
    INC 0
    MST .kernel.proc.count!
; continue
    @GOTO kernel.func.swap_point