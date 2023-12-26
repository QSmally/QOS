
// kernel device (io2 ... io15)

@org 0xC000
@include "boot/constants.s"

@section instance

flags:      0 lsh @real |           ; x/y address modes are virtual
            1 lsh @ints |           ; enable interrupts
            1 lsh @inst             ; enable instance ptrs (page 0)
entrypoint: jmp skg, .kmainpt       ; boot jump text
                                    ; linker adds globals/pointer map

@section globals

.kmainpt:   u16 .kmain

@section gextension
@region 256 ; sysc/int map

.intmap:
            u16 .syscexit ; 0

@end
@region 256 ; kvariable mmap

.kvmmap:
            u16 0x00 0x10 ; io16

@end

@section text

.kmain:     imm  rx, 0x00           ; userland offset
            imm  ry, 0x00
            mldw sid, 1             ; load entrypoint
            jmp  sid, 0x00          ; call to main

.syscexit:  jmp  rel, .syscexit     ; deadlock
