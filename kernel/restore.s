@PAGE 1 2
@ADDRESSABLE kernel.restore

PLD @port.context_store
RST 7
PLD @port.context_store
RST 6
PLD @port.context_store
RST 5
PLD @port.context_store
RST 4
PLD @port.context_store
RST 3
PLD @port.context_store
RST 2
PLD @port.context_store
RST 1

CPL
@MMUARG
CPL
@MMUARG
@MMU @mmu.intermediate_load