@PAGE 6 0
@ADDRESSABLE os.shell

.loop:
    @QOSSUBROUTINE @kernel.reschedule
    @GOTO loop