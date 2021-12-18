@ENUM kernel
    @DECLARE fork 0b00000000
    @DECLARE terminate 0b00000011
    @DECLARE swap_point 0b00000100
    @DECLARE allocate_page 0b00000110
    @DECLARE allocate 0b00001000
    @DECLARE drop 0b00001010
    @DECLARE data_store 0b00001100
    @DECLARE data_load 0b00001110
    @DECLARE segment_load 0b00010000
    @DECLARE call 0b00010010
    @DECLARE return 0b00010101
@END