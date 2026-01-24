/***********/
/* PACKAGE */
/***********/
package mips;

/*******************/
/* GENERAL IMPORTS */
/*******************/
import java.util.*;

/*******************/
/* PROJECT IMPORTS */
/*******************/
import ir.*;
import temp.*;

/**
 * Tracks function metadata for MIPS generation
 * - Function boundaries (start/end labels)
 * - Number of local variables
 * - Number of temporaries used
 */
public class FunctionInfo
{
	public String name;
	public int numLocalVars;
	public int numTemps;
	public int startIndex;  // Index in IR command list
	public int endIndex;    // Index in IR command list
	
	public FunctionInfo(String name)
	{
		this.name = name;
		this.numLocalVars = 0;
		this.numTemps = 0;
		this.startIndex = -1;
		this.endIndex = -1;
	}
	
	/**
	 * Analyze IR commands for a function to determine metadata
	 */
	public static Map<String, FunctionInfo> analyzeFunctions(List<IrCommand> irCommands)
	{
		Map<String, FunctionInfo> functions = new HashMap<>();
		FunctionInfo currentFunc = null;
		Set<Temp> allTemps = new HashSet<>();
		
		for (int i = 0; i < irCommands.size(); i++) {
			IrCommand cmd = irCommands.get(i);
			
			// Detect function start by label
			if (cmd instanceof IrCommandLabel) {
				IrCommandLabel label = (IrCommandLabel) cmd;
				String labelName = label.labelName;
				
				// Check if this is a function label (starts with "Label_" followed by function name)
				// or is "main" or other function entry point
				if (labelName.equals("main") || labelName.startsWith("Label_")) {
					// End previous function if any
					if (currentFunc != null) {
						currentFunc.endIndex = i - 1;
					}
					
					// Start new function
					String funcName = labelName.equals("main") ? "main" : 
					                  labelName.substring(6); // Remove "Label_" prefix
					
					// Check if it's an auto-generated loop label (e.g., Label_1_start)
					// Format: Label_DIGITS_...
					boolean isAutoLabel = labelName.matches("Label_\\d+_.*");
					
					// If it's main or NOT an auto-generated loop label, treat it as a function
					if (labelName.equals("main") || !isAutoLabel) {
						currentFunc = new FunctionInfo(labelName);
						currentFunc.startIndex = i;
						functions.put(labelName, currentFunc);
						allTemps.clear(); // Reset temp tracking for this function
					} else {
						currentFunc = null; // This is a loop label, not a function
					}
				}
			}
			
			// Track temps used in current function
			if (currentFunc != null) {
				collectTempsFromCommand(cmd, allTemps);
				currentFunc.numTemps = allTemps.size();
			}
		}
		
		// End last function
		if (currentFunc != null) {
			currentFunc.endIndex = irCommands.size() - 1;
		}
		
		return functions;
	}
	
	/**
	 * Collect all temps used by an IR command
	 */
	private static void collectTempsFromCommand(IrCommand cmd, Set<Temp> temps)
	{
		// Collect temps from various command types
		if (cmd instanceof IRcommandConstInt) {
			IRcommandConstInt ci = (IRcommandConstInt) cmd;
			if (ci.t != null) temps.add(ci.t);
		}
		else if (cmd instanceof IrCommandBinopAddIntegers) {
			IrCommandBinopAddIntegers binop = (IrCommandBinopAddIntegers) cmd;
			if (binop.t1 != null) temps.add(binop.t1);
			if (binop.t2 != null) temps.add(binop.t2);
			if (binop.dst != null) temps.add(binop.dst);
		}
		else if (cmd instanceof IrCommandBinopSubIntegers) {
			IrCommandBinopSubIntegers binop = (IrCommandBinopSubIntegers) cmd;
			if (binop.t1 != null) temps.add(binop.t1);
			if (binop.t2 != null) temps.add(binop.t2);
			if (binop.dst != null) temps.add(binop.dst);
		}
		else if (cmd instanceof IrCommandBinopMulIntegers) {
			IrCommandBinopMulIntegers binop = (IrCommandBinopMulIntegers) cmd;
			if (binop.t1 != null) temps.add(binop.t1);
			if (binop.t2 != null) temps.add(binop.t2);
			if (binop.dst != null) temps.add(binop.dst);
		}
		else if (cmd instanceof IrCommandBinopDivIntegers) {
			IrCommandBinopDivIntegers binop = (IrCommandBinopDivIntegers) cmd;
			if (binop.t1 != null) temps.add(binop.t1);
			if (binop.t2 != null) temps.add(binop.t2);
			if (binop.dst != null) temps.add(binop.dst);
		}
		else if (cmd instanceof IrCommandBinopLtIntegers) {
			IrCommandBinopLtIntegers binop = (IrCommandBinopLtIntegers) cmd;
			if (binop.t1 != null) temps.add(binop.t1);
			if (binop.t2 != null) temps.add(binop.t2);
			if (binop.dst != null) temps.add(binop.dst);
		}
		else if (cmd instanceof IrCommandBinopGtIntegers) {
			IrCommandBinopGtIntegers binop = (IrCommandBinopGtIntegers) cmd;
			if (binop.t1 != null) temps.add(binop.t1);
			if (binop.t2 != null) temps.add(binop.t2);
			if (binop.dst != null) temps.add(binop.dst);
		}
		else if (cmd instanceof IrCommandBinopEqIntegers) {
			IrCommandBinopEqIntegers binop = (IrCommandBinopEqIntegers) cmd;
			if (binop.t1 != null) temps.add(binop.t1);
			if (binop.t2 != null) temps.add(binop.t2);
			if (binop.dst != null) temps.add(binop.dst);
		}
		else if (cmd instanceof IrCommandLoad) {
			IrCommandLoad load = (IrCommandLoad) cmd;
			if (load.dst != null) temps.add(load.dst);
		}
		else if (cmd instanceof IrCommandStore) {
			IrCommandStore store = (IrCommandStore) cmd;
			if (store.src != null) temps.add(store.src);
		}
		else if (cmd instanceof IrCommandCall) {
			IrCommandCall call = (IrCommandCall) cmd;
			if (call.dst != null) temps.add(call.dst);
			if (call.args != null) {
				for (Temp arg : call.args) {
					if (arg != null) temps.add(arg);
				}
			}
		}
		else if (cmd instanceof IrCommandReturn) {
			IrCommandReturn ret = (IrCommandReturn) cmd;
			if (ret.returnValue != null) temps.add(ret.returnValue);
		}
		else if (cmd instanceof IrCommandMove) {
			IrCommandMove move = (IrCommandMove) cmd;
			if (move.src != null) temps.add(move.src);
			if (move.dst != null) temps.add(move.dst);
		}
		// Add more command types as needed
	}
}
