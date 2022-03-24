@PAGE 0 2
@ADDRESSABLE kernel.proc

// Two byte stride
// 0: aaaaaaaa
// 1: bb.cc.dddd

// a: segment address
// b: cycle age
// c: priority (cycle max)
// d: parent pid

; kernel task
    .os.main+
    0b00010000
; tasks
    %array 30