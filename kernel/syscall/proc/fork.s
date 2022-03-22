@PAGE 2 0
@OVERFLOWABLE

// Spawns a new process and immediately starts executing the zero-page of it. This
// kernel call should be called with the snapshot QOS header, as its context and
// application address will be stored as a snapshot.

// Type: returnable (@QOSTRACECALL)
// Arguments: segment address
// Returns: empty tuple

// TODO: filesystem permissions

@DECLARE new_proc_index 1
@DECLARE stride_location 2
@DECLARE context_store_location 2

@DECLARE stride 2

; main
    IMM acc, .kernel.proc!+
    MMU @mmu.kernel_data_target
    PRF .kernel.proc!-
; register init
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
    MST @new_proc_index, .kernel.proc!
; place target segment
    PPK
    MST @new_proc_index
    .kernel.proc! 0x01

; snapshot location in context store
    IMM acc, .kernel.swap!+
    MMU @mmu.kernel_data_target
; save call stack head
    MMU @mmu.pid_load
    BSL 4
    RST @context_store_location
    CPL
    MST @context_store_location, 0x80

; configure new pid
    AST @new_proc_index
    BSR 1
    MMU @mmu.pid_register
; continue
    PPL
    MMU @mmu.instruction_target
    JMP zer, 0x00