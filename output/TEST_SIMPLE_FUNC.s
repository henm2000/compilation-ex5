.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
.text
Label_Add:
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
	subu $sp,$sp,16
	lw $t0,8($fp)
	lw $t1,12($fp)
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
	sw $t0,-48($fp)
	lw $t0,-48($fp)
	move $v0,$t0
	addu $sp,$sp,16
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
	li $t0,3
	li $t1,5
	subu $sp,$sp,4
	sw $t1,0($sp)
	subu $sp,$sp,4
	sw $t0,0($sp)
	jal Label_Add
	move $t0,$v0
	addu $sp,$sp,8
	sw $t0,global_x
	lw $t0,global_x
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall

.data
global_x: .word 0
.text
	li $v0,10
	syscall
