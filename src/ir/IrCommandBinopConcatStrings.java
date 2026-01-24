package ir;
import temp.*;
import mips.*;

/**
 * IR Command for string concatenation
 * Allocates new string on heap, copies both strings, null-terminates
 */
public class IrCommandBinopConcatStrings extends IrCommand
{
	public Temp dst;
	public Temp string1;
	public Temp string2;
	
	public IrCommandBinopConcatStrings(Temp dst, Temp string1, Temp string2)
	{
		this.dst = dst;
		this.string1 = string1;
		this.string2 = string2;
	}
	
	/*********************/
	/* MIPS Translation */
	/*********************/
	public void mipsMe()
	{
		MipsGenerator.getInstance().concatStrings(dst, string1, string2);
	}
}
