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
// c: priority
// d: pid
// e: task data byte

.&kernel.task_queue.empty_address:
    .os.lifecycle_task+
    .os.lifecycle_task-
    0xA0
    0x00
.&kernel.task_queue.default_head:
    %array 92