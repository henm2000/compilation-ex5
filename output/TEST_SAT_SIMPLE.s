.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
global_x: .word 0
global_y: .word 0
.text
main:
	li $t0,30000
	sw $t0,global_x
	li $t0,5000
	sw $t0,global_y
	lw $t0,global_x
	lw $t1,global_y
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
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	li $v0,10
	syscall
