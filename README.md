
# QOS

> A single-core, multi-context operating system with a monolithic kernel.

## Build

See the [QCPU CLI](https://github.com/QSmally/QCPU-CLI) for building and emulating QOS.

**Assemble flags**
* `--no-mma-supported` - falls back to two `MSA` instructions, adds a byte.
* `--performance-unsafe` - removes tests to reduce the codebase and increase performance.
