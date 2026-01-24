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
		PrintWriter fileWriter=null;  // Only used for error output
		String inputFileName = argv[0];
		String outputFileName = argv[1];
		
		try
		{
			/********************************/
			/* [1] Initialize a file reader */
			/********************************/
			fileReader = new FileReader(inputFileName);

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
					try {
						fileWriter = new PrintWriter(outputFileName);
						fileWriter.print("Register Allocation Failed");
						fileWriter.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
					return;
				}
				
				/**************************************/
				/* [7] Emit MIPS Assembly Instructions */
				/**************************************/
				// Start .data section with error messages
				MipsGenerator.getInstance(outputFileName).printDotDataString();
				
				// Analyze functions to determine prologue/epilogue needs
				java.util.Map<String, mips.FunctionInfo> functionInfo = mips.FunctionInfo.analyzeFunctions(irCommands);
				MipsGenerator.getInstance(outputFileName).setFunctionInfo(functionInfo);
				
				// Execute IR commands 
				// Global allocations and string constants will add to .data
				// When main label is reached, label() will:
				//   1. Call finalizeDataSection() to print strings/globals
				//   2. Print .text
				//   3. Execute initialization code (la for strings, sw for globals)
				//   4. Print main:
				// Then rest of code will write to .text section
				for (IrCommand cmd : irCommands) {
					cmd.mipsMe();
				}
				
			/****************************/
			/* [8] Finalize MIPS file  */
			/****************************/
			MipsGenerator.getInstance(outputFileName).finalizeFile();            }

			// No need to close fileWriter - MipsGenerator handles its own file
			
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