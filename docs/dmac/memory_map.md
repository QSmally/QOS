
# Memory map

> Read about `fs/inode` file structure.

### Virtual space

**Virtual space: addressing**

* `a`: sequential block address inside inode;
* `b`: physical upper address;
* `c`: section address;
* `d`: byte-specific virtual address;

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
                                          (3*32) ------------- /  range (0.aaaa.ccc) - (0.aaaa.ccc)
                                            |
 per-process virtual context      / 101 ----^---- 111 \
| - - | - - | | - - | - - | | - - | - - | | - - | - - |
| 32  | 32  | | 32  | 32  | | 32  | 32  | | 32  | 32  | Virtual address
|     |     | |     |     | |     |     | |     |     | (ccc.ddddd)
| - - | - - | | - - | - - | | - - | - - | | - - | - - |
```

### System call

**System call: `memory_map_range`**

Parameters (push order):
* file inode;
* range start (block address);
* range end (block address);
* connected register.

Tuple return (pull order):
* base address.

Implementation example:
```s
PPS @inode                ; xxxxxxxx
PPS @start_range          ; 0.yyyy.zzz
PPS @end_range            ; 0.yyyy.zzz
PPI, @register
ENT @syscalls.memory_map
PPL
ADD @register             ; offset from begin of virtual block
RST @register
```

**System call: `memory_unmap`**

Parameters (push order):
* connected register.

Tuple return (pull order);
* void.

Implementation example:
```s
PPI, @register
ENT @syscalls.memory_unmap
```
