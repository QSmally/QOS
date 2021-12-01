@PAGE 0 0

// The first thing QCPU sees when booting up.

.main:
    @MMUSTATICARG .os.main-
    @MMUSTATICARG .os.main+
    @MMU @mmu.intermediate_load