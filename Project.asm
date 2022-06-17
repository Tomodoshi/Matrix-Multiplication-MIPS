.data
	A:.word 2,5,8,3
	b:.word 3,2
	x:.word 4,6
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
	
	#jumping out of the funct. back to the main method
	jr $ra
	
add_vec:

	#loading the registers used in the funct. into the stack to protect their values 
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	#performing b[0]+x[0] & b[1]+x[1]
	add $t0, $zero, $a0
	add $t1, $zero, $a1
	add $t2, $zero, $zero
	add $t5, $zero, $s3
	
	while:
		beq $t2, 2, endWhile
		lw $t3, 0($t0)
		lw $t4, 0($t1)
		add $t3, $t3, $t4
		sw $t3, 0($t5)
		add $t0, $t0, 4
		add $t1, $t1, 4
		add $t5, $t5, 4
		addi $t2, $t2, 1
		j while
	endWhile:
	
	addi $t5, $t5, -8
	
	#storing and returning the result of b+x
	add $v0, $zero, $t5
	
	#Popping the stack to get the original values back
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	#jumping back to the lin_alg method
	jr $ra
	
mul_matrix:

	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	add $t0, $a0, $zero
	add $t1, $a1, $zero
	addi $t2, $zero, 0
	addi $t8, $zero, 0
	addi $t9, $zero, 0
	
	while2:
		row1:
		beq $t2, 2, preRow2
		lw $t3, 0($t0)
		lw $t4, 0($t1)
		mul $t3, $t3, $t4
		add $t8, $t8, $t3
		addi $t0, $t0, 4
		addi $t1, $t1, 4
		addi $t2, $t2, 1
		j row1
		
		preRow2:
		add $t1, $a1, $zero
		
		row2:
		beq $t2, 4, endWhile2
		lw $t3, 0($t0)
		lw $t4, 0($t1)
		mul $t3, $t3, $t4
		add $t9, $t9, $t3
		addi $t0, $t0, 4
		addi $t1, $t1, 4
		addi $t2, $t2, 1
		j row2
	endWhile2:
	
	sw $t8, 0($s4)
	sw $t9, 4($s4)
	add $v0, $zero $s4
	
	#Popping the stack to get the original values back
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	#jumping back to the lin_alg method
	jr $ra
	
exit:


