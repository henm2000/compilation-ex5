package ast;
import temp.*;
import ir.*;

import types.*;
import symboltable.SymbolTable;
import exceptions.SemanticErrorException;
public class AstStmtWhile extends AstStmt
{
    public AstExp cond;
    public AstStmtList body;
    public int line;
    public AstStmtWhile(AstExp cond, AstStmtList body, int line)
    {
        serialNumber = AstNodeSerialNumber.getFresh();
        System.out.print("====================== stmt -> WHILE\n");

        this.cond = cond;
        this.body = body;
        this.line = line;
    }

    public void printMe()
    {
        System.out.print("AST NODE WHILE\n");
        AstGraphviz.getInstance().logNode(serialNumber, "WHILE");

        if (cond != null) {
            cond.printMe();
            AstGraphviz.getInstance().logEdge(serialNumber, cond.serialNumber);
        }

        if (body != null) {
            body.printMe();
            AstGraphviz.getInstance().logEdge(serialNumber, body.serialNumber);
        }
    }
    
    public Type semantMe()
    {
        /****************************/
        /* [0] Semant the Condition */
        /*     Must be of type int   */
        /****************************/
        if (cond == null || cond.semantMe() != TypeInt.getInstance())
        {
            throw new SemanticErrorException(line);
        }
        
        /*************************/
        /* [1] Begin While Scope */
        /*************************/
        SymbolTable.getInstance().beginScope();

        /***************************/
        /* [2] Semant Body         */
        /***************************/
        if (body != null) {
            body.semantMe();
        }

        /*****************/
        /* [3] End Scope */
        /*****************/
        SymbolTable.getInstance().endScope();

        /***************************************************/
        /* [4] Return value is irrelevant for while statement */
        /***************************************************/
        return null;		
    }

	public Temp irMe()
	{
		/*******************************/
		/* [1] Allocate 2 fresh labels */
		/*******************************/
		String labelEnd   = IrCommand.getFreshLabel("end");
		String labelStart = IrCommand.getFreshLabel("start");

		/*********************************/
		/* [2] entry label for the while */
		/*********************************/
		Ir.
				getInstance().
				AddIrCommand(new IrCommandLabel(labelStart));

		/********************/
		/* [3] cond.IRme(); */
		/********************/
		Temp condTemp = cond.irMe();

		/******************************************/
		/* [4] Jump conditionally to the loop end */
		/******************************************/
		Ir.
				getInstance().
				AddIrCommand(new IrCommandJumpIfEqToZero(condTemp,labelEnd));

		/*******************/
		/* [5] body.IRme() */
		/*******************/
		body.irMe();

		/******************************/
		/* [6] Jump to the loop entry */
		/******************************/
		Ir.
				getInstance().
				AddIrCommand(new IrCommandJumpLabel(labelStart));

		/**********************/
		/* [7] Loop end label */
		/**********************/
		Ir.
				getInstance().
				AddIrCommand(new IrCommandLabel(labelEnd));

		/*******************/
		/* [8] return null */
		/*******************/
		return null;
	}
}