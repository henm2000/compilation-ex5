.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
vtable_Dog:
	.word Label_Dog_go
vtable_SmallDog:
	.word Label_SmallDog_go
.text
Label_Dog_go:
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
	subu $sp,$sp,24
.data
string_const_0: .asciiz "go"
.text
	la $t0,string_const_0
	move $a0,$t0
	li $v0,4
	syscall
	li $t0,2
	li $t1,666
	add $t0,$t0,$t1
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
	li $t1,2
	sub $t0,$t0,$t1
	li $t9,32767
	ble $t0,$t9,sub_no_overflow_3
	li $t0,32767
	j sub_done_5
sub_no_overflow_3:
	li $t9,-32768
	bge $t0,$t9,sub_no_underflow_4
	li $t0,-32768
sub_no_underflow_4:
sub_done_5:
	move $v0,$t0
	addu $sp,$sp,24
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
Label_SmallDog_go:
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
.data
string_const_1: .asciiz "no"
.text
	la $t0,string_const_1
	move $a0,$t0
	li $v0,4
	syscall
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
main:
	li $t0,16
	move $a0,$t0
	li $v0,9
	syscall
	move $t1,$v0
	la $t0,vtable_SmallDog  # load vtable address for SmallDog
	bnez $t1,store_continue_6
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_6:
	sw $t0,0($t1)
	li $t0,8
	bnez $t1,store_continue_7
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_7:
	sw $t0,4($t1)
.data
string_const_2: .asciiz "RUN"
.text
	la $t0,string_const_2
	bnez $t1,store_continue_8
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_8:
	sw $t0,8($t1)
	li $t0,0
	bnez $t1,store_continue_9
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_9:
	sw $t0,12($t1)
	sw $t1,global_dog
	lw $t0,global_dog
	lw $t9,0($t0)  # load vtable ptr
	lw $t9,0($t9)  # load method addr from vtable
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
	lw $t9,36($sp)
	subu $sp,$sp,4
	sw $t0,0($sp)
	jalr $t9  # indirect call
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

.data
global_dog: .word 0
.text
	li $v0,10
	syscall
