.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
.text
Label_BubbleSort:
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
	subu $sp,$sp,20
	li $t0,0
	sw $t0,-48($fp)
	li $t0,0
	sw $t0,-52($fp)
	li $t0,32767
	sw $t0,-56($fp)
	li $t0,-1
	sw $t0,-60($fp)
	li $t0,0
	sw $t0,-64($fp)
Label_1_start:
	lw $t0,-48($fp)
	lw $t5,12($fp)
	blt $t0,$t5,Label_10_AssignOne
	bge $t0,$t5,Label_11_AssignZero
Label_10_AssignOne:
	li $t0,1
	j Label_9_end
Label_11_AssignZero:
	li $t0,0
	j Label_9_end
Label_9_end:
	beq $t0,$zero,Label_0_end
	lw $t0,-48($fp)
	sw $t0,-52($fp)
	li $t0,32767
	sw $t0,-56($fp)
Label_3_start:
	lw $t5,-52($fp)
	lw $t0,12($fp)
	blt $t5,$t0,Label_13_AssignOne
	bge $t5,$t0,Label_14_AssignZero
Label_13_AssignOne:
	li $t0,1
	j Label_12_end
Label_14_AssignZero:
	li $t0,0
	j Label_12_end
Label_12_end:
	beq $t0,$zero,Label_2_end
	lw Temp_14,8($fp)
	lw Temp_15,-52($fp)
	bnez Temp_14,array_not_null_0
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_0:
	bgez Temp_15,array_index_nonneg_1
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_1:
	lw $s0,0(Temp_14)
	blt Temp_15,$s0,array_index_ok_2
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_2:
	addi $s0,Temp_15,1
	sll $s0,$s0,2
	add $s0,Temp_14,$s0
	lw $t2,0($s0)
	lw $t0,-56($fp)
	blt $t2,$t0,Label_16_AssignOne
	bge $t2,$t0,Label_17_AssignZero
Label_16_AssignOne:
	li $t0,1
	j Label_15_end
Label_17_AssignZero:
	li $t0,0
	j Label_15_end
Label_15_end:
	beq $t0,$zero,Label_5_if_false
Label_4_if_true:
	lw Temp_18,8($fp)
	lw Temp_19,-52($fp)
	bnez Temp_18,array_not_null_3
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_3:
	bgez Temp_19,array_index_nonneg_4
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_4:
	lw $s0,0(Temp_18)
	blt Temp_19,$s0,array_index_ok_5
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_5:
	addi $s0,Temp_19,1
	sll $s0,$s0,2
	add $s0,Temp_18,$s0
	lw $t3,0($s0)
	sw $t3,-56($fp)
	lw $t0,-52($fp)
	sw $t0,-60($fp)
	j Label_6_if_end
Label_5_if_false:
Label_6_if_end:
	lw $t2,-52($fp)
	li $t0,1
	add $t0,$t2,$t0
	li $t9,32767
	ble $t0,$t9,add_no_overflow_6
	li $t0,32767
	j add_done_8
add_no_overflow_6:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_7
	li $t0,-32768
add_no_underflow_7:
add_done_8:
	sw $t0,-52($fp)
	j Label_3_start
Label_2_end:
	lw Temp_25,8($fp)
	lw Temp_26,-48($fp)
	bnez Temp_25,array_not_null_9
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_9:
	bgez Temp_26,array_index_nonneg_10
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_10:
	lw $s0,0(Temp_25)
	blt Temp_26,$s0,array_index_ok_11
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_11:
	addi $s0,Temp_26,1
	sll $s0,$s0,2
	add $s0,Temp_25,$s0
	lw $t4,0($s0)
	sw $t4,-64($fp)
	lw Temp_28,-56($fp)
	lw Temp_29,8($fp)
	lw Temp_30,-48($fp)
	bnez Temp_29,array_not_null_12
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_12:
	bgez Temp_30,array_index_nonneg_13
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_13:
	lw $s0,0(Temp_29)
	blt Temp_30,$s0,array_index_ok_14
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_14:
	addi $s0,Temp_30,1
	sll $s0,$s0,2
	add $s0,Temp_29,$s0
	sw Temp_28,0($s0)
	lw Temp_31,-64($fp)
	lw Temp_32,8($fp)
	lw Temp_33,-60($fp)
	bnez Temp_32,array_not_null_15
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_15:
	bgez Temp_33,array_index_nonneg_16
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_16:
	lw $s0,0(Temp_32)
	blt Temp_33,$s0,array_index_ok_17
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_17:
	addi $s0,Temp_33,1
	sll $s0,$s0,2
	add $s0,Temp_32,$s0
	sw Temp_31,0($s0)
	lw $t2,-48($fp)
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
	sw $t0,-48($fp)
	j Label_1_start
Label_0_end:
	addu $sp,$sp,20
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
	li $t2,7
	li $t0,1
	add $t3,$t2,$t0
	li $t9,32767
	ble $t3,$t9,add_no_overflow_21
	li $t3,32767
	j add_done_23
add_no_overflow_21:
	li $t9,-32768
	bge $t3,$t9,add_no_underflow_22
	li $t3,-32768
add_no_underflow_22:
add_done_23:
	li $t0,4
	mul $t0,$t3,$t0
	li $t9,32767
	ble $t0,$t9,mul_no_overflow_24
	li $t0,32767
	j mul_done_26
mul_no_overflow_24:
	li $t9,-32768
	bge $t0,$t9,mul_no_underflow_25
	li $t0,-32768
mul_no_underflow_25:
mul_done_26:
	move $a0,$t0
	li $v0,9
	syscall
	move $t0,$v0
	bnez $t0,store_continue_27
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
store_continue_27:
	sw $t2,0($t0)
	sw $t0,global_arr
	li Temp_43,34
	lw Temp_44,global_arr
	li Temp_45,0
	bnez Temp_44,array_not_null_28
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_28:
	bgez Temp_45,array_index_nonneg_29
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_29:
	lw $s0,0(Temp_44)
	blt Temp_45,$s0,array_index_ok_30
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_30:
	addi $s0,Temp_45,1
	sll $s0,$s0,2
	add $s0,Temp_44,$s0
	sw Temp_43,0($s0)
	li Temp_46,12
	lw Temp_47,global_arr
	li Temp_48,1
	bnez Temp_47,array_not_null_31
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_31:
	bgez Temp_48,array_index_nonneg_32
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_32:
	lw $s0,0(Temp_47)
	blt Temp_48,$s0,array_index_ok_33
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_33:
	addi $s0,Temp_48,1
	sll $s0,$s0,2
	add $s0,Temp_47,$s0
	sw Temp_46,0($s0)
	li Temp_49,-600
	lw Temp_50,global_arr
	li Temp_51,2
	bnez Temp_50,array_not_null_34
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_34:
	bgez Temp_51,array_index_nonneg_35
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_35:
	lw $s0,0(Temp_50)
	blt Temp_51,$s0,array_index_ok_36
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_36:
	addi $s0,Temp_51,1
	sll $s0,$s0,2
	add $s0,Temp_50,$s0
	sw Temp_49,0($s0)
	li Temp_52,-400
	lw Temp_53,global_arr
	li Temp_54,3
	bnez Temp_53,array_not_null_37
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_37:
	bgez Temp_54,array_index_nonneg_38
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_38:
	lw $s0,0(Temp_53)
	blt Temp_54,$s0,array_index_ok_39
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_39:
	addi $s0,Temp_54,1
	sll $s0,$s0,2
	add $s0,Temp_53,$s0
	sw Temp_52,0($s0)
	li Temp_55,70
	lw Temp_56,global_arr
	li Temp_57,4
	bnez Temp_56,array_not_null_40
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_40:
	bgez Temp_57,array_index_nonneg_41
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_41:
	lw $s0,0(Temp_56)
	blt Temp_57,$s0,array_index_ok_42
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_42:
	addi $s0,Temp_57,1
	sll $s0,$s0,2
	add $s0,Temp_56,$s0
	sw Temp_55,0($s0)
	li Temp_58,30
	lw Temp_59,global_arr
	li Temp_60,5
	bnez Temp_59,array_not_null_43
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_43:
	bgez Temp_60,array_index_nonneg_44
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_44:
	lw $s0,0(Temp_59)
	blt Temp_60,$s0,array_index_ok_45
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_45:
	addi $s0,Temp_60,1
	sll $s0,$s0,2
	add $s0,Temp_59,$s0
	sw Temp_58,0($s0)
	li Temp_61,-580
	lw Temp_62,global_arr
	li Temp_63,6
	bnez Temp_62,array_not_null_46
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_46:
	bgez Temp_63,array_index_nonneg_47
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_47:
	lw $s0,0(Temp_62)
	blt Temp_63,$s0,array_index_ok_48
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_48:
	addi $s0,Temp_63,1
	sll $s0,$s0,2
	add $s0,Temp_62,$s0
	sw Temp_61,0($s0)
	lw $t2,global_arr
	li $t0,7
	subu $sp,$sp,4
	sw $t0,0($sp)
	subu $sp,$sp,4
	sw $t2,0($sp)
	jal Label_BubbleSort
	addu $sp,$sp,8
	li $t0,0
	sw $t0,global_i
Label_8_start:
	lw $t2,global_i
	li $t0,7
	blt $t2,$t0,Label_19_AssignOne
	bge $t2,$t0,Label_20_AssignZero
Label_19_AssignOne:
	li $t0,1
	j Label_18_end
Label_20_AssignZero:
	li $t0,0
	j Label_18_end
Label_18_end:
	beq $t0,$zero,Label_7_end
	lw Temp_70,global_arr
	lw Temp_71,global_i
	bnez Temp_70,array_not_null_49
	la $a0,string_invalid_ptr_dref
	li $v0,4
	syscall
	li $v0,10
	syscall
array_not_null_49:
	bgez Temp_71,array_index_nonneg_50
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_nonneg_50:
	lw $s0,0(Temp_70)
	blt Temp_71,$s0,array_index_ok_51
	la $a0,string_access_violation
	li $v0,4
	syscall
	li $v0,10
	syscall
array_index_ok_51:
	addi $s0,Temp_71,1
	sll $s0,$s0,2
	add $s0,Temp_70,$s0
	lw $t1,0($s0)
	move $a0,$t1
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	lw $t0,global_i
	li $t1,1
	add $t0,$t0,$t1
	li $t9,32767
	ble $t0,$t9,add_no_overflow_52
	li $t0,32767
	j add_done_54
add_no_overflow_52:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_53
	li $t0,-32768
add_no_underflow_53:
add_done_54:
	sw $t0,global_i
	j Label_8_start
Label_7_end:

.data
global_arr: .word 0
global_i: .word 0
.text
	li $v0,10
	syscall
