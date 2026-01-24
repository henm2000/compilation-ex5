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
 * Store to array with bounds checking
 * array[index] := src
 * 
 * Array layout: [length | elem0 | elem1 | ...]
 * Array pointer points TO length field
 * 
 * Checks:
 * - array != null
 * - index >= 0
 * - index < length
 * 
 * Then stores: Mem[array + (index+1)*4] := src
 */
public class IrCommandArrayStore extends IrCommand
{
	public Temp arrayPtr;
	public Temp index;
	public Temp src;
	
	public IrCommandArrayStore(Temp arrayPtr, Temp index, Temp src)
	{
		this.arrayPtr = arrayPtr;
		this.index = index;
		this.src = src;
	}

	public void mipsMe()
	{
		MipsGenerator gen = MipsGenerator.getInstance();
		
		// Perform bounds checking (null check, index < 0, index >= length)
		gen.checkArrayBounds(arrayPtr, index);
		
		// Calculate element address: array + (index+1)*4
		// We need to use $s0 as scratch register
		String regArray = gen.tempToReg(arrayPtr);
		String regIndex = gen.tempToReg(index);
		String regSrc = gen.tempToReg(src);
		
		// $s0 = index + 1
		gen.fileWriter.format("\taddi $s0,%s,1\n", regIndex);
		// $s0 = (index+1) * 4
		gen.fileWriter.format("\tsll $s0,$s0,2\n");
		// $s0 = array + (index+1)*4
		gen.fileWriter.format("\tadd $s0,%s,$s0\n", regArray);
		// Mem[$s0] = src
		gen.fileWriter.format("\tsw %s,0($s0)\n", regSrc);
	}
}
