@HEADER QOSREQUEST instruction

// A returnable kernel/OS call that pushes the return address onto the call stack.

@DECLARE return_label %random

CPS
.@return_label-
CPS
.@return_label+
ENT
@instruction
.@return_label: