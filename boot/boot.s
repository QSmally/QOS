#SEGMENT 0
#ADDRESSABLE kernel.boot

#INCLUDE boot+strings

#DECLARE string_iterator 1

; main
    IMM @string_iterator, .qos_string
.load_char:
    MLD 1 @string_iterator, 0x00
    PRT zer, @physical_out.tty
    BRH #!zero, .load_char
; start os
    IMM acc, os.login+
    DMA @dmac.execution_context
    DMA @dmac.k_off
    JMP 0 zer, os.login