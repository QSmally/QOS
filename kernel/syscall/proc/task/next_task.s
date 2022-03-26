@PAGE 2 6
@ADDRESSABLE kernel.next_task

; return
    IMM acc, .kernel.restore+
    MMU @mmu.instruction_target
    @GOTO kernel.restore