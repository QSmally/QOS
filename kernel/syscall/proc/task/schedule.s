@PAGE 2 6
@ADDRESSABLE kernel.schedule
@OVERFLOWABLE

// Type: CAL
// Arguments: task priority
// Returns: empty tuple

@DECLARE return_pointer 2
@DECLARE insertion_priority 3
@DECLARE insertion_pointer 4
@DECLARE shift_pointer 5
@DECLARE shift_destination_pointer 6
@DECLARE stride_constant 7

; main
    CPL
    RST @return_pointer
    PPL
    RST @insertion_priority
    IMM @stride_constant, 4

; queue pointers
    MLD zer, .kernel.nodes.task_queue_head!
    RST @shift_destination_pointer
    SUB @stride_constant
    RST @shift_pointer
; override if queue is empty
    IMM @insertion_pointer, .kernel.task_queue.empty_address!
    SUB @shift_destination_pointer
    BRH #zero, .insert_frame
.find_target_iteration:
    MLD @insertion_pointer, 0x02
    BSR 4
    SUB @insertion_priority
    BRH #!signed, .shift_frame_iteration
; increment skipped task's priority
    ADD @insertion_priority
    INC acc
    MST @insertion_pointer, 0x02
; increment insertion pointer
    AST @insertion_pointer
    ADD @stride_constant
    RST @insertion_pointer
; continue if elements ahead
    SUB @shift_destination_pointer
    BRH #!zero, .find_target_iteration

.&shift_frame_iteration:
    MLD @shift_pointer, 0x00
    MST @shift_destination_pointer, 0x00
    MLD @shift_pointer, 0x01
    MST @shift_destination_pointer, 0x01
    MLD @shift_pointer, 0x02
    MST @shift_destination_pointer, 0x02
    MLD @shift_pointer, 0x03
    MST @shift_destination_pointer, 0x03
; test if shift is complete
    AST @shift_pointer
    SUB @insertion_pointer
    BRH #zero, .insert_frame
; decrement destination pointer
    AST @shift_destination_pointer
    SUB @stride_constant
    RST @shift_destination_pointer
; decrement source pointer
    AST @shift_pointer
    SUB @stride_constant
    RST @shift_pointer
    JMP zer, .shift_frame_iteration

.&insert_frame:
    CPL
    MST @insertion_pointer, 0x00
    CPL
    MST @insertion_pointer, 0x01
    AST @insertion_priority
    BSL 4
    MST @insertion_pointer, 0x02
; increment head frame pointer
    MLD zer, .kernel.nodes.task_queue_head!
    ADD @stride_constant
    MST zer, .kernel.nodes.task_queue_head!
; return
    JMP @return_pointer, 0