start:
    addi x1 x1 1
    add x2 x2 x7
    beq x0 x0 start
    blt x1 x3 100
    sd x5 8(x6)
    ld x7 -8(x9)