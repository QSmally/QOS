@PAGE 5 0
@ADDRESSABLE os.lifecycle_task

.loop:
    @QOSSUBROUTINE @kernel.reschedule
    JMP zer, .loop