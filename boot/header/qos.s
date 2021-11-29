@HEADER QOS instruction

// Enters kernel mode by calling a kernel/OS function.

@DECLARE return_label %random

CPS
.@return_label+
CPS
.@return_label-
ENT
@instruction
.@return_label: