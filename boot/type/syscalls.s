#ENUM syscalls
    ; processes
    #DECLARE spawn 0b00000
    #DECLARE terminate 0b00001
    ; dynamic dispatch
    #DECLARE thread_dispatch 0b00010
    #DECLARE thread_source_dispatch 0b00011
    #DECLARE thread_signal 0b00100
    #DECLARE thread_dispose 0b00101
    ; intersegmentation
    #DECLARE segment_jump 0b00110
    #DECLARE library_call 0b00111
    ; memory
    #DECLARE allocate_32 0b01000
    #DECLARE drop 0b01001
    #DECLARE memory_map 0b01010
    #DECLARE memory_map_continuous 0b01011
    #DECLARE memory_map_inode 0b01100
    #DECLARE memory_unmap 0b01101
    ; filesystem
    #DECLARE file_create 0b01110
    #DECLARE file_delete 0b01111
    #DECLARE file_truncate 0b10000
    #DECLARE file_open 0b10001
    #DECLARE file_read 0b10010
    #DECLARE file_write 0b10011