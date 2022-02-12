@PAGE 2 0
@OVERFLOWABLE

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

; main
    IMM 0, .kernel.proc+
    MMU @mmu.kernel_data_target
    IMM @new_proc_index, 0
    IMM @stride_location, @stride
.find_empty_iteration:
    AST @new_proc_index
    ADD @stride_location
    RST @new_proc_index
; maximum index panic
    @IF !performance-unsafe
        BSR 5
        BRH #!zero, .overflow_panic
    @END
    MLD @new_proc_index, .kernel.proc
    BRH #!zero, .find_empty_iteration
; insert parent pid
    MMU @mmu.pid_load
    MST @new_proc_index, .kernel.proc
; insert target segment
    PPL
    MST @new_proc_index, 0x41
; swap to new pid
    AST @new_proc_index
    BSR 1
    MMU @mmu.pid_register
; save address
    IMM 0, .kernel.swap+
    MMU @mmu.kernel_data_target
    AST @new_proc_index
    BSR 3
    RST @context_store_location
    CPL
    MST @context_store_location, 0x80
; continue
    AST @new_proc_index
    MMU @mmu.instruction_target
    JMP 0, 0
@IF !performance-unsafe
    .&overflow_panic:
        IMM 0, .kernel.panic+
        MMU @mmu.instruction_target
        JMP 0, .kernel.panic
@END