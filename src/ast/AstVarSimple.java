package ast;
import temp.*;
import ir.*;

import types.*;
import symboltable.SymbolTable;
import exceptions.SemanticErrorException;
public class AstVarSimple extends AstVar
{
	/************************/
	/* simple variable name */
	/************************/
	public String name;
	public int line;
	/******************/
	/* CONSTRUCTOR(S) */
	/******************/
	public AstVarSimple(String name, int line)
	{
		/******************************/
		/* SET A UNIQUE SERIAL NUMBER */
		/******************************/
		serialNumber = AstNodeSerialNumber.getFresh();
	
		/***************************************/
		/* PRINT CORRESPONDING DERIVATION RULE */
		/***************************************/
		System.out.format("====================== var -> ID( %s )\n",name);

		/*******************************/
		/* COPY INPUT DATA MEMBERS ... */
		/*******************************/
		this.name = name;
		this.line = line;
	}

	/**************************************************/
	public void printMe()
	{
		/**********************************/
		/* AST NODE TYPE = AST SIMPLE VAR */
		/**********************************/
		System.out.format("AST NODE SIMPLE VAR( %s )\n",name);

		/*********************************/
		/* Print to AST GRAPHVIZ DOT file */
		/*********************************/
		AstGraphviz.getInstance().logNode(
				serialNumber,
			String.format("SIMPLE\nVAR\n(%s)",name));
	}

    public boolean isField = false;

	public Type semantMe()
	{
		/************************************************/
		/* Use class scope resolution if in a class,    */
		/* otherwise use regular scope resolution        */
		/************************************************/
		Type result = SymbolTable.getInstance().findInClassScope(name);
		if (result == null) {
			throw new SemanticErrorException(line);
		}
		
		// Determine if it is a field
        isField = false;
        TypeClass currentClass = SymbolTable.getInstance().getCurrentClass();
        if (currentClass != null) {
             // 1. Check if name is defined in class hierarchy
            TypeClass cls = currentClass;
            while (cls != null) {
                for (TypeList it = cls.dataMembers; it != null; it = it.tail) {
                    if (it.head != null && it.head.name != null && it.head.name.equals(name)) {
                        isField = true;
                        break;
                    }
                }
                if (isField) break;
                cls = cls.father;
            }
            
            // 2. Robustness check: if not found in hierarchy (maybe wrapper issue?),
            // but not found in local/global scope either, it must be a field.
            if (!isField) {
                 if (SymbolTable.getInstance().find(name) == null) {
                     isField = true;
                 }
            }
        }
		
		/*********************************************/
		
		/*********************************************/
		/* Store the type for use in irMe() */
		/*********************************************/
		this.type = result;
		
		return result;
	}

	public Temp irMe()
	{
		Temp t = TempFactory.getInstance().getFreshTemp();
        
        if (isField) {
             // It's a field access (implicit 'this')
             // 1. Load 'this'
             Temp t_this = TempFactory.getInstance().getFreshTemp();
             Ir.getInstance().AddIrCommand(new IrCommandLoad(t_this, "this"));
             
             // 2. Calculate offset
             TypeClass cls = SymbolTable.getInstance().getCurrentClass();
             int offset = 0;
             if (cls != null) {
                 offset = cls.getFieldOffset(name);
             }
             
             // 3. Load from memory
             Ir.getInstance().AddIrCommand(new IrCommandLoadMemory(t, t_this, offset));
        } else {
		     Ir.getInstance().AddIrCommand(new IrCommandLoad(t,name));
        }
		return t;
	}
}