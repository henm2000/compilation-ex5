package ast;

import types.*;
import exceptions.SemanticErrorException;
import temp.*;
import ir.*;

public class AstVarSubscript extends AstVar
{
	public AstVar var;
	public AstExp subscript;
	public int line;
	/******************/
	/* CONSTRUCTOR(S) */
	/******************/
	public AstVarSubscript(AstVar var, AstExp subscript, int line)
	{
		/******************************/
		/* SET A UNIQUE SERIAL NUMBER */
		/******************************/
		serialNumber = AstNodeSerialNumber.getFresh();

		/***************************************/
		/* PRINT CORRESPONDING DERIVATION RULE */
		/***************************************/
		System.out.print("====================== var -> var [ exp ]\n");

		/*******************************/
		/* COPY INPUT DATA MEMBERS ... */
		/*******************************/
		this.var = var;
		this.subscript = subscript;
		this.line = line;
	}

	/*****************************************************/
	/* The printing message for a subscript var AST node */
	/*****************************************************/
	public void printMe()
	{
		/*************************************/
		/* AST NODE TYPE = AST SUBSCRIPT VAR */
		/*************************************/
		System.out.print("AST NODE SUBSCRIPT VAR\n");

		/****************************************/
		/* RECURSIVELY PRINT VAR + SUBSCRIPT ... */
		/****************************************/
		if (var != null) var.printMe();
		if (subscript != null) subscript.printMe();
		
		/***************************************/
		/* PRINT Node to AST GRAPHVIZ DOT file */
		/***************************************/
		AstGraphviz.getInstance().logNode(
				serialNumber,
			"SUBSCRIPT\nVAR\n...[...]");
		
		/****************************************/
		/* PRINT Edges to AST GRAPHVIZ DOT file */
		/****************************************/
		if (var       != null) AstGraphviz.getInstance().logEdge(serialNumber,var.serialNumber);
		if (subscript != null) AstGraphviz.getInstance().logEdge(serialNumber,subscript.serialNumber);
	}
	
	public Type semantMe()
	{
		Type varType = null;
		Type subscriptType = null;
		
		/******************************/
		/* [1] Recursively semant var */
		/******************************/
		if (var != null) {
			varType = var.semantMe();
		} else {
			throw new SemanticErrorException(line);
		}
		
		/*********************************/
		/* [2] Make sure var type is an array or nil */
		/*     Nil is allowed for array types, but we can't access elements on nil */
		/*********************************/
		if (isNilType(varType)) {
			// Nil is allowed for array types, but we can't access elements on nil
			// This is a semantic error - attempting to access an array element on nil
			throw new SemanticErrorException(line);
		}
		
		if (!varType.isArray()) {
			throw new SemanticErrorException(line);
		}
		
		TypeArray arrayType = (TypeArray) varType;
		
		/******************************/
		/* [3] Semant subscript expression */
		/******************************/
		if (subscript != null) {
			subscriptType = subscript.semantMe();
		} else {
			throw new SemanticErrorException(line);
		}
		
		/*********************************/
		/* [4] Subscript must be of type int */
		/*********************************/
		if (subscriptType != TypeInt.getInstance()) {
			throw new SemanticErrorException(line);
		}
		
		/*********************************/
		/* [5] If subscript is constant, must be >= 0 */
		/*********************************/
		if (subscript instanceof AstExpInt) {
			AstExpInt intExp = (AstExpInt) subscript;
			if (intExp.value < 0) {
				throw new SemanticErrorException(line);
			}
		}
		
		/*********************************/
		/* [6] Store the type for use in irMe() */
		/*********************************/
		this.type = arrayType.elementType;
		
		return arrayType.elementType;
	}

	public Temp irMe()
	{
		// Get the array base address
		Temp t_arr = var.irMe();
		
		// Get the index value
		Temp t_index = subscript.irMe();
		
		// Calculate offset: index * 4 (each element is 4 bytes)
		Temp t_offset = TempFactory.getInstance().getFreshTemp();
		Temp t_const4 = TempFactory.getInstance().getFreshTemp();
		Ir.getInstance().AddIrCommand(new IRcommandConstInt(t_const4, 4));
		Ir.getInstance().AddIrCommand(new IrCommandBinopMulIntegers(t_offset, t_index, t_const4));
		
		// Calculate address: arr + offset
		Temp t_addr = TempFactory.getInstance().getFreshTemp();
		Ir.getInstance().AddIrCommand(new IrCommandBinopAddIntegers(t_addr, t_arr, t_offset));
		
		// Load from memory: t_result := Mem[t_addr + 0]
		Temp t_result = TempFactory.getInstance().getFreshTemp();
		Ir.getInstance().AddIrCommand(new IrCommandLoadMemory(t_result, t_addr, 0));
		
		return t_result;
	}
}
