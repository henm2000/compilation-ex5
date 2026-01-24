.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
	global_s1: .word 0
string_const_0: .asciiz "Having"
	global_s2: .word 0
string_const_1: .asciiz "said"
	global_s3: .word 0
string_const_2: .asciiz "that"
.text
	la $t0,string_const_0
	sw $t0,global_s1
	la $t1,string_const_1
	sw $t1,global_s2
	la $t4,string_const_2
	sw $t4,global_s3
main:
	li $t0,3
	li $t1,1
	add $t4,$t0,$t1
	li $t1,4
	mul $t1,$t4,$t1
	move $a0,$t1
	li $v0,9
	syscall
	move $t1,$v0
	bnez $t1,store_continue_0
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_0:
	sw $t0,0($t1)
	sw $t1,global_names
	lw Temp_9,global_s1
	lw Temp_10,global_names
	li Temp_11,0
	bnez Temp_10,array_not_null_1
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_1:
	bgez Temp_11,array_index_nonneg_2
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_2:
	lw $s0,0(Temp_10)
	blt Temp_11,$s0,array_index_ok_3
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_3:
	addi $s0,Temp_11,1
	sll $s0,$s0,2
	add $s0,Temp_10,$s0
	sw Temp_9,0($s0)
.data
string_const_3: .asciiz "Citroen"
.text
	la $t5,string_const_3
	lw $t0,global_s2
	add Temp_12,$t5,$t0
	lw Temp_15,global_names
	li Temp_16,1
	bnez Temp_15,array_not_null_4
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_4:
	bgez Temp_16,array_index_nonneg_5
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_5:
	lw $s0,0(Temp_15)
	blt Temp_16,$s0,array_index_ok_6
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_6:
	addi $s0,Temp_16,1
	sll $s0,$s0,2
	add $s0,Temp_15,$s0
	sw Temp_12,0($s0)
	lw $t0,global_s1
.data
string_const_4: .asciiz "said"
.text
	la $t3,string_const_4
	add $t1,$t0,$t3
	lw $t0,global_s3
	add Temp_17,$t1,$t0
	lw Temp_22,global_names
	li Temp_23,2
	bnez Temp_22,array_not_null_7
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_7:
	bgez Temp_23,array_index_nonneg_8
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_8:
	lw $s0,0(Temp_22)
	blt Temp_23,$s0,array_index_ok_9
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_9:
	addi $s0,Temp_23,1
	sll $s0,$s0,2
	add $s0,Temp_22,$s0
	sw Temp_17,0($s0)
	lw Temp_24,global_names
	li Temp_25,2
	bnez Temp_24,array_not_null_10
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_10:
	bgez Temp_25,array_index_nonneg_11
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_11:
	lw $s0,0(Temp_24)
	blt Temp_25,$s0,array_index_ok_12
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_12:
	addi $s0,Temp_25,1
	sll $s0,$s0,2
	add $s0,Temp_24,$s0
	lw $t2,0($s0)
	move $a0,$t2
	li $v0,4
	syscall
	li $v0,10
	syscall
