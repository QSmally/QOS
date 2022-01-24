@PAGE 2 2
@ADDRESSABLE kernel.calls.swap_point

// Switches contexts to another process, depends on the process cycle age and
// priority. It uses a round robin-like process scheduling algorithm which adds
// task priority.

// Type: returnable
// Arguments: empty tuple
// Returns: empty tuple

@DECLARE iterator 1
@DECLARE task 2
@DECLARE task_priority 3
@DECLARE target_segment_address 4
@DECLARE age_removal_bits 4

@DECLARE stride 2
@DECLARE max_proc 30

.main:
    IMM 0, .kernel.proc+
    MMU @mmu.kernel_data_target
    MLD 0, .kernel.proc.swap_index!
    RST @iterator
    CND #zero
.find_priority_iteration:
    MLD @iterator, .kernel.proc
    BRH 0, .empty_iteration
; skip if no priority
    BSR 4
    RST @task
    IMM 0, 0x03
    AND @task
    RST @task_priority
    BRH 0, .empty_iteration
; skip if fulfilled
    BSR 2
    SUB @task_priority
    BRH 0, .empty_iteration
; increment task age
    IMM 0, 0x40
    ADD @task
    MST @iterator, .kernel.proc
; continue
    IMM 0, 0x0F
    AND @task
    RST @task
    MMU @mmu.pid_register
    MLD @iterator, 0x41
    CPS @target_segment_address
    IMM 0, .kernel.swap+
    MMU @mmu.kernel_data_target
    AST @task
    BSL 1
    MLD 7, 0x80
    CPS 7
    IMM 0, .kernel.restore+
    MMU @mmu.instruction_target
    JMP 0, .kernel.restore
.empty_iteration:
    IMM 0, @max_proc
    SUB @iterator
    BRH .reset_iteration_stash
    IMM 0, @stride
    ADD @iterator
    RST @iterator
    JMP .find_priority_iteration
.reset_iteration_stash:
    IMM @age_removal_bits, 0b00111111
    .reset_iteration:
        MLD @iterator, .kernel.proc
        AND @age_removal_bits
        MST @iterator, .kernel.proc
    ; decrement iterator
        IMM 0, @stride
        SUB @iterator
        RST @iterator
        BRH 0, .find_priority_iteration
    ; run loop
        JMP 0, .reset_iteration