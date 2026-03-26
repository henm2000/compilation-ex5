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
		mips.MipsGenerator gen = mips.MipsGenerator.getInstance();
		
		// Handle special built-in functions
		if (funcName.equals("Label_PrintInt") && args.size() == 1) {
			// Use the printInt helper
			gen.printInt(args.get(0));
		} else if (funcName.equals("Label_PrintString") && args.size() == 1) {
			// Use the printString helper
			String regStr = gen.tempToReg(args.get(0));
			gen.fileWriter.format("\tmove $a0,%s\n", regStr);
			gen.fileWriter.format("\tli $v0,4\n");
			gen.fileWriter.format("\tsyscall\n");
		} else {
			// User-defined function call
			
			// Save all caller-saved registers ($t0-$t9) to stack before call
			// This ensures temps that are live across the call are preserved
			gen.fileWriter.format("\t# Save caller-saved registers\n");
			gen.fileWriter.format("\taddiu $sp,$sp,-40\n");  // 10 registers * 4 bytes
			for (int i = 0; i < 10; i++) {
				gen.fileWriter.format("\tsw $t%d,%d($sp)\n", i, i * 4);
			}
			
			// Push arguments onto stack in RIGHT-TO-LEFT order (so first arg is at top)
			for (int i = args.size() - 1; i >= 0; i--) {
				gen.pushArg(args.get(i));
			}
			
			// Call the function (pass null for dst - we'll handle move after restore)
			gen.call(null, funcName);
			
			// Pop arguments from stack
			gen.popArgs(args.size());
			
			// Restore caller-saved registers after call
			gen.fileWriter.format("\t# Restore caller-saved registers\n");
			for (int i = 0; i < 10; i++) {
				gen.fileWriter.format("\tlw $t%d,%d($sp)\n", i, i * 4);
			}
			gen.fileWriter.format("\taddiu $sp,$sp,40\n");
			
			// Move result to dst (must be after restore to not clobber it)
			if (dst != null) {
				String dstReg = gen.tempToReg(dst);
				gen.fileWriter.format("\tmove %s,$v0\n", dstReg);
			}
		}
	}
}

