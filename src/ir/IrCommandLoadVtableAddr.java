/***********/
/* PACKAGE */
/***********/
package ir;

/*******************/
/* PROJECT IMPORTS */
/*******************/
import temp.*;

/**
 * Load address of a vtable into a temp
 * dst := address_of(vtable_label)
 */
public class IrCommandLoadVtableAddr extends IrCommand
{
	public Temp dst;
	public String className;
	
	public IrCommandLoadVtableAddr(Temp dst, String className)
	{
		this.dst = dst;
		this.className = className;
	}

	public void mipsMe()
	{
		mips.MipsGenerator gen = mips.MipsGenerator.getInstance();
		String dstReg = gen.tempToReg(dst);
		String vtableLabel = "vtable_" + className;
		gen.fileWriter.format("\tla %s,%s  # load vtable address for %s\n", dstReg, vtableLabel, className);
	}
}
