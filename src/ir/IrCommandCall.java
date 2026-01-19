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
import java.util.List;

/**
 * Function or method call
 * dst := call funcName(args)
 * Maps to MIPS: jal funcName (with args passed via stack or $a0-$a3)
 */
public class IrCommandCall extends IrCommand
{
	public Temp dst;  // null if return type is void
	public String funcName;
	public List<Temp> args;
	
	public IrCommandCall(Temp dst, String funcName, List<Temp> args)
	{
		this.dst      = dst;
		this.funcName = funcName;
		this.args     = args;
	}

	public void mipsMe()
	{
		// Handle special built-in functions
		if (funcName.equals("Label_PrintInt") && args.size() == 1) {
			// Use the printInt helper
			mips.MipsGenerator.getInstance().printInt(args.get(0));
		} else {
			// User-defined function call
			// Push arguments onto stack in RIGHT-TO-LEFT order (so first arg is at top)
			for (int i = args.size() - 1; i >= 0; i--) {
				mips.MipsGenerator.getInstance().pushArg(args.get(i));
			}
			
			// Call the function
			mips.MipsGenerator.getInstance().call(dst, funcName);
			
			// Pop arguments from stack
			mips.MipsGenerator.getInstance().popArgs(args.size());
		}
	}
}

