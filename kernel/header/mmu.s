@HEADER MMU instruction

// A function which executes the MMU instruction by loading from the port
// associated to the management unit, and it clears the input stack when doing
// that.

// Addressing must have the high byte inputted first, followed by the low byte. If
// the latter was not inputted, it defaults to a zero byte.

CPN @instruction