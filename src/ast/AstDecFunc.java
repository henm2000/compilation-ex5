package ast;
import temp.*;
import ir.*;

import java.util.List;
import types.*;
import exceptions.SemanticErrorException;
import symboltable.SymbolTable;

public class AstDecFunc extends AstDec
{
    public String returnType;
    public String name;
    public List<AstParam> params;
    public AstStmtList body;
    public int line;
    
    public AstDecFunc(String returnType, String name, List<AstParam> params, AstStmtList body, int line)
    {
        serialNumber = AstNodeSerialNumber.getFresh();
        System.out.print("====================== dec -> funcDec\n");
        this.returnType = returnType;
        this.name = name;
        this.params = params;
        this.body = body;
        this.line = line;
    }

    public void printMe()
    {
        System.out.print("AST NODE FUNC DEC ( " + returnType + " " + name + " )\n");
        AstGraphviz.getInstance().logNode(serialNumber, "FUNC\\n(" + name + ")");
        if (params != null) {
            for (AstParam p : params) {
                p.printMe();
                AstGraphviz.getInstance().logEdge(serialNumber, p.serialNumber);
            }
        }
        if (body != null) {
            body.printMe();
            AstGraphviz.getInstance().logEdge(serialNumber, body.serialNumber);
        }
    }
    
    public Type semantMe()
    {
        Type t;
        Type returnTypeObj = null;
        TypeList type_list = null;

        /*******************/
        /* [0] Check if function name is a reserved keyword */
        /*******************/
        if (SymbolTable.getInstance().isReservedKeyword(name)) {
            throw new SemanticErrorException(line);
        }
        
        /*******************/
        /* [0a] Check return type exists */
        /*     Must be a type definition, not a variable */
        /*******************/
        returnTypeObj = SymbolTable.getInstance().findTypeDefinition(this.returnType);
        if (returnTypeObj == null)
        {
            throw new SemanticErrorException(line);
        }
    
        /****************************/
        /* [1] Begin Function Scope */
        /****************************/
        SymbolTable.getInstance().beginScope();

        /***************************/
        /* [2] Semant Input Params */
        /***************************/
        if (params != null) {
            for (int i = params.size() - 1; i >= 0; i--)
            {
                AstParam param = params.get(i);
                
                /************************************************/
                /* [2a] Check if parameter name is a reserved keyword */
                /************************************************/
                if (SymbolTable.getInstance().isReservedKeyword(param.id)) {
                    throw new SemanticErrorException(line);
                }
                
                /**************************************/
                /* [2b] Check That Name does NOT exist */
                /**************************************/
                if (SymbolTable.getInstance().findInCurrentScope(param.id) != null)
                {
                    throw new SemanticErrorException(line);
                }
                
                t = SymbolTable.getInstance().findTypeDefinition(param.typeName);
                if (t == null)
                {
                    throw new SemanticErrorException(line);
                }
                
                /************************************************/
                /* [2c] Check that parameter type is not void    */
                /************************************************/
                if (t == TypeVoid.getInstance() || param.typeName.equals("void"))
                {
                    throw new SemanticErrorException(line);
                }
                
                type_list = new TypeList(t, type_list);
                SymbolTable.getInstance().enter(param.id, t);
            }
        }

        TypeFunction funcType = new TypeFunction(returnTypeObj, name, type_list);
        SymbolTable.getInstance().enter(name, funcType);

        /*******************/
        /* [3] Set return type for return statement validation */
        /*******************/
        SymbolTable.getInstance().setReturnType(returnTypeObj);

        /*******************/
        /* [4] Semant Body */
        /*******************/
        if (body != null) {
            body.semantMe();
        }

        /*******************/
        /* [5] Clear return type */
        /*******************/
        SymbolTable.getInstance().clearReturnType();

        /*****************/
        /* [6] End Scope */
        /*****************/
        SymbolTable.getInstance().endScope();

        /***************************************************/
        /* [7] Enter the Function Type to the Symbol Table */
        /***************************************************/
        SymbolTable.getInstance().enter(name, funcType);

        /************************************************************/
        /* [8] Return value is irrelevant for function declarations */
        /************************************************************/
        return null;		
    }
    
    /**
     * Create the function signature and enter it into the symbol table
     * WITHOUT semanticizing the body. This allows all method signatures 
     * to be available before any method body is processed.
     * Returns the TypeFunction that was created.
     */
    public TypeFunction createSignature()
    {
        Type t;
        Type returnTypeObj = null;
        TypeList type_list = null;

        /*******************/
        /* [0] Check if function name is a reserved keyword */
        /*******************/
        if (SymbolTable.getInstance().isReservedKeyword(name)) {
            throw new SemanticErrorException(line);
        }
        
        /*******************/
        /* [0a] Check return type exists */
        /*     Must be a type definition, not a variable */
        /*******************/
        returnTypeObj = SymbolTable.getInstance().findTypeDefinition(this.returnType);
        if (returnTypeObj == null)
        {
            throw new SemanticErrorException(line);
        }
    
        /****************************/
        /* [1] Begin Function Scope (temporarily) */
        /****************************/
        SymbolTable.getInstance().beginScope();

        /***************************/
        /* [2] Process Input Params to build TypeList */
        /***************************/
        if (params != null) {
            for (int i = params.size() - 1; i >= 0; i--)
            {
                AstParam param = params.get(i);
                
                /************************************************/
                /* [2a] Check if parameter name is a reserved keyword */
                /************************************************/
                if (SymbolTable.getInstance().isReservedKeyword(param.id)) {
                    throw new SemanticErrorException(line);
                }
                
                /**************************************/
                /* [2b] Check That Name does NOT exist */
                /**************************************/
                if (SymbolTable.getInstance().findInCurrentScope(param.id) != null)
                {
                    throw new SemanticErrorException(line);
                }
                
                t = SymbolTable.getInstance().findTypeDefinition(param.typeName);
                if (t == null)
                {
                    throw new SemanticErrorException(line);
                }
                
                /************************************************/
                /* [2c] Check that parameter type is not void    */
                /************************************************/
                if (t == TypeVoid.getInstance() || param.typeName.equals("void"))
                {
                    throw new SemanticErrorException(line);
                }
                
                type_list = new TypeList(t, type_list);
            }
        }

        /*****************/
        /* [3] End temporary scope */
        /*****************/
        SymbolTable.getInstance().endScope();

        /****************************/
        /* [4] Create function type */
        /****************************/
        TypeFunction funcType = new TypeFunction(returnTypeObj, name, type_list);

        /***************************************************/
        /* [5] Enter the Function Type to the Symbol Table */
        /***************************************************/
        SymbolTable.getInstance().enter(name, funcType);

        return funcType;
    }
    
    /**
     * Semanticize only the body of the function.
     * Assumes the signature has already been created via createSignature().
     */
    public void semanticizeBody()
    {
        Type t;
        Type returnTypeObj = null;
        TypeList type_list = null;
        
        // Get the existing function type from symbol table
        TypeFunction funcType = (TypeFunction) SymbolTable.getInstance().find(name);
        if (funcType == null) {
            throw new SemanticErrorException(line);
        }
        
        returnTypeObj = funcType.returnType;
        
        /****************************/
        /* [1] Begin Function Scope */
        /****************************/
        SymbolTable.getInstance().beginScope();

        /***************************/
        /* [2] Semant Input Params and enter them in scope */
        /***************************/
        if (params != null) {
            for (int i = params.size() - 1; i >= 0; i--)
            {
                AstParam param = params.get(i);
                
                t = SymbolTable.getInstance().findTypeDefinition(param.typeName);
                if (t == null)
                {
                    throw new SemanticErrorException(line);
                }
                
                SymbolTable.getInstance().enter(param.id, t);
            }
        }

        // Enter function name in its own scope for recursion
        SymbolTable.getInstance().enter(name, funcType);

        /*******************/
        /* [3] Set return type for return statement validation */
        /*******************/
        SymbolTable.getInstance().setReturnType(returnTypeObj);

        /*******************/
        /* [4] Semant Body */
        /*******************/
        if (body != null) {
            body.semantMe();
        }

        /*******************/
        /* [5] Clear return type */
        /*******************/
        SymbolTable.getInstance().clearReturnType();

        /*****************/
        /* [6] End Scope */
        /*****************/
        SymbolTable.getInstance().endScope();
    }

	public Temp irMe()
	{
		// Use actual function name instead of hardcoded "main"
		String funcLabel = "Label_" + name;
		Ir.getInstance().AddIrCommand(new IrCommandLabel(funcLabel));
		if (body != null) body.irMe();

		return null;
	}
}