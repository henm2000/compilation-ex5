.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
.text
main:
	li $t0,10
	sw $t0,global_a
	li $t0,3
	sw $t0,global_b
	lw $t1,global_a
	lw $t0,global_b
	bnez $t0,div_continue_0
	la $a0,string_illegal_div_by_0
	li $v0,4
	syscall
	li $v0,10
	syscall
div_continue_0:
	div $t1,$t0
	mflo $t0
	sw $t0,global_c
	lw $t0,global_c
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	lw $t0,global_a
	lw $t1,global_b
	slt $t0,$t1,$t0
	beq $t0,$zero,Label_1_if_false
Label_0_if_true:
	li $t0,1
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	j Label_2_if_end
Label_1_if_false:
	li $t0,0
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
Label_2_if_end:
	lw $t0,global_b
	lw $t1,global_a
	slt $t0,$t1,$t0
	beq $t0,$zero,Label_4_if_false
Label_3_if_true:
	li $t0,1
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	j Label_5_if_end
Label_4_if_false:
	li $t0,0
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
Label_5_if_end:
	li $v0,10
	syscall
