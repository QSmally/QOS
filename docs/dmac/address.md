
# Address

### References

**References: alignment**

```

                | physical upper | physical lower |
                | - - - - - - -  |  - - - - - - - |
Inode           | 0 0 0 x x x x x y y y 0 0 0 0 0 | (8)
Block           | 0 0 0 x y y y y z z z 0 0 0 0 0 | (8) x0: file, x1: heap
Segment (upper) | x x x x x x x x 0 0 0 0 0 0 0 0 | (8)
Virtual (lower) | 0 0 0 0 0 0 0 0 x x x y y y y y | (8)
```
