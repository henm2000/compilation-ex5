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

/**
 * Binary operation: greater than comparison of integers
 * dst := (t1 > t2) ? 1 : 0
 * Maps to MIPS: slt $dst, $t2, $t1 (swapped operands for GT)
 */
public class IrCommandBinopGtIntegers extends IrCommand
{
	public Temp t1;
	public Temp t2;
	public Temp dst;
	
	public IrCommandBinopGtIntegers(Temp dst, Temp t1, Temp t2)
	{
		this.dst = dst;
		this.t1 = t1;
		this.t2 = t2;
	}

	public void mipsMe()
	{
		// TODO: Implement MIPS generation
		// MipsGenerator.getInstance().gt(dst, t1, t2);
	}
}

