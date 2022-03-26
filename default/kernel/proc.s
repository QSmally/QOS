@PAGE 0 3
@ADDRESSABLE kernel.proc

// Two byte stride
// 0: aaaaaaaa
// 1: bbbb.cccc

// a: segment address
// b: priority
// c: parent pid

; kernel task
    .os.lifecycle_task+
    0b00010000
; tasks
    %array 30