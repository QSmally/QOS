@PAGE 2 0
@OVERFLOWABLE

// Spawns a new process and immediately starts executing the zero-page of it. This
// kernel call should be called with the snapshot QOS header, as its context and
// application address will be stored as a snapshot.

// Type: @QOSTRACECALL
// Arguments: segment address
// Returns: empty tuple

// TODO: filesystem permissions

@DECLARE new_proc_index 1
@DECLARE stride_location 2
@DECLARE context_store_location 2

@DECLARE stride 2

; main
    PRF .kernel.proc!-
    IMM @stride_location, @stride
    IMM @new_proc_index, 0

.find_empty_iteration:
    AST @new_proc_index
    ADD @stride_location
    RST @new_proc_index
; exceeds process maximum
    @IF !performance-unsafe
        BSR 5
        BRH #zero, .in_bounds
    ; panic
        IMM acc, .kernel.panic!+
        MMU @mmu.instruction_target
        JMP zer, .kernel.panic!
    @END
.in_bounds:
    MLD @new_proc_index, .kernel.proc!
    BRH #!zero, .find_empty_iteration

; place parent pid
    MMU @mmu.pid_load
    MST @new_proc_index, .kernel.proc! 0x01
; place target segment
    PPK
    MST @new_proc_index, .kernel.proc! 0x00

; reschedule old task
    // TODO: reschedule old task

; configure new pid
    AST @new_proc_index
    BSR 1
    MMU @mmu.pid_register

; continue
    PPL
    MMU @mmu.instruction_target
    MMU @mmu.kernel_exit
    JMP zer, 0x00