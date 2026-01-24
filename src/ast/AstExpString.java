package ast;
import types.*;
import temp.*;
import ir.*;

public class AstExpString extends AstExp
{
    public String value;
    public int line;
    public AstExpString(String value, int line)
    {
        serialNumber = AstNodeSerialNumber.getFresh();
        System.out.print("====================== exp -> STRING\n");
        this.value = value;
        this.line = line;
    }

    public void printMe()
    {
        System.out.print("AST NODE STRING EXP ( " + value + " )\n");
        AstGraphviz.getInstance().logNode(serialNumber, "STRING\\n(" + value + ")");
    }
    public Type semantMe()
    {
        Type result = TypeString.getInstance();
        this.type = result;
        return result;
    }

	public Temp irMe()
	{
		// Create a temp to hold the string address
		Temp t = TempFactory.getInstance().getFreshTemp();
		
		// Strip surrounding quotes from the string literal
		String actualValue = value;
		if (actualValue.startsWith("\"") && actualValue.endsWith("\"")) {
			actualValue = actualValue.substring(1, actualValue.length() - 1);
		}
		
		// Use IrCommandConstString to load the string address
		// This will add the string to .data section and load its address
		Ir.getInstance().AddIrCommand(new IrCommandConstString(t, actualValue));
		
		return t;
	}
}