@PAGE 0 2
@ADDRESSABLE kernel.proc

// Two byte stride
// a.bb.ccccc
// dddddddd

// a: has execution loop
// b: priority index
// c: process index

.&kernel.proc.main:
    0x01
    .os.main+
.&kernel.proc.others:
    %array 30