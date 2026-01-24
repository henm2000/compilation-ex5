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
 * Store to memory at address + offset
 * Mem[t1 + offset] := t2
 * Maps to MIPS: sw $t2, offset($t1)
 */
public class IrCommandStoreMemory extends IrCommand
{
	public Temp address;
	public int offset;
	public Temp src;
	
	public IrCommandStoreMemory(Temp address, int offset, Temp src)
	{
		this.address = address;
		this.offset  = offset;
		this.src     = src;
	}

	public void mipsMe()
	{
		mips.MipsGenerator.getInstance().storeMemory(address, offset, src);
	}
}

