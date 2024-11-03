    addi x1 x0 777
    #Questo è il mio registro di partenza
    addi x2 x0 0
    sd x1 0(x2)
    addi x2 x2 8
    addi x1 x0 929
    sd x1 0(x2)
    addi x2 x2 8
    addi x1 x0 3
    sd x1 0(x2)
    addi x2 x2 8
    addi x1 x0 515
    sd x1 0(x2)
    addi x2 x2 8
    addi x1 x0 222
    sd x1 0(x2)
    #Questo è il mio registro di arrivo
    add x5 x2 x0
main:
    #Imposto registro di partenza
    addi x4 x0 0
    addi x6 x0 1
loop:
    beq x4 x5 check
    ld x1 0(x4)
    ld x2 8(x4)
    addi x4 x4 8
    blt x1 x2 loop
    sd x2 -8(x4)
    sd x1 0(x4)
    add x6 x0 x0
    beq x0 x0 loop
check:
    beq x6 x0 main
    addi x10 x0 1
    beq x0 x0 0