
// 'master boot' sector regfile (io0)

@org 0xC000
@include "constants.s"

@region 3

flags:      1 lsh @real |           ; x/y address modes are physical
            0 lsh @ints |           ; disable interrupts
            0 lsh @inst |           ; disable instance ptrs (page 0)
entrypoint: jmp rel .mbmain         ; reset jump text

@end
@region 253 ; boot text

.mbmain:    imm  rx,  @dmac'l
            imm  ry,  @dmac'u
            ; currently assumes io2 is >256 byte regfile (expanding into io3)
            imm  ra,  @boot'l
            mst  sid, 0x00          ; kfixedl = io2'l
            imm  ra,  @boot'u
            mst  sid, 0x01          ; kfixedh = io2'u
            jmp  rel, .entrypoint   ; kmain, flushes mmu

@end
