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
 * Print string to console
 * PrintString(str_temp)
 */
public class IrCommandPrintString extends IrCommand
{
	public Temp str;
	
	public IrCommandPrintString(Temp str)
	{
		this.str = str;
	}

	public void mipsMe()
	{
		MipsGenerator gen = MipsGenerator.getInstance();
		String regStr = gen.tempToReg(str);
		
		gen.fileWriter.format("\tmove $a0,%s\n", regStr);
		gen.fileWriter.format("\tli $v0,4\n");
		gen.fileWriter.format("\tsyscall\n");
	}
}
