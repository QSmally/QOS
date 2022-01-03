@HEADER CALL subroutine_label

// Jumps to a page inside of the scoped program segment by pushing the lower
// address byte to the call stack, and requesting the new instruction page from
// memory.

@DECLARE return_label %random

CPS 0, .@return_label-
JMP 0, .@subroutine_label-
.@return_label: