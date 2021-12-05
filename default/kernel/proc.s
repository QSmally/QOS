@PAGE 0 2
@ADDRESSABLE kernel.proc

// 0:   current process context
// 1:   process count
// ...: two byte entities
//   0-3:  masking bits
//   4-7:  parent id
//   8-15: segment address

.&kernel.proc.current:
    0x00
.&kernel.proc.count:
    0x00
%array 30