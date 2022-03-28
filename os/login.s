@PAGE 5 1
@ADDRESSABLE os.login
@OVERFLOWABLE

@DECLARE string_iterator 1

; main
    IMM @string_iterator, .login_string
.print_char:
    MLD @string_iterator, 0
    BRH #zero, .accept_input
; print character
    PST zer, @port.io
    INC @string_iterator
    JMP zer, .print_char
.accept_input:
    PPI, @interrupt.keypress
    @QOSSUBROUTINE @kernel.interrupt

.login_string:
    $login, 0x20, $>
    0x00
.passwd_string:
    $password, 0x20, $>
    0x00