@PAGE 5 1
@ADDRESSABLE os.login

@DECLARE string_iterator 1

; main
    IMM @string_iterator, .login_string
.load_char:
    MLD @string_iterator, 0
    BRH #zero, .accept_input
; print character
    PST zer, @port.io
    INC @string_iterator
    JMP zer, .load_char
.accept_input:
    // PPI, @interrupt.keypress
    // @QOSSUBROUTINE @kernel.interrupt
    @QOSSUBROUTINE @kernel.reschedule
    JMP zer, .accept_input

.login_string:
    $login, 0x20, $>
    0x00