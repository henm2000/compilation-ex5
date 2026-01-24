.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
.text
Label_trace3x3:
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
	subu $sp,$sp,56
	lw $t1,8($fp)
	li $t0,0
	bnez $t1,array_not_null_0
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_0:
	bgez $t0,array_index_nonneg_1
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_1:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_2
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_2:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	lw $t1,0($s0)
	li $t0,0
	bnez $t1,array_not_null_3
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_3:
	bgez $t0,array_index_nonneg_4
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_4:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_5
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_5:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	lw $t2,0($s0)
	lw $t1,8($fp)
	li $t0,1
	bnez $t1,array_not_null_6
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_6:
	bgez $t0,array_index_nonneg_7
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_7:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_8
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_8:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	lw $t0,0($s0)
	li $t1,1
	bnez $t0,array_not_null_9
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_9:
	bgez $t1,array_index_nonneg_10
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_10:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_11
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_11:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	lw $t0,0($s0)
	add $t2,$t2,$t0
	li $t9,32767
	ble $t2,$t9,add_no_overflow_12
	li $t2,32767
	j add_done_14
add_no_overflow_12:
	li $t9,-32768
	bge $t2,$t9,add_no_underflow_13
	li $t2,-32768
add_no_underflow_13:
add_done_14:
	lw $t1,8($fp)
	li $t0,2
	bnez $t1,array_not_null_15
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_15:
	bgez $t0,array_index_nonneg_16
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_16:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_17
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_17:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	lw $t1,0($s0)
	li $t0,2
	bnez $t1,array_not_null_18
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_18:
	bgez $t0,array_index_nonneg_19
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_19:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_20
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_20:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	lw $t0,0($s0)
	add $t0,$t2,$t0
	li $t9,32767
	ble $t0,$t9,add_no_overflow_21
	li $t0,32767
	j add_done_23
add_no_overflow_21:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_22
	li $t0,-32768
add_no_underflow_22:
add_done_23:
	move $v0,$t0
	addu $sp,$sp,56
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
	li $t1,3
	li $t0,1
	add $t2,$t1,$t0
	li $t9,32767
	ble $t2,$t9,add_no_overflow_24
	li $t2,32767
	j add_done_26
add_no_overflow_24:
	li $t9,-32768
	bge $t2,$t9,add_no_underflow_25
	li $t2,-32768
add_no_underflow_25:
add_done_26:
	li $t0,4
	mul $t0,$t2,$t0
	li $t9,32767
	ble $t0,$t9,mul_no_overflow_27
	li $t0,32767
	j mul_done_29
mul_no_overflow_27:
	li $t9,-32768
	bge $t0,$t9,mul_no_underflow_28
	li $t0,-32768
mul_no_underflow_28:
mul_done_29:
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	bnez $t0,store_continue_30
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_30:
	sw $t1,0($t0)
	sw $t0,global_row0
	li $t2,3
	li $t0,1
	add $t1,$t2,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_31
	li $t1,32767
	j add_done_33
add_no_overflow_31:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_32
	li $t1,-32768
add_no_underflow_32:
add_done_33:
	li $t0,4
	mul $t0,$t1,$t0
	li $t9,32767
	ble $t0,$t9,mul_no_overflow_34
	li $t0,32767
	j mul_done_36
mul_no_overflow_34:
	li $t9,-32768
	bge $t0,$t9,mul_no_underflow_35
	li $t0,-32768
mul_no_underflow_35:
mul_done_36:
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	bnez $t0,store_continue_37
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_37:
	sw $t2,0($t0)
	sw $t0,global_row1
	li $t2,3
	li $t0,1
	add $t0,$t2,$t0
	li $t9,32767
	ble $t0,$t9,add_no_overflow_38
	li $t0,32767
	j add_done_40
add_no_overflow_38:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_39
	li $t0,-32768
add_no_underflow_39:
add_done_40:
	li $t1,4
	mul $t0,$t0,$t1
	li $t9,32767
	ble $t0,$t9,mul_no_overflow_41
	li $t0,32767
	j mul_done_43
mul_no_overflow_41:
	li $t9,-32768
	bge $t0,$t9,mul_no_underflow_42
	li $t0,-32768
mul_no_underflow_42:
mul_done_43:
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	bnez $t0,store_continue_44
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_44:
	sw $t2,0($t0)
	sw $t0,global_row2
	li $t1,3
	li $t0,1
	add $t2,$t1,$t0
	li $t9,32767
	ble $t2,$t9,add_no_overflow_45
	li $t2,32767
	j add_done_47
add_no_overflow_45:
	li $t9,-32768
	bge $t2,$t9,add_no_underflow_46
	li $t2,-32768
add_no_underflow_46:
add_done_47:
	li $t0,4
	mul $t0,$t2,$t0
	li $t9,32767
	ble $t0,$t9,mul_no_overflow_48
	li $t0,32767
	j mul_done_50
mul_no_overflow_48:
	li $t9,-32768
	bge $t0,$t9,mul_no_underflow_49
	li $t0,-32768
mul_no_underflow_49:
mul_done_50:
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	bnez $t0,store_continue_51
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_51:
	sw $t1,0($t0)
	sw $t0,global_A
	lw $t2,global_row0
	lw $t1,global_A
	li $t0,0
	bnez $t1,array_not_null_52
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_52:
	bgez $t0,array_index_nonneg_53
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_53:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_54
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_54:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t2,0($s0)
	lw $t2,global_row1
	lw $t1,global_A
	li $t0,1
	bnez $t1,array_not_null_55
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_55:
	bgez $t0,array_index_nonneg_56
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_56:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_57
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_57:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t2,0($s0)
	lw $t0,global_row2
	lw $t2,global_A
	li $t1,2
	bnez $t2,array_not_null_58
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_58:
	bgez $t1,array_index_nonneg_59
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_59:
	lw $s0,0($t2)
	blt $t1,$s0,array_index_ok_60
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_60:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t0,0($s0)
	li $t1,0
	lw $t0,global_A
	li $t2,0
	bnez $t0,array_not_null_61
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_61:
	bgez $t2,array_index_nonneg_62
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_62:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_63
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_63:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	lw $t0,0($s0)
	li $t2,0
	bnez $t0,array_not_null_64
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_64:
	bgez $t2,array_index_nonneg_65
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_65:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_66
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_66:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	li $t2,1
	lw $t1,global_A
	li $t0,0
	bnez $t1,array_not_null_67
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_67:
	bgez $t0,array_index_nonneg_68
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_68:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_69
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_69:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	lw $t0,0($s0)
	li $t1,1
	bnez $t0,array_not_null_70
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_70:
	bgez $t1,array_index_nonneg_71
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_71:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_72
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_72:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t2,0($s0)
	li $t1,2
	lw $t0,global_A
	li $t2,0
	bnez $t0,array_not_null_73
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_73:
	bgez $t2,array_index_nonneg_74
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_74:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_75
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_75:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	lw $t0,0($s0)
	li $t2,2
	bnez $t0,array_not_null_76
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_76:
	bgez $t2,array_index_nonneg_77
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_77:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_78
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_78:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	li $t0,3
	lw $t2,global_A
	li $t1,1
	bnez $t2,array_not_null_79
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_79:
	bgez $t1,array_index_nonneg_80
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_80:
	lw $s0,0($t2)
	blt $t1,$s0,array_index_ok_81
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_81:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	lw $t1,0($s0)
	li $t2,0
	bnez $t1,array_not_null_82
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_82:
	bgez $t2,array_index_nonneg_83
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_83:
	lw $s0,0($t1)
	blt $t2,$s0,array_index_ok_84
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_84:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t0,0($s0)
	li $t1,4
	lw $t2,global_A
	li $t0,1
	bnez $t2,array_not_null_85
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_85:
	bgez $t0,array_index_nonneg_86
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_86:
	lw $s0,0($t2)
	blt $t0,$s0,array_index_ok_87
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_87:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	lw $t0,0($s0)
	li $t2,1
	bnez $t0,array_not_null_88
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_88:
	bgez $t2,array_index_nonneg_89
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_89:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_90
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_90:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	li $t2,5
	lw $t1,global_A
	li $t0,1
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
	lw $t1,0($s0)
	li $t0,2
	bnez $t1,array_not_null_94
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_94:
	bgez $t0,array_index_nonneg_95
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_95:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_96
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_96:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t2,0($s0)
	li $t2,6
	lw $t0,global_A
	li $t1,2
	bnez $t0,array_not_null_97
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_97:
	bgez $t1,array_index_nonneg_98
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_98:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_99
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_99:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	lw $t1,0($s0)
	li $t0,0
	bnez $t1,array_not_null_100
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_100:
	bgez $t0,array_index_nonneg_101
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_101:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_102
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_102:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t2,0($s0)
	li $t1,7
	lw $t2,global_A
	li $t0,2
	bnez $t2,array_not_null_103
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_103:
	bgez $t0,array_index_nonneg_104
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_104:
	lw $s0,0($t2)
	blt $t0,$s0,array_index_ok_105
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_105:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	lw $t2,0($s0)
	li $t0,1
	bnez $t2,array_not_null_106
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_106:
	bgez $t0,array_index_nonneg_107
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_107:
	lw $s0,0($t2)
	blt $t0,$s0,array_index_ok_108
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_108:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t1,0($s0)
	li $t0,8
	lw $t1,global_A
	li $t2,2
	bnez $t1,array_not_null_109
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_109:
	bgez $t2,array_index_nonneg_110
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_110:
	lw $s0,0($t1)
	blt $t2,$s0,array_index_ok_111
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_111:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	lw $t2,0($s0)
	li $t1,2
	bnez $t2,array_not_null_112
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_112:
	bgez $t1,array_index_nonneg_113
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_113:
	lw $s0,0($t2)
	blt $t1,$s0,array_index_ok_114
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_114:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t0,0($s0)
	lw $t0,global_A
	subu $sp,$sp,4
	sw $t0,0($sp)
	jal Label_trace3x3
	move $t0,$v0
	addu $sp,$sp,4
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall

.data
global_row0: .word 0
global_row1: .word 0
global_row2: .word 0
global_A: .word 0
.text
	li $v0,10
	syscall
