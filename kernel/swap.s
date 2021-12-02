@PAGE 1 1
@ADDRESSABLE kernel.swap

// An internal callable which pushes the CPU registers onto the context stack, in
// ascending order. It's required to pull them in reversed order out of the stack.

AST 1
PST @port.context_store
AST 2
PST @port.context_store
AST 3
PST @port.context_store
AST 4
PST @port.context_store
AST 5
PST @port.context_store
AST 6
PST @port.context_store
AST 7
PST @port.context_store
@RETURN