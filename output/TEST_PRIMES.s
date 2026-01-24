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
	sw $t0,-48($fp)
	lw $t0,8($fp)
	sw $t0,-52($fp)
Label_1_start:
	lw $t0,-48($fp)
	lw $t1,-52($fp)
	blt $t0,$t1,Label_11_AssignOne
	bge $t0,$t1,Label_12_AssignZero
Label_11_AssignOne:
	li $t0,1
	j Label_10_end
Label_12_AssignZero:
	li $t0,0
	j Label_10_end
Label_10_end:
	beq $t0,$zero,Label_0_end
	lw $t1,8($fp)
	lw $t2,8($fp)
	lw $t0,-48($fp)
	bnez $t0,div_continue_0
	la $a0,string_illegal_div_by_0
	li $v0,4
	syscall
	li $v0,10
	syscall
div_continue_0:
	div $t2,$t0
	mflo $t2
	lw $t0,-48($fp)
	mul $t0,$t2,$t0
	li $t9,32767
	ble $t0,$t9,mul_no_overflow_1
	li $t0,32767
	j mul_done_3
mul_no_overflow_1:
	li $t9,-32768
	bge $t0,$t9,mul_no_underflow_2
	li $t0,-32768
mul_no_underflow_2:
mul_done_3:
	sub $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,sub_no_overflow_4
	li $t1,32767
	j sub_done_6
sub_no_overflow_4:
	li $t9,-32768
	bge $t1,$t9,sub_no_underflow_5
	li $t1,-32768
sub_no_underflow_5:
sub_done_6:
	li $t0,0
	beq $t1,$t0,Label_14_AssignOne
	bne $t1,$t0,Label_15_AssignZero
Label_14_AssignOne:
	li $t0,1
	j Label_13_end
Label_15_AssignZero:
	li $t0,0
	j Label_13_end
Label_13_end:
	beq $t0,$zero,Label_3_if_false
Label_2_if_true:
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
	j Label_4_if_end
Label_3_if_false:
Label_4_if_end:
	lw $t1,-48($fp)
	li $t0,1
	add $t0,$t1,$t0
	li $t9,32767
	ble $t0,$t9,add_no_overflow_7
	li $t0,32767
	j add_done_9
add_no_overflow_7:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_8
	li $t0,-32768
add_no_underflow_8:
add_done_9:
	sw $t0,-48($fp)
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
	sw $t0,-48($fp)
Label_6_start:
	lw $t0,-48($fp)
	lw $t1,12($fp)
	blt $t0,$t1,Label_17_AssignOne
	bge $t0,$t1,Label_18_AssignZero
Label_17_AssignOne:
	li $t0,1
	j Label_16_end
Label_18_AssignZero:
	li $t0,0
	j Label_16_end
Label_16_end:
	beq $t0,$zero,Label_5_end
	lw $t0,-48($fp)
	subu $sp,$sp,4
	sw $t0,0($sp)
	jal Label_IsPrime
	move $t0,$v0
	addu $sp,$sp,4
	li $t1,1
	beq $t0,$t1,Label_20_AssignOne
	bne $t0,$t1,Label_21_AssignZero
Label_20_AssignOne:
	li $t0,1
	j Label_19_end
Label_21_AssignZero:
	li $t0,0
	j Label_19_end
Label_19_end:
	beq $t0,$zero,Label_8_if_false
Label_7_if_true:
	lw $t0,-48($fp)
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	j Label_9_if_end
Label_8_if_false:
Label_9_if_end:
	lw $t1,-48($fp)
	li $t0,1
	add $t0,$t1,$t0
	li $t9,32767
	ble $t0,$t9,add_no_overflow_10
	li $t0,32767
	j add_done_12
add_no_overflow_10:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_11
	li $t0,-32768
add_no_underflow_11:
add_done_12:
	sw $t0,-48($fp)
	j Label_6_start
Label_5_end:
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
	li $t0,2
	li $t1,10
	subu $sp,$sp,4
	sw $t1,0($sp)
	subu $sp,$sp,4
	sw $t0,0($sp)
	jal Label_PrintPrimes
	addu $sp,$sp,8
	li $v0,10
	syscall
