import java.io.*;
import java_cup.runtime.Symbol;
import ast.*;
import ir.*;
import mips.*;
import java.util.*;
import exceptions.*;
import regalloc.*;

public class Main
{
	/*this code works on the pc*/ 
	static public void main(String argv[]) throws Exception
	{
		Lexer l;
		Parser p;
		Symbol s;
		AstProgram  ast;
		FileReader fileReader=null;
		PrintWriter fileWriter=null;
		String inputFileName = argv[0];
		String outputFileName = argv[1];
		
		try
		{
			/********************************/
			/* [1] Initialize a file reader */
			/********************************/
			fileReader = new FileReader(inputFileName);

			/********************************/
			/* [2] Initialize a file writer */
			/********************************/
			fileWriter = new PrintWriter(outputFileName);
			
			/******************************/
			/* [3] Initialize a new lexer */
			/******************************/
			l = new Lexer(fileReader);
			
			/*******************************/
			/* [4] Initialize a new parser */
			/*******************************/
			p = new Parser(l);

			/***********************************/
			/* [5] 3 ... 2 ... 1 ... Parse !!! */
			/***********************************/
			ast = (AstProgram) p.parse().value;
			
			/*************************/
			/* [6] Print the AST ... */
			/*************************/
			if (ast != null) 
			{
                // ast.printMe(); // Disabled - GraphViz output not needed
				ast.semantMe();
				/*************************/
				/* [6a] Generate IR ... */
				/*************************/
				ast.irMe();
				
				/****************************************/
				/* [6b] Perform Register Allocation ... */
				/****************************************/
				List<IrCommand> irCommands = Ir.getInstance().getAllCommands();
				RegisterAllocator allocator = new RegisterAllocator(irCommands);
				
				if (!allocator.allocate()) {
					// Register allocation failed - need spilling
					fileWriter.print("Register Allocation Failed");
					fileWriter.close();
					return;
				}
				
				/**************************************/
				/* [7] Emit MIPS Assembly Instructions */
				/**************************************/
				MipsGenerator.getInstance(outputFileName).printDotDataString();
				
				// Analyze functions to determine prologue/epilogue needs
				java.util.Map<String, mips.FunctionInfo> functionInfo = mips.FunctionInfo.analyzeFunctions(irCommands);
				MipsGenerator.getInstance(outputFileName).setFunctionInfo(functionInfo);
				
				for (IrCommand cmd : irCommands) {
					cmd.mipsMe();
				}
				
				MipsGenerator.getInstance(outputFileName).printDotTextString();			
			/****************************/
			/* [8] Finalize MIPS file  */
			/****************************/
			MipsGenerator.getInstance(outputFileName).finalizeFile();            }

			/*************************/
			/* [9] Close output file */
			/*************************/
			fileWriter.close();
			
			/*************************************/
			/* [10] Finalize AST GRAPHIZ DOT file */
			/*************************************/
			// AstGraphviz.getInstance().finalizeFile();
    	}
			     
		catch (SyntaxErrorException e)
        {
            // Syntax error: must print ERROR(line)
            try {
                if (fileWriter == null) {
                    fileWriter = new PrintWriter(outputFileName);
                }
                fileWriter.print("ERROR(" + e.getLine() + ")");
                fileWriter.flush();
            } catch (Exception ignored) {}
        }
        catch (LexicalErrorException e)
        {
            try {
                if (fileWriter == null) {
                    fileWriter = new PrintWriter(outputFileName);
                }
                fileWriter.print("ERROR"); 
                fileWriter.flush();
            } catch (Exception ignored) {}
        }

        catch (SemanticErrorException e)
        {
            try {
                if (fileWriter == null) {
                    fileWriter = new PrintWriter(outputFileName);
                }
                fileWriter.print("ERROR(" + e.getLine() + ")");
                fileWriter.flush();
            } catch (Exception ignored) {}
        }
        finally
        {
            try {
                if (fileReader != null) fileReader.close();
            } catch (IOException ignored) {}
            if (fileWriter != null) fileWriter.close();
        }
    }
}