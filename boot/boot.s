#SEGMENT 0
#ADDRESSABLE kernel.boot

#INCLUDE boot+strings

#DECLARE string_reference 5

    IMM @string_reference, .qos_string
.load_char:
    MLD(I) @string_reference, 0x00
    PRT zer, @physical_out.tty
    BRH #!zero, .load_char
; start os
    IMM acc, os.login+
    DMA @dmac.execution_context
    DMA @dmac.k_off
    JMP zer, os.login