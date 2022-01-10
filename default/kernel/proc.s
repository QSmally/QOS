@PAGE 0 2
@ADDRESSABLE kernel.proc

// Two byte stride
// 0: aa.bb.cccc
// 1: dddddddd

// a: age index
// b: priority index
// c: pid
// d: segment address

.&kernel.proc.swap_index:
    0x02
.&kernel.proc.main:
    .os.main+
.&kernel.proc.tasks:
    %array 30