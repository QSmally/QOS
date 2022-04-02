@PAGE 5 1
@ADDRESSABLE os.login
@OVERFLOWABLE

@DECLARE string_iterator 1

; main
    IMM @string_iterator, .login_string
    PST zer, @port.terminal_newline
.print_char:
    MLD @string_iterator, 0
    BRH #zero, .start_input
; print character
    PST zer, @port.terminal_push
    INC @string_iterator
    JMP zer, .print_char
.start_input:
    @QOSSUBROUTINE @kernel.reschedule
.accept_input:
    PLD zer, @port.terminal
    BRH #zero, .start_input
    PST zer, @port.terminal_push
    @GOTO accept_input

.login_string:
    $login, 0x20, $>
    0x00