@PAGE 2 3
@ADDRESSABLE kernel.func.swap_point

// Switches contexts to another process.

// Type: returnable
// Arguments: empty tuple
// Returns: empty tuple

@DECLARE proc_iterator_index 1

@DECLARE max_index 30
@DECLARE stride 2

.main:
    @MMU16LABEL kernel.proc
    @MMU @mmu.data_load
    @MMU @mmu.pid_load
    RST @proc_iterator_index
    CND #zero
.find_nonempty_iteration:
    @BYTE 0 @max_index
    SUB @proc_iterator_index
    JMP .loop_back
    @BYTE 0 @stride
    ADD @proc_iterator_index
    RST @proc_iterator_index
    POI @proc_iterator_index
    MLD 0
    JMP .find_nonempty_iteration
; ignore swap if same context
    @MMU @mmu.pid_load
    SUB @proc_iterator_index
    JMP .continue
.swap_context:
    AST @proc_iterator_index
    @MMU @mmu.pid_register
.continue:
    @MMU16LABEL kernel.restore
    @MMU @mmu.intermediate_load
.loop_back:
    @BYTE @proc_iterator_index 0
    JMP .find_nonempty_iteration