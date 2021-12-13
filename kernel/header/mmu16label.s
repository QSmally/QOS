@HEADER MMU16LABEL label

// Appends a full, 16-bit address of a label to the input stack of the MMU.

IMM 0
.@label+
PST @port.mmu
IMM 0
.@label-
PST @port.mmu