@PAGE 0 4
@ADDRESSABLE kernel.interrupts

// Four byte stride
// 0: aaaaaaaa
// 1: bbbbbbbb
// 2: cccccccc
// 3: dddddddd

// a: interrupt id
// b: segment address
// c: lower address
// d: task data

%array 32