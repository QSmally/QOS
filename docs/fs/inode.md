
# Inode

> Read about `dmac/address`.

### Structure

```
| - - - - - - - |           | - -
| 8:  config    | - - - - - | 000: lock
| - - - - - - - |           | 001: permissions
| 8:  name str  |           | 010: 
| - - - - - - - |           | 011: 
| 16: physical  | (Block    | 100: 
| 1   addresses |  address) | 101: 
| - - - - - - - |           | 110: 
                            | 111: 
                            | - -
```
