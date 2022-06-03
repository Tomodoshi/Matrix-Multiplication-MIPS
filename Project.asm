.data

	A:.word 2,3,7,5
	b:.word 4,3
	x:.word 9,2
	z:.word 0,0
	y:.word 0,0


.text
	
mian:
	la $s0, A
	la $s1, b
	la $s2, x
	la $s3, z
	la $s4, y
	
	add $a0, $s0, $zero
	add $a1, $s1, $zero
	add $a2, $s2, $zero
	jal lin_alg
	add $s4, $s4, $v0
	j Exit:
	
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
	
	lw $a2, 12($sp)
	lw $a1, 8($sp)
	lw $a0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 16
	jr $ra
	
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
	
	sw $t2, 0($s3)
	sw $t3, 4($s3)
	add $v0, $v0, $s3
	
	lw $ra, 16($sp)
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 20
	jr $ra
	
mul_matrix:
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	sw $t2, 12($sp)
	sw $t3, 16($sp)
	
	lw $t0, 0($a0)
	lw $t1, 0($a1)
	mul $t2, $t0, $t1
	lw $t0, 4($a0)
	lw $t1, 4($a1)
	mul $t3, $t0, $t1
	add $t2, $t2, $t3
	sw $t2, 0($v0)
	
	lw $t0, 8($a0)
	lw $t1, 0($a1)
	mul $t2, $t0, $t1
	lw $t0, 12($a0)
	lw $t1, 4($a1)
	mul $t3, $t0, $t1
	add $t2, $t2, $t3
	sw $t2, 4($v0)
	
	lw $ra, 0($sp)
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	lw $t2, 12($sp)
	lw $t3, 16($sp)
	addi $sp, $sp, 20
	jr $ra
	
Exit:
	
	