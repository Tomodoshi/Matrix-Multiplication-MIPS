.data

	A:.word 2,3,7,5
	b:.word 4,3
	x:.word 9,2


.text
	la $s0, A
	la $s1, b
	la $s2, x
mian:
	add $a0, $s0, $zero
	add $a1, $s1, $zero
	add $a2, $s2, $zero
	jal lin_alg
	
lin_alg:
	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	
	add $a0, $zero, $s1
	add $a1, $zero, $s2
	jal add_vec
	add $a0, $s0, $zero
	add $a1, $v0, $zero
	jal mul_matrix
	
	lw $ra, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 16
	
add_vec:

	addi $sp, $sp, -20
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $ra, 16($sp)
	
	lw $t0, 0($a0)
	lw $t1, 0($a1)
	add $t2, $t0, $t1
	lw $t0, 4($a0)
	lw $t1, 4($a1)
	add $t3, $t0, $t1
	sw $v0, 0($t2)
	sw $v0, 4($t3)
	
	lw $ra, 16($sp)
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	
mul_matrix:
	
	lw $t0, 0($a0)
	lw $t1, 0($a1)
	mul $t2, $t0, $t1
	lw $t0, 4($a0)
	lw $t1, 4($a1)
	mul $t3, $t0, $t1
	add $t2, $t2, $t3
	sw $v0, 0($t2)
	
	lw $t0, 8($a0)
	lw $t1, 0($a1)
	mul $t2, $t0, $t1
	lw $t0, 12($a0)
	lw $t1, 4($a1)
	mul $t3, $t0, $t1
	add $t2, $t2, $t3
	sw $v0, 4($t2)
	
	
	