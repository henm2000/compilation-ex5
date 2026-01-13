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
		// TODO: Implement MIPS generation
	}
}

