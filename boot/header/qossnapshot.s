@HEADER QOSSNAPSHOT instruction

// A partially-returnable kernel/OS call that pushes the lower return address onto
// the call stack.

@DECLARE return_label %random

CPS 0, .@return_label
@QOS @instruction
.@return_label: