    addi x4 x0 16
    addi x2 x0 1
    sd x0 0(x0)
    sd x2 8(x0)
    addi x5 x0 8
loop:
    ld x1 -8(x5)
    ld x2 0(x5)
    add x3 x1 x2
    blt x4 x3 end
    addi x5 x5 8
    sd x3 0(x5)
    blt x3 x4 loop
end:
    beq x0 x0 0