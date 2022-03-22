@HEADER QOSTRACECALL instruction

// A snapshotable kernel/OS call that pushes the lower address onto the call stack.

@DECLARE return_label %random

CPI, .@return_label
@QOS @instruction
.@return_label: