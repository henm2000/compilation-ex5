package ir;
import temp.*;
import mips.*;

/**
 * IR Command for string equality comparison
 * Compares content byte-by-byte, returns 1 if equal, 0 otherwise
 */
public class IrCommandBinopEqStrings extends IrCommand
{
	public Temp dst;
	public Temp string1;
	public Temp string2;
	
	public IrCommandBinopEqStrings(Temp dst, Temp string1, Temp string2)
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
		MipsGenerator.getInstance().compareStrings(dst, string1, string2);
	}
}
