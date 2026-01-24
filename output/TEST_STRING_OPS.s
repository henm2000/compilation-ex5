.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
global_s1: .word 0
string_const_0: .asciiz "Hello"
global_s2: .word 0
string_const_1: .asciiz "World"
global_s3: .word 0
.text
main:
	la $t0,string_const_0
	sw $t0,global_s1
	la $t1,string_const_1
	sw $t1,global_s2
	lw $t1,global_s1
	lw $t0,global_s2
	move $s0,$t1
	move $s1,$t0
	move $s2,$zero
	move $s4,$s0
concat_loop1_start_0:
	lb $a0,0($s4)
	beqz $a0,concat_loop1_end_1
	addi $s2,$s2,1
	addi $s4,$s4,1
	j concat_loop1_start_0
concat_loop1_end_1:
	move $t9,$s2
	move $s2,$zero
	move $s4,$s1
concat_loop2_start_2:
	lb $a0,0($s4)
	beqz $a0,concat_loop2_end_3
	addi $s2,$s2,1
	addi $s4,$s4,1
	j concat_loop2_start_2
concat_loop2_end_3:
	add $a0,$t9,$s2
	addi $a0,$a0,1
	li $v0,9
	syscall
	move $t0,$v0
	move $s3,$v0
	move $s4,$s0
concat_loop3_start_4:
	lb $a0,0($s4)
	beqz $a0,concat_loop3_end_5
	sb $a0,0($s3)
	addi $s4,$s4,1
	addi $s3,$s3,1
	j concat_loop3_start_4
concat_loop3_end_5:
	move $s4,$s1
concat_loop4_start_6:
	lb $a0,0($s4)
	sb $a0,0($s3)
	beqz $a0,concat_loop4_end_7
	addi $s4,$s4,1
	addi $s3,$s3,1
	j concat_loop4_start_6
concat_loop4_end_7:
	sw $t0,global_s3
	lw $t0,global_s3
	move $a0,$t0
	li $v0,4
	syscall
	lw $t0,global_s1
.data
string_const_2: .asciiz "Hello"
.text
	la $t2,string_const_2
	move $s0,$t0
	move $s1,$t2
strcmp_loop_start_8:
	lb $t9,0($s0)
	lb $a0,0($s1)
	bne $t9,$a0,strcmp_not_equal_9
	beqz $t9,strcmp_equal_10
	addi $s0,$s0,1
	addi $s1,$s1,1
	j strcmp_loop_start_8
strcmp_equal_10:
	li $t0,1
	j strcmp_done_11
strcmp_not_equal_9:
	li $t0,0
strcmp_done_11:
	beq $t0,$zero,Label_1_if_false
Label_0_if_true:
	li $t0,1
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	j Label_2_if_end
Label_1_if_false:
Label_2_if_end:
	lw $t0,global_s1
	lw $t1,global_s2
	move $s0,$t0
	move $s1,$t1
strcmp_loop_start_12:
	lb $t9,0($s0)
	lb $a0,0($s1)
	bne $t9,$a0,strcmp_not_equal_13
	beqz $t9,strcmp_equal_14
	addi $s0,$s0,1
	addi $s1,$s1,1
	j strcmp_loop_start_12
strcmp_equal_14:
	li $t0,1
	j strcmp_done_15
strcmp_not_equal_13:
	li $t0,0
strcmp_done_15:
	beq $t0,$zero,Label_4_if_false
Label_3_if_true:
	li $t0,99
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	j Label_5_if_end
Label_4_if_false:
	li $t0,0
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
Label_5_if_end:
	li $v0,10
	syscall
