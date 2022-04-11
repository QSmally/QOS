@PAGE 5 1
@ADDRESSABLE os.login
@OVERFLOWABLE

@DECLARE string_iterator 1
@DECLARE enter_key 2
@DECLARE key 3

; main
    PRT zer, @port.terminal_newline
    IMM @enter_key, 0x0A
; login username
    PPI, 1
    IMM @string_iterator, .login_string
    CAL zer, .print_char
; login password
    PRT zer, @port.terminal_newline
    PPI, 0
    IMM @string_iterator, .passwd_string
    CAL zer, .print_char
; postlogin task
    PRT zer, @port.terminal_newline
    @QOS @kernel.terminate

.print_char:
    MLD @string_iterator, 0
    BRH #zero, .accept_input
; print character
    PRT zer, @port.terminal_push
    INC @string_iterator
    JMP zer, .print_char

.&accept_input:
    PRT zer, @port.terminal_request
    BRH #zero, .accept_input
    RST @key
    SUB @enter_key
    BRH #zero, .return
; optionally print character
    PPK
    BRH #zero, .accept_input
    AST @key
    PRT zer, @port.terminal_push
    @GOTO accept_input
.&return:
    PPL
    @RETURN

.&login_string:
    $login, 0x20, $>
    0x00
.&passwd_string:
    $password, 0x20, $>
    0x00