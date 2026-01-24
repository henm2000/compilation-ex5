/***********/
/* PACKAGE */
/***********/
package ir;

/*******************/
/* GENERAL IMPORTS */
/*******************/

/*******************/
/* PROJECT IMPORTS */
/*******************/
import temp.*;
import mips.*;

/**
 * Load from array with bounds checking
 * dst := array[index]
 * 
 * Array layout: [length | elem0 | elem1 | ...]
 * Array pointer points TO length field
 * 
 * Checks:
 * - array != null
 * - index >= 0
 * - index < length
 * 
 * Then loads: dst := Mem[array + (index+1)*4]
 */
public class IrCommandArrayLoad extends IrCommand
{
	public Temp dst;
	public Temp arrayPtr;
	public Temp index;
	
	public IrCommandArrayLoad(Temp dst, Temp arrayPtr, Temp index)
	{
		this.dst = dst;
		this.arrayPtr = arrayPtr;
		this.index = index;
	}

	public void mipsMe()
	{
		MipsGenerator gen = MipsGenerator.getInstance();
		
		// Perform bounds checking (null check, index < 0, index >= length)
		gen.checkArrayBounds(arrayPtr, index);
		
		// Calculate element address: array + (index+1)*4
		// We need to use $s0 and $s1 as scratch registers
		String regArray = gen.tempToReg(arrayPtr);
		String regIndex = gen.tempToReg(index);
		String regDst = gen.tempToReg(dst);
		
		// $s0 = index + 1
		gen.fileWriter.format("\taddi $s0,%s,1\n", regIndex);
		// $s0 = (index+1) * 4
		gen.fileWriter.format("\tsll $s0,$s0,2\n");
		// $s0 = array + (index+1)*4
		gen.fileWriter.format("\tadd $s0,%s,$s0\n", regArray);
		// dst = Mem[$s0]
		gen.fileWriter.format("\tlw %s,0($s0)\n", regDst);
	}
}
