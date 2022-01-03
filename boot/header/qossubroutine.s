@HEADER QOSSUBROUTINE instruction

// A returnable kernel/OS call that pushes the return address onto the call stack.

@DECLARE return_label %random

CPS 0, .@return_label-
CPS 0, .@return_label+
@QOS @instruction
.@return_label: