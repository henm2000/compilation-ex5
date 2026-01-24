.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
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
	li $t0,2
Label_1_start:
	lw $t0,global_i
	lw $t1,global_p
	blt $t0,$t1,Label_13_AssignOne
	bge $t0,$t1,Label_14_AssignZero
Label_13_AssignOne:
	li $t0,1
	j Label_12_end
Label_14_AssignZero:
	li $t0,0
	j Label_12_end
Label_12_end:
	beq $t0,$zero,Label_0_end
	li $t0,2
Label_3_start:
	lw $t0,global_j
	lw $t1,global_p
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
	lw $t0,global_i
	lw $t1,global_j
	mul $t0,$t0,$t1
	lw $t1,global_p
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
	j Label_6_if_end
Label_5_if_false:
Label_6_if_end:
	lw $t1,global_j
	li $t0,1
	add $t0,$t1,$t0
	j Label_3_start
Label_2_end:
	lw $t1,global_i
	li $t0,1
	add $t0,$t1,$t0
	j Label_1_start
Label_0_end:
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
	lw $t0,global_start
Label_8_start:
	lw $t2,global_p
	lw $t0,global_end
	li $t1,1
	add $t0,$t0,$t1
	blt $t2,$t0,Label_22_AssignOne
	bge $t2,$t0,Label_23_AssignZero
Label_22_AssignOne:
	li $t0,1
	j Label_21_end
Label_23_AssignZero:
	li $t0,0
	j Label_21_end
Label_21_end:
	beq $t0,$zero,Label_7_end
	lw $t0,global_p
	subu $sp,$sp,4
	sw $t0,0($sp)
	jal Label_IsPrime
	move $t0,$v0
	addu $sp,$sp,4
	beq $t0,$zero,Label_10_if_false
Label_9_if_true:
	lw $t0,global_p
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	j Label_11_if_end
Label_10_if_false:
Label_11_if_end:
	lw $t0,global_p
	li $t1,1
	add $t0,$t0,$t1
	j Label_8_start
Label_7_end:
	global_i: .word 0
	global_j: .word 0
	global_p: .word 0
.text
	sw $t0,global_i
	sw $t0,global_j
	sw $t0,global_j
	sw $t0,global_j
	sw $t0,global_i
	sw $t0,global_p
	sw $t0,global_p
main:
	li $t0,2
	li $t1,100
	subu $sp,$sp,4
	sw $t1,0($sp)
	subu $sp,$sp,4
	sw $t0,0($sp)
	jal Label_PrintPrimes
	addu $sp,$sp,8
	li $v0,10
	syscall
