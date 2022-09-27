
# Assembly

> Extended QCPU 2 assembly

### Preprocessor

**Preprocessor: file index**

* `#SEGMENT <uint>` - defines the starting point of a segment,
* `#ADDRESSABLE <string>` - label namespace,
* `#HEADER <string>(...)` - defines a group of preprocessed instructions,
* `#ENUMERATION <string>` - defines a group of declared key/value pairs,
* `#INCLUDE <file>` - includes a file and appends it to this segment (in order),
* `#ASSOCIATED <file>` - associated segment (continuous addressing used with memory mapping),
* `#DECLARE <key> <value>` - file-local preprocessed value.

**Preprocessor: usage**

* `INSTR @declared_key`,
* `@header(0, 1, @declared_key)`,
* `BRH #flag, 0x00`.

### Comments

* Segment reference: `//`,
* Specific comments/code-block naming: `;`.

### References

**References: definition**

* Segment-private label: `.label:`,
* Public label (added to namespace): `.&label:`,
* Offset address: `.label(<uint>):` or `.&label(<uint>):`.

**Reference: usage**

* File-private label: `.label`,
* Segment-specific label `.(<filename>)label`,
* Namespaced label: `.<namespace>.label`,
* Upper address space: `.label+` or `.(<filename>)label+` or `.<namespace>.label+`.
