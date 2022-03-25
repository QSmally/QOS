@PAGE 0 3
@ADDRESSABLE kernel.proc

// Two byte stride
// 0: aaaaaaaa
// 1: bbb.ccccc

// a: segment address
// b: priority
// c: parent pid

; kernel task
    .os.main+
    0b00010000
; tasks
    %array 30