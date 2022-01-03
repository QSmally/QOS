@PAGE 2 3
@ADDRESSABLE kernel.calls.swap_point

// Switches contexts to another process.

// Type: returnable
// Arguments: empty tuple
// Returns: empty tuple

@DECLARE proc_iterator_index 1

@DECLARE max_index 30
@DECLARE stride 2

.main:
    @MMUSTATICARG .kernel.proc+
    @MMU @mmu.kernel_data_target
    @MMU @mmu.pid_load
    RST @proc_iterator_index
    CND #zero
.find_nonempty_iteration:
    IMM 0, @max_index
    SUB @proc_iterator_index
    JMP 0, .loop_back-
    IMM 0, @stride
    ADD @proc_iterator_index
    RST @proc_iterator_index
    MLD @proc_iterator_index, 0
    BRH 0, .find_nonempty_iteration-
; ignore swap if same context
    @MMU @mmu.pid_load
    SUB @proc_iterator_index
    BRH 0, .continue-
; swap context
    AST @proc_iterator_index
    @MMU @mmu.pid_register
.continue:
    @MMU16LABEL kernel.restore
    @MMU @mmu.intermediate_load
.loop_back:
    IMM @proc_iterator_index, 0
    JMP 0, .find_nonempty_iteration