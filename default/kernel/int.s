@PAGE 0 3
@ADDRESSABLE kernel.int

// 0:   next interrupt identifier
// 1:   interrupt count
// ...: two byte entities
//   0-3:  masking bits
//   4-7:  process id
//   8-15: page address

.&kernel.int.next_id:
    0x01
.&kernel.int.count:
    0x00
%array 30