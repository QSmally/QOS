@HEADER MMU instruction

// A function which executes the MMU instruction by loading from the port
// associated to the management unit, and it clears the input stack when doing
// that.

// If performing a process-management task, such as spawning a process, the 'proc'
// data table will be loaded into memory. Likewise, any filesystem operation will
// automatically perform a load operation for that specific page. The MMU will
// write the page of memory which has been automatically loaded at the return call.

// Addressing must have the high byte inputted first, followed by the low byte. If
// the latter was not inputted, it defaults to a zero byte.

CPN @instruction