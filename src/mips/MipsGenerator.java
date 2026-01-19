/***********/
/* PACKAGE */
/***********/
package mips;

/*******************/
/* GENERAL IMPORTS */
/*******************/
import java.io.PrintWriter;
import java.util.Map;

/*******************/
/* PROJECT IMPORTS */
/*******************/
import temp.*;

public class MipsGenerator
{
	private static final int WORD_SIZE = 4;
	private static final int NUM_TEMP_REGISTERS = 10; // $t0-$t9
	
	/***********************/
	/* The file writer ... */
	/***********************/
	private PrintWriter fileWriter;
	
	/**********************************/
	/* Function metadata for prologue/epilogue */
	/**********************************/
	private Map<String, FunctionInfo> functionInfo;
	private String currentFunction;

	/***********************/
	/* The file writer ... */
	/***********************/
	public void finalizeFile()
	{
		fileWriter.print("\tli $v0,10\n");
		fileWriter.print("\tsyscall\n");
		fileWriter.close();
	}
	
	/**************************************/
	/* Convert Temp to physical register  */
	/**************************************/
	private String tempToReg(Temp t)
	{
		if (t == null) {
			return "$zero"; // Fallback
		}
		if (t.isAllocated()) {
			return t.getPhysicalRegister(); // e.g., "$t0"
		}
		// Fallback if not allocated (shouldn't happen after allocation)
		return "Temp_" + t.getSerialNumber();
	}
	
	/******************************************/
	/* Set function metadata                  */
	/* Call before generating MIPS            */
	/******************************************/
	public void setFunctionInfo(Map<String, FunctionInfo> funcInfo)
	{
		this.functionInfo = funcInfo;
	}
	
	public void printInt(Temp t)
	{
		String reg = tempToReg(t);
		fileWriter.format("\tmove $a0,%s\n", reg);
		fileWriter.format("\tli $v0,1\n");
		fileWriter.format("\tsyscall\n");
		fileWriter.format("\tli $a0,32\n");
		fileWriter.format("\tli $v0,11\n");
		fileWriter.format("\tsyscall\n");
	}
//	public Temp addressLocalVar(int serialLocalVarNum)
//	{
//		Temp t  = TempFactory.getInstance().getFreshTemp();
//		int idx = t.getSerialNumber();
//
//		fileWriter.format("\taddi Temp_%d,$fp,%d\n",idx,-serialLocalVarNum*WORD_SIZE);
//
//		return t;
//	}
	public void allocate(String varName)
	{
		// .data is printed once in printDotDataString(), not before each variable
		fileWriter.format("\tglobal_%s: .word 721\n",varName);
	}
	public void load(Temp dst, String varName)
	{
		String reg = tempToReg(dst);
		fileWriter.format("\tlw %s,global_%s\n", reg, varName);
	}
	public void store(String varName, Temp src)
	{
		String reg = tempToReg(src);
		fileWriter.format("\tsw %s,global_%s\n", reg, varName);
	}
	public void li(Temp t, int value)
	{
		String reg = tempToReg(t);
		fileWriter.format("\tli %s,%d\n", reg, value);
	}
	public void add(Temp dst, Temp oprnd1, Temp oprnd2)
	{
		String regDst = tempToReg(dst);
		String reg1 = tempToReg(oprnd1);
		String reg2 = tempToReg(oprnd2);
		fileWriter.format("\tadd %s,%s,%s\n", regDst, reg1, reg2);
	}
	public void mul(Temp dst, Temp oprnd1, Temp oprnd2)
	{
		String regDst = tempToReg(dst);
		String reg1 = tempToReg(oprnd1);
		String reg2 = tempToReg(oprnd2);
		fileWriter.format("\tmul %s,%s,%s\n", regDst, reg1, reg2);
	}
	public void label(String inlabel)
	{
		// Check if this is a function label
		boolean isFunction = false;
		int numLocalVars = 0;
		
		if (functionInfo != null && functionInfo.containsKey(inlabel)) {
			isFunction = true;
			currentFunction = inlabel;
			numLocalVars = functionInfo.get(inlabel).numTemps; // Use temps as local vars
		}
		
		if (inlabel.equals("main") || inlabel.equals("Label_main"))
		{
			fileWriter.format(".text\n");
			if (inlabel.equals("Label_main")) {
				fileWriter.format("main:\n"); // Output "main:" for Label_main
			} else {
				fileWriter.format("%s:\n",inlabel);
			}
			// Main doesn't need prologue/epilogue in simple implementation
			// Skip prologue for main to keep output simple
		}
		else
		{
			fileWriter.format("%s:\n",inlabel);
			
			// If this is a user-defined function, generate prologue
			if (isFunction) {
				functionPrologue(numLocalVars);
			}
		}
	}	
	
	public void printDotTextString() {
		// Placeholder if handled in label()
	}
	public void jump(String inlabel)
	{
		fileWriter.format("\tj %s\n",inlabel);
	}	
	public void blt(Temp oprnd1, Temp oprnd2, String label)
	{
		String reg1 = tempToReg(oprnd1);
		String reg2 = tempToReg(oprnd2);
		fileWriter.format("\tblt %s,%s,%s\n", reg1, reg2, label);				
	}
	public void bge(Temp oprnd1, Temp oprnd2, String label)
	{
		String reg1 = tempToReg(oprnd1);
		String reg2 = tempToReg(oprnd2);
		fileWriter.format("\tbge %s,%s,%s\n", reg1, reg2, label);				
	}
	public void bne(Temp oprnd1, Temp oprnd2, String label)
	{
		String reg1 = tempToReg(oprnd1);
		String reg2 = tempToReg(oprnd2);
		fileWriter.format("\tbne %s,%s,%s\n", reg1, reg2, label);				
	}
	public void beq(Temp oprnd1, Temp oprnd2, String label)
	{
		String reg1 = tempToReg(oprnd1);
		String reg2 = tempToReg(oprnd2);
		fileWriter.format("\tbeq %s,%s,%s\n", reg1, reg2, label);				
	}
	public void beqz(Temp oprnd1, String label)
	{
		String reg = tempToReg(oprnd1);
		fileWriter.format("\tbeq %s,$zero,%s\n", reg, label);				
	}
	
	/******************************************/
	/* Function Prologue                      */
	/* Called at function entry               */
	/******************************************/
	public void functionPrologue(int numLocalVars)
	{
		// Save $ra (return address)
		fileWriter.format("\tsubu $sp,$sp,4\n");
		fileWriter.format("\tsw $ra,0($sp)\n");
		
		// Save old $fp
		fileWriter.format("\tsubu $sp,$sp,4\n");
		fileWriter.format("\tsw $fp,0($sp)\n");
		
		// Set new $fp to current $sp
		fileWriter.format("\tmove $fp,$sp\n");
		
		// Save all callee-saved registers ($t0-$t9)
		for (int i = 0; i < NUM_TEMP_REGISTERS; i++) {
			fileWriter.format("\tsubu $sp,$sp,4\n");
			fileWriter.format("\tsw $t%d,0($sp)\n", i);
		}
		
		// Allocate space for local variables
		if (numLocalVars > 0) {
			int localSpace = numLocalVars * WORD_SIZE;
			fileWriter.format("\tsubu $sp,$sp,%d\n", localSpace);
		}
	}
	
	/******************************************/
	/* Function Epilogue                      */
	/* Called before function return          */
	/******************************************/
	public void functionEpilogue(int numLocalVars)
	{
		// Deallocate local variable space
		if (numLocalVars > 0) {
			int localSpace = numLocalVars * WORD_SIZE;
			fileWriter.format("\taddu $sp,$sp,%d\n", localSpace);
		}
		
		// Restore all callee-saved registers ($t0-$t9) in reverse order
		for (int i = NUM_TEMP_REGISTERS - 1; i >= 0; i--) {
			fileWriter.format("\tlw $t%d,0($sp)\n", i);
			fileWriter.format("\taddu $sp,$sp,4\n");
		}
		
		// Restore old $fp
		fileWriter.format("\tlw $fp,0($sp)\n");
		fileWriter.format("\taddu $sp,$sp,4\n");
		
		// Restore $ra
		fileWriter.format("\tlw $ra,0($sp)\n");
		fileWriter.format("\taddu $sp,$sp,4\n");
		
		// Return to caller
		fileWriter.format("\tjr $ra\n");
	}
	
	/******************************************/
	/* Push argument onto stack               */
	/* Called for each argument before call   */
	/******************************************/
	public void pushArg(Temp arg)
	{
		String reg = tempToReg(arg);
		fileWriter.format("\tsubu $sp,$sp,4\n");
		fileWriter.format("\tsw %s,0($sp)\n", reg);
	}
	
	/******************************************/
	/* Pop N arguments from stack             */
	/* Called after function returns          */
	/******************************************/
	public void popArgs(int numArgs)
	{
		if (numArgs > 0) {
			int argSpace = numArgs * WORD_SIZE;
			fileWriter.format("\taddu $sp,$sp,%d\n", argSpace);
		}
	}
	
	/******************************************/
	/* Call a function                        */
	/* dst: where to store return value       */
	/* label: function label                  */
	/******************************************/
	public void call(Temp dst, String label)
	{
		// Jump and link to function
		fileWriter.format("\tjal %s\n", label);
		
		// If non-void return, move result from $v0 to dst register
		if (dst != null) {
			String dstReg = tempToReg(dst);
			fileWriter.format("\tmove %s,$v0\n", dstReg);
		}
	}
	
	/******************************************/
	/* Return from function with value        */
	/******************************************/
	public void returnValue(Temp returnTemp)
	{
		if (returnTemp != null) {
			String reg = tempToReg(returnTemp);
			fileWriter.format("\tmove $v0,%s\n", reg);
		}
		
		// Generate epilogue if we're in a function
		if (currentFunction != null && functionInfo != null && functionInfo.containsKey(currentFunction)) {
			int numLocalVars = functionInfo.get(currentFunction).numTemps;
			functionEpilogue(numLocalVars);
		}
	}
	
	/**************************************/
	/* USUAL SINGLETON IMPLEMENTATION ... */
	/**************************************/
	private static MipsGenerator instance = null;

	/*****************************/
	/* PREVENT INSTANTIATION ... */
	/*****************************/
	protected MipsGenerator() {}

	/******************************/
	/* GET SINGLETON INSTANCE ... */
	/******************************/
	public static MipsGenerator getInstance()
	{
		return getInstance("MIPS.txt"); // Fallback for safety, though Main should call the other one
	}

	public static MipsGenerator getInstance(String filename)
	{
		if (instance == null)
		{
			/*******************************/
			/* [0] The instance itself ... */
			/*******************************/
			instance = new MipsGenerator();

			try
			{
				/***************************************/
				/* [2] Open MIPS text file for writing */
				/***************************************/
				instance.fileWriter = new PrintWriter(filename);
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}

			// Data section is printed explicitly by Main calling printDotDataString()			
		}
		return instance;
	}
	
	public void printDotDataString() {
		instance.fileWriter.print(".data\n");
		instance.fileWriter.print("string_access_violation: .asciiz \"Access Violation\"\n");
		instance.fileWriter.print("string_illegal_div_by_0: .asciiz \"Illegal Division By Zero\"\n");
		instance.fileWriter.print("string_invalid_ptr_dref: .asciiz \"Invalid Pointer Dereference\"\n");
		// Global variables will be allocated here (via IrCommandAllocate.mipsMe())
	}
	
}
