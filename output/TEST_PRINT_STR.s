.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
global_s1: .word 0
string_const_0: .asciiz "Hello"
global_s2: .word 0
string_const_1: .asciiz "World"
.text
	la $t1,string_const_0
	sw $t1,global_s1
	la $t0,string_const_1
	sw $t0,global_s2
main:
	lw $t0,global_s1
	move $a0,$t0
	li $v0,4
	syscall
	lw $t0,global_s2
	move $a0,$t0
	li $v0,4
	syscall
	li $v0,10
	syscall
