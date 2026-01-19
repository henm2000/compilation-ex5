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
 * Simplification-based register allocator using graph coloring.
 * 
 * Algorithm:
 * 1. Build interference graph from liveness info
 * 2. Simplification: Remove nodes with degree < K, push on stack
 * 3. If all nodes have degree >= K, FAIL (no spilling)
 * 4. Coloring: Pop stack, assign colors avoiding neighbors
 * 
 * K = 10 (registers $t0 through $t9)
 */
public class RegisterAllocator
{
	/******************************************/
	/* Number of available registers          */
	/******************************************/
	private static final int K = 10;
	
	/******************************************/
	/* Available physical registers           */
	/******************************************/
	private static final String[] REGISTERS = {
		"$t0", "$t1", "$t2", "$t3", "$t4",
		"$t5", "$t6", "$t7", "$t8", "$t9"
	};
	
	/******************************************/
	/* IR commands and analysis results       */
	/******************************************/
	private List<IrCommand> irCommands;
	private LivenessAnalyzer liveness;
	private InterferenceGraph graph;
	
	/******************************************/
	/* Simplification stack                   */
	/******************************************/
	private Stack<Temp> simplificationStack;
	
	/******************/
	/* CONSTRUCTOR    */
	/******************/
	public RegisterAllocator(List<IrCommand> irCommands)
	{
		this.irCommands = irCommands;
		this.simplificationStack = new Stack<>();
	}
	
	/******************************************/
	/* Main allocation algorithm              */
	/* Returns true if successful             */
	/******************************************/
	public boolean allocate()
	{
		// Step 1: Perform liveness analysis
		liveness = new LivenessAnalyzer(irCommands);
		
		// Step 2: Build interference graph
		graph = new InterferenceGraph(irCommands, liveness);
		
		// Step 3: Simplification phase
		if (!simplify()) {
			return false; // Failed - need spilling
		}
		
		// Step 4: Coloring phase
		if (!color()) {
			return false; // Failed - couldn't color
		}
		
		return true; // Success!
	}
	
	/******************************************/
	/* Simplification phase                   */
	/* Remove nodes with degree < K           */
	/******************************************/
	private boolean simplify()
	{
		while (!graph.isEmpty())
		{
			// Find a node with degree < K
			Temp candidate = null;
			for (Temp t : graph.getAllNodes()) {
				if (graph.getDegree(t) < K) {
					candidate = t;
					break;
				}
			}
			
			// If no node with degree < K found, we fail
			if (candidate == null) {
				// All remaining nodes have degree >= K
				// This means we would need spilling, but we don't support it
				return false;
			}
			
			// Remove the node and push onto stack
			simplificationStack.push(candidate);
			graph.removeNode(candidate);
		}
		
		return true;
	}
	
	/******************************************/
	/* Coloring phase                         */
	/* Assign registers to temps              */
	/******************************************/
	private boolean color()
	{
		// Rebuild the graph (we destroyed it during simplification)
		graph = new InterferenceGraph(irCommands, liveness);
		
		// Pop temps from stack and assign colors
		while (!simplificationStack.isEmpty())
		{
			Temp t = simplificationStack.pop();
			
			// Find which colors are already used by neighbors
			Set<String> usedColors = new HashSet<>();
			for (Temp neighbor : graph.getNeighbors(t)) {
				if (neighbor.isAllocated()) {
					usedColors.add(neighbor.getPhysicalRegister());
				}
			}
			
			// Find first available color
			String assignedColor = null;
			for (String reg : REGISTERS) {
				if (!usedColors.contains(reg)) {
					assignedColor = reg;
					break;
				}
			}
			
			// If no color available, fail
			if (assignedColor == null) {
				return false;
			}
			
			// Assign the color to this temp
			t.setPhysicalRegister(assignedColor);
		}
		
		return true;
	}
}
