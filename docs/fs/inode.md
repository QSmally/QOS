
# Inode

> Read about `dmac/address`.

### Structure

```
| - - - - - - - |   | - -
| 8:  config    | - | 000: (1) lock, (3) flags, (4) type
| - - - - - - - |   | 001: (8) parent directory
| 8:  name str  |   | 010: (?) permissions
| - - - - - - - |   | 011: (?) user
| 16: type-     |   | 100: type-defined
|     defined   |   | 101: type-defined
| - - - - - - - |   | 110: type-defined
                    | 111: type-defined
                    | - -
```

**Structure: type**

* Normal (`0b00#`)
    - `000`: data content;
    - `001`: executable content.
* Link (`0b01#`)
    - `010`: directory;
    - `011`: symbolic.
* Dynamic content (`0b10#`)
    - `100`: device;
    - `101`: publisher? implement publisher driver.
* Undefined (`0b11#`)
    - `1100`: ?;
    - `1101`: ?.
