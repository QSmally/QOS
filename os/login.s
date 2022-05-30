@PAGE 5 1
@ADDRESSABLE os.login
@OVERFLOWABLE

@MAKEPAGE input_information 5 4

@DECLARE string_iterator 1
@DECLARE insertion_pointer 2
@DECLARE showing_input 3
@DECLARE enter_key 4
@DECLARE key 5

; main
    IMM @enter_key, 0x0A
; login username
    IMM @string_iterator, .login_string
    IMM @insertion_pointer, 0x80
    IMM @showing_input, 1
    CAL zer, .print_char
; login password
    PRT zer, @port.terminal_newline
    IMM @string_iterator, .passwd_string
    IMM @insertion_pointer, 0x90
    IMM @showing_input, 0
    CAL zer, .print_char

; postlogin task
    PRT zer, @port.terminal_newline
    PPI, .os.shell+
    PPI, 0
    @QOS @kernel.spawn

; terminate login process
    @QOS @kernel.terminate

.&print_char:
    MLD @string_iterator, 0
    BRH #zero, .accept_input
; print character
    PRT zer, @port.terminal_push
    INC @string_iterator
    @GOTO print_char

.&accept_input:
    PRT zer, @port.terminal_request
    BRH #zero, .accept_input
    RST @key
    SUB @enter_key
    BRH #zero, .return
; append to memory
    AST @key
    MST @insertion_pointer, 0x00
    INC @insertion_pointer
; optionally print character
    AST @showing_input
    BRH #zero, .accept_input
    AST @key
    PRT zer, @port.terminal_push
    @GOTO accept_input
.return:
    @RETURN

.&login_string:
    $login, 0x20, $>
    0x00
.&passwd_string:
    $password, 0x20, $>
    0x00