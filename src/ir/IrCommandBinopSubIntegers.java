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
 * Binary operation: subtraction of integers
 * dst := t1 - t2
 * Maps to MIPS: sub $dst, $t1, $t2
 */
public class IrCommandBinopSubIntegers extends IrCommand
{
	public Temp t1;
	public Temp t2;
	public Temp dst;
	
	public IrCommandBinopSubIntegers(Temp dst, Temp t1, Temp t2)
	{
		this.dst = dst;
		this.t1 = t1;
		this.t2 = t2;
	}

	public void mipsMe()
	{
		mips.MipsGenerator.getInstance().sub(dst, t1, t2);
	}
}

