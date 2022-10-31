#SEGMENT 1
#ADDRESSABLE kernel.defaults

#INCLUDE proc
#INCLUDE task_queue
#INCLUDE interrupts

.&proc_head:
    0x00
.&task_queue_head:
    0x00
.&interrupts_head:
    0x00