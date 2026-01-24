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
	/* Made public for IR commands */
	/***********************/
	public PrintWriter fileWriter;
	
	/***********************/
	/* Buffer for .data section content */
	/***********************/
	private StringBuilder dataSection = new StringBuilder();
	private StringBuilder lateGlobals = new StringBuilder(); // Globals allocated after .text started
	
	/***********************/
	/* Label counter for unique labels */
	/***********************/
	private int labelCounter = 0;
	
	/***********************/
	/* String constant counter */
	/***********************/
	private int stringCounter = 0;
	
	/***********************/
	/* String constants to add to .data */
	/***********************/
	private java.util.List<String> stringConstants = new java.util.ArrayList<>();
	
	/***********************/
	/* Global variable declarations */
	/***********************/
	private java.util.List<String> globalDeclarations = new java.util.ArrayList<>();
	
	/***********************/
	/* Initialization code (executes right after .text starts) */
	/***********************/
	private java.util.List<Runnable> initializationCode = new java.util.ArrayList<>();
	
	/***********************/
	/* Program code (executes after initialization) */
	/***********************/
	private java.util.List<Runnable> programCode = new java.util.ArrayList<>();
	
	/***********************/
	/* Whether .data section has been started */
	/***********************/
	private boolean dataStarted = false;
	
	/***********************/
	/* Whether .text section has been started */
	/***********************/
	private boolean textStarted = false;
	
	public boolean isTextStarted() {
		return textStarted;
	}
	
	public void addInitialization(Runnable code) {
		initializationCode.add(code);
	}
	
	/***********************/
	/* Whether we're in initialization phase (before main label) */
	/***********************/
	private boolean inInitialization = false;
	
	/************************************/
	/* Defer code execution until .text */
	/************************************/
	public void deferIfNeeded(Runnable code)
	{
		if (!textStarted) {
			initializationCode.add(code);
		} else {
			code.run();
		}
	}
	
	/**********************************/
	/* Function metadata for prologue/epilogue */
	/**********************************/
	private Map<String, FunctionInfo> functionInfo;
	private String currentFunction;
	private boolean epilogueGenerated = false;  // Track if epilogue already generated for current function
	
	/**********************************/
	/* Variable location tracking */
	/**********************************/
	private Map<String, Integer> parameterOffsets = new java.util.HashMap<>();
	private Map<String, Integer> localVariableOffsets = new java.util.HashMap<>();
	private int nextLocalOffset = 0; // Negative offsets from $fp
	private java.util.List<String> currentFunctionParams = new java.util.ArrayList<>();

	/***********************/
	/* The file writer ... */
	/***********************/
	public void finalizeFile()
	{
		// If there are late globals (allocated after .text started),
		// add them as a separate .data section
		if (lateGlobals.length() > 0) {
			fileWriter.print("\n.data\n");
			fileWriter.print(lateGlobals.toString());
			fileWriter.print(".text\n");
		}
		
		fileWriter.print("\tli $v0,10\n");
		fileWriter.print("\tsyscall\n");
		fileWriter.close();
	}
	
	/**************************************/
	/* Convert Temp to physical register  */
	/* Made public for IR commands        */
	/**************************************/
	public String tempToReg(Temp t)
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
	public void allocate(String varName, String scope)
	{
		if (scope.equals("global")) {
			// Global variable declaration
			String decl = "global_" + varName + ": .word 0\n";
			
			if (!textStarted) {
				// Buffer in .data section (before .text starts)
				dataSection.append(decl);
			} else {
				// .text already started - we need to add this global retroactively
				// This can happen for variables declared in main body
				// We'll append to the data section buffer and note it needs special handling
				lateGlobals.append(decl);
			}
		} else if (scope.equals("parameter")) {
			// Parameters are passed on stack - track offset from $fp
			// First param at 8($fp), second at 12($fp), etc.
			// (after saved $ra at 4($fp) and saved $fp at 0($fp))
			int paramIndex = currentFunctionParams.size();
			int offset = 8 + (paramIndex * 4);
			parameterOffsets.put(varName, offset);
			currentFunctionParams.add(varName);
		} else if (scope.equals("local")) {
			// Local variables allocated in prologue
			// Use negative offsets from $fp
			// After saving $ra, $fp, and 10 temp registers (11 words = 44 bytes)
			// Locals start at -48($fp), -52($fp), etc.
			if (nextLocalOffset == 0) {
				nextLocalOffset = 48; // Start after saved registers
			}
			localVariableOffsets.put(varName, -nextLocalOffset);
			nextLocalOffset += 4;
		}
	}
	
	// Backward compatibility
	public void allocate(String varName)
	{
		allocate(varName, "global");
	}
	public void load(Temp dst, String varName)
	{
		String reg = tempToReg(dst);
		
		// Check if it's a parameter
		if (parameterOffsets.containsKey(varName)) {
			int offset = parameterOffsets.get(varName);
			fileWriter.format("\tlw %s,%d($fp)\n", reg, offset);
		}
		// Check if it's a local variable
		else if (localVariableOffsets.containsKey(varName)) {
			int offset = localVariableOffsets.get(varName);
			fileWriter.format("\tlw %s,%d($fp)\n", reg, offset);
		}
		// Otherwise it's a global
		else {
			fileWriter.format("\tlw %s,global_%s\n", reg, varName);
		}
	}
	public void store(String varName, Temp src)
	{
		String reg = tempToReg(src);
		
		// Check if it's a parameter
		if (parameterOffsets.containsKey(varName)) {
			int offset = parameterOffsets.get(varName);
			fileWriter.format("\tsw %s,%d($fp)\n", reg, offset);
		}
		// Check if it's a local variable
		else if (localVariableOffsets.containsKey(varName)) {
			int offset = localVariableOffsets.get(varName);
			fileWriter.format("\tsw %s,%d($fp)\n", reg, offset);
		}
		// Otherwise it's a global
		else {
			// Global initialization should only happen after .text starts
			if (!textStarted) {
				// Defer until after .text - add to initialization list
				final String r = reg;
				final String v = varName;
				initializationCode.add(() -> fileWriter.format("\tsw %s,global_%s\n", r, v));
			} else {
				fileWriter.format("\tsw %s,global_%s\n", reg, varName);
			}
		}
	}
	public void li(Temp t, int value)
	{
		String reg = tempToReg(t);
		
		// Only defer global initialization (before .text AND not in a function)
		if (!textStarted && currentFunction == null) {
			initializationCode.add(() -> fileWriter.format("\tli %s,%d\n", reg, value));
		} else {
			fileWriter.format("\tli %s,%d\n", reg, value);
		}
	}
	public void add(Temp dst, Temp oprnd1, Temp oprnd2)
	{
		String regDst = tempToReg(dst);
		String reg1 = tempToReg(oprnd1);
		String reg2 = tempToReg(oprnd2);
		
		// Perform addition
		fileWriter.format("\tadd %s,%s,%s\n", regDst, reg1, reg2);
		
		// Saturate to [-32768, 32767]
		String labelNoOverflow = "add_no_overflow_" + labelCounter++;
		String labelNoUnderflow = "add_no_underflow_" + labelCounter++;
		String labelDone = "add_done_" + labelCounter++;
		
		// Check for overflow (result > 32767)
		fileWriter.format("\tli $t9,32767\n");
		fileWriter.format("\tble %s,$t9,%s\n", regDst, labelNoOverflow);
		fileWriter.format("\tli %s,32767\n", regDst);
		fileWriter.format("\tj %s\n", labelDone);
		
		// Check for underflow (result < -32768)
		fileWriter.format("%s:\n", labelNoOverflow);
		fileWriter.format("\tli $t9,-32768\n");
		fileWriter.format("\tbge %s,$t9,%s\n", regDst, labelNoUnderflow);
		fileWriter.format("\tli %s,-32768\n", regDst);
		
		fileWriter.format("%s:\n", labelNoUnderflow);
		fileWriter.format("%s:\n", labelDone);
	}
	public void mul(Temp dst, Temp oprnd1, Temp oprnd2)
	{
		String regDst = tempToReg(dst);
		String reg1 = tempToReg(oprnd1);
		String reg2 = tempToReg(oprnd2);
		
		// Perform multiplication
		fileWriter.format("\tmul %s,%s,%s\n", regDst, reg1, reg2);
		
		// Saturate to [-32768, 32767]
		String labelNoOverflow = "mul_no_overflow_" + labelCounter++;
		String labelNoUnderflow = "mul_no_underflow_" + labelCounter++;
		String labelDone = "mul_done_" + labelCounter++;
		
		// Check for overflow (result > 32767)
		fileWriter.format("\tli $t9,32767\n");
		fileWriter.format("\tble %s,$t9,%s\n", regDst, labelNoOverflow);
		fileWriter.format("\tli %s,32767\n", regDst);
		fileWriter.format("\tj %s\n", labelDone);
		
		// Check for underflow (result < -32768)
		fileWriter.format("%s:\n", labelNoOverflow);
		fileWriter.format("\tli $t9,-32768\n");
		fileWriter.format("\tbge %s,$t9,%s\n", regDst, labelNoUnderflow);
		fileWriter.format("\tli %s,-32768\n", regDst);
		
		fileWriter.format("%s:\n", labelNoUnderflow);
		fileWriter.format("%s:\n", labelDone);
	}
	
	public void sub(Temp dst, Temp oprnd1, Temp oprnd2)
	{
		String regDst = tempToReg(dst);
		String reg1 = tempToReg(oprnd1);
		String reg2 = tempToReg(oprnd2);
		
		// Perform subtraction
		fileWriter.format("\tsub %s,%s,%s\n", regDst, reg1, reg2);
		
		// Saturate to [-32768, 32767]
		String labelNoOverflow = "sub_no_overflow_" + labelCounter++;
		String labelNoUnderflow = "sub_no_underflow_" + labelCounter++;
		String labelDone = "sub_done_" + labelCounter++;
		
		// Check for overflow (result > 32767)
		fileWriter.format("\tli $t9,32767\n");
		fileWriter.format("\tble %s,$t9,%s\n", regDst, labelNoOverflow);
		fileWriter.format("\tli %s,32767\n", regDst);
		fileWriter.format("\tj %s\n", labelDone);
		
		// Check for underflow (result < -32768)
		fileWriter.format("%s:\n", labelNoOverflow);
		fileWriter.format("\tli $t9,-32768\n");
		fileWriter.format("\tbge %s,$t9,%s\n", regDst, labelNoUnderflow);
		fileWriter.format("\tli %s,-32768\n", regDst);
		
		fileWriter.format("%s:\n", labelNoUnderflow);
		fileWriter.format("%s:\n", labelDone);
	}
	
	public void div(Temp dst, Temp oprnd1, Temp oprnd2)
	{
		String regDst = tempToReg(dst);
		String reg1 = tempToReg(oprnd1);
		String reg2 = tempToReg(oprnd2);
		
		// Check for division by zero
		String labelContinue = "div_continue_" + labelCounter++;
		fileWriter.format("\tbnez %s,%s\n", reg2, labelContinue);
		
		// Division by zero error
		fileWriter.format("\tla $a0,string_illegal_div_by_0\n");
		fileWriter.format("\tli $v0,4\n");
		fileWriter.format("\tsyscall\n");
		fileWriter.format("\tli $v0,10\n");
		fileWriter.format("\tsyscall\n");
		
		// Continue with division
		fileWriter.format("%s:\n", labelContinue);
		fileWriter.format("\tdiv %s,%s\n", reg1, reg2);
		fileWriter.format("\tmflo %s\n", regDst);
	}
	
	public void slt(Temp dst, Temp oprnd1, Temp oprnd2)
	{
		String regDst = tempToReg(dst);
		String reg1 = tempToReg(oprnd1);
		String reg2 = tempToReg(oprnd2);
		fileWriter.format("\tslt %s,%s,%s\n", regDst, reg1, reg2);
	}
	
	public void sgt(Temp dst, Temp oprnd1, Temp oprnd2)
	{
		// sgt is same as slt with swapped operands
		String regDst = tempToReg(dst);
		String reg1 = tempToReg(oprnd1);
		String reg2 = tempToReg(oprnd2);
		fileWriter.format("\tslt %s,%s,%s\n", regDst, reg2, reg1);
	}
	
	public void seq(Temp dst, Temp oprnd1, Temp oprnd2)
	{
		String regDst = tempToReg(dst);
		String reg1 = tempToReg(oprnd1);
		String reg2 = tempToReg(oprnd2);
		fileWriter.format("\tseq %s,%s,%s\n", regDst, reg1, reg2);
	}
	
	/****************************************/
	/* String Concatenation                 */
	/* Allocates new string, copies both,   */
	/* null-terminates                      */
	/****************************************/
	public void concatStrings(Temp dst, Temp str1, Temp str2)
	{
		String regDst = tempToReg(dst);
		String reg1 = tempToReg(str1);
		String reg2 = tempToReg(str2);
		
		// We'll use $s0-$s4 as scratch registers for this operation
		// $s0 = saved str1 address
		// $s1 = saved str2 address  
		// $s2 = loop counter / byte value
		// $s3 = destination write pointer
		// $s4 = source read pointer
		
		// Save input pointers (in case regDst aliases reg1 or reg2)
		fileWriter.format("\tmove $s0,%s\n", reg1);
		fileWriter.format("\tmove $s1,%s\n", reg2);
		
		String labelLoop1Start = "concat_loop1_start_" + labelCounter++;
		String labelLoop1End = "concat_loop1_end_" + labelCounter++;
		String labelLoop2Start = "concat_loop2_start_" + labelCounter++;
		String labelLoop2End = "concat_loop2_end_" + labelCounter++;
		String labelLoop3Start = "concat_loop3_start_" + labelCounter++;
		String labelLoop3End = "concat_loop3_end_" + labelCounter++;
		
		// Calculate length of str1 (find null terminator)
		fileWriter.format("\tmove $s2,$zero\n");  // length counter
		fileWriter.format("\tmove $s4,$s0\n");     // read pointer = str1
		fileWriter.format("%s:\n", labelLoop1Start);
		fileWriter.format("\tlb $a0,0($s4)\n");
		fileWriter.format("\tbeqz $a0,%s\n", labelLoop1End);
		fileWriter.format("\taddi $s2,$s2,1\n");
		fileWriter.format("\taddi $s4,$s4,1\n");
		fileWriter.format("\tj %s\n", labelLoop1Start);
		fileWriter.format("%s:\n", labelLoop1End);
		fileWriter.format("\tmove $t9,$s2\n");     // Save len1 in $t9
		
		// Calculate length of str2
		fileWriter.format("\tmove $s2,$zero\n");  // length counter
		fileWriter.format("\tmove $s4,$s1\n");     // read pointer = str2
		fileWriter.format("%s:\n", labelLoop2Start);
		fileWriter.format("\tlb $a0,0($s4)\n");
		fileWriter.format("\tbeqz $a0,%s\n", labelLoop2End);
		fileWriter.format("\taddi $s2,$s2,1\n");
		fileWriter.format("\taddi $s4,$s4,1\n");
		fileWriter.format("\tj %s\n", labelLoop2Start);
		fileWriter.format("%s:\n", labelLoop2End);
		
		// Allocate memory: len1 + len2 + 1 (for null terminator)
		fileWriter.format("\tadd $a0,$t9,$s2\n");  // len1 + len2
		fileWriter.format("\taddi $a0,$a0,1\n");
		fileWriter.format("\tli $v0,9\n");
		fileWriter.format("\tsyscall\n");
		fileWriter.format("\tmove %s,$v0\n", regDst);  // Save result
		fileWriter.format("\tmove $s3,$v0\n");         // Write pointer
		
		// Copy str1
		fileWriter.format("\tmove $s4,$s0\n");  // Read from str1
		fileWriter.format("%s:\n", labelLoop3Start);
		fileWriter.format("\tlb $a0,0($s4)\n");
		fileWriter.format("\tbeqz $a0,%s\n", labelLoop3End);
		fileWriter.format("\tsb $a0,0($s3)\n");
		fileWriter.format("\taddi $s4,$s4,1\n");
		fileWriter.format("\taddi $s3,$s3,1\n");
		fileWriter.format("\tj %s\n", labelLoop3Start);
		fileWriter.format("%s:\n", labelLoop3End);
		
		// Copy str2 (including null terminator)
		String labelLoop4Start = "concat_loop4_start_" + labelCounter++;
		String labelLoop4End = "concat_loop4_end_" + labelCounter++;
		fileWriter.format("\tmove $s4,$s1\n");  // Read from str2
		fileWriter.format("%s:\n", labelLoop4Start);
		fileWriter.format("\tlb $a0,0($s4)\n");
		fileWriter.format("\tsb $a0,0($s3)\n");    // Write byte (including final \\0)
		fileWriter.format("\tbeqz $a0,%s\n", labelLoop4End);  // Stop after writing \\0
		fileWriter.format("\taddi $s4,$s4,1\n");
		fileWriter.format("\taddi $s3,$s3,1\n");
		fileWriter.format("\tj %s\n", labelLoop4Start);
		fileWriter.format("%s:\n", labelLoop4End);
	}
	
	/****************************************/
	/* String Equality Comparison           */
	/* Returns 1 if equal, 0 otherwise      */
	/****************************************/
	public void compareStrings(Temp dst, Temp str1, Temp str2)
	{
		String regDst = tempToReg(dst);
		String reg1 = tempToReg(str1);
		String reg2 = tempToReg(str2);
		
		String labelLoopStart = "strcmp_loop_start_" + labelCounter++;
		String labelNotEqual = "strcmp_not_equal_" + labelCounter++;
		String labelEqual = "strcmp_equal_" + labelCounter++;
		String labelDone = "strcmp_done_" + labelCounter++;
		
		// Use $s0 and $s1 as pointers
		fileWriter.format("\tmove $s0,%s\n", reg1);
		fileWriter.format("\tmove $s1,%s\n", reg2);
		
		// Loop: compare byte by byte
		fileWriter.format("%s:\n", labelLoopStart);
		fileWriter.format("\tlb $t9,0($s0)\n");
		fileWriter.format("\tlb $a0,0($s1)\n");
		
		// If characters differ, not equal
		fileWriter.format("\tbne $t9,$a0,%s\n", labelNotEqual);
		
		// If both are null (end of string), equal
		fileWriter.format("\tbeqz $t9,%s\n", labelEqual);
		
		// Move to next character
		fileWriter.format("\taddi $s0,$s0,1\n");
		fileWriter.format("\taddi $s1,$s1,1\n");
		fileWriter.format("\tj %s\n", labelLoopStart);
		
		// Strings are equal
		fileWriter.format("%s:\n", labelEqual);
		fileWriter.format("\tli %s,1\n", regDst);
		fileWriter.format("\tj %s\n", labelDone);
		
		// Strings are not equal
		fileWriter.format("%s:\n", labelNotEqual);
		fileWriter.format("\tli %s,0\n", regDst);
		
		fileWriter.format("%s:\n", labelDone);
	}
	
	public void move(Temp dst, Temp src)
	{
		String regDst = tempToReg(dst);
		String regSrc = tempToReg(src);
		fileWriter.format("\tmove %s,%s\n", regDst, regSrc);
	}
	
	public void loadMemory(Temp dst, Temp address, int offset)
	{
		String regDst = tempToReg(dst);
		String regAddr = tempToReg(address);
		
		// Check for null pointer
		String labelContinue = "load_continue_" + labelCounter++;
		fileWriter.format("\tbnez %s,%s\n", regAddr, labelContinue);
		
		// Null pointer error
		fileWriter.format("\tla $a0,string_invalid_ptr_dref\n");
		fileWriter.format("\tli $v0,4\n");
		fileWriter.format("\tsyscall\n");
		fileWriter.format("\tli $v0,10\n");
		fileWriter.format("\tsyscall\n");
		
		// Continue with load
		fileWriter.format("%s:\n", labelContinue);
		fileWriter.format("\tlw %s,%d(%s)\n", regDst, offset, regAddr);
	}
	
	public void storeMemory(Temp address, int offset, Temp src)
	{
		String regAddr = tempToReg(address);
		String regSrc = tempToReg(src);
		
		// Check for null pointer
		String labelContinue = "store_continue_" + labelCounter++;
		fileWriter.format("\tbnez %s,%s\n", regAddr, labelContinue);
		
		// Null pointer error
		fileWriter.format("\tla $a0,string_invalid_ptr_dref\n");
		fileWriter.format("\tli $v0,4\n");
		fileWriter.format("\tsyscall\n");
		fileWriter.format("\tli $v0,10\n");
		fileWriter.format("\tsyscall\n");
		
		// Continue with store
		fileWriter.format("%s:\n", labelContinue);
		fileWriter.format("\tsw %s,%d(%s)\n", regSrc, offset, regAddr);
	}
	
	public void malloc(Temp dst, Temp size)
	{
		String regDst = tempToReg(dst);
		String regSize = tempToReg(size);
		fileWriter.format("\tmove $a0,%s\n", regSize);
		fileWriter.format("\tli $v0,9\n");
		fileWriter.format("\tsyscall\n");
		fileWriter.format("\tmove %s,$v0\n", regDst);
	}

	private String loadOperand(Temp t, String scratch) {
		return tempToReg(t);
	}
	
	/******************************************/
	/* Array bounds checking helper           */
	/* Checks: index >= 0 AND index < length  */
	/* Uses $s0 as scratch register           */
	/******************************************/
	public void checkArrayBounds(Temp arrayPtr, Temp index)
	{
		// Load operands (handles spilling)
		String regArray = loadOperand(arrayPtr, "$t1");
		String regIndex = loadOperand(index, "$t2");
		
		// Check for null pointer first
		String labelNotNull = "array_not_null_" + labelCounter++;
		fileWriter.format("\tbnez %s,%s\n", regArray, labelNotNull);
		
		// Null pointer error
		fileWriter.format("\tla $a0,string_invalid_ptr_dref\n");
		fileWriter.format("\tli $v0,4\n");
		fileWriter.format("\tsyscall\n");
		fileWriter.format("\tli $v0,10\n");
		fileWriter.format("\tsyscall\n");
		
		fileWriter.format("%s:\n", labelNotNull);
		
		// Check if index < 0
		String labelIndexNonNeg = "array_index_nonneg_" + labelCounter++;
		fileWriter.format("\tbgez %s,%s\n", regIndex, labelIndexNonNeg);
		
		// Index negative - access violation
		fileWriter.format("\tla $a0,string_access_violation\n");
		fileWriter.format("\tli $v0,4\n");
		fileWriter.format("\tsyscall\n");
		fileWriter.format("\tli $v0,10\n");
		fileWriter.format("\tsyscall\n");
		
		fileWriter.format("%s:\n", labelIndexNonNeg);
		
		// Load array length from offset 0 into $s0
		fileWriter.format("\tlw $s0,0(%s)\n", regArray);
		
		// Check if index < length
		String labelIndexInBounds = "array_index_ok_" + labelCounter++;
		fileWriter.format("\tblt %s,$s0,%s\n", regIndex, labelIndexInBounds);
		
		// Index >= length - access violation
		fileWriter.format("\tla $a0,string_access_violation\n");
		fileWriter.format("\tli $v0,4\n");
		fileWriter.format("\tsyscall\n");
		fileWriter.format("\tli $v0,10\n");
		fileWriter.format("\tsyscall\n");
		
		fileWriter.format("%s:\n", labelIndexInBounds);
	}
	
	public void label(String inlabel)
	{
		// If we were in a function and now switching to a new function/label,
		// generate epilogue for the previous function (in case it didn't have explicit return)
		if (currentFunction != null && !inlabel.matches("Label_\\d+.*")) {
			// This is not a loop label, it's a new function or main
			// Generate epilogue for previous function if it was a real function
			// BUT only if epilogue wasn't already generated by a return statement
			if (!epilogueGenerated && functionInfo != null && functionInfo.containsKey(currentFunction)) {
				int prevNumLocalVars = functionInfo.get(currentFunction).numTemps;
				functionEpilogue(prevNumLocalVars);
			}
			currentFunction = null;  // Clear current function
			epilogueGenerated = false;  // Reset flag for next function
			
			// Clear parameter and local variable tracking
			parameterOffsets.clear();
			localVariableOffsets.clear();
			currentFunctionParams.clear();
			nextLocalOffset = 0;
		}
		
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
			// Before printing main, write all buffered .data content (global variables + late globals)
			if (!textStarted) {
				if (dataSection.length() > 0 || lateGlobals.length() > 0) {
					fileWriter.print(dataSection.toString());
					fileWriter.print(lateGlobals.toString());
				}
				// Print .text section before main label
				fileWriter.format(".text\n");
				textStarted = true;
			}
			
			// Print main label
			if (inlabel.equals("Label_main")) {
				fileWriter.format("main:\n"); // Output "main:" for Label_main
			} else {
				fileWriter.format("%s:\n",inlabel);
			}
			
			// Then execute deferred initialization code
			for (Runnable init : initializationCode) {
				init.run();
			}
			initializationCode.clear();
			
			// Main doesn't need prologue/epilogue in simple implementation
		}
		else
		{
			// For non-main labels (functions or loops)
			if (!textStarted && isFunction) {
				// This is a function before main - start .text now with current data
				if (dataSection.length() > 0) {
					fileWriter.print(dataSection.toString());
				}
				fileWriter.format(".text\n");
				textStarted = true;
				// Note: late globals (from main's body) will be added to lateGlobals buffer
			}
			
			fileWriter.format("%s:\n",inlabel);
			
			// If this is a user-defined function, generate prologue
			if (isFunction) {
				functionPrologue(numLocalVars);
			}
		}
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
		
		// Generate epilogue immediately for explicit return
		if (currentFunction != null && functionInfo != null && functionInfo.containsKey(currentFunction)) {
			int numLocalVars = functionInfo.get(currentFunction).numTemps;
			functionEpilogue(numLocalVars);
			epilogueGenerated = true;  // Mark that epilogue was generated
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
		// Start .data section  
		instance.fileWriter.print(".data\n");
		
		// Print error message strings
		// (Global variables will be added when label("main") is called)
		instance.fileWriter.print("string_access_violation: .asciiz \"Access Violation\"\n");
		instance.fileWriter.print("string_illegal_div_by_0: .asciiz \"Illegal Division By Zero\"\n");
		instance.fileWriter.print("string_invalid_ptr_dref: .asciiz \"Invalid Pointer Dereference\"\n");
		instance.dataStarted = true;
	}
	
	/******************************************/
	/* Get next string constant ID            */
	/******************************************/
	public int getNextStringId()
	{
		return stringCounter++;
	}
	
	/******************************************/
	/* Add a string constant to .data section */
	/******************************************/
	public void addStringConstant(String label, String value)
	{
		// Escape the string value for MIPS .asciiz
		String escapedValue = value.replace("\\", "\\\\")
		                           .replace("\"", "\\\"")
		                           .replace("\n", "\\n")
		                           .replace("\t", "\\t");
		
		String declaration = label + ": .asciiz \"" + escapedValue + "\"\n";
		
		// Add to data section buffer
		// If .text hasn't started, this will be written before .text
		// If .text has started, we have a problem - strings should be in .data!
		// Temporary workaround: prepend .data directive for late strings
		if (textStarted) {
			// Late string - write immediately with .data directive
			fileWriter.print(".data\n");
			fileWriter.print(declaration);
			fileWriter.print(".text\n");
		} else {
			dataSection.append(declaration);
		}
	}
	
	/******************************************/
	/* Print string to console                */
	/* Uses syscall 4 with address in $a0    */
	/******************************************/
	public void printString(Temp stringAddr)
	{
		String regStr = tempToReg(stringAddr);
		
		// Move string address to $a0
		fileWriter.format("\tmove $a0,%s\n", regStr);
		// syscall 4 = print string
		fileWriter.format("\tli $v0,4\n");
		fileWriter.format("\tsyscall\n");
	}
	
}
