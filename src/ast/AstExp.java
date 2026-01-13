package ast;
import types.*;

public abstract class AstExp extends AstNode
{
	/******************************/
	/* Store the type from semantMe() */
	/******************************/
	public Type type;
	
    public Type semantMe()
	{
		return null;
	}
}