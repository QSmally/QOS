@PAGE 2 3
@OVERFLOWABLE

// Switches contexts to another process, depends on the process cycle age and
// priority. It uses a round robin-like process scheduling algorithm which adds
// task priority.

// Preemptive, round-robin, priority based

// Type: returnable or not-returnable (@QOSTRACECALL or @QOS)
// Arguments: 1 if returnable, 0 if not
// Returns: empty tuple

@DECLARE iterator 1
@DECLARE task_segment 2
@DECLARE task_metadata 3
@DECLARE stride_location 4
@DECLARE context_store_location 4
@DECLARE iterator_mask 5
@DECLARE cycle_age 7
@DECLARE cycle_age_reset 6
@DECLARE clear_age_constant 7

@DECLARE stride 2

; main
    IMM acc, .kernel.proc!+
    MMU @mmu.kernel_data_target
; process index
    MLD zer, .kernel.metadata.swap_index!
    RST @iterator
; variables and constants
    IMM @stride_location, @stride
    IMM @iterator_mask, 0b00011111
    IMM @cycle_age_reset, 0x00

.&find_proc_iteration:
    AST @iterator
    ADD @stride_location
    AND @iterator_mask
    RST @iterator
; swap overflow
    BRH #zero, .cycle_reset
    .&load_proc_frame:
        MLD @iterator, .kernel.proc!
        BRH #zero, .find_proc_iteration
        RST @task_segment

.staged_proc:
    MLD @iterator, .kernel.proc! 0x01
    RST @task_metadata
; fetch cycle age
    IMM acc, 0b11000000
    AND @task_metadata
    BSR 6
    RST @cycle_age
; compare with cycle priority
    IMM acc, 0b00110000
    AND @task_metadata
    BSR 4
    INC acc
    SUB @cycle_age
    BRH #zero, .find_proc_iteration

; execute process, increment cycle age
    IMM acc, 0b01000000
    ADD @task_metadata
    MST @iterator, .kernel.proc! 0x01
; save swap index
    AST @iterator
    MST zer, .kernel.metadata.swap_index!
; context store segment
    IMM acc, .kernel.swap!+
    MMU @mmu.kernel_data_target
; skip process traceback
    PPL
    BRH #zero, .skip_snapshot
    ; save call stack head
        MMU @mmu.pid_load
        BSL 3
        RST @context_store_location
        CPL
        MST @context_store_location, 0x80
.&skip_snapshot:
    AST @iterator
    BSR 1
    MMU @mmu.pid_register
; lower address
    BSL 3
    MLD acc, 0x80
    CPS acc
; upper address
    CPS @task_segment

; restore context
    IMM acc, .kernel.restore!+
    MMU @mmu.instruction_target
    JMP zer, .kernel.restore!

.&cycle_reset:
    AST @cycle_age_reset
    BRH #!zero, .reset_counter_head
    ; set validation bit
        IMM @cycle_age_reset, 0x01
        JMP zer, .load_proc_frame
    .reset_counter_head:
        IMM @clear_age_constant, 0b00111111
    .reset_counter_loop:
        MLD @iterator, .kernel.proc! 0x01
        AND @clear_age_constant
        MST @iterator, .kernel.proc! 0x01
    ; increment iterator
        AST @iterator
        ADD @stride_location
        AND @iterator_mask
        RST @iterator
    ; optional continue
        BRH #!zero, .reset_counter_loop
        JMP zer, .load_proc_frame