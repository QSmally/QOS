@PAGE 2 6

; return
    IMM acc, .kernel.restore+
    MMU @mmu.instruction_target
    @GOTO kernel.restore