package ast;
import temp.*;
import ir.*;
import types.*;
import symboltable.SymbolTable;

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
		// Handle different variable types
		if (var instanceof AstVarSimple) {
			// Simple variable: x := exp
			AstVarSimple simpleVar = (AstVarSimple) var;
			
			if (simpleVar.isField) {
			    // It is a field assignment: this.x := exp
			    Temp t_this = TempFactory.getInstance().getFreshTemp();
			    Ir.getInstance().AddIrCommand(new IrCommandLoad(t_this, "this"));
			    
                // RHS evaluation
			    Temp src = exp.irMe();

			    // Calculate offset
			    int offset = 0;
			    TypeClass currentClass = SymbolTable.getInstance().getCurrentClass();
                if (currentClass != null) {
                    offset = currentClass.getFieldOffset(simpleVar.name);
                }
                
                // Store to memory
                Ir.getInstance().AddIrCommand(new IrCommandStoreMemory(t_this, offset, src));
			    
			} else {
                Temp src = exp.irMe();
    			Ir.getInstance().AddIrCommand(new IrCommandStore(simpleVar.name, src));
			}
		}
		else if (var instanceof AstVarField) {
			// Class field: obj.field := exp
			AstVarField fieldVar = (AstVarField) var;
			
			// Get the object address
			Temp t_obj = fieldVar.var.irMe();
			
            // RHS evaluation
		    Temp src = exp.irMe();

			// Get the class type to calculate offset (use stored type)
			Type varType = fieldVar.var.type;
			if (varType != null && varType.isClass()) {
				TypeClass cls = (TypeClass) varType;
				int offset = cls.getFieldOffset(fieldVar.fieldName);
				
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
			
            // RHS evaluation
		    Temp src = exp.irMe();

			// Use IrCommandArrayStore which includes bounds checking
			// Array layout: [length | elem0 | elem1 | ...]
			// This command will:
			// 1. Check array != null
			// 2. Check index >= 0
			// 3. Check index < length (loaded from offset 0)
			// 4. Store to element at offset (index+1)*4
			Ir.getInstance().AddIrCommand(new IrCommandArrayStore(t_arr, t_index, src));
		}
		return null;
	}
}