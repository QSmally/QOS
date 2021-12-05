@HEADER MMUDYNAMICARG *instruction

// Pushes the result of an instruction onto the input stack of the MMU.

@DECLARE break_label %random

.@break_label:
    @*instruction
    PST @port.mmu