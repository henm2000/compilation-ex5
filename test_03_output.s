.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
.text
Label_MergeLists:
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
	subu $sp,$sp,12
	lw $t1,8($fp)
	li $t0,0
	beq $t1,$t0,Label_15_AssignOne
	bne $t1,$t0,Label_16_AssignZero
Label_15_AssignOne:
	li $t0,1
	j Label_14_end
Label_16_AssignZero:
	li $t0,0
	j Label_14_end
Label_14_end:
	beq $t0,$zero,Label_1_if_false
Label_0_if_true:
	lw $t0,12($fp)
	move $v0,$t0
	addu $sp,$sp,12
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
	j Label_2_if_end
Label_1_if_false:
Label_2_if_end:
	lw $t1,12($fp)
	li $t0,0
	beq $t1,$t0,Label_18_AssignOne
	bne $t1,$t0,Label_19_AssignZero
Label_18_AssignOne:
	li $t0,1
	j Label_17_end
Label_19_AssignZero:
	li $t0,0
	j Label_17_end
Label_17_end:
	beq $t0,$zero,Label_4_if_false
Label_3_if_true:
	lw $t0,8($fp)
	move $v0,$t0
	addu $sp,$sp,12
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
	j Label_5_if_end
Label_4_if_false:
Label_5_if_end:
	lw $t0,8($fp)
	bnez $t0,load_continue_0
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_0:
	lw $t1,0($t0)
	lw $t0,12($fp)
	bnez $t0,load_continue_1
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_1:
	lw $t0,0($t0)
	blt $t1,$t0,Label_21_AssignOne
	bge $t1,$t0,Label_22_AssignZero
Label_21_AssignOne:
	li $t0,1
	j Label_20_end
Label_22_AssignZero:
	li $t0,0
	j Label_20_end
Label_20_end:
	beq $t0,$zero,Label_7_if_false
Label_6_if_true:
	lw $t0,8($fp)
	sw $t0,-48($fp)
	lw $t0,8($fp)
	bnez $t0,load_continue_2
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_2:
	lw $t1,4($t0)
	lw $t0,12($fp)
	subu $sp,$sp,4
	sw $t0,0($sp)
	subu $sp,$sp,4
	sw $t1,0($sp)
	jal Label_MergeLists
	move $t1,$v0
	addu $sp,$sp,8
	lw $t0,-48($fp)
	bnez $t0,store_continue_3
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_3:
	sw $t1,4($t0)
	lw $t0,-48($fp)
	move $v0,$t0
	addu $sp,$sp,12
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
	j Label_8_if_end
Label_7_if_false:
Label_8_if_end:
	lw $t0,12($fp)
	bnez $t0,load_continue_4
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_4:
	lw $t1,0($t0)
	lw $t0,8($fp)
	bnez $t0,load_continue_5
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_5:
	lw $t0,0($t0)
	blt $t1,$t0,Label_24_AssignOne
	bge $t1,$t0,Label_25_AssignZero
Label_24_AssignOne:
	li $t0,1
	j Label_23_end
Label_25_AssignZero:
	li $t0,0
	j Label_23_end
Label_23_end:
	beq $t0,$zero,Label_10_if_false
Label_9_if_true:
	lw $t0,12($fp)
	sw $t0,-52($fp)
	lw $t1,8($fp)
	lw $t0,12($fp)
	bnez $t0,load_continue_6
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_6:
	lw $t0,4($t0)
	subu $sp,$sp,4
	sw $t0,0($sp)
	subu $sp,$sp,4
	sw $t1,0($sp)
	jal Label_MergeLists
	move $t1,$v0
	addu $sp,$sp,8
	lw $t0,-52($fp)
	bnez $t0,store_continue_7
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_7:
	sw $t1,4($t0)
	lw $t0,-52($fp)
	move $v0,$t0
	addu $sp,$sp,12
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
	j Label_11_if_end
Label_10_if_false:
Label_11_if_end:
main:
	li $t0,8
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	sw $t0,global_a
	li $t0,8
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	sw $t0,global_b
	li $t0,8
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	sw $t0,global_c
	li $t0,8
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	sw $t0,global_d
	li $t0,8
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	sw $t0,global_A
	li $t0,8
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	sw $t0,global_B
	li $t0,8
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	sw $t0,global_C
	li $t0,8
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	sw $t0,global_D
	li $t0,34
	lw $t1,global_a
	bnez $t1,store_continue_8
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_8:
	sw $t0,0($t1)
	li $t0,70
	lw $t1,global_b
	bnez $t1,store_continue_9
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_9:
	sw $t0,0($t1)
	li $t1,92
	lw $t0,global_c
	bnez $t0,store_continue_10
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_10:
	sw $t1,0($t0)
	li $t0,96
	lw $t1,global_d
	bnez $t1,store_continue_11
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_11:
	sw $t0,0($t1)
	li $t0,12
	lw $t1,global_A
	bnez $t1,store_continue_12
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_12:
	sw $t0,0($t1)
	li $t1,50
	lw $t0,global_B
	bnez $t0,store_continue_13
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_13:
	sw $t1,0($t0)
	li $t0,97
	lw $t1,global_C
	bnez $t1,store_continue_14
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_14:
	sw $t0,0($t1)
	li $t1,99
	lw $t0,global_D
	bnez $t0,store_continue_15
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_15:
	sw $t1,0($t0)
	lw $t0,global_b
	lw $t1,global_a
	bnez $t1,store_continue_16
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_16:
	sw $t0,4($t1)
	lw $t1,global_c
	lw $t0,global_b
	bnez $t0,store_continue_17
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_17:
	sw $t1,4($t0)
	lw $t1,global_d
	lw $t0,global_c
	bnez $t0,store_continue_18
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_18:
	sw $t1,4($t0)
	li $t1,0
	lw $t0,global_d
	bnez $t0,store_continue_19
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_19:
	sw $t1,4($t0)
	lw $t0,global_B
	lw $t1,global_A
	bnez $t1,store_continue_20
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_20:
	sw $t0,4($t1)
	lw $t0,global_C
	lw $t1,global_B
	bnez $t1,store_continue_21
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_21:
	sw $t0,4($t1)
	lw $t0,global_D
	lw $t1,global_C
	bnez $t1,store_continue_22
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_22:
	sw $t0,4($t1)
	li $t0,0
	lw $t1,global_D
	bnez $t1,store_continue_23
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_23:
	sw $t0,4($t1)
	lw $t0,global_a
	lw $t1,global_A
	subu $sp,$sp,4
	sw $t1,0($sp)
	subu $sp,$sp,4
	sw $t0,0($sp)
	jal Label_MergeLists
	move $t0,$v0
	addu $sp,$sp,8
	sw $t0,global_l
Label_13_start:
	li $t1,1
	lw $t0,global_l
	li $t2,0
	beq $t0,$t2,Label_27_AssignOne
	bne $t0,$t2,Label_28_AssignZero
Label_27_AssignOne:
	li $t0,1
	j Label_26_end
Label_28_AssignZero:
	li $t0,0
	j Label_26_end
Label_26_end:
	sub $t0,$t1,$t0
	li $t9,32767
	ble $t0,$t9,sub_no_overflow_24
	li $t0,32767
	j sub_done_26
sub_no_overflow_24:
	li $t9,-32768
	bge $t0,$t9,sub_no_underflow_25
	li $t0,-32768
sub_no_underflow_25:
sub_done_26:
	beq $t0,$zero,Label_12_end
	lw $t0,global_l
	bnez $t0,load_continue_27
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_27:
	lw $t0,0($t0)
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	lw $t0,global_l
	bnez $t0,load_continue_28
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_28:
	lw $t0,4($t0)
	sw $t0,global_l
	j Label_13_start
Label_12_end:

.data
global_a: .word 0
global_b: .word 0
global_c: .word 0
global_d: .word 0
global_A: .word 0
global_B: .word 0
global_C: .word 0
global_D: .word 0
global_l: .word 0
.text
	li $v0,10
	syscall
