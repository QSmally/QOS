@PAGE 2 2

// Terminates the process which is currently active. It must be called with the
// unaddressed syscall header.

@DECLARE current_pid 1
@DECLARE current_proc_index 2

.main:
    @MMUSTATICARG .kernel.proc+
    @MMUSTATICARG .kernel.proc-
    @MMU @mmu.data_load
    MLD .kernel.proc.current!
    RST @current_pid
    ADD @current_pid
    RST @current_proc_index
    @BYTE 0 0
    POI @current_proc_index
    MST 0
.continue:
    // TODO: swap contexts to another process and clear '.kernel.proc.current'
    @MMUSTATICARG .kernel.panic+
    @MMUSTATICARG .kernel.panic-
    @MMU @mmu.exit_intermediate_load