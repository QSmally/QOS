@PAGE 2 0

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
    @MMUSTATICARG .kernel.proc+
    @MMU @mmu.kernel_data_target
    @MMU @mmu.pid_load
    RST @current_proc_index
    IMM @new_proc_index, 0
    IMM @stride_loc, @stride
; maximum process panic
    @IF !performance-unsafe
        IMM @max_proc_count, 16
        MLD 0, .kernel.proc.count!
        SUB @max_proc_count
        @DROPTHROUGH CND #!zero
        BRH 0, .find_empty_iteration
    ; panic if overflow
        @MMU16LABEL kernel.panic
        @MMU @mmu.exit_intermediate_load
    @END
.find_empty_iteration:
    AST @new_proc_index
    ADD @stride_loc
    RST @new_proc_index
    MLD @new_proc_index, .kernel.proc
    BRH 0, .find_empty_iteration
; insert parent pid
    AST @current_proc_index
    MST @new_proc_index, .kernel.proc
    AST @new_proc_index
    @MMU @mmu.pid_register
; insert application segment address
    PPL
    RST @target_segment
    MST @new_proc_index, 0x41 ; todo: add OR syntax
; increment process count
    MLD 0, .kernel.proc.count!
    INC 0
    MST 0, .kernel.proc.count!
; swap to new context
    @MMUDYNAMICARG AST @target_segment
    @MMU @mmu.exit_intermediate_load