package ast;
import types.*;
import temp.*;
import ir.*;

import types.*;
import symboltable.SymbolTable;
import exceptions.SemanticErrorException;
public class AstStmtIf extends AstStmt
{
    public AstExp cond;
    public AstStmtList thenBody;
    public AstStmtList elseBody; // may be null
    public int line;
    public AstStmtIf(AstExp cond, AstStmtList thenBody, AstStmtList elseBody, int line)
    {
        serialNumber = AstNodeSerialNumber.getFresh();
        
        if (elseBody == null) {
            System.out.print("====================== stmt -> IF (exp) {stmtList}\n");
        } else {
            System.out.print("====================== stmt -> IF (exp) {stmtList} ELSE {stmtList}\n");
        }

        this.cond = cond;
        this.thenBody = thenBody;
        this.elseBody = elseBody;
        this.line = line;
    }

    public void printMe()
    {
        System.out.print("AST NODE IF STMT\n");

        AstGraphviz.getInstance().logNode(serialNumber, "IF");

        // print condition
        if (cond != null) {
            cond.printMe();
            AstGraphviz.getInstance().logEdge(serialNumber, cond.serialNumber);
        }

        // print 'then' body
        if (thenBody != null) {
            thenBody.printMe();
            AstGraphviz.getInstance().logEdge(serialNumber, thenBody.serialNumber);
        }

        // print 'else' body (if exists)
        if (elseBody != null) {
            elseBody.printMe();
            AstGraphviz.getInstance().logEdge(serialNumber, elseBody.serialNumber);
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
        /* [1] Begin Then Scope */
        /*************************/
        SymbolTable.getInstance().beginScope();

        /***************************/
        /* [2] Semant Then Body    */
        /***************************/
        if (thenBody != null) {
            thenBody.semantMe();
        }

        /*****************/
        /* [3] End Then Scope */
        /*****************/
        SymbolTable.getInstance().endScope();
        
        /*************************/
        /* [4] Handle Else Body  */
        /*     (if it exists)     */
        /*************************/
        if (elseBody != null) {
            /*************************/
            /* [4a] Begin Else Scope */
            /*************************/
            SymbolTable.getInstance().beginScope();

            /***************************/
            /* [4b] Semant Else Body    */
            /***************************/
            elseBody.semantMe();

            /*****************/
            /* [4c] End Else Scope */
            /*****************/
            SymbolTable.getInstance().endScope();
        }

        /***************************************************/
        /* [5] Return value is irrelevant for if statement */
        /***************************************************/
        return null;		
    }

	public Temp irMe()
	{
		// 1. Evaluate condition
		Temp t_cond = cond.irMe();
		
		// 2. Create labels
		String label_true = IrCommand.getFreshLabel("if_true");
		String label_false = IrCommand.getFreshLabel("if_false");
		String label_end = IrCommand.getFreshLabel("if_end");
		
		// 3. Jump if condition is false (zero)
		Ir.getInstance().AddIrCommand(new IrCommandJumpIfZero(t_cond, label_false));
		
		// 4. Generate "then" block
		Ir.getInstance().AddIrCommand(new IrCommandLabel(label_true));
		if (thenBody != null) {
			thenBody.irMe();
		}
		
		// 5. Jump to end (skip else)
		Ir.getInstance().AddIrCommand(new IrCommandJump(label_end));
		
		// 6. Generate "else" block (if exists)
		Ir.getInstance().AddIrCommand(new IrCommandLabel(label_false));
		if (elseBody != null) {
			elseBody.irMe();
		}
		
		// 7. End label
		Ir.getInstance().AddIrCommand(new IrCommandLabel(label_end));
		return null;
	}
}
