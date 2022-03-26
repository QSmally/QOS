@PAGE 2 6
@ADDRESSABLE kernel.schedule
@OVERFLOWABLE

// Type: CAL
// Arguments: empty tuple
// Returns: empty tuple

@DECLARE return_pointer 3
@DECLARE insertion_pointer 4
@DECLARE stride_constant 7
@DECLARE shift_pointer 6
@DECLARE shift_destination_pointer 5

; main
    CPL
    RST @return_pointer
    IMM @stride_constant, 4

; shift queue
    MLD zer, .kernel.nodes.queue_head!
    RST @shift_pointer
    ADD @stride_constant
    RST @shift_destination_pointer
; insertion pointer
    IMM @insertion_pointer, .kernel.task_queue.default_head!
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
; increment head frame pointer
    MLD zer, .kernel.nodes.queue_head!
    ADD @stride_constant
    MST zer, .kernel.nodes.queue_head!
; return
    JMP @return_pointer, 0