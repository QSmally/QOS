
# File types

> Read about `fs/inode`.

### Content/executable

```
| - - - - - - - |           | - -
| 8:  config    | - - - - - | 000: (1) lock, (4) flags, (3) type
| - - - - - - - |           | 001: (8) parent directory
| 8:  name str  |           | 010: (?) permissions
| - - - - - - - |           | 011: (?) user
| 16: physical  | (Block    | 100: type-defined
| (1) addresses |  address) | 101: type-defined
| - - - - - - - |           | 110: type-defined
                            | 111: type-defined
                            | - -
```
