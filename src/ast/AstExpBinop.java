package ast;
import temp.*;
import ir.*;
import types.*;
import exceptions.SemanticErrorException;

public class AstExpBinop extends AstExp
{
    int op;
    public AstExp left;
    public AstExp right;    
    public int line;
    /******************/
    /* CONSTRUCTOR(S) */
    /******************/
    public AstExpBinop(AstExp left, AstExp right, int op, int line)
    {
        /******************************/
        /* SET A UNIQUE SERIAL NUMBER */
        /******************************/
        serialNumber = AstNodeSerialNumber.getFresh();

        /***************************************/
        /* PRINT CORRESPONDING DERIVATION RULE */
        /***************************************/
        System.out.print("====================== exp -> exp BINOP exp\n");

        /*******************************/
        /* COPY INPUT DATA MEMBERS ... */
        /*******************************/
        this.left = left;
        this.right = right;
        this.op = op;
        this.line = line;
    }
    
    /*************************************************/
    /* The printing message for a binop exp AST node */
    /*************************************************/
    public void printMe()
    {
        String sop="";
        
        /*********************************/
        /* CONVERT op to a printable sop */
        /*********************************/
        /* Mapping used in CUP actions:
         * 0 -> PLUS
         * 1 -> MINUS
         * 2 -> TIMES
         * 3 -> DIVIDE
         * 4 -> LT
         * 5 -> GT
         * 6 -> EQ
         */
        if (op == 0) { sop = "+"; }
        else if (op == 1) { sop = "-"; }
        else if (op == 2) { sop = "*"; }
        else if (op == 3) { sop = "/"; }
        else if (op == 4) { sop = "<"; }
        else if (op == 5) { sop = ">"; }
        else if (op == 6) { sop = "="; }
        else { sop = "?"; }
        
        /*************************************/
        /* AST NODE TYPE = AST BINOP EXP */
        /*************************************/
        System.out.print("AST NODE BINOP EXP ( " + sop + " )\n");

        /**************************************/
        /* RECURSIVELY PRINT left + right ... */
        /**************************************/
        if (left != null) left.printMe();
        if (right != null) right.printMe();
        
        /**************************************/
        /* PRINT to AST GRAPHVIZ DOT file */
        /**************************************/
        // the helper AstGraphviz is assumed to exist in the project
        AstGraphviz.getInstance().logNode(
            serialNumber,
            "BINOP\\n(" + sop + ")"
        );
        
        /* print edges to children */
        if (left != null)
            AstGraphviz.getInstance().logEdge(serialNumber, left.serialNumber);
        if (right != null)
            AstGraphviz.getInstance().logEdge(serialNumber, right.serialNumber);
    }
    public Type semantMe()
    {
    /* Mapping used in CUP actions:
         * 0 -> PLUS
         * 1 -> MINUS
         * 2 -> TIMES
         * 3 -> DIVIDE
         * 4 -> LT
         * 5 -> GT
         * 6 -> EQ
         */
        Type t1 = null;
        Type t2 = null;
        
        if (left  != null) t1 = left.semantMe();
        if (right != null) t2 = right.semantMe();
        
        // Handle equality operator (=)
        if (this.op == 6) {
            if (areTypesComparableForEquality(t1, t2)) {
                this.type = TypeInt.getInstance(); // Equality returns int
                return this.type;
            } else {
                throw new SemanticErrorException(this.line);
            }
        }
        
        // Handle PLUS operator (+)
        if (this.op == 0) {
            // String concatenation
            if (t1 == TypeString.getInstance() && t2 == TypeString.getInstance()) {
                this.type = TypeString.getInstance();
                return this.type;
            }
            // Integer addition
            if (t1 == TypeInt.getInstance() && t2 == TypeInt.getInstance()) {
                this.type = TypeInt.getInstance();
                return this.type;
            }
            throw new SemanticErrorException(this.line);
        }
        
        // Handle MINUS, TIMES, DIVIDE, LT, GT (only for integers)
        if (this.op >= 1 && this.op <= 5) {
            if (t1 == TypeInt.getInstance() && t2 == TypeInt.getInstance()) {
                // Check division by zero for constant expressions
                if (this.op == 3) { // DIVIDE
                    checkDivisionByZero(right);
                }
                this.type = TypeInt.getInstance();
                return this.type;
            }
            throw new SemanticErrorException(this.line);
        }
        
        throw new SemanticErrorException(this.line);
    }

    private boolean areTypesComparableForEquality(Type t1, Type t2) {
        boolean t1IsNil = isNilType(t1);
        boolean t2IsNil = isNilType(t2);
        
        if (t1IsNil && t2IsNil) {
            return false;
        }
        
        if (t1IsNil) {
            return t2.isArray() || t2.isClass();
        }
        if (t2IsNil) {
            return t1.isArray() || t1.isClass();
        }
        
        if (t1 == TypeInt.getInstance() || t1 == TypeString.getInstance()) {
            return t1 == t2;
        }
        
        if (t1.isArray() && t2.isArray()) {
            TypeArray arr1 = (TypeArray) t1;
            TypeArray arr2 = (TypeArray) t2;
            return arr1.name.equals(arr2.name);
        }
        
        if (t1.isClass() && t2.isClass()) {
            TypeClass c1 = (TypeClass) t1;
            TypeClass c2 = (TypeClass) t2;
            return areClassesComparable(c1, c2);
        }
        
        return false;
    }

    private boolean areClassesComparable(TypeClass c1, TypeClass c2) {
        if (c1.name.equals(c2.name)) {
            return true;
        }
        
        TypeClass current = c1.father;
        while (current != null) {
            if (current.name.equals(c2.name)) {
                return true;
            }
            current = current.father;
        }
        
        current = c2.father;
        while (current != null) {
            if (current.name.equals(c1.name)) {
                return true;
            }
            current = current.father;
        }
        
        return false;
    }

    private void checkDivisionByZero(AstExp divisor) {
        if (divisor instanceof AstExpInt) {
            AstExpInt intExp = (AstExpInt) divisor;
            if (intExp.value == 0) {
                throw new SemanticErrorException(this.line);
            }
        }
    }   

	public Temp irMe()
	{
		Temp t1 = null;
		Temp t2 = null;
		Temp dst = TempFactory.getInstance().getFreshTemp();

		if (left  != null) t1 = left.irMe();
		if (right != null) t2 = right.irMe();

		/* Operator mapping from CUP_FILE.cup:
		 * 0 -> PLUS
		 * 1 -> MINUS
		 * 2 -> TIMES
		 * 3 -> DIVIDE
		 * 4 -> LT
		 * 5 -> GT
		 * 6 -> EQ
		 */
		
		if (op == 0)  // PLUS
		{
			// Check result type to distinguish string concat from int add
			if (this.type == TypeString.getInstance()) {
				Ir.getInstance().AddIrCommand(new IrCommandBinopConcatStrings(dst,t1,t2));
			} else {
				// Integer addition
				Ir.getInstance().AddIrCommand(new IrCommandBinopAddIntegers(dst,t1,t2));
			}
		}
		else if (op == 1)  // MINUS
		{
			Ir.getInstance().AddIrCommand(new IrCommandBinopSubIntegers(dst,t1,t2));
		}
		else if (op == 2)  // TIMES
		{
			Ir.getInstance().AddIrCommand(new IrCommandBinopMulIntegers(dst,t1,t2));
		}
		else if (op == 3)  // DIVIDE
		{
			Ir.getInstance().AddIrCommand(new IrCommandBinopDivIntegers(dst,t1,t2));
		}
		else if (op == 4)  // LT
		{
			Ir.getInstance().AddIrCommand(new IrCommandBinopLtIntegers(dst,t1,t2));
		}
		else if (op == 5)  // GT
		{
			Ir.getInstance().AddIrCommand(new IrCommandBinopGtIntegers(dst,t1,t2));
		}
		else if (op == 6)  // EQ
		{
			// Check operand types to distinguish string equality from int/pointer equality
			Type leftType = (left != null) ? left.type : null;
			if (leftType == TypeString.getInstance()) {
				Ir.getInstance().AddIrCommand(new IrCommandBinopEqStrings(dst,t1,t2));
			} else {
				// Integer/pointer equality
				Ir.getInstance().AddIrCommand(new IrCommandBinopEqIntegers(dst,t1,t2));
			}
		}
		
		return dst;
	}
}