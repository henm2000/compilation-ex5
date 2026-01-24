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
	la $t3,string_const_1
	sw $t3,global_s2
	la $t2,string_const_2
	sw $t2,global_s3
main:
	li $t3,3
	li $t0,1
	add $t0,$t3,$t0
	li $t9,32767
	ble $t0,$t9,add_no_overflow_0
	li $t0,32767
	j add_done_2
add_no_overflow_0:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_1
	li $t0,-32768
add_no_underflow_1:
add_done_2:
	li $t2,4
	mul $t0,$t0,$t2
	li $t9,32767
	ble $t0,$t9,mul_no_overflow_3
	li $t0,32767
	j mul_done_5
mul_no_overflow_3:
	li $t9,-32768
	bge $t0,$t9,mul_no_underflow_4
	li $t0,-32768
mul_no_underflow_4:
mul_done_5:
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	bnez $t0,store_continue_6
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_6:
	sw $t3,0($t0)
	sw $t0,global_names
	lw Temp_9,global_s1
	lw Temp_10,global_names
	li Temp_11,0
	bnez Temp_10,array_not_null_7
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_7:
	bgez Temp_11,array_index_nonneg_8
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_8:
	lw $s0,0(Temp_10)
	blt Temp_11,$s0,array_index_ok_9
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_9:
	addi $s0,Temp_11,1
	sll $s0,$s0,2
	add $s0,Temp_10,$s0
	sw Temp_9,0($s0)
.data
string_const_3: .asciiz "Citroen"
.text
	la Temp_13,string_const_3
	lw Temp_14,global_s2
	move $s0,$zero
	move $t9,Temp_13
concat_loop1_start_10:
	lb $s2,0($t9)
	beqz $s2,concat_loop1_end_11
	addi $s0,$s0,1
	addi $t9,$t9,1
	j concat_loop1_start_10
concat_loop1_end_11:
	move $s1,$zero
	move $t9,Temp_14
concat_loop1b_start_14:
	lb $s2,0($t9)
	beqz $s2,concat_loop1b_end_15
	addi $s1,$s1,1
	addi $t9,$t9,1
	j concat_loop1b_start_14
concat_loop1b_end_15:
	add $a0,$s0,$s1
	addi $a0,$a0,1
	li $v0,9
	syscall
	move Temp_12,$v0
	move $s2,$v0
	move $t9,Temp_13
concat_loop2_start_12:
	lb $a0,0($t9)
	beqz $a0,concat_loop2_end_13
	sb $a0,0($s2)
	addi $t9,$t9,1
	addi $s2,$s2,1
	j concat_loop2_start_12
concat_loop2_end_13:
	move $t9,Temp_14
concat_loop3_start_16:
	lb $a0,0($t9)
	sb $a0,0($s2)
	beqz $a0,concat_loop3_end_17
	addi $t9,$t9,1
	addi $s2,$s2,1
	j concat_loop3_start_16
concat_loop3_end_17:
	lw Temp_15,global_names
	li Temp_16,1
	bnez Temp_15,array_not_null_18
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_18:
	bgez Temp_16,array_index_nonneg_19
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_19:
	lw $s0,0(Temp_15)
	blt Temp_16,$s0,array_index_ok_20
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_20:
	addi $s0,Temp_16,1
	sll $s0,$s0,2
	add $s0,Temp_15,$s0
	sw Temp_12,0($s0)
	lw Temp_19,global_s1
.data
string_const_4: .asciiz "said"
.text
	la Temp_20,string_const_4
	move $s0,$zero
	move $t9,Temp_19
concat_loop1_start_21:
	lb $s2,0($t9)
	beqz $s2,concat_loop1_end_22
	addi $s0,$s0,1
	addi $t9,$t9,1
	j concat_loop1_start_21
concat_loop1_end_22:
	move $s1,$zero
	move $t9,Temp_20
concat_loop1b_start_25:
	lb $s2,0($t9)
	beqz $s2,concat_loop1b_end_26
	addi $s1,$s1,1
	addi $t9,$t9,1
	j concat_loop1b_start_25
concat_loop1b_end_26:
	add $a0,$s0,$s1
	addi $a0,$a0,1
	li $v0,9
	syscall
	move Temp_18,$v0
	move $s2,$v0
	move $t9,Temp_19
concat_loop2_start_23:
	lb $a0,0($t9)
	beqz $a0,concat_loop2_end_24
	sb $a0,0($s2)
	addi $t9,$t9,1
	addi $s2,$s2,1
	j concat_loop2_start_23
concat_loop2_end_24:
	move $t9,Temp_20
concat_loop3_start_27:
	lb $a0,0($t9)
	sb $a0,0($s2)
	beqz $a0,concat_loop3_end_28
	addi $t9,$t9,1
	addi $s2,$s2,1
	j concat_loop3_start_27
concat_loop3_end_28:
	lw Temp_21,global_s3
	move $s0,$zero
	move $t9,Temp_18
concat_loop1_start_29:
	lb $s2,0($t9)
	beqz $s2,concat_loop1_end_30
	addi $s0,$s0,1
	addi $t9,$t9,1
	j concat_loop1_start_29
concat_loop1_end_30:
	move $s1,$zero
	move $t9,Temp_21
concat_loop1b_start_33:
	lb $s2,0($t9)
	beqz $s2,concat_loop1b_end_34
	addi $s1,$s1,1
	addi $t9,$t9,1
	j concat_loop1b_start_33
concat_loop1b_end_34:
	add $a0,$s0,$s1
	addi $a0,$a0,1
	li $v0,9
	syscall
	move Temp_17,$v0
	move $s2,$v0
	move $t9,Temp_18
concat_loop2_start_31:
	lb $a0,0($t9)
	beqz $a0,concat_loop2_end_32
	sb $a0,0($s2)
	addi $t9,$t9,1
	addi $s2,$s2,1
	j concat_loop2_start_31
concat_loop2_end_32:
	move $t9,Temp_21
concat_loop3_start_35:
	lb $a0,0($t9)
	sb $a0,0($s2)
	beqz $a0,concat_loop3_end_36
	addi $t9,$t9,1
	addi $s2,$s2,1
	j concat_loop3_start_35
concat_loop3_end_36:
	lw Temp_22,global_names
	li Temp_23,2
	bnez Temp_22,array_not_null_37
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_37:
	bgez Temp_23,array_index_nonneg_38
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_38:
	lw $s0,0(Temp_22)
	blt Temp_23,$s0,array_index_ok_39
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_39:
	addi $s0,Temp_23,1
	sll $s0,$s0,2
	add $s0,Temp_22,$s0
	sw Temp_17,0($s0)
	lw Temp_24,global_names
	li Temp_25,2
	bnez Temp_24,array_not_null_40
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_40:
	bgez Temp_25,array_index_nonneg_41
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_41:
	lw $s0,0(Temp_24)
	blt Temp_25,$s0,array_index_ok_42
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_42:
	addi $s0,Temp_25,1
	sll $s0,$s0,2
	add $s0,Temp_24,$s0
	lw $t1,0($s0)
	move $a0,$t1
	li $v0,4
	syscall
	li $v0,10
	syscall
