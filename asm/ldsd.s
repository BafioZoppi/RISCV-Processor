    addi x5 x0 30
start:
    addi x1 x1 7
    addi x2 x0 8
    sd x1 8(x2)
    add x1 x0 x0
    addi x2 x2 16
    ld x1 -8(x2)
    blt x1 x5 start
    addi x1 x0 999
    addi x2 x0 8
    sd x1 0(x2)
    blt x5 x6 0