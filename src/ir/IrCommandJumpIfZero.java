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
 * Conditional jump if temp equals zero
 * Maps to MIPS: beqz $t0, label
 */
public class IrCommandJumpIfZero extends IrCommand
{
	public Temp t;
	public String labelName;
	
	public IrCommandJumpIfZero(Temp t, String labelName)
	{
		this.t          = t;
		this.labelName = labelName;
	}

	public void mipsMe()
	{
		MipsGenerator.getInstance().beqz(t, labelName);
	}
}

