.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
.text
Label_monthJuly:
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
	li $t0,7
	sw $t0,-48($fp)
	lw $t0,-48($fp)
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
Label_Person_getAge:
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
	lw $t0,8($fp)
	bnez $t0,load_continue_0
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_0:
	lw $t0,8($t0)
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
Label_Person_birthday:
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
	subu $sp,$sp,28
	lw $t1,8($fp)
	lw $t0,8($fp)
	bnez $t0,load_continue_1
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_1:
	lw $t0,8($t0)
	li $t2,1
	add $t0,$t0,$t2
	li $t9,32767
	ble $t0,$t9,add_no_overflow_2
	li $t0,32767
	j add_done_4
add_no_overflow_2:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_3
	li $t0,-32768
add_no_underflow_3:
add_done_4:
	bnez $t1,store_continue_5
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_5:
	sw $t0,8($t1)
	lw $t0,8($fp)
	bnez $t0,load_continue_6
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_6:
	lw $t0,8($t0)
	move $v0,$t0
	addu $sp,$sp,28
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
Label_Student_getAverage:
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
	li $t0,0
	sw $t0,-48($fp)
	li $t0,0
	sw $t0,-52($fp)
Label_1_start:
	lw $t0,-48($fp)
	li $t1,10
	blt $t0,$t1,Label_6_AssignOne
	bge $t0,$t1,Label_7_AssignZero
Label_6_AssignOne:
	li $t0,1
	j Label_5_end
Label_7_AssignZero:
	li $t0,0
	j Label_5_end
Label_5_end:
	beq $t0,$zero,Label_0_end
	lw $t1,-52($fp)
	lw $t0,8($fp)
	bnez $t0,load_continue_7
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_7:
	lw $t0,16($t0)
	lw $t2,-48($fp)
	bnez $t0,array_not_null_8
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_8:
	bgez $t2,array_index_nonneg_9
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_9:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_10
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_10:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	lw $t0,0($s0)
	add $t0,$t1,$t0
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
	sw $t0,-52($fp)
	lw $t1,-48($fp)
	li $t0,1
	add $t0,$t1,$t0
	li $t9,32767
	ble $t0,$t9,add_no_overflow_14
	li $t0,32767
	j add_done_16
add_no_overflow_14:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_15
	li $t0,-32768
add_no_underflow_15:
add_done_16:
	sw $t0,-48($fp)
	j Label_1_start
Label_0_end:
	lw $t1,-52($fp)
	li $t0,10
	bnez $t0,div_continue_17
	la $a0,string_illegal_div_by_0
	li $v0,4
	syscall
	li $v0,10
	syscall
div_continue_17:
	div $t1,$t0
	mflo $t0
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
	move $t0,$v0
	sw $t0,global_moish
	lw $t3,global_moish
	li $t2,10
	li $t0,1
	add $t0,$t2,$t0
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
	li $t1,4
	mul $t0,$t0,$t1
	li $t9,32767
	ble $t0,$t9,mul_no_overflow_21
	li $t0,32767
	j mul_done_23
mul_no_overflow_21:
	li $t9,-32768
	bge $t0,$t9,mul_no_underflow_22
	li $t0,-32768
mul_no_underflow_22:
mul_done_23:
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	bnez $t0,store_continue_24
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_24:
	sw $t2,0($t0)
	bnez $t3,store_continue_25
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_25:
	sw $t0,16($t3)
	lw $t2,global_moish
	li $t0,13
	li $t1,1
	add $t1,$t0,$t1
	li $t9,32767
	ble $t1,$t9,add_no_overflow_26
	li $t1,32767
	j add_done_28
add_no_overflow_26:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_27
	li $t1,-32768
add_no_underflow_27:
add_done_28:
	li $t3,4
	mul $t1,$t1,$t3
	li $t9,32767
	ble $t1,$t9,mul_no_overflow_29
	li $t1,32767
	j mul_done_31
mul_no_overflow_29:
	li $t9,-32768
	bge $t1,$t9,mul_no_underflow_30
	li $t1,-32768
mul_no_underflow_30:
mul_done_31:
	move $a0,$t1
	li $v0,9
	syscall
	move $t1,$v0
	bnez $t1,store_continue_32
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_32:
	sw $t0,0($t1)
	bnez $t2,store_continue_33
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_33:
	sw $t1,12($t2)
	lw $t0,global_moish
	bnez $t0,load_continue_34
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_34:
	lw $t2,12($t0)
	li $t1,0
	li $t0,7400
	bnez $t2,array_not_null_35
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_35:
	bgez $t1,array_index_nonneg_36
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_36:
	lw $s0,0($t2)
	blt $t1,$s0,array_index_ok_37
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_37:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t0,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_38
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_38:
	lw $t0,12($t0)
	li $t2,1
	li $t1,7400
	bnez $t0,array_not_null_39
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_39:
	bgez $t2,array_index_nonneg_40
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_40:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_41
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_41:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_42
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_42:
	lw $t2,12($t0)
	li $t1,2
	li $t0,7400
	bnez $t2,array_not_null_43
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_43:
	bgez $t1,array_index_nonneg_44
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_44:
	lw $s0,0($t2)
	blt $t1,$s0,array_index_ok_45
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_45:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t0,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_46
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_46:
	lw $t0,12($t0)
	li $t2,3
	li $t1,7400
	bnez $t0,array_not_null_47
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_47:
	bgez $t2,array_index_nonneg_48
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_48:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_49
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_49:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_50
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_50:
	lw $t0,12($t0)
	li $t2,4
	li $t1,7400
	bnez $t0,array_not_null_51
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_51:
	bgez $t2,array_index_nonneg_52
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_52:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_53
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_53:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_54
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_54:
	lw $t0,12($t0)
	li $t2,5
	li $t1,7400
	bnez $t0,array_not_null_55
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_55:
	bgez $t2,array_index_nonneg_56
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_56:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_57
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_57:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_58
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_58:
	lw $t0,12($t0)
	li $t1,6
	li $t2,7400
	bnez $t0,array_not_null_59
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_59:
	bgez $t1,array_index_nonneg_60
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_60:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_61
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_61:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t2,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_62
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_62:
	lw $t0,12($t0)
	li $t2,7
	li $t1,7400
	bnez $t0,array_not_null_63
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_63:
	bgez $t2,array_index_nonneg_64
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_64:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_65
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_65:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_66
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_66:
	lw $t0,12($t0)
	li $t1,8
	li $t2,7400
	bnez $t0,array_not_null_67
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_67:
	bgez $t1,array_index_nonneg_68
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_68:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_69
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_69:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t2,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_70
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_70:
	lw $t2,12($t0)
	li $t0,9
	li $t1,7400
	bnez $t2,array_not_null_71
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_71:
	bgez $t0,array_index_nonneg_72
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_72:
	lw $s0,0($t2)
	blt $t0,$s0,array_index_ok_73
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_73:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t1,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_74
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_74:
	lw $t2,12($t0)
	li $t1,10
	li $t0,7400
	bnez $t2,array_not_null_75
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_75:
	bgez $t1,array_index_nonneg_76
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_76:
	lw $s0,0($t2)
	blt $t1,$s0,array_index_ok_77
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_77:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t0,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_78
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_78:
	lw $t1,12($t0)
	li $t0,11
	li $t2,7400
	bnez $t1,array_not_null_79
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_79:
	bgez $t0,array_index_nonneg_80
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_80:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_81
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_81:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t2,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_82
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_82:
	lw $t0,12($t0)
	li $t1,12
	li $t2,7400
	bnez $t0,array_not_null_83
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_83:
	bgez $t1,array_index_nonneg_84
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_84:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_85
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_85:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t2,0($s0)
	li $t0,0
	sw $t0,global_LinearAlgebra1
	li $t0,1
	sw $t0,global_LinearAlgebra2
	li $t0,2
	sw $t0,global_Calculus1
	li $t0,3
	sw $t0,global_Calculus2
	li $t0,4
	sw $t0,global_Calculus3
	li $t0,5
	sw $t0,global_COMPILATION
	li $t0,6
	sw $t0,global_ODE
	li $t0,7
	sw $t0,global_PDE
	li $t0,8
	sw $t0,global_Scheme
	li $t0,9
	sw $t0,global_CPP
	lw $t0,global_moish
	bnez $t0,load_continue_86
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_86:
	lw $t0,16($t0)
	lw $t2,global_LinearAlgebra1
	li $t1,96
	bnez $t0,array_not_null_87
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_87:
	bgez $t2,array_index_nonneg_88
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_88:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_89
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_89:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_90
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_90:
	lw $t1,16($t0)
	lw $t0,global_LinearAlgebra2
	li $t2,100
	bnez $t1,array_not_null_91
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_91:
	bgez $t0,array_index_nonneg_92
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_92:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_93
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_93:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t2,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_94
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_94:
	lw $t0,16($t0)
	lw $t2,global_Calculus1
	li $t1,95
	bnez $t0,array_not_null_95
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_95:
	bgez $t2,array_index_nonneg_96
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_96:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_97
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_97:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_98
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_98:
	lw $t1,16($t0)
	lw $t2,global_Calculus2
	li $t0,81
	bnez $t1,array_not_null_99
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_99:
	bgez $t2,array_index_nonneg_100
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_100:
	lw $s0,0($t1)
	blt $t2,$s0,array_index_ok_101
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_101:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t0,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_102
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_102:
	lw $t0,16($t0)
	lw $t1,global_Calculus3
	li $t2,95
	bnez $t0,array_not_null_103
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_103:
	bgez $t1,array_index_nonneg_104
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_104:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_105
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_105:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t2,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_106
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_106:
	lw $t2,16($t0)
	lw $t1,global_COMPILATION
	li $t0,95
	bnez $t2,array_not_null_107
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_107:
	bgez $t1,array_index_nonneg_108
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_108:
	lw $s0,0($t2)
	blt $t1,$s0,array_index_ok_109
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_109:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t0,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_110
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_110:
	lw $t0,16($t0)
	lw $t1,global_ODE
	li $t2,100
	bnez $t0,array_not_null_111
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_111:
	bgez $t1,array_index_nonneg_112
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_112:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_113
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_113:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t2,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_114
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_114:
	lw $t0,16($t0)
	lw $t1,global_PDE
	li $t2,100
	bnez $t0,array_not_null_115
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_115:
	bgez $t1,array_index_nonneg_116
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_116:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_117
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_117:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t2,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_118
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_118:
	lw $t0,16($t0)
	lw $t2,global_Scheme
	li $t1,74
	bnez $t0,array_not_null_119
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_119:
	bgez $t2,array_index_nonneg_120
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_120:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_121
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_121:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_122
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_122:
	lw $t0,16($t0)
	lw $t1,global_CPP
	li $t2,99
	bnez $t0,array_not_null_123
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_123:
	bgez $t1,array_index_nonneg_124
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_124:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_125
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_125:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t2,0($s0)
	lw $t0,global_moish
	subu $sp,$sp,4
	sw $t0,0($sp)
	jal Label_Student_getAverage
	move $t1,$v0
	addu $sp,$sp,4
	li $t0,60
	slt $t0,$t0,$t1
	beq $t0,$zero,Label_3_if_false
Label_2_if_true:
	lw $t0,global_moish
	bnez $t0,load_continue_126
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_126:
	lw $t0,12($t0)
	lw $t1,global_moish
	bnez $t1,load_continue_127
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_127:
	lw $t3,8($t1)
	lw $t1,global_moish
	bnez $t1,load_continue_128
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_128:
	lw $t2,12($t1)
	lw $t1,global_moish
	subu $sp,$sp,4
	sw $t1,0($sp)
	jal Label_Person_birthday
	move $t1,$v0
	addu $sp,$sp,4
	bnez $t2,array_not_null_129
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_129:
	bgez $t1,array_index_nonneg_130
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_130:
	lw $s0,0($t2)
	blt $t1,$s0,array_index_ok_131
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_131:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	lw $t2,0($s0)
	li $t1,1000
	add $t1,$t2,$t1
	li $t9,32767
	ble $t1,$t9,add_no_overflow_132
	li $t1,32767
	j add_done_134
add_no_overflow_132:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_133
	li $t1,-32768
add_no_underflow_133:
add_done_134:
	bnez $t0,array_not_null_135
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_135:
	bgez $t3,array_index_nonneg_136
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_136:
	lw $s0,0($t0)
	blt $t3,$s0,array_index_ok_137
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_137:
	addi $s0,$t3,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_138
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_138:
	lw $t1,12($t0)
	lw $t0,global_moish
	bnez $t0,load_continue_139
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_139:
	lw $t2,8($t0)
	lw $t0,global_moish
	bnez $t0,load_continue_140
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_140:
	lw $t3,12($t0)
	lw $t0,global_moish
	subu $sp,$sp,4
	sw $t0,0($sp)
	jal Label_Person_birthday
	move $t0,$v0
	addu $sp,$sp,4
	bnez $t3,array_not_null_141
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_141:
	bgez $t0,array_index_nonneg_142
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_142:
	lw $s0,0($t3)
	blt $t0,$s0,array_index_ok_143
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_143:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t3,$s0
	lw $t0,0($s0)
	li $t3,1000
	add $t0,$t0,$t3
	li $t9,32767
	ble $t0,$t9,add_no_overflow_144
	li $t0,32767
	j add_done_146
add_no_overflow_144:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_145
	li $t0,-32768
add_no_underflow_145:
add_done_146:
	bnez $t1,array_not_null_147
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_147:
	bgez $t2,array_index_nonneg_148
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_148:
	lw $s0,0($t1)
	blt $t2,$s0,array_index_ok_149
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_149:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t0,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_150
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_150:
	lw $t1,12($t0)
	li $t0,10
	bnez $t1,array_not_null_151
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_151:
	bgez $t0,array_index_nonneg_152
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_152:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_153
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_153:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	lw $t0,0($s0)
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	lw $t0,global_moish
	bnez $t0,load_continue_154
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_154:
	lw $t0,12($t0)
	li $t1,11
	bnez $t0,array_not_null_155
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_155:
	bgez $t1,array_index_nonneg_156
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_156:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_157
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_157:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	lw $t0,0($s0)
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	j Label_4_if_end
Label_3_if_false:
Label_4_if_end:

.data
global_moish: .word 0
global_LinearAlgebra1: .word 0
global_LinearAlgebra2: .word 0
global_Calculus1: .word 0
global_Calculus2: .word 0
global_Calculus3: .word 0
global_COMPILATION: .word 0
global_ODE: .word 0
global_PDE: .word 0
global_Scheme: .word 0
global_CPP: .word 0
.text
	li $v0,10
	syscall
