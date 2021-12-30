@ENUM kernel
    @DECLARE fork 0b00000000            ; 0x00 << 1 | 0
    @DECLARE terminate 0b00000011       ; 0x01 << 1 | 1
    @DECLARE swap_point 0b00000100      ; 0x02 << 1 | 0
    @DECLARE allocate_page 0b00000110   ; 0x03 << 1 | 0
    @DECLARE allocate 0b00001000        ; 0x04 << 1 | 0
    @DECLARE drop 0b00001010            ; 0x05 << 1 | 0
    @DECLARE data_store 0b00001100      ; 0x06 << 1 | 0
    @DECLARE data_load 0b00001110       ; 0x07 << 1 | 0
    @DECLARE segment_load 0b00010000    ; 0x08 << 1 | 0
    @DECLARE call 0b00010010            ; 0x09 << 1 | 0
    @DECLARE return 0b00010101          ; 0x0A << 1 | 1
@END