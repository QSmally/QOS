@PAGE 5 0
@ADDRESSABLE os.lifecycle_task

.loop:
    // IMM acc, $0
    // PST zer, @port.io
    @QOSSUBROUTINE @kernel.reschedule
    @GOTO loop