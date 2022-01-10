@PAGE 2 0

// Spawns a new process and immediately starts executing the zero-page of it. This
// kernel call should be called with the snapshot QOS header, as its context and
// application address will be stored as a snapshot.

// Type: returnable
// Arguments: segment address
// Returns: empty tuple

// TODO: filesystem permissions

@DECLARE new_proc_index 1
@DECLARE stride_location 2
@DECLARE context_store_location 2

@DECLARE stride 2

.main:
    @MMUSTATICARG .kernel.proc+
    @MMU @mmu.kernel_data_target
    IMM @new_proc_index, 0
    IMM @stride_location, @stride
    CND #!zero
.find_empty_iteration:
    AST @new_proc_index
    ADD @stride_location
    RST @new_proc_index
; maximum index panic
    @IF !performance-unsafe
        BSR 5
        BRH .overflow_panic
    @END
    MLD @new_proc_index, .kernel.proc
    BRH 0, .find_empty_iteration
; insert parent pid
    @MMU @mmu.pid_load
    MST @new_proc_index, .kernel.proc
; insert target segment
    PPL
    MST @new_proc_index, 0x41
; swap to new pid
    AST @new_proc_index
    BSR 1
    @MMU @mmu.pid_register
; save address
    @MMUSTATICARG .kernel.swap+
    @MMU @mmu.kernel_data_target
    AST @new_proc_index
    BSR 3
    RST @context_store_location
    CPL
    MST @context_store_location, 0x80
; continue
    @MMUDYNAMICARG AST @new_proc_index
    @MMU @mmu.exit_intermediate_load
@IF performance-unsafe
    .overflow_panic:
        @MMU16LABEL kernel.panic
        @MMU @mmu.exit_intermediate_load
@END