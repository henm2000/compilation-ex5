/***********/
/* PACKAGE */
/***********/
package ir;

/*******************/
/* PROJECT IMPORTS */
/*******************/
import temp.*;
import java.util.List;

/**
 * Indirect function call via vtable
 * dst := call [vtableTemp + offset](args)
 * Used for polymorphic method dispatch
 */
public class IrCommandCallIndirect extends IrCommand
{
	public Temp dst;        // null if return type is void
	public Temp objTemp;    // object reference (to load vtable from)
	public int vtableOffset; // offset into vtable for this method
	public List<Temp> args;
	
	public IrCommandCallIndirect(Temp dst, Temp objTemp, int vtableOffset, List<Temp> args)
	{
		this.dst = dst;
		this.objTemp = objTemp;
		this.vtableOffset = vtableOffset;
		this.args = args;
	}

	public void mipsMe()
	{
		mips.MipsGenerator gen = mips.MipsGenerator.getInstance();
		
		// 0. Null-check receiver object before vtable access
		String labelObjNotNull = getFreshLabel("call_indirect_not_null");
		String objReg = gen.tempToReg(objTemp);
		gen.fileWriter.format("\tbnez %s,%s\n", objReg, labelObjNotNull);
		gen.fileWriter.format("\tla $a0,string_invalid_ptr_dref\n");
		gen.fileWriter.format("\tli $v0,4\n");
		gen.fileWriter.format("\tsyscall\n");
		gen.fileWriter.format("\tli $v0,10\n");
		gen.fileWriter.format("\tsyscall\n");
		gen.fileWriter.format("%s:\n", labelObjNotNull);

		// 1. Load vtable pointer from object (at offset 0)
		//    vtable_ptr = Mem[objTemp + 0]
		gen.fileWriter.format("\tlw $t9,0(%s)  # load vtable ptr\n", objReg);
		
		// 2. Load method address from vtable
		//    method_addr = Mem[vtable_ptr + vtableOffset]
		gen.fileWriter.format("\tlw $t9,%d($t9)  # load method addr from vtable\n", vtableOffset);
		
		// 3. Save all caller-saved registers ($t0-$t8) to stack before call
		//    Note: $t9 holds method addr, so we save it last and use a different approach
		gen.fileWriter.format("\t# Save caller-saved registers\n");
		gen.fileWriter.format("\taddiu $sp,$sp,-40\n");  // 10 registers * 4 bytes
		for (int i = 0; i < 9; i++) {
			gen.fileWriter.format("\tsw $t%d,%d($sp)\n", i, i * 4);
		}
		gen.fileWriter.format("\tsw $t9,36($sp)\n");  // save method addr at slot 9
		gen.fileWriter.format("\tlw $t9,36($sp)\n");  // reload it for call
		
		// 4. Push arguments onto stack in RIGHT-TO-LEFT order
		for (int i = args.size() - 1; i >= 0; i--) {
			gen.pushArg(args.get(i));
		}
		
		// 5. Call the method indirectly
		gen.fileWriter.format("\tjalr $t9  # indirect call\n");
		
		// 6. Pop arguments from stack
		gen.popArgs(args.size());
		
		// 7. Restore caller-saved registers after call
		gen.fileWriter.format("\t# Restore caller-saved registers\n");
		for (int i = 0; i < 10; i++) {
			gen.fileWriter.format("\tlw $t%d,%d($sp)\n", i, i * 4);
		}
		gen.fileWriter.format("\taddiu $sp,$sp,40\n");
		
		// 8. If non-void return, move result from $v0 to dst register
		if (dst != null) {
			String dstReg = gen.tempToReg(dst);
			gen.fileWriter.format("\tmove %s,$v0\n", dstReg);
		}
	}
}
