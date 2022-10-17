
# Memory map

> Read about `fs/inode` file structure.

### Virtual space

**Virtual space: addressing**

* `a`: sequential block address inside inode;
* `b`: physical upper address;
* `c`: section address;
* `d`: byte-specific virtual address;
* `e`: heap bit.

**Virtual space: physical mapping**

```
 physical space
| - - - | | - - - | | - - - | | - - - | | - - - | | - - - | | - - - | | - - - | 
|  256  | |  256  | |  256  | |  256  | |  256  | |  256  | |  256  | |  256  | Physical address
| 8*32  | | 8*32  | | 8*32  | | 8*32  | | 8*32  | | 8*32  | | 8*32  | | 8*32  | reference (aaaa -> bbbbbbbb)
|       | |       | |       | |       | |       | |       | |       | |       |
|       | |       | |       | |       | |       | |       | |       | |       |
| - - - | | - - - | | - - - | | - - - | | - - - | | - - - | | - - - | | - - - |
                                                                | Block address
                                          (3*32) ------------- /  range (e.aaaa.ccc) - (0.aaaa.ccc)
                                            |
 per-process virtual context      / 101 ----^---- 111 \
| - - | - - | | - - | - - | | - - | - - | | - - | - - |
| 32  | 32  | | 32  | 32  | | 32  | 32  | | 32  | 32  | Virtual address
|     |     | |     |     | |     |     | |     |     | (ccc.ddddd)
| - - | - - | | - - | - - | | - - | - - | | - - | - - |
```

### System call

**System call: `memory_map`**

Parameters (push order):
* file inode;
* range start (block address);
* range end (block address).

Tuple return (pull order):
* base address.

Implementation example:
```s
PPS @inode                ; aaaaaaaa?
PPS @start_range          ; b.cccc.ddd
PPS @end_range            ; 0.eeeeeee
ENT @syscalls.memory_map
PPL
ADD @address              ; offset from begin of virtual block
RST @address
```

**System call: `memory_unmap`**

Parameters (push order):
* address in specified range.

Tuple return (pull order);
* void.

Implementation example:
```s
PPI, @address
ENT @syscalls.memory_unmap
```
