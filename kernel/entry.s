@PAGE 1 0

// The gateway of kernel/OS calls which are made with 'ENT', automatically enters
// kernel mode and swaps to the right call page.

// TODO:
// For QCPU CLI, add an 'emulator' configuration closure in the defaults file to
// configure the address for the ENT instruction, generate an MMU enumeration
// automatically and construct the address array for '(kernel_)intermediate_load'.

.swapnt_map(0):
    0 ; 0, spawn
    1 ; 1, terminate
    0 ; 2, reschedule
    0 ; 3, create task
    0 ; 4, allocate segment
    0 ; 5, drop segment
    0 ; 6, set data target
    0 ; 7, reset data target
    0 ; 8, segment load
    0 ; 9, call
    1 ; 10, return

.main(16):
    PPK
    MLD acc, .swapnt_map
    BRH #!zero, .data_target
    @CALL kernel.swap
.data_target:
    IMM acc, .kernel.nodes!+
    MMU @mmu.kernel_data_target
; system call
    PPL
    MMU @mmu.kernel_intermediate_load