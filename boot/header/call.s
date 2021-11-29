@HEADER CALL to_label

// Jumps to a page inside of the scoped program segment by pushing the lower
// address byte to the call stack, and requesting the new instruction page from
// memory.

@DECLARE return_label %random

CPS
.@return_label-
SPL
.@to_label-
.@return_label: