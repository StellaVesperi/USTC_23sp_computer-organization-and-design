.section .data
fib: .word 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
n: .word 0

.section .text
.globl main
main:
    # 读入n
    la t0, n
    li a0, 4
    lw a1, 0(t0)
    li a2, 0
    li a7, 8
    ecall

    # 将1、1存入fib数组
    la t0, fib
    li t1, 1
    sw t1, 0(t0)
    sw t1, 4(t0)

    # 计算剩余的数列项
    li t2, 2
    li t3, 0
    li t4, 1
    li t5, 0
loop:
    beq t2, a1, exit
    addi t2, t2, 1
    add t5, t3, t4
    sw t5, 4*t2(t0)
    mv t3, t4
    mv t4, t5
    j loop
exit:
    # 退出程序
    li a0, 10
    li a7, 93
    ecall

