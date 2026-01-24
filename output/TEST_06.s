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
main:
	la $t0,string_const_0
	sw $t0,global_s1
	la $t3,string_const_1
	sw $t3,global_s2
	la $t2,string_const_2
	sw $t2,global_s3
	li $t2,3
	li $t0,1
	add $t3,$t2,$t0
	li $t9,32767
	ble $t3,$t9,add_no_overflow_0
	li $t3,32767
	j add_done_2
add_no_overflow_0:
	li $t9,-32768
	bge $t3,$t9,add_no_underflow_1
	li $t3,-32768
add_no_underflow_1:
add_done_2:
	li $t0,4
	mul $t0,$t3,$t0
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
	sw $t2,0($t0)
	sw $t0,global_names
	lw $t2,global_names
	li $t0,0
	lw $t3,global_s1
	bnez $t2,array_not_null_7
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_7:
	bgez $t0,array_index_nonneg_8
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_8:
	lw $s0,0($t2)
	blt $t0,$s0,array_index_ok_9
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_9:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t3,0($s0)
	lw $t3,global_names
	li $t0,1
.data
string_const_3: .asciiz "Citroen"
.text
	la $t4,string_const_3
	lw $t2,global_s2
	move $s0,$t4
	move $s1,$t2
	move $s2,$zero
	move $s4,$s0
concat_loop1_start_10:
	lb $a0,0($s4)
	beqz $a0,concat_loop1_end_11
	addi $s2,$s2,1
	addi $s4,$s4,1
	j concat_loop1_start_10
concat_loop1_end_11:
	move $t9,$s2
	move $s2,$zero
	move $s4,$s1
concat_loop2_start_12:
	lb $a0,0($s4)
	beqz $a0,concat_loop2_end_13
	addi $s2,$s2,1
	addi $s4,$s4,1
	j concat_loop2_start_12
concat_loop2_end_13:
	add $a0,$t9,$s2
	addi $a0,$a0,1
	li $v0,9
	syscall
	move $t2,$v0
	move $s3,$v0
	move $s4,$s0
concat_loop3_start_14:
	lb $a0,0($s4)
	beqz $a0,concat_loop3_end_15
	sb $a0,0($s3)
	addi $s4,$s4,1
	addi $s3,$s3,1
	j concat_loop3_start_14
concat_loop3_end_15:
	move $s4,$s1
concat_loop4_start_16:
	lb $a0,0($s4)
	sb $a0,0($s3)
	beqz $a0,concat_loop4_end_17
	addi $s4,$s4,1
	addi $s3,$s3,1
	j concat_loop4_start_16
concat_loop4_end_17:
	bnez $t3,array_not_null_18
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_18:
	bgez $t0,array_index_nonneg_19
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_19:
	lw $s0,0($t3)
	blt $t0,$s0,array_index_ok_20
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_20:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t3,$s0
	sw $t2,0($s0)
	lw $t2,global_names
	li $t3,2
	lw $t0,global_s1
.data
string_const_4: .asciiz "said"
.text
	la $t1,string_const_4
	move $s0,$t0
	move $s1,$t1
	move $s2,$zero
	move $s4,$s0
concat_loop1_start_21:
	lb $a0,0($s4)
	beqz $a0,concat_loop1_end_22
	addi $s2,$s2,1
	addi $s4,$s4,1
	j concat_loop1_start_21
concat_loop1_end_22:
	move $t9,$s2
	move $s2,$zero
	move $s4,$s1
concat_loop2_start_23:
	lb $a0,0($s4)
	beqz $a0,concat_loop2_end_24
	addi $s2,$s2,1
	addi $s4,$s4,1
	j concat_loop2_start_23
concat_loop2_end_24:
	add $a0,$t9,$s2
	addi $a0,$a0,1
	li $v0,9
	syscall
	move $t1,$v0
	move $s3,$v0
	move $s4,$s0
concat_loop3_start_25:
	lb $a0,0($s4)
	beqz $a0,concat_loop3_end_26
	sb $a0,0($s3)
	addi $s4,$s4,1
	addi $s3,$s3,1
	j concat_loop3_start_25
concat_loop3_end_26:
	move $s4,$s1
concat_loop4_start_27:
	lb $a0,0($s4)
	sb $a0,0($s3)
	beqz $a0,concat_loop4_end_28
	addi $s4,$s4,1
	addi $s3,$s3,1
	j concat_loop4_start_27
concat_loop4_end_28:
	lw $t0,global_s3
	move $s0,$t1
	move $s1,$t0
	move $s2,$zero
	move $s4,$s0
concat_loop1_start_29:
	lb $a0,0($s4)
	beqz $a0,concat_loop1_end_30
	addi $s2,$s2,1
	addi $s4,$s4,1
	j concat_loop1_start_29
concat_loop1_end_30:
	move $t9,$s2
	move $s2,$zero
	move $s4,$s1
concat_loop2_start_31:
	lb $a0,0($s4)
	beqz $a0,concat_loop2_end_32
	addi $s2,$s2,1
	addi $s4,$s4,1
	j concat_loop2_start_31
concat_loop2_end_32:
	add $a0,$t9,$s2
	addi $a0,$a0,1
	li $v0,9
	syscall
	move $t0,$v0
	move $s3,$v0
	move $s4,$s0
concat_loop3_start_33:
	lb $a0,0($s4)
	beqz $a0,concat_loop3_end_34
	sb $a0,0($s3)
	addi $s4,$s4,1
	addi $s3,$s3,1
	j concat_loop3_start_33
concat_loop3_end_34:
	move $s4,$s1
concat_loop4_start_35:
	lb $a0,0($s4)
	sb $a0,0($s3)
	beqz $a0,concat_loop4_end_36
	addi $s4,$s4,1
	addi $s3,$s3,1
	j concat_loop4_start_35
concat_loop4_end_36:
	bnez $t2,array_not_null_37
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_37:
	bgez $t3,array_index_nonneg_38
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_38:
	lw $s0,0($t2)
	blt $t3,$s0,array_index_ok_39
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_39:
	addi $s0,$t3,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t0,0($s0)
	lw $t0,global_names
	li $t1,2
	bnez $t0,array_not_null_40
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_40:
	bgez $t1,array_index_nonneg_41
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_41:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_42
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_42:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	lw $t0,0($s0)
	move $a0,$t0
	li $v0,4
	syscall

.data
global_names: .word 0
.text
	li $v0,10
	syscall
