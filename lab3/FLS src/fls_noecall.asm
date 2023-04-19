.data
	1			        #initialize fn-2 as 1
	1			        #initialize fn-1 as 1
.text
li x21, 0			    #x21 for saving the current Fibonacci number fn
lw x19, 0(x0)			#load fn-2 from memory to x19
lw x20, 4(x0)			#load fn-1 from memory to x20
li x18, 3			    #set the value of i to 3
addi x5, x0, 40			#set the number of Fibonacci numbers to calculate to 40

calculate:			    #loop for calculating the Fibonacci numbers
blt x5, x18, done		#exit the loop if i exceeds the number of Fibonacci numbers to calculate
add x21, x19, x20		#calculate the current Fibonacci number fn as the sum of fn-1 and fn-2
addi x7, x18, -1		#calculate the address of fn in memory
add x6, x7, x7
add x6, x6, x6		
sw x21, 0(x6)			#store the current Fibonacci number fn in memory
addi x19, x20, 0		#update fn-2 to the previous value of fn-1
addi x20, x21, 0		#update fn-1 to the current value of fn
addi x18, x18, 1		#increment i by 1 to move to the next Fibonacci number
j calculate				#jump back to the beginning of the loop to calculate the next Fibonacci number

done:
ret 					#return from the calculate function to exit the program
