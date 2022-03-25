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
// c: pid reference
// d: priority
// e: task data byte

%array 96