.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
.text
Label_IsPrime:
	subu $sp,$sp,4
	sw $ra,0($sp)
	subu $sp,$sp,4
	sw $fp,0($sp)
	move $fp,$sp
	subu $sp,$sp,4
	sw $t0,0($sp)
	subu $sp,$sp,4
	sw $t1,0($sp)
	subu $sp,$sp,4
	sw $t2,0($sp)
	subu $sp,$sp,4
	sw $t3,0($sp)
	subu $sp,$sp,4
	sw $t4,0($sp)
	subu $sp,$sp,4
	sw $t5,0($sp)
	subu $sp,$sp,4
	sw $t6,0($sp)
	subu $sp,$sp,4
	sw $t7,0($sp)
	subu $sp,$sp,4
	sw $t8,0($sp)
	subu $sp,$sp,4
	sw $t9,0($sp)
	subu $sp,$sp,8
	li $t0,2
	sw $t0,-44($fp)
	li $t0,2
	sw $t0,-48($fp)
Label_1_start:
	lw $t1,-44($fp)
	lw $t0,8($fp)
	blt $t1,$t0,Label_13_AssignOne
	bge $t1,$t0,Label_14_AssignZero
Label_13_AssignOne:
	li $t0,1
	j Label_12_end
Label_14_AssignZero:
	li $t0,0
	j Label_12_end
Label_12_end:
	beq $t0,$zero,Label_0_end
	li $t0,2
	sw $t0,-48($fp)
Label_3_start:
	lw $t0,-48($fp)
	lw $t1,8($fp)
	blt $t0,$t1,Label_16_AssignOne
	bge $t0,$t1,Label_17_AssignZero
Label_16_AssignOne:
	li $t0,1
	j Label_15_end
Label_17_AssignZero:
	li $t0,0
	j Label_15_end
Label_15_end:
	beq $t0,$zero,Label_2_end
	lw $t1,-44($fp)
	lw $t0,-48($fp)
	mul $t0,$t1,$t0
	li $t9,32767
	ble $t0,$t9,mul_no_overflow_0
	li $t0,32767
	j mul_done_2
mul_no_overflow_0:
	li $t9,-32768
	bge $t0,$t9,mul_no_underflow_1
	li $t0,-32768
mul_no_underflow_1:
mul_done_2:
	lw $t1,8($fp)
	beq $t0,$t1,Label_19_AssignOne
	bne $t0,$t1,Label_20_AssignZero
Label_19_AssignOne:
	li $t0,1
	j Label_18_end
Label_20_AssignZero:
	li $t0,0
	j Label_18_end
Label_18_end:
	beq $t0,$zero,Label_5_if_false
Label_4_if_true:
	li $t0,0
	move $v0,$t0
	addu $sp,$sp,8
	lw $t9,0($sp)
	addu $sp,$sp,4
	lw $t8,0($sp)
	addu $sp,$sp,4
	lw $t7,0($sp)
	addu $sp,$sp,4
	lw $t6,0($sp)
	addu $sp,$sp,4
	lw $t5,0($sp)
	addu $sp,$sp,4
	lw $t4,0($sp)
	addu $sp,$sp,4
	lw $t3,0($sp)
	addu $sp,$sp,4
	lw $t2,0($sp)
	addu $sp,$sp,4
	lw $t1,0($sp)
	addu $sp,$sp,4
	lw $t0,0($sp)
	addu $sp,$sp,4
	lw $fp,0($sp)
	addu $sp,$sp,4
	lw $ra,0($sp)
	addu $sp,$sp,4
	jr $ra
	j Label_6_if_end
Label_5_if_false:
Label_6_if_end:
	lw $t0,-48($fp)
	li $t1,1
	add $t0,$t0,$t1
	li $t9,32767
	ble $t0,$t9,add_no_overflow_3
	li $t0,32767
	j add_done_5
add_no_overflow_3:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_4
	li $t0,-32768
add_no_underflow_4:
add_done_5:
	sw $t0,-48($fp)
	j Label_3_start
Label_2_end:
	lw $t1,-44($fp)
	li $t0,1
	add $t0,$t1,$t0
	li $t9,32767
	ble $t0,$t9,add_no_overflow_6
	li $t0,32767
	j add_done_8
add_no_overflow_6:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_7
	li $t0,-32768
add_no_underflow_7:
add_done_8:
	sw $t0,-44($fp)
	j Label_1_start
Label_0_end:
	li $t0,1
	move $v0,$t0
	addu $sp,$sp,8
	lw $t9,0($sp)
	addu $sp,$sp,4
	lw $t8,0($sp)
	addu $sp,$sp,4
	lw $t7,0($sp)
	addu $sp,$sp,4
	lw $t6,0($sp)
	addu $sp,$sp,4
	lw $t5,0($sp)
	addu $sp,$sp,4
	lw $t4,0($sp)
	addu $sp,$sp,4
	lw $t3,0($sp)
	addu $sp,$sp,4
	lw $t2,0($sp)
	addu $sp,$sp,4
	lw $t1,0($sp)
	addu $sp,$sp,4
	lw $t0,0($sp)
	addu $sp,$sp,4
	lw $fp,0($sp)
	addu $sp,$sp,4
	lw $ra,0($sp)
	addu $sp,$sp,4
	jr $ra
Label_PrintPrimes:
	subu $sp,$sp,4
	sw $ra,0($sp)
	subu $sp,$sp,4
	sw $fp,0($sp)
	move $fp,$sp
	subu $sp,$sp,4
	sw $t0,0($sp)
	subu $sp,$sp,4
	sw $t1,0($sp)
	subu $sp,$sp,4
	sw $t2,0($sp)
	subu $sp,$sp,4
	sw $t3,0($sp)
	subu $sp,$sp,4
	sw $t4,0($sp)
	subu $sp,$sp,4
	sw $t5,0($sp)
	subu $sp,$sp,4
	sw $t6,0($sp)
	subu $sp,$sp,4
	sw $t7,0($sp)
	subu $sp,$sp,4
	sw $t8,0($sp)
	subu $sp,$sp,4
	sw $t9,0($sp)
	subu $sp,$sp,4
	lw $t0,8($fp)
	sw $t0,-44($fp)
Label_8_start:
	lw $t1,-44($fp)
	lw $t0,12($fp)
	li $t2,1
	add $t0,$t0,$t2
	li $t9,32767
	ble $t0,$t9,add_no_overflow_9
	li $t0,32767
	j add_done_11
add_no_overflow_9:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_10
	li $t0,-32768
add_no_underflow_10:
add_done_11:
	blt $t1,$t0,Label_22_AssignOne
	bge $t1,$t0,Label_23_AssignZero
Label_22_AssignOne:
	li $t0,1
	j Label_21_end
Label_23_AssignZero:
	li $t0,0
	j Label_21_end
Label_21_end:
	beq $t0,$zero,Label_7_end
	lw $t0,-44($fp)
	# Save caller-saved registers
	addiu $sp,$sp,-40
	sw $t0,0($sp)
	sw $t1,4($sp)
	sw $t2,8($sp)
	sw $t3,12($sp)
	sw $t4,16($sp)
	sw $t5,20($sp)
	sw $t6,24($sp)
	sw $t7,28($sp)
	sw $t8,32($sp)
	sw $t9,36($sp)
	subu $sp,$sp,4
	sw $t0,0($sp)
	jal Label_IsPrime
	addu $sp,$sp,4
	# Restore caller-saved registers
	lw $t0,0($sp)
	lw $t1,4($sp)
	lw $t2,8($sp)
	lw $t3,12($sp)
	lw $t4,16($sp)
	lw $t5,20($sp)
	lw $t6,24($sp)
	lw $t7,28($sp)
	lw $t8,32($sp)
	lw $t9,36($sp)
	addiu $sp,$sp,40
	move $t0,$v0
	beq $t0,$zero,Label_10_if_false
Label_9_if_true:
	lw $t0,-44($fp)
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	j Label_11_if_end
Label_10_if_false:
Label_11_if_end:
	lw $t0,-44($fp)
	li $t1,1
	add $t0,$t0,$t1
	li $t9,32767
	ble $t0,$t9,add_no_overflow_12
	li $t0,32767
	j add_done_14
add_no_overflow_12:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_13
	li $t0,-32768
add_no_underflow_13:
add_done_14:
	sw $t0,-44($fp)
	j Label_8_start
Label_7_end:
	addu $sp,$sp,4
	lw $t9,0($sp)
	addu $sp,$sp,4
	lw $t8,0($sp)
	addu $sp,$sp,4
	lw $t7,0($sp)
	addu $sp,$sp,4
	lw $t6,0($sp)
	addu $sp,$sp,4
	lw $t5,0($sp)
	addu $sp,$sp,4
	lw $t4,0($sp)
	addu $sp,$sp,4
	lw $t3,0($sp)
	addu $sp,$sp,4
	lw $t2,0($sp)
	addu $sp,$sp,4
	lw $t1,0($sp)
	addu $sp,$sp,4
	lw $t0,0($sp)
	addu $sp,$sp,4
	lw $fp,0($sp)
	addu $sp,$sp,4
	lw $ra,0($sp)
	addu $sp,$sp,4
	jr $ra
main:
	li $t1,2
	li $t0,100
	# Save caller-saved registers
	addiu $sp,$sp,-40
	sw $t0,0($sp)
	sw $t1,4($sp)
	sw $t2,8($sp)
	sw $t3,12($sp)
	sw $t4,16($sp)
	sw $t5,20($sp)
	sw $t6,24($sp)
	sw $t7,28($sp)
	sw $t8,32($sp)
	sw $t9,36($sp)
	subu $sp,$sp,4
	sw $t0,0($sp)
	subu $sp,$sp,4
	sw $t1,0($sp)
	jal Label_PrintPrimes
	addu $sp,$sp,8
	# Restore caller-saved registers
	lw $t0,0($sp)
	lw $t1,4($sp)
	lw $t2,8($sp)
	lw $t3,12($sp)
	lw $t4,16($sp)
	lw $t5,20($sp)
	lw $t6,24($sp)
	lw $t7,28($sp)
	lw $t8,32($sp)
	lw $t9,36($sp)
	addiu $sp,$sp,40
	li $v0,10
	syscall
