
# Inode

> Read about `dmac/address`.

### Structure

```
| - - - - - - - |   | - -
| 8:  config    | - | 000: (4) flags, (4) type
| - - - - - - - |   | 001: (8) parent directory
| 8:  name str  |   | 010: (?) permissions
| - - - - - - - |   | 011: type-defined
| 16: type-     |   | 100: type-defined
|     defined   |   | 101: type-defined
| - - - - - - - |   | 110: type-defined
                    | 111: type-defined
                    | - -
```

**Structures: flags**

* `0b0001`: atomic;
* `0b0010`: lock;
* `0b0100`: ?;
* `0b1000`: ?.

**Structure: type**

* Normal (`0b00#`)
    - `000`: data content;
    - `001`: executable content.
* Link (`0b01#`)
    - `010`: directory;
    - `011`: symbolic.
* Dynamic content (`0b1##`)
    - `100`: publisher;
    - `101`: device;
    - `110`: ?;
    - `111`: ?.
