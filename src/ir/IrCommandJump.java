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

import mips.*;

/**
 * Unconditional jump to a label
 * Maps to MIPS: j label
 */
public class IrCommandJump extends IrCommand
{
	public String labelName;
	
	public IrCommandJump(String labelName)
	{
		this.labelName = labelName;
	}

	public void mipsMe()
	{
		MipsGenerator.getInstance().jump(labelName);
	}
}

