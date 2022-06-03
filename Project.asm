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
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $s0, 0($sp)
	
	jal add_vec
	add $s0, $v0, $zero
	add $a3, $s0, $zero
	jal mul_matrix
	
	lw $ra, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 8
	
add_vec:

	addi $sp, $sp, -20
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $ra, 16($sp)
	
	lw $t0, 0($a1)
	lw $t1, 0($a2)
	add $t2, $t0, $t1
	lw $t0, 4($a1)
	lw $t1, 4($a2)
	add $t3, $t0, $t1
	sw $v0, 0($t2)
	sw $v0, 4($t3)
	
	lw $ra, 16($sp)
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	
mul_matrix:
	
	