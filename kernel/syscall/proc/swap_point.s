@PAGE 2 3
@ADDRESSABLE kernel.swap_point
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

@DECLARE stride 2

; main
    IMM acc, .kernel.proc!+
    MMU @mmu.kernel_data_target
; register init
    MLD zer, .kernel.proc.swap_index!
    RST @iterator
    IMM @stride_location, @stride
    IMM @iterator_mask, 0x1F

.find_proc_iteration:
    AST @iterator
    ADD @stride_location
    AND @iterator_mask
    RST @iterator
; load proc frame
    MLD @iterator, .kernel.proc!
    BRH #zero, .find_proc_iteration
    RST @task_segment

.staged_proc:
    MLD @iterator, .kernel.proc! 0x01
    RST @task_metadata
    // todo:
    // second stage of process swap, priority indexing

.execute_proc:
    AST @iterator
    MST zer, .kernel.proc.swap_index!
; context store segment
    IMM acc, .kernel.swap!+
    MMU @mmu.kernel_data_target
; skip process traceback
    PPL
    BRH #zero, .skip_snapshot
; save call stack head
    MMU @mmu.pid_load
    BSL 4
    RST @context_store_location
    CPL
    MST @context_store_location, 0x80
.&skip_snapshot:
    IMM acc, 0x0F
    AND @task_metadata
    MMU @mmu.pid_register
; lower address
    BSL 4
    MLD acc, 0x80
    CPS acc
; upper address
    CPS @task_segment

; restore context
    IMM acc, .kernel.restore!+
    MMU @mmu.instruction_target
    JMP zer, .kernel.restore!