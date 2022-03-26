@PAGE 0 5
@ADDRESSABLE kernel.task_queue
@OVERFLOWABLE

// Four byte stride
// 0: aaaaaaaa
// 1: bbbbbbbb
// 2: cccc.dddd
// 3: eeeeeeee

// a: segment address
// b: lower address
// c: pid
// d: priority
// e: task data byte

.&kernel.task_queue.default_head:
    .os.lifecycle_task+
    .os.lifecycle_task-
    0x05
    0x00
; tasks
    %array 92