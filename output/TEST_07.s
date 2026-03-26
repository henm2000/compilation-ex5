.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
vtable_Grandfather:
	.word Label_Grandfather_WALK
	.word Label_Grandfather_RUN
	.word Label_Grandfather_SWIM
vtable_Father:
	.word Label_Grandfather_WALK
	.word Label_Father_RUN
	.word Label_Father_SWIM
	.word Label_Father_PAINT
vtable_Son:
	.word Label_Son_WALK
	.word Label_Son_RUN
	.word Label_Father_SWIM
	.word Label_Father_PAINT
.text
Label_Grandfather_WALK:
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
.data
string_const_0: .asciiz "GrandfatherWALK"
.text
	la $t0,string_const_0
	move $a0,$t0
	li $v0,4
	syscall
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
Label_Grandfather_RUN:
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
.data
string_const_1: .asciiz "GrandfatherRUN"
.text
	la $t6,string_const_1
	move $a0,$t6
	li $v0,4
	syscall
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
Label_Grandfather_SWIM:
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
.data
string_const_2: .asciiz "GrandfatherSWIM"
.text
	la $t7,string_const_2
	move $a0,$t7
	li $v0,4
	syscall
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
Label_Father_SWIM:
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
.data
string_const_3: .asciiz "FatherSWIM"
.text
	la $t5,string_const_3
	move $a0,$t5
	li $v0,4
	syscall
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
Label_Father_PAINT:
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
.data
string_const_4: .asciiz "FatherPAINT"
.text
	la $t8,string_const_4
	move $a0,$t8
	li $v0,4
	syscall
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
Label_Father_RUN:
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
.data
string_const_5: .asciiz "FatherRUN"
.text
	la $t9,string_const_5
	move $a0,$t9
	li $v0,4
	syscall
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
Label_Son_RUN:
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
.data
string_const_6: .asciiz "SonRUN"
.text
	la $t4,string_const_6
	move $a0,$t4
	li $v0,4
	syscall
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
Label_Son_WALK:
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
.data
string_const_7: .asciiz "SonWALK"
.text
	la $t1,string_const_7
	move $a0,$t1
	li $v0,4
	syscall
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
	li $t0,0
	sw $t0,global_i
	li $t1,27
	li $t0,1
	add $t4,$t1,$t0
	li $t9,32767
	ble $t4,$t9,add_no_overflow_0
	li $t4,32767
	j add_done_2
add_no_overflow_0:
	li $t9,-32768
	bge $t4,$t9,add_no_underflow_1
	li $t4,-32768
add_no_underflow_1:
add_done_2:
	li $t0,4
	mul $t0,$t4,$t0
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
	sw $t1,0($t0)
	sw $t0,global_A
Label_1_start:
	lw $t0,global_i
	li $t1,27
	blt $t0,$t1,Label_5_AssignOne
	bge $t0,$t1,Label_6_AssignZero
Label_5_AssignOne:
	li $t0,1
	j Label_4_end
Label_6_AssignZero:
	li $t0,0
	j Label_4_end
Label_4_end:
	beq $t0,$zero,Label_0_end
	lw $t0,global_A
	lw $t4,global_i
	li $t1,4
	move $a0,$t1
	li $v0,9
	syscall
	move $t1,$v0
	la $t2,vtable_Father  # load vtable address for Father
	bnez $t1,store_continue_7
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_7:
	sw $t2,0($t1)
	bnez $t0,array_not_null_8
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_8:
	bgez $t4,array_index_nonneg_9
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_9:
	lw $s0,0($t0)
	blt $t4,$s0,array_index_ok_10
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_10:
	addi $s0,$t4,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	lw $t0,global_i
	li $t1,1
	add $t0,$t0,$t1
	li $t9,32767
	ble $t0,$t9,add_no_overflow_11
	li $t0,32767
	j add_done_13
add_no_overflow_11:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_12
	li $t0,-32768
add_no_underflow_12:
add_done_13:
	sw $t0,global_i
	j Label_1_start
Label_0_end:
	li $t0,0
	sw $t0,global_i
Label_3_start:
	lw $t0,global_i
	li $t1,11
	blt $t0,$t1,Label_8_AssignOne
	bge $t0,$t1,Label_9_AssignZero
Label_8_AssignOne:
	li $t0,1
	j Label_7_end
Label_9_AssignZero:
	li $t0,0
	j Label_7_end
Label_7_end:
	beq $t0,$zero,Label_2_end
	lw $t2,global_A
	lw $t1,global_i
	li $t0,4
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	la $t3,vtable_Son  # load vtable address for Son
	bnez $t0,store_continue_14
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_14:
	sw $t3,0($t0)
	bnez $t2,array_not_null_15
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_15:
	bgez $t1,array_index_nonneg_16
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_16:
	lw $s0,0($t2)
	blt $t1,$s0,array_index_ok_17
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_17:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t0,0($s0)
	lw $t0,global_i
	li $t1,1
	add $t0,$t0,$t1
	li $t9,32767
	ble $t0,$t9,add_no_overflow_18
	li $t0,32767
	j add_done_20
add_no_overflow_18:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_19
	li $t0,-32768
add_no_underflow_19:
add_done_20:
	sw $t0,global_i
	j Label_3_start
Label_2_end:
	lw $t1,global_A
	li $t0,3
	bnez $t1,array_not_null_21
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_21:
	bgez $t0,array_index_nonneg_22
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_22:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_23
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_23:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	lw $t0,0($s0)
	sw $t0,global_g1
	lw $t1,global_A
	li $t0,20
	bnez $t1,array_not_null_24
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_24:
	bgez $t0,array_index_nonneg_25
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_25:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_26
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_26:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	lw $t0,0($s0)
	sw $t0,global_g2
	lw $t0,global_g1
	lw $t9,0($t0)  # load vtable ptr
	lw $t9,0($t9)  # load method addr from vtable
	subu $sp,$sp,4
	sw $t0,0($sp)
	jalr $t9  # indirect call
	addu $sp,$sp,4
	lw $t0,global_g2
	lw $t9,0($t0)  # load vtable ptr
	lw $t9,8($t9)  # load method addr from vtable
	subu $sp,$sp,4
	sw $t0,0($sp)
	jalr $t9  # indirect call
	addu $sp,$sp,4

.data
global_i: .word 0
global_A: .word 0
global_g1: .word 0
global_g2: .word 0
.text
	li $v0,10
	syscall
