
@include "kernel/sysc.s"

@section text

main:       imm rx, 0
            sysc @exit
