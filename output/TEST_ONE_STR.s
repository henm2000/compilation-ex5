.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
global_s: .word 0
string_const_0: .asciiz "Test"
.text
main:
	la $t0,string_const_0
	sw $t0,global_s
	lw $t0,global_s
	move $a0,$t0
	li $v0,4
	syscall
	li $v0,10
	syscall
