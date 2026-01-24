.data
string_access_violation: .asciiz "Access Violation"
string_illegal_div_by_0: .asciiz "Illegal Division By Zero"
string_invalid_ptr_dref: .asciiz "Invalid Pointer Dereference"
.text
Label_foo:
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
	subu $sp,$sp,380
	li $t0,1
	sw $t0,-48($fp)
	li $t0,2
	sw $t0,-52($fp)
	li $t0,3
	sw $t0,-56($fp)
	li $t0,4
	sw $t0,-60($fp)
	li $t0,5
	sw $t0,-64($fp)
	li $t0,6
	sw $t0,-68($fp)
	li $t0,7
	sw $t0,-72($fp)
	li $t0,8
	sw $t0,-76($fp)
	li $t0,9
	sw $t0,-80($fp)
	li $t0,10
	sw $t0,-84($fp)
	li $t0,11
	sw $t0,-88($fp)
	li $t0,12
	sw $t0,-92($fp)
	li $t0,13
	sw $t0,-96($fp)
	li $t0,14
	sw $t0,-100($fp)
	li $t0,15
	sw $t0,-104($fp)
	li $t0,16
	sw $t0,-108($fp)
	li $t0,17
	sw $t0,-112($fp)
	li $t0,18
	sw $t0,-116($fp)
	li $t0,19
	sw $t0,-120($fp)
	li $t0,20
	sw $t0,-124($fp)
	li $t0,21
	sw $t0,-128($fp)
	li $t0,22
	sw $t0,-132($fp)
	li $t0,23
	sw $t0,-136($fp)
	li $t0,24
	sw $t0,-140($fp)
	li $t0,25
	sw $t0,-144($fp)
	li $t0,26
	sw $t0,-148($fp)
	li $t0,27
	sw $t0,-152($fp)
	li $t0,28
	sw $t0,-156($fp)
	li $t0,29
	sw $t0,-160($fp)
	li $t0,30
	sw $t0,-164($fp)
	li $t0,31
	sw $t0,-168($fp)
	li $t0,32
	sw $t0,-172($fp)
	lw $t1,-48($fp)
	lw $t0,-52($fp)
	add $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_0
	li $t1,32767
	j add_done_2
add_no_overflow_0:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_1
	li $t1,-32768
add_no_underflow_1:
add_done_2:
	lw $t0,-56($fp)
	add $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_3
	li $t1,32767
	j add_done_5
add_no_overflow_3:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_4
	li $t1,-32768
add_no_underflow_4:
add_done_5:
	lw $t0,-60($fp)
	add $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_6
	li $t1,32767
	j add_done_8
add_no_overflow_6:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_7
	li $t1,-32768
add_no_underflow_7:
add_done_8:
	lw $t0,-64($fp)
	add $t0,$t1,$t0
	li $t9,32767
	ble $t0,$t9,add_no_overflow_9
	li $t0,32767
	j add_done_11
add_no_overflow_9:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_10
	li $t0,-32768
add_no_underflow_10:
add_done_11:
	lw $t1,-68($fp)
	add $t1,$t0,$t1
	li $t9,32767
	ble $t1,$t9,add_no_overflow_12
	li $t1,32767
	j add_done_14
add_no_overflow_12:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_13
	li $t1,-32768
add_no_underflow_13:
add_done_14:
	lw $t0,-72($fp)
	add $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_15
	li $t1,32767
	j add_done_17
add_no_overflow_15:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_16
	li $t1,-32768
add_no_underflow_16:
add_done_17:
	lw $t0,-76($fp)
	add $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_18
	li $t1,32767
	j add_done_20
add_no_overflow_18:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_19
	li $t1,-32768
add_no_underflow_19:
add_done_20:
	lw $t0,-80($fp)
	add $t0,$t1,$t0
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
	lw $t1,-84($fp)
	add $t1,$t0,$t1
	li $t9,32767
	ble $t1,$t9,add_no_overflow_24
	li $t1,32767
	j add_done_26
add_no_overflow_24:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_25
	li $t1,-32768
add_no_underflow_25:
add_done_26:
	lw $t0,-88($fp)
	add $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_27
	li $t1,32767
	j add_done_29
add_no_overflow_27:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_28
	li $t1,-32768
add_no_underflow_28:
add_done_29:
	lw $t0,-92($fp)
	add $t0,$t1,$t0
	li $t9,32767
	ble $t0,$t9,add_no_overflow_30
	li $t0,32767
	j add_done_32
add_no_overflow_30:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_31
	li $t0,-32768
add_no_underflow_31:
add_done_32:
	lw $t1,-96($fp)
	add $t1,$t0,$t1
	li $t9,32767
	ble $t1,$t9,add_no_overflow_33
	li $t1,32767
	j add_done_35
add_no_overflow_33:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_34
	li $t1,-32768
add_no_underflow_34:
add_done_35:
	lw $t0,-100($fp)
	add $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_36
	li $t1,32767
	j add_done_38
add_no_overflow_36:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_37
	li $t1,-32768
add_no_underflow_37:
add_done_38:
	lw $t0,-104($fp)
	add $t0,$t1,$t0
	li $t9,32767
	ble $t0,$t9,add_no_overflow_39
	li $t0,32767
	j add_done_41
add_no_overflow_39:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_40
	li $t0,-32768
add_no_underflow_40:
add_done_41:
	lw $t1,-108($fp)
	add $t1,$t0,$t1
	li $t9,32767
	ble $t1,$t9,add_no_overflow_42
	li $t1,32767
	j add_done_44
add_no_overflow_42:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_43
	li $t1,-32768
add_no_underflow_43:
add_done_44:
	lw $t0,-112($fp)
	add $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_45
	li $t1,32767
	j add_done_47
add_no_overflow_45:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_46
	li $t1,-32768
add_no_underflow_46:
add_done_47:
	lw $t0,-116($fp)
	add $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_48
	li $t1,32767
	j add_done_50
add_no_overflow_48:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_49
	li $t1,-32768
add_no_underflow_49:
add_done_50:
	lw $t0,-120($fp)
	add $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_51
	li $t1,32767
	j add_done_53
add_no_overflow_51:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_52
	li $t1,-32768
add_no_underflow_52:
add_done_53:
	lw $t0,-124($fp)
	add $t0,$t1,$t0
	li $t9,32767
	ble $t0,$t9,add_no_overflow_54
	li $t0,32767
	j add_done_56
add_no_overflow_54:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_55
	li $t0,-32768
add_no_underflow_55:
add_done_56:
	lw $t1,-128($fp)
	add $t0,$t0,$t1
	li $t9,32767
	ble $t0,$t9,add_no_overflow_57
	li $t0,32767
	j add_done_59
add_no_overflow_57:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_58
	li $t0,-32768
add_no_underflow_58:
add_done_59:
	lw $t1,-132($fp)
	add $t1,$t0,$t1
	li $t9,32767
	ble $t1,$t9,add_no_overflow_60
	li $t1,32767
	j add_done_62
add_no_overflow_60:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_61
	li $t1,-32768
add_no_underflow_61:
add_done_62:
	lw $t0,-136($fp)
	add $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_63
	li $t1,32767
	j add_done_65
add_no_overflow_63:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_64
	li $t1,-32768
add_no_underflow_64:
add_done_65:
	lw $t0,-140($fp)
	add $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_66
	li $t1,32767
	j add_done_68
add_no_overflow_66:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_67
	li $t1,-32768
add_no_underflow_67:
add_done_68:
	lw $t0,-144($fp)
	add $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_69
	li $t1,32767
	j add_done_71
add_no_overflow_69:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_70
	li $t1,-32768
add_no_underflow_70:
add_done_71:
	lw $t0,-148($fp)
	add $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_72
	li $t1,32767
	j add_done_74
add_no_overflow_72:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_73
	li $t1,-32768
add_no_underflow_73:
add_done_74:
	lw $t0,-152($fp)
	add $t0,$t1,$t0
	li $t9,32767
	ble $t0,$t9,add_no_overflow_75
	li $t0,32767
	j add_done_77
add_no_overflow_75:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_76
	li $t0,-32768
add_no_underflow_76:
add_done_77:
	lw $t1,-156($fp)
	add $t0,$t0,$t1
	li $t9,32767
	ble $t0,$t9,add_no_overflow_78
	li $t0,32767
	j add_done_80
add_no_overflow_78:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_79
	li $t0,-32768
add_no_underflow_79:
add_done_80:
	lw $t1,-160($fp)
	add $t0,$t0,$t1
	li $t9,32767
	ble $t0,$t9,add_no_overflow_81
	li $t0,32767
	j add_done_83
add_no_overflow_81:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_82
	li $t0,-32768
add_no_underflow_82:
add_done_83:
	lw $t1,-164($fp)
	add $t1,$t0,$t1
	li $t9,32767
	ble $t1,$t9,add_no_overflow_84
	li $t1,32767
	j add_done_86
add_no_overflow_84:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_85
	li $t1,-32768
add_no_underflow_85:
add_done_86:
	lw $t0,-168($fp)
	add $t1,$t1,$t0
	li $t9,32767
	ble $t1,$t9,add_no_overflow_87
	li $t1,32767
	j add_done_89
add_no_overflow_87:
	li $t9,-32768
	bge $t1,$t9,add_no_underflow_88
	li $t1,-32768
add_no_underflow_88:
add_done_89:
	lw $t0,-172($fp)
	add $t0,$t1,$t0
	li $t9,32767
	ble $t0,$t9,add_no_overflow_90
	li $t0,32767
	j add_done_92
add_no_overflow_90:
	li $t9,-32768
	bge $t0,$t9,add_no_underflow_91
	li $t0,-32768
add_no_underflow_91:
add_done_92:
	move $v0,$t0
	addu $sp,$sp,380
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
	jal Label_foo
	move $t0,$v0
	move $a0,$t0
	li $v0,1
	syscall
	li $a0,32
	li $v0,11
	syscall
	li $v0,10
	syscall
