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
 * Allocate memory on the heap
 * dst := malloc(size)
 * Maps to MIPS: sbrk syscall (allocate size bytes, return address in $v0)
 */
public class IrCommandMalloc extends IrCommand
{
	public Temp dst;
	public Temp size;
	
	public IrCommandMalloc(Temp dst, Temp size)
	{
		this.dst  = dst;
		this.size = size;
	}

	public void mipsMe()
	{
		mips.MipsGenerator.getInstance().malloc(dst, size);
	}
}

