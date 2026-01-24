/***********/
/* PACKAGE */
/***********/
package regalloc;

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
 * Performs liveness analysis on IR commands.
 * 
 * Liveness: A temp is "live" at a point if its current value will be used later.
 * 
 * Uses backward dataflow analysis:
 *   IN[n]  = USE[n] ∪ (OUT[n] - DEF[n])
 *   OUT[n] = ∪ IN[successor] for all successors
 * 
 * Simplified CFG: Every IR command is its own basic block.
 */
public class LivenessAnalyzer
{
	/******************************************/
	/* IR commands to analyze                  */
	/******************************************/
	private List<IrCommand> irCommands;
	
	/******************************************/
	/* Liveness sets for each command         */
	/******************************************/
	private Map<IrCommand, Set<Temp>> inSets;   // Temps live before command
	private Map<IrCommand, Set<Temp>> outSets;  // Temps live after command
	
	/******************************************/
	/* USE and DEF sets for each command      */
	/******************************************/
	private Map<IrCommand, Set<Temp>> useSets;  // Temps used (read) by command
	private Map<IrCommand, Set<Temp>> defSets;  // Temps defined (written) by command
	
	/******************/
	/* CONSTRUCTOR    */
	/******************/
	public LivenessAnalyzer(List<IrCommand> irCommands)
	{
		this.irCommands = irCommands;
		this.inSets = new HashMap<>();
		this.outSets = new HashMap<>();
		this.useSets = new HashMap<>();
		this.defSets = new HashMap<>();
		
		// Perform the analysis
		computeUseDefSets();
		computeLiveness();
	}
	
	/******************************************/
	/* Compute USE and DEF sets for each cmd  */
	/******************************************/
	private void computeUseDefSets()
	{
		for (IrCommand cmd : irCommands)
		{
			Set<Temp> use = new HashSet<>();
			Set<Temp> def = new HashSet<>();
			
			// Extract USE and DEF based on command type
			// USE = temps read by this command
			// DEF = temps written by this command
			
			if (cmd instanceof IrCommandBinopAddIntegers) {
				IrCommandBinopAddIntegers binop = (IrCommandBinopAddIntegers) cmd;
				if (binop.t1 != null) use.add(binop.t1);
				if (binop.t2 != null) use.add(binop.t2);
				if (binop.dst != null) def.add(binop.dst);
			}
			else if (cmd instanceof IrCommandBinopSubIntegers) {
				IrCommandBinopSubIntegers binop = (IrCommandBinopSubIntegers) cmd;
				if (binop.t1 != null) use.add(binop.t1);
				if (binop.t2 != null) use.add(binop.t2);
				if (binop.dst != null) def.add(binop.dst);
			}
			else if (cmd instanceof IrCommandBinopMulIntegers) {
				IrCommandBinopMulIntegers binop = (IrCommandBinopMulIntegers) cmd;
				if (binop.t1 != null) use.add(binop.t1);
				if (binop.t2 != null) use.add(binop.t2);
				if (binop.dst != null) def.add(binop.dst);
			}
			else if (cmd instanceof IrCommandBinopDivIntegers) {
				IrCommandBinopDivIntegers binop = (IrCommandBinopDivIntegers) cmd;
				if (binop.t1 != null) use.add(binop.t1);
				if (binop.t2 != null) use.add(binop.t2);
				if (binop.dst != null) def.add(binop.dst);
			}
			else if (cmd instanceof IrCommandBinopLtIntegers) {
				IrCommandBinopLtIntegers binop = (IrCommandBinopLtIntegers) cmd;
				if (binop.t1 != null) use.add(binop.t1);
				if (binop.t2 != null) use.add(binop.t2);
				if (binop.dst != null) def.add(binop.dst);
			}
			else if (cmd instanceof IrCommandBinopGtIntegers) {
				IrCommandBinopGtIntegers binop = (IrCommandBinopGtIntegers) cmd;
				if (binop.t1 != null) use.add(binop.t1);
				if (binop.t2 != null) use.add(binop.t2);
				if (binop.dst != null) def.add(binop.dst);
			}
			else if (cmd instanceof IrCommandBinopEqIntegers) {
				IrCommandBinopEqIntegers binop = (IrCommandBinopEqIntegers) cmd;
				if (binop.t1 != null) use.add(binop.t1);
				if (binop.t2 != null) use.add(binop.t2);
				if (binop.dst != null) def.add(binop.dst);
			}
			else if (cmd instanceof IrCommandBinopConcatStrings) {
				IrCommandBinopConcatStrings binop = (IrCommandBinopConcatStrings) cmd;
				if (binop.string1 != null) use.add(binop.string1);
				if (binop.string2 != null) use.add(binop.string2);
				if (binop.dst != null) def.add(binop.dst);
			}
			else if (cmd instanceof IrCommandBinopEqStrings) {
				IrCommandBinopEqStrings binop = (IrCommandBinopEqStrings) cmd;
				if (binop.string1 != null) use.add(binop.string1);
				if (binop.string2 != null) use.add(binop.string2);
				if (binop.dst != null) def.add(binop.dst);
			}
			else if (cmd instanceof IrCommandLoad) {
				IrCommandLoad load = (IrCommandLoad) cmd;
				// Load from variable to temp - defines the temp
				if (load.dst != null) def.add(load.dst);
			}
			else if (cmd instanceof IrCommandStore) {
				IrCommandStore store = (IrCommandStore) cmd;
				// Store from temp to variable - uses the temp
				if (store.src != null) use.add(store.src);
			}
			else if (cmd instanceof IRcommandConstInt) {
				IRcommandConstInt constCmd = (IRcommandConstInt) cmd;
				// Constant assignment - defines the temp
				if (constCmd.t != null) def.add(constCmd.t);
			}
			else if (cmd instanceof IrCommandMove) {
				IrCommandMove move = (IrCommandMove) cmd;
				// Move: dst = src
				if (move.src != null) use.add(move.src);
				if (move.dst != null) def.add(move.dst);
			}
			else if (cmd instanceof IrCommandPrintInt) {
				IrCommandPrintInt print = (IrCommandPrintInt) cmd;
				// PrintInt uses the temp
				if (print.t != null) use.add(print.t);
			}
			else if (cmd instanceof IrCommandReturn) {
				IrCommandReturn ret = (IrCommandReturn) cmd;
				// Return uses the temp (if present)
				if (ret.returnValue != null) use.add(ret.returnValue);
			}
			else if (cmd instanceof IrCommandJumpIfZero) {
				IrCommandJumpIfZero jz = (IrCommandJumpIfZero) cmd;
				// Conditional jump uses the temp
				if (jz.t != null) use.add(jz.t);
			}
			else if (cmd instanceof IrCommandJumpIfEqToZero) {
				IrCommandJumpIfEqToZero jez = (IrCommandJumpIfEqToZero) cmd;
				// Conditional jump uses the temp
				if (jez.t != null) use.add(jez.t);
			}
			else if (cmd instanceof IrCommandMalloc) {
				IrCommandMalloc malloc = (IrCommandMalloc) cmd;
				// Malloc uses size temp, defines dst temp
				if (malloc.size != null) use.add(malloc.size);
				if (malloc.dst != null) def.add(malloc.dst);
			}
			else if (cmd instanceof IrCommandLoadMemory) {
				IrCommandLoadMemory loadMem = (IrCommandLoadMemory) cmd;
				// Load from memory: uses address temp, defines dst temp
				if (loadMem.address != null) use.add(loadMem.address);
				if (loadMem.dst != null) def.add(loadMem.dst);
			}
			else if (cmd instanceof IrCommandStoreMemory) {
				IrCommandStoreMemory storeMem = (IrCommandStoreMemory) cmd;
				// Store to memory: uses address and value temps
				if (storeMem.address != null) use.add(storeMem.address);
				if (storeMem.src != null) use.add(storeMem.src);
			}
			else if (cmd instanceof IrCommandCall) {
				IrCommandCall call = (IrCommandCall) cmd;
				// Function call uses all argument temps
				if (call.args != null) {
					for (Temp arg : call.args) {
						if (arg != null) use.add(arg);
					}
				}
				// If non-void return, defines dst temp
				if (call.dst != null) def.add(call.dst);
			}
			else if (cmd instanceof IrCommandArrayLoad) {
				IrCommandArrayLoad arrLoad = (IrCommandArrayLoad) cmd;
				if (arrLoad.arrayPtr != null) use.add(arrLoad.arrayPtr);
				if (arrLoad.index != null) use.add(arrLoad.index);
				if (arrLoad.dst != null) def.add(arrLoad.dst);
			}
			else if (cmd instanceof IrCommandArrayStore) {
				IrCommandArrayStore arrStore = (IrCommandArrayStore) cmd;
				if (arrStore.arrayPtr != null) use.add(arrStore.arrayPtr);
				if (arrStore.index != null) use.add(arrStore.index);
				if (arrStore.src != null) use.add(arrStore.src);
			}
			// Labels, jumps, allocate don't use/def temps
			
			useSets.put(cmd, use);
			defSets.put(cmd, def);
		}
	}
	
	/******************************************/
	/* Compute liveness using fixed-point     */
	/******************************************/
	private void computeLiveness()
	{
		// Initialize all IN and OUT sets to empty
		for (IrCommand cmd : irCommands) {
			inSets.put(cmd, new HashSet<>());
			outSets.put(cmd, new HashSet<>());
		}
		
		// Fixed-point iteration (backward analysis)
		boolean changed = true;
		int iterations = 0;
		final int MAX_ITERATIONS = 1000;
		
		while (changed && iterations < MAX_ITERATIONS) {
			changed = false;
			iterations++;
			
			// Process commands in REVERSE order (backward analysis)
			for (int i = irCommands.size() - 1; i >= 0; i--) {
				IrCommand cmd = irCommands.get(i);
				
				// Save old sets for comparison
				Set<Temp> oldIn = new HashSet<>(inSets.get(cmd));
				Set<Temp> oldOut = new HashSet<>(outSets.get(cmd));
				
				// Compute OUT[n] = ∪ IN[successor]
				Set<Temp> newOut = new HashSet<>();
				for (IrCommand succ : getSuccessors(cmd, i)) {
					newOut.addAll(inSets.get(succ));
				}
				
				// Compute IN[n] = USE[n] ∪ (OUT[n] - DEF[n])
				Set<Temp> newIn = new HashSet<>(useSets.get(cmd));
				Set<Temp> outMinusDef = new HashSet<>(newOut);
				outMinusDef.removeAll(defSets.get(cmd));
				newIn.addAll(outMinusDef);
				
				// Update sets
				inSets.put(cmd, newIn);
				outSets.put(cmd, newOut);
				
				// Check if anything changed
				if (!newIn.equals(oldIn) || !newOut.equals(oldOut)) {
					changed = true;
				}
			}
		}
	}
	
	/******************************************/
	/* Get successors of a command             */
	/* Simple CFG: next command, or jump target*/
	/******************************************/
	private List<IrCommand> getSuccessors(IrCommand cmd, int index)
	{
		List<IrCommand> successors = new ArrayList<>();
		
		// Jump commands
		if (cmd instanceof IrCommandJump) {
			IrCommandJump jump = (IrCommandJump) cmd;
			// Find the label
			IrCommand target = findLabel(jump.labelName);
			if (target != null) successors.add(target);
		}
		else if (cmd instanceof IrCommandJumpIfZero) {
			IrCommandJumpIfZero jz = (IrCommandJumpIfZero) cmd;
			// Conditional: both fall-through and jump target
			IrCommand target = findLabel(jz.labelName);
			if (target != null) successors.add(target);
			// Fall through to next command
			if (index + 1 < irCommands.size()) {
				successors.add(irCommands.get(index + 1));
			}
		}
		else if (cmd instanceof IrCommandJumpIfEqToZero) {
			IrCommandJumpIfEqToZero jez = (IrCommandJumpIfEqToZero) cmd;
			// Conditional: both fall-through and jump target
			IrCommand target = findLabel(jez.labelName);
			if (target != null) successors.add(target);
			// Fall through to next command
			if (index + 1 < irCommands.size()) {
				successors.add(irCommands.get(index + 1));
			}
		}
		else if (cmd instanceof IrCommandReturn) {
			// Return has no successors (end of function)
		}
		else {
			// Default: fall through to next command
			if (index + 1 < irCommands.size()) {
				successors.add(irCommands.get(index + 1));
			}
		}
		
		return successors;
	}
	
	/******************************************/
	/* Find label command by label name       */
	/******************************************/
	private IrCommand findLabel(String labelName)
	{
		for (IrCommand cmd : irCommands) {
			if (cmd instanceof IrCommandLabel) {
				IrCommandLabel label = (IrCommandLabel) cmd;
				if (label.labelName != null && label.labelName.equals(labelName)) {
					return cmd;
				}
			}
		}
		return null;
	}
	
	/******************************************/
	/* Public interface                        */
	/******************************************/
	
	public Set<Temp> getDefTempsAtCommand(IrCommand cmd)
	{
		return defSets.getOrDefault(cmd, new HashSet<>());
	}
	
	public Set<Temp> getUseTempsAtCommand(IrCommand cmd)
	{
		return useSets.getOrDefault(cmd, new HashSet<>());
	}	

	/**
	 * Get temps live AFTER a command executes.
	 */
	public Set<Temp> getLiveTempsAtCommand(IrCommand cmd)
	{
		return outSets.getOrDefault(cmd, new HashSet<>());
	}
	
	public Map<IrCommand, Set<Temp>> getInSets()
	{
		return inSets;
	}
	
	public Map<IrCommand, Set<Temp>> getOutSets()
	{
		return outSets;
	}
}
