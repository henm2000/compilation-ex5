.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
	global_a: .word 0
	global_b: .word 0
.text
main:
	li $t0,30000
	sw $t0,global_a
	li $t0,5000
	sw $t0,global_b
	lw $t1,global_a
	lw $t0,global_b
	add $t0,$t1,$t0
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
	li $t0,-30000
	sw $t0,global_a
	li $t0,-5000
	sw $t0,global_b
	lw $t1,global_a
	lw $t0,global_b
	add $t0,$t1,$t0
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
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	li $t0,200
	sw $t0,global_a
	li $t0,200
	sw $t0,global_b
	lw $t1,global_a
	lw $t0,global_b
	mul $t0,$t1,$t0
	li $t9,32767
	ble $t0,$t9,mul_no_overflow_6
	li $t0,32767
	j mul_done_8
mul_no_overflow_6:
	li $t9,-32768
	bge $t0,$t9,mul_no_underflow_7
	li $t0,-32768
mul_no_underflow_7:
mul_done_8:
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	li $v0,10
	syscall
