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
 * String constant
 * dst := address of string literal
 * The string is stored in .data section
 */
public class IrCommandConstString extends IrCommand
{
	public Temp dst;
	public String value;
	
	public IrCommandConstString(Temp dst, String value)
	{
		this.dst = dst;
		this.value = value;
	}

	public void mipsMe()
	{
		MipsGenerator gen = MipsGenerator.getInstance();
		
		// Generate a unique label for this string
		String stringLabel = "string_const_" + gen.getNextStringId();
		
		// Add string to data section
		gen.addStringConstant(stringLabel, value);
		
		// Load address of string - defer if .text hasn't started
		final String regDst = gen.tempToReg(dst);
		final String label = stringLabel;
		if (!gen.isTextStarted()) {
			gen.addInitialization(() -> gen.fileWriter.format("\tla %s,%s\n", regDst, label));
		} else {
			gen.fileWriter.format("\tla %s,%s\n", regDst, label);
		}
	}
}
