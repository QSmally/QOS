@PAGE 2 0
@ADDRESSABLE kernel.func.fork
@OVERFLOWABLE

// Spawns a new process and immediately starts executing the zero-page of it. This
// kernel call should be called with the requestable header, as its context and
// application address will be stored as a snapshot.

// Type: returnable
// Arguments: process target segment address
// Returns: empty tuple

// TODO: filesystem permissions

@DECLARE current_proc_index 1
@DECLARE target_segment 2
@DECLARE new_proc_index 3
@DECLARE stride_loc 4
@DECLARE max_proc_count 5

@DECLARE stride 2

.main:
    MLD .kernel.proc.current!
    RST @current_proc_index
    @BYTE @new_proc_index 0
    @BYTE @stride_loc @stride
    CND #!zero
; maximum process panic
    @IF !performance-unsafe
        @BYTE @max_proc_count 16
        MLD .kernel.proc.count!
        SUB @max_proc_count
        JMP .find_empty_iteration
    ; panic if overflow
        @MMU16LABEL kernel.panic
        @MMU @mmu.exit_intermediate_load
    @END
.find_empty_iteration:
    AST @new_proc_index
    ADD @stride_loc
    RST @new_proc_index
    POI @new_proc_index
    MLD 0
    JMP .find_empty_iteration
; insert parent pid
    AST @current_proc_index
    POI @new_proc_index
    MST 0
    AST @new_proc_index
    MST .kernel.proc.current!
; insert application segment address
    PPL
    RST @target_segment
    POI @new_proc_index
    MST 1
; increment process count
    MLD .kernel.proc.count!
    INC 0
    MST .kernel.proc.count!
; swap to new context
    @MMU16LABEL kernel.proc
    @MMU @mmu.data_store
    @MMUDYNAMICARG AST @current_proc_index
    @MMU @mmu.context_snapshot
    @MMUDYNAMICARG AST @target_segment
    @MMU @mmu.exit_intermediate_load