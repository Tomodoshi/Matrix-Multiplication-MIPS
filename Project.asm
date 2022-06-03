.data

	A:.word 2,3,7,5
	b:.word 4,3
	x:.word 9,2
	z:.word 0,0
	y:.word 0,0
	
	newLine: .asciiz "\n"

.text

mian:
	#loading the addresses of the arrays into save registers
	la $s0, A
	la $s1, b
	la $s2, x
	la $s3, z
	la $s4, y
	
	#calling lin_alg(A, b, x)
	add $a0, $s0, $zero
	add $a1, $s1, $zero
	add $a2, $s2, $zero
	jal lin_alg
	
	#printing the values on the console
	lw $t1, 0($s4)

	#Printing current number
	li $v0, 1
	add $a0, $zero, $t1
	syscall
	
	#Printing a new Line
	li $v0, 4
	la $a0, newLine
	syscall
	
	lw $t1, 4($s4)

	#Printing current number
	li $v0, 1
	add $a0, $zero, $t1
	syscall
	
	#Printing a new Line
	li $v0, 4
	la $a0, newLine
	syscall
	
	j exit
	
	
	
lin_alg:
	
	#loading the registers used in the funct. into the stack to protect their values 
	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	
	#calling add_vec(b, x)
	add $a0, $zero, $s1
	add $a1, $zero, $s2
	jal add_vec
	
	#calling mul_matrix(A, z)
	add $a0, $s0, $zero
	add $a1, $v0, $zero
	jal mul_matrix
	
	#Popping the stack to get the original values back
	lw $a2, 12($sp)
	lw $a1, 8($sp)
	lw $a0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 16
	
	#jumping out of the funt. back to the main method
	jr $ra
	
add_vec:

	#loading the registers used in the funct. into the stack to protect their values 
	addi $sp, $sp, -20
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $ra, 16($sp)
	
	#performing b[0]+x[0] & b[1]+x[1]
	lw $t0, 0($a0)
	lw $t1, 0($a1)
	add $t2, $t0, $t1
	lw $t0, 4($a0)
	lw $t1, 4($a1)
	add $t3, $t0, $t1
	
	#storing and returning the result of b+x
	sw $t2, 0($s3)
	sw $t3, 4($s3)
	add $v0, $zero, $s3
	
	#Popping the stack to get the original values back
	lw $ra, 16($sp)
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 20
	
	#jumping back to the lin_alg method
	jr $ra
	
mul_matrix:

	#loading the registers used in the funct. into the stack to protect their values 
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	sw $t2, 12($sp)
	sw $t3, 16($sp)
	
	#performing the matrix multiplication (A[0]*z[0] + A[1]*z[1])
	lw $t0, 0($a0)
	lw $t1, 0($a1)
	mul $t2, $t0, $t1
	lw $t0, 4($a0)
	lw $t1, 4($a1)
	mul $t3, $t0, $t1
	add $t2, $t2, $t3
	sw $t2, 0($s4)
	
	#performing the matrix multiplication (A[2]*z[0] + A[3]*z[1])
	lw $t0, 8($a0)
	lw $t1, 0($a1)
	mul $t2, $t0, $t1
	lw $t0, 12($a0)
	lw $t1, 4($a1)
	mul $t3, $t0, $t1
	add $t2, $t2, $t3
	sw $t2, 4($s4)
	
	add $t9, $zero, $zero
	
	#returnning the product of A*z
	add $v0, $v0, $s4
	
	#Popping the stack to get the original values back
	lw $ra, 0($sp)
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	lw $t2, 12($sp)
	lw $t3, 16($sp)
	addi $sp, $sp, 20
	
	#jumping back to the lin_alg method
	jr $ra
	
exit:
	