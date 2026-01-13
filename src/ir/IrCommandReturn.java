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
 * Return from function
 * return value (if non-void)
 * Maps to MIPS: move $v0, value; jr $ra
 */
public class IrCommandReturn extends IrCommand
{
	public Temp returnValue;  // null if return type is void
	
	public IrCommandReturn(Temp returnValue)
	{
		this.returnValue = returnValue;
	}

	public void mipsMe()
	{
		// TODO: Implement MIPS generation
	}
}

