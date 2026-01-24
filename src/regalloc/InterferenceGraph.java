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
 * Interference graph for register allocation.
 * 
 * Nodes: Temps (temporary variables from IR)
 * Edges: Two temps interfere if they are simultaneously live
 * 
 * Graph coloring: Assign colors (physical registers) such that
 * no two adjacent nodes have the same color.
 */
public class InterferenceGraph
{
	/******************************************/
	/* Adjacency list representation          */
	/* Map: temp -> set of interfering temps  */
	/******************************************/
	private Map<Temp, Set<Temp>> adjList;
	
	/******************************************/
	/* All temps in the graph                 */
	/******************************************/
	private Set<Temp> allTemps;
	
	/******************/
	/* CONSTRUCTOR    */
	/******************/
	public InterferenceGraph(List<IrCommand> irCommands, LivenessAnalyzer liveness)
	{
		this.adjList = new HashMap<>();
		this.allTemps = new HashSet<>();
		
		// Build the graph
		buildGraph(irCommands, liveness);
	}
	
	/******************************************/
	/* Build interference graph from liveness */
	/******************************************/
	private void buildGraph(List<IrCommand> irCommands, LivenessAnalyzer liveness)
	{
		// For each IR command, if multiple temps are live simultaneously,
		// they interfere with each other
		
		for (IrCommand cmd : irCommands)
		{
			// Add all defined temps to the graph
			for (Temp t : liveness.getDefTempsAtCommand(cmd)) {
				addNode(t);
			}

			// Add all used temps to the graph
			for (Temp t : liveness.getUseTempsAtCommand(cmd)) {
				addNode(t);
			}

			// Get all temps live AFTER this command
			Set<Temp> liveTemps = liveness.getLiveTempsAtCommand(cmd);
			
			// Add all temps to the graph
			for (Temp t : liveTemps) {
				addNode(t);
			}
			
			// Create interference edges between all pairs of live temps
			// If temps t1 and t2 are both live, they cannot use the same register
			List<Temp> liveList = new ArrayList<>(liveTemps);
			for (int i = 0; i < liveList.size(); i++) {
				for (int j = i + 1; j < liveList.size(); j++) {
					addEdge(liveList.get(i), liveList.get(j));
				}
			}
		}
	}
	
	/******************************************/
	/* Add a temp node to the graph           */
	/******************************************/
	public void addNode(Temp t)
	{
		if (t != null) {
			allTemps.add(t);
			if (!adjList.containsKey(t)) {
				adjList.put(t, new HashSet<>());
			}
		}
	}
	
	/******************************************/
	/* Add interference edge between two temps*/
	/* (undirected edge)                       */
	/******************************************/
	public void addEdge(Temp t1, Temp t2)
	{
		if (t1 == null || t2 == null || t1.equals(t2)) {
			return; // No self-loops
		}
		
		// Ensure both nodes exist
		addNode(t1);
		addNode(t2);
		
		// Add undirected edge
		adjList.get(t1).add(t2);
		adjList.get(t2).add(t1);
	}
	
	/******************************************/
	/* Get all neighbors (interfering temps)  */
	/******************************************/
	public Set<Temp> getNeighbors(Temp t)
	{
		return adjList.getOrDefault(t, new HashSet<>());
	}
	
	/******************************************/
	/* Get degree (number of interferences)   */
	/******************************************/
	public int getDegree(Temp t)
	{
		return getNeighbors(t).size();
	}
	
	/******************************************/
	/* Remove a node from the graph           */
	/* (used during simplification)           */
	/******************************************/
	public void removeNode(Temp t)
	{
		if (t == null || !allTemps.contains(t)) {
			return;
		}
		
		// Remove edges from all neighbors
		Set<Temp> neighbors = new HashSet<>(adjList.get(t));
		for (Temp neighbor : neighbors) {
			adjList.get(neighbor).remove(t);
		}
		
		// Remove the node
		adjList.remove(t);
		allTemps.remove(t);
	}
	
	/******************************************/
	/* Get all temps currently in the graph   */
	/******************************************/
	public Set<Temp> getAllNodes()
	{
		return new HashSet<>(allTemps);
	}
	
	/******************************************/
	/* Check if graph is empty                */
	/******************************************/
	public boolean isEmpty()
	{
		return allTemps.isEmpty();
	}
	
	/******************************************/
	/* Get number of nodes                    */
	/******************************************/
	public int size()
	{
		return allTemps.size();
	}
}
