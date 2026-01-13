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
 * Load from memory at address + offset
 * t1 := Mem[t2 + offset]
 * Maps to MIPS: lw $t1, offset($t2)
 */
public class IrCommandLoadMemory extends IrCommand
{
	public Temp dst;
	public Temp address;
	public int offset;
	
	public IrCommandLoadMemory(Temp dst, Temp address, int offset)
	{
		this.dst     = dst;
		this.address = address;
		this.offset  = offset;
	}

	public void mipsMe()
	{
		// TODO: Implement MIPS generation
	}
}

