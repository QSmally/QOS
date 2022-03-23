@PAGE 0 2
@ADDRESSABLE kernel.proc

// Two byte stride
// 0: aaaaaaaa
// 1: bb.cc.dddd

// a: segment address
// b: cycle age
// c: priority (cycle max)
// d: parent pid

.&kernel.proc.main:
    .os.main+
.&kernel.proc.swap_index:
    0x00
; tasks
    %array 30