@PAGE 2 7

// Acknowledges and returns from the interrupt service routine and swaps to another
// context.

// Type: non-returnable (@QOS)
// Arguments: empty tuple
// Returns: empty tuple

; main
    @GOTO kernel.swap_point