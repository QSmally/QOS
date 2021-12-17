@HEADER MMU16LABEL label

// Appends a full, 16-bit address of a label to the input stack of the MMU.

@IF no-mma-supported
    MSA
    .@label+
    MSA
    .@label-
@ELSE
    MMA
    .@label+
    .@label-
@END