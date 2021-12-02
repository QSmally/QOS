@PAGE 0 0
@ADDRESSABLE kernel.boot

// The first thing QCPU sees when booting up.

.main:
    @MMUSTATICARG .os.main-
    @MMUSTATICARG .os.main+
    @MMU @mmu.intermediate_load