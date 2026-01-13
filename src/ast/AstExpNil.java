package ast;
import types.*;
import temp.*;
import ir.*;

public class AstExpNil extends AstExp
{
    public int line;
    public AstExpNil(int line)
    {
        serialNumber = AstNodeSerialNumber.getFresh();
        System.out.print("====================== exp -> NIL\n");
        this.line = line;
    }
    public Type semantMe(){
        Type result = TypeNil.getInstance();
        this.type = result;
        return result;
    }

    public void printMe()
    {
        System.out.print("AST NODE NIL\n");
        AstGraphviz.getInstance().logNode(serialNumber, "NIL");
    }

	public Temp irMe()
	{
		// nil is represented as 0 (null pointer)
		Temp t = TempFactory.getInstance().getFreshTemp();
		Ir.getInstance().AddIrCommand(new IRcommandConstInt(t, 0));
		return t;
	}
}