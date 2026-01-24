.data
myvar: .word 0
str: .asciiz "Hello"
.text
	la $t0,str
	sw $t0,myvar
main:
	lw $t0,myvar
	move $a0,$t0
	li $v0,4
	syscall
	li $v0,10
	syscall
