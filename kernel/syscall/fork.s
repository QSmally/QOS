@PAGE 2 0

@DECLARE current_proc_mask 1
@DECLARE index 2
@DECLARE stride 3

.main:
    @MMUSTATICARG .kernel.active_processes-
    @MMUSTATICARG .kernel.active_processes+
    @MMU @mmu.data_load
    MLD 0
    RST @current_proc_mask
    @BYTE @index 0
    @BYTE @stride 2
    CND #!zero
.iteration:
    AST @index
    ADD @stride
    RST @index
    POI @index
    MLD 0
    JMP .iteration
.create:
    @BYTE 0 0x1F
    AND @current_proc_mask
    POI @index
    MST 0
    MST 0
.return:
    @MMUSTATICARG .kernel.restore-
    @MMUSTATICARG .kernel.restore+
    @MMU @mmu.intermediate_load