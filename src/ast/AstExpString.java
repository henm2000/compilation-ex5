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
		// For now, strings are represented as their address
		// In a full implementation, strings would be stored in data section
		// For IR generation, we'll create a temp and note the string value
		// The MIPS generator will handle string storage
		Temp t = TempFactory.getInstance().getFreshTemp();
		
		// Note: String handling in IR is simplified
		// The actual string storage will be handled in MIPS generation phase
		// For now, we can use a placeholder or store the string address
		// Since we don't have a string constant IR command, we'll use a simple approach:
		// Store 0 as placeholder (MIPS generator will replace with actual string address)
		Ir.getInstance().AddIrCommand(new IRcommandConstInt(t, 0));
		
		// TODO: In MIPS phase, strings should be stored in .data section
		// and this temp should contain the address of the string
		
		return t;
	}
}