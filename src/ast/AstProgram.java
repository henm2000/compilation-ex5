package ast;
import types.*;
import temp.*;
import ir.*;

import java.util.List;

public class AstProgram extends AstNode
{
    public List<AstDec> decls;
    public int line;
    public AstProgram(List<AstDec> decls, int line)
    {
        serialNumber = AstNodeSerialNumber.getFresh();
        System.out.print("====================== program -> dec {dec}\n");
        this.decls = decls;
        this.line = line;
    }
    public Type semantMe(){
        for (AstDec d : decls) {
            d.semantMe();
        }
        return null;
    }
    public void printMe()
    {
        System.out.print("AST NODE PROGRAM\n");
        AstGraphviz.getInstance().logNode(serialNumber, "PROGRAM");
        if (decls != null) {
            for (AstDec d : decls) {
                if (d != null) {
                    d.printMe();
                    AstGraphviz.getInstance().logEdge(serialNumber, d.serialNumber);
                }
            }
        }
    }

	public Temp irMe()
	{
		// According to spec: global variable initializations must happen BEFORE main
		// So we need to:
		// 1. Process all global variable declarations first
		// 2. Then process all functions
		
		if (decls != null) {
			// First pass: Generate IR for global variables
			// This ensures all global initializers execute before main
			for (AstDec d : decls) {
				if (d != null && d instanceof AstDecVar) {
					d.irMe();
				}
			}
			
			// Second pass: Generate IR for functions and classes
			for (AstDec d : decls) {
				if (d != null) {
					if (d instanceof AstDecFunc) {
						d.irMe();
					} else if (d instanceof AstDecClass) {
						d.irMe();
					}
				}
			}
		}
		return null;
	}
}