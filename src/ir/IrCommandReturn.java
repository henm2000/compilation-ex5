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
		// Move return value to $v0 if non-void
		if (returnValue != null) {
			mips.MipsGenerator.getInstance().returnValue(returnValue);
		}
		// Note: Function epilogue will be generated separately to restore registers and jr $ra
	}
}
