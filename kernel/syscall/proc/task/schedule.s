@PAGE 2 5
@ADDRESSABLE kernel.schedule
@OVERFLOWABLE

// Type: CAL
// Arguments: task priority
// Returns: empty tuple

// TODO:
// Fix a task being executed twice when in a loop of two tasks.

@DECLARE return_pointer 1
@DECLARE priority 2
@DECLARE insertion_pointer 3
@DECLARE shift_pointer 4
@DECLARE shift_destination_pointer 5
@DECLARE stride_constant 6

; main
    CPL
    RST @return_pointer
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
    RST @priority
    PPK
    SUB @priority
    BRH #signed, .shift_frame_iteration
; increment skipped task's priority
    INC @priority
    BSL 4
    MST @insertion_pointer, 0x02
; increment insertion pointer
    AST @insertion_pointer
    ADD @stride_constant
    RST @insertion_pointer
; continue if elements ahead
    SUB @shift_destination_pointer
    BRH #!zero, .find_target_iteration
    JMP zer, .insert_frame

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
    PPL
    BSL 4
    MST @insertion_pointer, 0x02
; increment head frame pointer
    MLD zer, .kernel.nodes.task_queue_head!
    ADD @stride_constant
    MST zer, .kernel.nodes.task_queue_head!
; return
    JMP @return_pointer, 0