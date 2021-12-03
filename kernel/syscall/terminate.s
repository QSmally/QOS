@PAGE 2 1

.main:
    // Erase the process and call the 'context swap point' system call.
.return:
    @MMUSTATICARG .kernel.restore-
    @MMUSTATICARG .kernel.restore+
    @MMU @mmu.intermediate_load