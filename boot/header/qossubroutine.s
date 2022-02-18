@HEADER QOSSUBROUTINE instruction

// A returnable kernel/OS call that pushes the return address onto the call stack.

@DECLARE return_label %random

CPI, .@return_label
CPI, .@return_label+
@QOS @instruction
.@return_label: