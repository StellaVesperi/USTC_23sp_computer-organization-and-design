.data
	1			        #initialize fn-2 as 1
	1			        #initialize fn-1 as 1
.text
li x21, 0			    #x21 for saving the current Fibonacci number fn
lw x19, 0(x0)			#load fn-2 from memory to x19
lw x20, 4(x0)			#load fn-1 from memory to x20
li x18, 3			    #set the value of i to 3
addi x5, x0, 40			#set the number of Fibonacci numbers to calculate to 5

calculate:			    #loop for calculating the Fibonacci numbers
blt x5, x18, exit		#exit the loop if i exceeds the number of Fibonacci numbers to calculate
add x21, x19, x20		#calculate the current Fibonacci number fn as the sum of fn-1 and fn-2
addi x7, x18, -1		#calculate the address of fn in memory
add x6, x7, x7
add x6, x6, x6		
sw x21, 0(x6)			#store the current Fibonacci number fn in memory
addi x19, x20, 0		#update fn-2 to the previous value of fn-1
addi x20, x21, 0		#update fn-1 to the current value of fn
addi x18, x18, 1		#increment i by 1 to move to the next Fibonacci number
jal calculate			#jump back to the beginning of the loop to calculate the next Fibonacci number

exit:
li a7, 10			    #system call to exit the program
ecall

/*
这段代码使用递归方法计算斐波那契数列中的前40个数字，
其中，x19和x20分别存储前两个斐波那契数fn-2和fn-1，
x21存储当前计算的斐波那契数fn，x18存储循环变量i，
x5存储需要计算的斐波那契数的个数。在循环中，使用blt指令判断是否已经计算到所需的斐波那契数的个数，
如果是则退出循环。每次循环中，根据斐波那契数的定义，计算出当前的斐波那契数fn，并将其存储到内存中。
然后更新fn-2和fn-1的值，以便计算下一个斐波那契数。最后，程序使用ecall指令调用系统调用来结束程序的执行。
*/