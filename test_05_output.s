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
main:
	li $t0,16
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	sw $t0,global_moish
	li $t0,10
	li $t1,1
	add $t2,$t0,$t1
	li $t9,32767
	ble $t2,$t9,add_no_overflow_0
	li $t2,32767
	j add_done_2
add_no_overflow_0:
	li $t9,-32768
	bge $t2,$t9,add_no_underflow_1
	li $t2,-32768
add_no_underflow_1:
add_done_2:
	li $t1,4
	mul $t1,$t2,$t1
	li $t9,32767
	ble $t1,$t9,mul_no_overflow_3
	li $t1,32767
	j mul_done_5
mul_no_overflow_3:
	li $t9,-32768
	bge $t1,$t9,mul_no_underflow_4
	li $t1,-32768
mul_no_underflow_4:
mul_done_5:
	move $a0,$t1
	li $v0,9
	syscall
	move $t1,$v0
	bnez $t1,store_continue_6
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_6:
	sw $t0,0($t1)
	lw $t0,global_moish
	bnez $t0,store_continue_7
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_7:
	sw $t1,12($t0)
	li $t1,13
	li $t0,1
	add $t2,$t1,$t0
	li $t9,32767
	ble $t2,$t9,add_no_overflow_8
	li $t2,32767
	j add_done_10
add_no_overflow_8:
	li $t9,-32768
	bge $t2,$t9,add_no_underflow_9
	li $t2,-32768
add_no_underflow_9:
add_done_10:
	li $t0,4
	mul $t0,$t2,$t0
	li $t9,32767
	ble $t0,$t9,mul_no_overflow_11
	li $t0,32767
	j mul_done_13
mul_no_overflow_11:
	li $t9,-32768
	bge $t0,$t9,mul_no_underflow_12
	li $t0,-32768
mul_no_underflow_12:
mul_done_13:
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	bnez $t0,store_continue_14
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_14:
	sw $t1,0($t0)
	lw $t1,global_moish
	bnez $t1,store_continue_15
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_15:
	sw $t0,8($t1)
	li $t2,7400
	lw $t0,global_moish
	bnez $t0,load_continue_16
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_16:
	lw $t1,8($t0)
	li $t0,0
	bnez $t1,array_not_null_17
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_17:
	bgez $t0,array_index_nonneg_18
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_18:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_19
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_19:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t2,0($s0)
	li $t2,7400
	lw $t0,global_moish
	bnez $t0,load_continue_20
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_20:
	lw $t1,8($t0)
	li $t0,1
	bnez $t1,array_not_null_21
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_21:
	bgez $t0,array_index_nonneg_22
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_22:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_23
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_23:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t2,0($s0)
	li $t1,7400
	lw $t0,global_moish
	bnez $t0,load_continue_24
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_24:
	lw $t2,8($t0)
	li $t0,2
	bnez $t2,array_not_null_25
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_25:
	bgez $t0,array_index_nonneg_26
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_26:
	lw $s0,0($t2)
	blt $t0,$s0,array_index_ok_27
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_27:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t1,0($s0)
	li $t1,7400
	lw $t0,global_moish
	bnez $t0,load_continue_28
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_28:
	lw $t2,8($t0)
	li $t0,3
	bnez $t2,array_not_null_29
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_29:
	bgez $t0,array_index_nonneg_30
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_30:
	lw $s0,0($t2)
	blt $t0,$s0,array_index_ok_31
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_31:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t1,0($s0)
	li $t1,7400
	lw $t0,global_moish
	bnez $t0,load_continue_32
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_32:
	lw $t2,8($t0)
	li $t0,4
	bnez $t2,array_not_null_33
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_33:
	bgez $t0,array_index_nonneg_34
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_34:
	lw $s0,0($t2)
	blt $t0,$s0,array_index_ok_35
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_35:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t1,0($s0)
	li $t1,7400
	lw $t0,global_moish
	bnez $t0,load_continue_36
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_36:
	lw $t0,8($t0)
	li $t2,5
	bnez $t0,array_not_null_37
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_37:
	bgez $t2,array_index_nonneg_38
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_38:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_39
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_39:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	li $t1,7400
	lw $t0,global_moish
	bnez $t0,load_continue_40
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_40:
	lw $t2,8($t0)
	li $t0,6
	bnez $t2,array_not_null_41
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_41:
	bgez $t0,array_index_nonneg_42
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_42:
	lw $s0,0($t2)
	blt $t0,$s0,array_index_ok_43
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_43:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t1,0($s0)
	li $t2,7400
	lw $t0,global_moish
	bnez $t0,load_continue_44
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_44:
	lw $t0,8($t0)
	li $t1,7
	bnez $t0,array_not_null_45
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_45:
	bgez $t1,array_index_nonneg_46
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_46:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_47
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_47:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t2,0($s0)
	li $t1,7400
	lw $t0,global_moish
	bnez $t0,load_continue_48
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_48:
	lw $t0,8($t0)
	li $t2,8
	bnez $t0,array_not_null_49
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_49:
	bgez $t2,array_index_nonneg_50
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_50:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_51
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_51:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	li $t0,7400
	lw $t1,global_moish
	bnez $t1,load_continue_52
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_52:
	lw $t1,8($t1)
	li $t2,9
	bnez $t1,array_not_null_53
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_53:
	bgez $t2,array_index_nonneg_54
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_54:
	lw $s0,0($t1)
	blt $t2,$s0,array_index_ok_55
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_55:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t0,0($s0)
	li $t2,7400
	lw $t0,global_moish
	bnez $t0,load_continue_56
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_56:
	lw $t0,8($t0)
	li $t1,10
	bnez $t0,array_not_null_57
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_57:
	bgez $t1,array_index_nonneg_58
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_58:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_59
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_59:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t2,0($s0)
	li $t1,7400
	lw $t0,global_moish
	bnez $t0,load_continue_60
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_60:
	lw $t0,8($t0)
	li $t2,11
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
	sw $t1,0($s0)
	li $t1,7400
	lw $t0,global_moish
	bnez $t0,load_continue_64
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_64:
	lw $t0,8($t0)
	li $t2,12
	bnez $t0,array_not_null_65
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_65:
	bgez $t2,array_index_nonneg_66
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_66:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_67
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_67:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
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
	li $t1,96
	lw $t0,global_moish
	bnez $t0,load_continue_68
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_68:
	lw $t2,12($t0)
	lw $t0,global_LinearAlgebra1
	bnez $t2,array_not_null_69
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_69:
	bgez $t0,array_index_nonneg_70
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_70:
	lw $s0,0($t2)
	blt $t0,$s0,array_index_ok_71
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_71:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t2,$s0
	sw $t1,0($s0)
	li $t0,100
	lw $t1,global_moish
	bnez $t1,load_continue_72
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_72:
	lw $t1,12($t1)
	lw $t2,global_LinearAlgebra2
	bnez $t1,array_not_null_73
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
	lw $s0,0($t1)
	blt $t2,$s0,array_index_ok_75
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_75:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t0,0($s0)
	li $t1,95
	lw $t0,global_moish
	bnez $t0,load_continue_76
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_76:
	lw $t0,12($t0)
	lw $t2,global_Calculus1
	bnez $t0,array_not_null_77
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_77:
	bgez $t2,array_index_nonneg_78
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_78:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_79
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_79:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	li $t0,81
	lw $t1,global_moish
	bnez $t1,load_continue_80
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_80:
	lw $t1,12($t1)
	lw $t2,global_Calculus2
	bnez $t1,array_not_null_81
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_81:
	bgez $t2,array_index_nonneg_82
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_82:
	lw $s0,0($t1)
	blt $t2,$s0,array_index_ok_83
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_83:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t0,0($s0)
	li $t1,95
	lw $t0,global_moish
	bnez $t0,load_continue_84
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_84:
	lw $t0,12($t0)
	lw $t2,global_Calculus3
	bnez $t0,array_not_null_85
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_85:
	bgez $t2,array_index_nonneg_86
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_86:
	lw $s0,0($t0)
	blt $t2,$s0,array_index_ok_87
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_87:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t1,0($s0)
	li $t2,95
	lw $t0,global_moish
	bnez $t0,load_continue_88
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_88:
	lw $t0,12($t0)
	lw $t1,global_COMPILATION
	bnez $t0,array_not_null_89
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_89:
	bgez $t1,array_index_nonneg_90
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_90:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_91
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_91:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t2,0($s0)
	li $t0,100
	lw $t1,global_moish
	bnez $t1,load_continue_92
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_92:
	lw $t1,12($t1)
	lw $t2,global_ODE
	bnez $t1,array_not_null_93
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_93:
	bgez $t2,array_index_nonneg_94
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_94:
	lw $s0,0($t1)
	blt $t2,$s0,array_index_ok_95
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_95:
	addi $s0,$t2,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t0,0($s0)
	li $t2,100
	lw $t0,global_moish
	bnez $t0,load_continue_96
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_96:
	lw $t1,12($t0)
	lw $t0,global_PDE
	bnez $t1,array_not_null_97
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_97:
	bgez $t0,array_index_nonneg_98
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_98:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_99
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_99:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t2,0($s0)
	li $t2,74
	lw $t0,global_moish
	bnez $t0,load_continue_100
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_100:
	lw $t0,12($t0)
	lw $t1,global_Scheme
	bnez $t0,array_not_null_101
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_101:
	bgez $t1,array_index_nonneg_102
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_102:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_103
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_103:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t2,0($s0)
	li $t2,99
	lw $t0,global_moish
	bnez $t0,load_continue_104
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_104:
	lw $t0,12($t0)
	lw $t1,global_CPP
	bnez $t0,array_not_null_105
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_105:
	bgez $t1,array_index_nonneg_106
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_106:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_107
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_107:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	sw $t2,0($s0)
	jal Label_Student_getAverage
	move $t1,$v0
	li $t0,60
	slt $t0,$t0,$t1
	beq $t0,$zero,Label_1_if_false
Label_0_if_true:
	lw $t0,global_moish
	bnez $t0,load_continue_108
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_108:
	lw $t1,8($t0)
	jal Label_Student_birthday
	move $t0,$v0
	bnez $t1,array_not_null_109
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_109:
	bgez $t0,array_index_nonneg_110
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_110:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_111
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_111:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	lw $t1,0($s0)
	li $t0,1000
	add $t2,$t1,$t0
	li $t9,32767
	ble $t2,$t9,add_no_overflow_112
	li $t2,32767
	j add_done_114
add_no_overflow_112:
	li $t9,-32768
	bge $t2,$t9,add_no_underflow_113
	li $t2,-32768
add_no_underflow_113:
add_done_114:
	lw $t0,global_moish
	bnez $t0,load_continue_115
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_115:
	lw $t1,8($t0)
	lw $t0,global_moish
	bnez $t0,load_continue_116
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_116:
	lw $t0,4($t0)
	bnez $t1,array_not_null_117
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_117:
	bgez $t0,array_index_nonneg_118
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_118:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_119
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_119:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t2,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_120
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_120:
	lw $t0,8($t0)
	jal Label_Student_birthday
	move $t1,$v0
	bnez $t0,array_not_null_121
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_121:
	bgez $t1,array_index_nonneg_122
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_122:
	lw $s0,0($t0)
	blt $t1,$s0,array_index_ok_123
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_123:
	addi $s0,$t1,1
	sll $s0,$s0,2
	add $s0,$t0,$s0
	lw $t0,0($s0)
	li $t1,1000
	add $t2,$t0,$t1
	li $t9,32767
	ble $t2,$t9,add_no_overflow_124
	li $t2,32767
	j add_done_126
add_no_overflow_124:
	li $t9,-32768
	bge $t2,$t9,add_no_underflow_125
	li $t2,-32768
add_no_underflow_125:
add_done_126:
	lw $t0,global_moish
	bnez $t0,load_continue_127
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_127:
	lw $t1,8($t0)
	lw $t0,global_moish
	bnez $t0,load_continue_128
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_128:
	lw $t0,4($t0)
	bnez $t1,array_not_null_129
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_129:
	bgez $t0,array_index_nonneg_130
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_130:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_131
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_131:
	addi $s0,$t0,1
	sll $s0,$s0,2
	add $s0,$t1,$s0
	sw $t2,0($s0)
	lw $t0,global_moish
	bnez $t0,load_continue_132
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_132:
	lw $t1,8($t0)
	li $t0,10
	bnez $t1,array_not_null_133
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_133:
	bgez $t0,array_index_nonneg_134
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_134:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_135
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_135:
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
	bnez $t0,load_continue_136
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
load_continue_136:
	lw $t1,8($t0)
	li $t0,11
	bnez $t1,array_not_null_137
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_137:
	bgez $t0,array_index_nonneg_138
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_138:
	lw $s0,0($t1)
	blt $t0,$s0,array_index_ok_139
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_139:
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
	j Label_2_if_end
Label_1_if_false:
Label_2_if_end:

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
