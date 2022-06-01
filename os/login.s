@PAGE 5 1
@ADDRESSABLE os.login
@OVERFLOWABLE

@MAKEPAGE input_information 5 5

@DECLARE string_iterator 1
@DECLARE insertion_pointer 2
@DECLARE showing_input 3
@DECLARE key 4
@DECLARE target_passwd_string 5
@DECLARE input_passwd_string 6
@DECLARE target_char 7

@DECLARE username_loc 0xA0
@DECLARE passwd_loc 0xB0
@DECLARE return_key 0x0A
@DECLARE escape_key 0x1B

; login username
.&escape:
    PRT zer, @port.terminal_newline
    IMM @string_iterator, .login_string
    IMM @insertion_pointer, @username_loc
    IMM @showing_input, 1
    CAL zer, .print_char
; login password
    IMM @string_iterator, .passwd_string
.&retry:
    PRT zer, @port.terminal_newline
    IMM @insertion_pointer, @passwd_loc
    IMM @showing_input, 0
    CAL zer, .print_char

; TODO:
; fetch user password,
; use strcmp kernel subroutine with stack as argument.
    IMM @target_passwd_string, .passwd_preview_string
    IMM @input_passwd_string, @passwd_loc
.&compare_char:
    MLI @target_passwd_string, 0x00
    RST @target_char
    MLI @input_passwd_string, 0x00
    ; if equal
        SUB @target_char
        @DEBUG
        BRH #!zero, .retry_passwd
    ; if string terminator
        AST @target_char
        @DEBUG
        BRH #!zero, .compare_char

; spawn shell
    PRT zer, @port.terminal_newline
    PPI, .os.shell+
    PPI, 0
    @QOS @kernel.spawn
.&retry_passwd:
    IMM @string_iterator, .retry_passwd_string
    @GOTO retry

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
    ; return key, submit
        IMM acc, @return_key
        SUB @key
        BRH #zero, .terminator
    ; escape key, retry username
        IMM acc, @escape_key
        SUB @key
        BRH #!zero, .memory_append
        CPL
        @GOTO escape
.memory_append:
    AST @key
    MST @insertion_pointer, 0x00
    INC @insertion_pointer
; optionally print character
    AST @showing_input
    BRH #zero, .accept_input
    AST @key
    PRT zer, @port.terminal_push
    @GOTO accept_input
.&terminator:
    CLR
    MST @insertion_pointer, 0x00
    @RETURN

.&login_string:
    $login, 0x20, $>
    0x00
.&retry_passwd_string:
    $retry, 0x20
.&passwd_string:
    $password, 0x20, $>
    0x00

.&passwd_preview_string:
    $test
    0x00