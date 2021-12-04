@PAGE 2 0
@OVERFLOWABLE

// Spawns a new process and immediately starts executing the zero-page of it. This
// kernel call should be called with the requestable header, as its context and
// application address will be stored as a snapshot.

// Arguments: process target segment address
// TODO: filesystem permissions

@DECLARE current_proc_mask 1
@DECLARE target_segment 2
@DECLARE new_pid_index 3
@DECLARE stride 4

.main:
    @MMUSTATICARG .kernel.proc+
    @MMUSTATICARG .kernel.proc-
    @MMU @mmu.data_load
    MLD .kernel.proc.current!
    RST @current_proc_mask
    @BYTE @new_pid_index 0
    @BYTE @stride 2
    CND #!zero
.iteration:
    AST @new_pid_index
    ADD @stride
    RST @new_pid_index
    POI @new_pid_index
    MLD 0
    JMP .iteration
.create:
    AST @current_proc_mask
    POI @new_pid_index
    MST 0
    AST @new_pid_index
    RSH 0
    MST .kernel.proc.current!
    PPL
    RST @target_segment
    POI @new_pid_index
    MST 1
.return:
    AST @current_proc_mask
    PST @port.mmu
    @MMU @mmu.context_snapshot
    AST @target_segment
    PST @port.mmu
    @MMU @mmu.exit_intermediate_load