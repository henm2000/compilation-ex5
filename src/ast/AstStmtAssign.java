package ast;
import temp.*;
import ir.*;
import types.*;

import types.*;
import exceptions.SemanticErrorException;
public class AstStmtAssign extends AstStmt
{
	/***************/
	/*  var := exp */
	/***************/
	public AstVar var;
	public AstExp exp;
	public int line;
	/*******************/
	/*  CONSTRUCTOR(S) */
	/*******************/
	public AstStmtAssign(AstVar var, AstExp exp, int line)
	{
		/******************************/
		/* SET A UNIQUE SERIAL NUMBER */
		/******************************/
		serialNumber = AstNodeSerialNumber.getFresh();

		/***************************************/
		/* PRINT CORRESPONDING DERIVATION RULE */
		/***************************************/
		System.out.print("====================== stmt -> var ASSIGN exp SEMICOLON\n");

		/*******************************/
		/* COPY INPUT DATA MEMBERS ... */
		/*******************************/
		this.var = var;
		this.exp = exp;
		this.line = line;
	}

	/*********************************************************/
	/* The printing message for an assign statement AST node */
	/*********************************************************/
	public void printMe()
	{
		/********************************************/
		/* AST NODE TYPE = AST ASSIGNMENT STATEMENT */
		/********************************************/
		System.out.print("AST NODE ASSIGN STMT\n");

		/***********************************/
		/* RECURSIVELY PRINT VAR + EXP ... */
		/***********************************/
		if (var != null) var.printMe();
		if (exp != null) exp.printMe();

		/***************************************/
		/* PRINT Node to AST GRAPHVIZ DOT file */
		/***************************************/
		AstGraphviz.getInstance().logNode(
				serialNumber,
			"ASSIGN\nleft := right\n");
		
		/****************************************/
		/* PRINT Edges to AST GRAPHVIZ DOT file */
		/****************************************/
		AstGraphviz.getInstance().logEdge(serialNumber,var.serialNumber);
		AstGraphviz.getInstance().logEdge(serialNumber,exp.serialNumber);
	}
	public Type semantMe()
	{
		Type varType = null;
		Type expType = null;
		
		/************************************************/
		/* [1] Get types of variable and expression     */
		/************************************************/
		if (var != null) varType = var.semantMe();
		if (exp != null) expType = exp.semantMe();
		
		/************************************************/
		/* [2] Check assignment compatibility           */
		/************************************************/
		if (!isAssignmentCompatible(varType, expType, exp)) {
			throw new SemanticErrorException(line);
		}
		
		/************************************************/
		/* [3] Return value is irrelevant for statements */
		/************************************************/
		return null;
	}

	/**
	 * Calculate field offset (same logic as AstVarField)
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
		for (TypeClass clazz : hierarchy) {
			if (found) break;
			
			for (TypeList it = clazz.dataMembers; it != null; it = it.tail) {
				if (it.head != null && it.head.name != null && it.head.name.equals(fieldName)) {
					if (it.head instanceof TypeClassField) {
						found = true;
						break;
					}
				}
				if (it.head instanceof TypeClassField) {
					offset += 4;
				}
			}
		}
		
		return offset;
	}

	public Temp irMe()
	{
		// Generate IR for the expression being assigned
		Temp src = exp.irMe();
		
		// Handle different variable types
		if (var instanceof AstVarSimple) {
			// Simple variable: x := exp
			AstVarSimple simpleVar = (AstVarSimple) var;
			Ir.getInstance().AddIrCommand(new IrCommandStore(simpleVar.name, src));
		}
		else if (var instanceof AstVarField) {
			// Class field: obj.field := exp
			AstVarField fieldVar = (AstVarField) var;
			
			// Get the object address
			Temp t_obj = fieldVar.var.irMe();
			
			// Get the class type to calculate offset (use stored type)
			Type varType = fieldVar.var.type;
			if (varType != null && varType.isClass()) {
				TypeClass cls = (TypeClass) varType;
				int offset = getFieldOffset(cls, fieldVar.fieldName);
				
				// Store to memory: Mem[t_obj + offset] := src
				Ir.getInstance().AddIrCommand(new IrCommandStoreMemory(t_obj, offset, src));
			}
		}
		else if (var instanceof AstVarSubscript) {
			// Array element: arr[i] := exp
			AstVarSubscript subscriptVar = (AstVarSubscript) var;
			
			// Get the array base address
			Temp t_arr = subscriptVar.var.irMe();
			
			// Get the index value
			Temp t_index = subscriptVar.subscript.irMe();
			
			// Calculate offset: index * 4
			Temp t_offset = TempFactory.getInstance().getFreshTemp();
			Temp t_const4 = TempFactory.getInstance().getFreshTemp();
			Ir.getInstance().AddIrCommand(new IRcommandConstInt(t_const4, 4));
			Ir.getInstance().AddIrCommand(new IrCommandBinopMulIntegers(t_offset, t_index, t_const4));
			
			// Calculate address: arr + offset
			Temp t_addr = TempFactory.getInstance().getFreshTemp();
			Ir.getInstance().AddIrCommand(new IrCommandBinopAddIntegers(t_addr, t_arr, t_offset));
			
			// Store to memory: Mem[t_addr + 0] := src
			Ir.getInstance().AddIrCommand(new IrCommandStoreMemory(t_addr, 0, src));
		}
		return null;
	}
}