@PAGE 2 6

// Acknowledges and returns from the interrupt service routine and swaps to another
// context.

// Type: non-returnable
// Arguments: empty tuple
// Returns: empty tuple

.main:
    @GOTO kernel.calls.swap_point