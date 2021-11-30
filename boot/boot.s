@PAGE 0 0

// The first thing QCPU sees when booting up.

.main:
    @MMUARG .os.main-
    @MMUARG .os.main+
    @MMU @mmu.intermediate_load