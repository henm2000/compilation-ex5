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
 * Move/copy value from one temp to another
 * Maps to MIPS: move $t0, $t1  (or add $t0, $t1, $zero)
 */
public class IrCommandMove extends IrCommand
{
	public Temp dst;
	public Temp src;
	
	public IrCommandMove(Temp dst, Temp src)
	{
		this.dst = dst;
		this.src = src;
	}

	public void mipsMe()
	{
		MipsGenerator.getInstance().move(dst, src);
	}
}

