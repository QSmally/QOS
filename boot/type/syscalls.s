#ENUM syscalls
    ; process
    #DECLARE spawn 0b00000
    #DECLARE terminate 0b00001
    ; thread
    #DECLARE thread_create 0b00010
    #DECLARE thread_discard 0b00011
    ; signals
    #DECLARE thread_sign_sync 0b00100
    #DECLARE thread_sign_async 0b00101
    #DECLARE thread_sign_create 0b00110
    ; shared libs
    #DECLARE shared_libr_call 0b00111
    #DECLARE return 0b01000
    ; memory
    #DECLARE allocate_256 0b01001
    #DECLARE allocate_32 0b01010
    #DECLARE drop 0b01011
    #DECLARE memory_map 0b01100
    #DECLARE memory_map_single 0b01101
    #DECLARE memory_unmap 0b01110
    #DECLARE memory_remap 0b01111
    ; files
    #DECLARE file_create 0b10000
    #DECLARE file_delete 0b10001
    #DECLARE file_truncate 0b10010
    #DECLARE file_open 0b10011