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

public class IrCommandAllocate extends IrCommand
{
	public String varName;
	public String scope; // "global", "parameter", or "local"
	
	public IrCommandAllocate(String varName)
	{
		this.varName = varName;
		this.scope = "global"; // Default to global
	}
	
	public IrCommandAllocate(String varName, String scope)
	{
		this.varName = varName;
		this.scope = scope;
	}

	public void mipsMe()
	{
		MipsGenerator.getInstance().allocate(varName, scope);
	}
}
