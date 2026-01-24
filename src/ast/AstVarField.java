package ast;

import types.*;
import exceptions.SemanticErrorException;
import temp.*;
import ir.*;

public class AstVarField extends AstVar
{
	public AstVar var; 
	public String fieldName;
	public int line;
	/******************/
	/* CONSTRUCTOR(S) */
	/******************/
	public AstVarField(AstVar var, String fieldName, int line)
	{
		/******************************/
		/* SET A UNIQUE SERIAL NUMBER */
		/******************************/
		serialNumber = AstNodeSerialNumber.getFresh();

		/***************************************/
		/* PRINT CORRESPONDING DERIVATION RULE */
		/***************************************/
		System.out.format("====================== var -> var DOT ID( %s )\n",fieldName);

		/*******************************/
		/* COPY INPUT DATA MEMBERS ... */
		/*******************************/
		this.var = var;
		this.fieldName = fieldName;
		this.line = line;
	}

	/*************************************************/
	/* The printing message for a field var AST node */
	/*************************************************/
	public void printMe()
	{
		/*********************************/
		/* AST NODE TYPE = AST FIELD VAR */
		/*********************************/
		System.out.print("AST NODE FIELD VAR\n");

		/**********************************************/
		/* RECURSIVELY PRINT VAR, then FIELD NAME ... */
		/**********************************************/
		if (var != null) var.printMe();
		System.out.format("FIELD NAME( %s )\n",fieldName);

		/***************************************/
		/* PRINT Node to AST GRAPHVIZ DOT file */
		/***************************************/
		AstGraphviz.getInstance().logNode(
				serialNumber,
			String.format("FIELD\nVAR\n...->%s",fieldName));
		
		/****************************************/
		/* PRINT Edges to AST GRAPHVIZ DOT file */
		/****************************************/
		if (var != null) AstGraphviz.getInstance().logEdge(serialNumber,var.serialNumber);
	}
	public Type semantMe()
	{
		Type t = null;
		TypeClass tc = null;
		
		/******************************/
		/* [1] Recursively semant var */
		/******************************/
		if (var != null) t = var.semantMe();
		
		/*********************************/
		/* [2] Make sure type is a class */
		/*********************************/
		if (isNilType(t)) {
			throw new SemanticErrorException(line);
		}
		
		if (t.isClass() == false)
		{
			throw new SemanticErrorException(line);
		}
		else
		{
			tc = (TypeClass) t;
		}
		
		/************************************/
		/* [3] Look for fieldName in class hierarchy */
		/************************************/
		TypeClass current = tc;
		Type fieldType = null;
		
		while (current != null) {
			for (TypeList it = current.dataMembers; it != null; it = it.tail)
			{
				if (it.head != null && it.head.name != null && it.head.name.equals(fieldName))
				{
					// If it's a TypeClassField, return the actual field type
					if (it.head instanceof TypeClassField) {
						fieldType = ((TypeClassField) it.head).getFieldType();
						break;
					}
					// If it's a method, that's an error (can't access method as field)
					if (it.head instanceof TypeFunction) {
						throw new SemanticErrorException(line);
					}
					fieldType = it.head;
					break;
				}
			}
			
			if (fieldType != null) break;
			current = current.father;
		}
		
		/*********************************************/
		/* [4] fieldName does not exist in class hierarchy */
		/*********************************************/
		if (fieldType == null) {
			throw new SemanticErrorException(line);
		}
		
		/*********************************************/
		/* [5] Store the type for use in irMe() */
		/*********************************************/
		this.type = fieldType;
		
		return fieldType;
	}

	/**
	 * Calculate the offset of a field in a class hierarchy
	 * Fields are 4 bytes each, laid out sequentially
	 * Superclass fields come first, then subclass fields
	 */
	private int getFieldOffset(TypeClass cls, String fieldName)
	{
		int offset = 0;
		boolean found = false;
		
		// Build the class hierarchy chain from root to cls
		java.util.List<TypeClass> hierarchy = new java.util.ArrayList<TypeClass>();
		TypeClass current = cls;
		while (current != null) {
			hierarchy.add(0, current); // Add at beginning to get root first
			current = current.father;
		}
		
		// Traverse hierarchy from root to cls, counting fields
		for (TypeClass class_ : hierarchy) {
			if (found) break;
			
			for (TypeList it = class_.dataMembers; it != null; it = it.tail) {
				if (it.head != null && it.head.name != null && it.head.name.equals(fieldName)) {
					if (it.head instanceof TypeClassField) {
						found = true;
						break; // Found it, offset is already calculated
					}
				}
				// Count fields before the target field
				if (it.head instanceof TypeClassField) {
					offset += 4; // Each field is 4 bytes
				}
			}
		}
		
		return offset;
	}

	public Temp irMe()
	{
		Temp t = var.irMe();
		
		// Calculate offset of the field
		// We need the type class of the variable holding the field
		if (var.type == null || !var.type.isClass()) {
			return null; // Should not happen after semantic analysis
		}
		
		// Use TypeClass.getFieldOffset which correctly handles hierarchy and sizes
		int offset = ((TypeClass)var.type).getFieldOffset(fieldName);
		
		// Create result temp
		Temp t_result = TempFactory.getInstance().getFreshTemp();
		
		// Load from memory: t_result = Mem[t + offset]
		Ir.getInstance().AddIrCommand(new IrCommandLoadMemory(t_result, t, offset));
		
		return t_result;
	}
}
