@PAGE 1 0

// The gateway of kernel/OS calls which are made with 'ENT', automatically enters
// kernel mode and swaps to the right call page.

// TODO:
// For QCPU CLI, add an 'emulator' configuration closure in the defaults file to
// configure the address for the ENT instruction, generate an MMU enumeration
// automatically and construct the address array for '(kernel_)intermediate_load'.

; main
    PPL
    RSH 0
    PPS 0
    BRH #underflow, .syscall
    @CALL kernel.swap
.syscall:
    PPL
    MMU @mmu.kernel_intermediate_load