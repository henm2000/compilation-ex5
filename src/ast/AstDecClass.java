package ast;
import ir.*;
import temp.*;
import java.util.List;
import java.util.HashMap;
import types.*;
import symboltable.SymbolTable;
import exceptions.SemanticErrorException;

public class AstDecClass extends AstDec
{
    public String name;
    public String extendsName; // may be null
    public List<AstDec> fields;
    public int line;

    public AstDecClass(String name, String extendsName, List<AstDec> fields, int line)
    {
        serialNumber = AstNodeSerialNumber.getFresh();
        System.out.print("====================== dec -> classDec\n");
        this.name = name;
        this.extendsName = extendsName;
        this.fields = fields;
        this.line = line;
    }

    public void printMe()
    {
        System.out.print("AST NODE CLASS DEC ( " + name + " )\n");
        AstGraphviz.getInstance().logNode(serialNumber, "CLASS\\n(" + name + ")");
        if (fields != null) {
            for (AstDec f : fields) {
                f.printMe();
                AstGraphviz.getInstance().logEdge(serialNumber, f.serialNumber);
            }
        }
    }
    
    public Type semantMe()
    {	
        /************************************************/
        /* [0] Check that we're in global scope         */
        /*     Classes can only be defined in global scope */
        /************************************************/
        if (!SymbolTable.getInstance().isInGlobalScope()) {
            throw new SemanticErrorException(line);
        }
        
        /************************************************/
        /* [1] Check if class name is a reserved keyword */
        /************************************************/
        if (SymbolTable.getInstance().isReservedKeyword(name)) {
            throw new SemanticErrorException(line);
        }
        
        /************************************************/
        /* [1a] Check if class name already exists       */
        /************************************************/
        if (SymbolTable.getInstance().find(name) != null) {
            throw new SemanticErrorException(line);
        }
        
        /************************************************/
        /* [2] Check if superclass exists and get it    */
        /*     Must be a type definition, not a variable */
        /************************************************/
        TypeClass superClass = null;
        if (extendsName != null) {
            Type superType = SymbolTable.getInstance().findTypeDefinition(extendsName);
            if (superType == null || !superType.isClass()) {
                throw new SemanticErrorException(line);
            }
            superClass = (TypeClass) superType;
            
            // Check for circular inheritance
            TypeClass current = superClass;
            while (current != null) {
                if (current.name.equals(name)) {
                    throw new SemanticErrorException(line);
                }
                current = current.father;
            }
        }
        
        /************************************************/
        /* [3] Create TypeClass and enter in global    */
        /*     scope so it's available everywhere      */
        /************************************************/
        TypeClass t = new TypeClass(superClass, name, null);
        SymbolTable.getInstance().enter(name, t);
        
        /*************************/
        /* [3a] Begin Class Scope */
        /*************************/
        SymbolTable.getInstance().beginScope();
        SymbolTable.getInstance().setCurrentClass(t);

        /************************************************/
        /* [4] Process fields/methods in TWO PASSES    */
        /*     Pass 1: Collect field types and method signatures */
        /*     Pass 2: Semanticize method bodies        */
        /************************************************/
        TypeList dataMembers = null;
        HashMap<String, Type> definedMembers = new HashMap<>();
        java.util.ArrayList<Type> memberTypesList = new java.util.ArrayList<>();
        java.util.ArrayList<AstDecFunc> methodsToProcess = new java.util.ArrayList<>();
        
        // Collect all member names from superclass for shadowing check
        HashMap<String, Type> superMembers = new HashMap<>();
        if (superClass != null) {
            TypeClass current = superClass;
            while (current != null) {
                for (TypeList it = current.dataMembers; it != null; it = it.tail) {
                    if (it.head != null && it.head.name != null) {
                        superMembers.put(it.head.name, it.head);
                    }
                }
                current = current.father;
            }
        }
        
        // PASS 1: Process fields and create method signatures (but don't process method bodies)
        for (AstDec field : fields) {
            if (field instanceof AstDecVar) {
                AstDecVar varDec = (AstDecVar) field;
                String memberName = varDec.id;
                
                // Check shadowing: field cannot shadow field or method in superclass
                if (superMembers.containsKey(memberName)) {
                    throw new SemanticErrorException(varDec.line);
                }
                
                // Check shadowing: field cannot shadow field or method already defined in this class
                if (definedMembers.containsKey(memberName)) {
                    throw new SemanticErrorException(varDec.line);
                }
                
                // Semant the variable declaration
                field.semantMe();
                
                // Get the declared type
                Type baseType = SymbolTable.getInstance().findTypeDefinition(varDec.typeName);
                if (baseType == null) {
                    throw new SemanticErrorException(line);
                }
                
                // Add to defined members
                definedMembers.put(memberName, baseType);
                
                // Wrap field in TypeClassField and add to list
                Type typeToAdd = new TypeClassField(memberName, baseType);
                memberTypesList.add(typeToAdd);
                
            } else if (field instanceof AstDecFunc) {
                AstDecFunc funcDec = (AstDecFunc) field;
                String memberName = funcDec.name;
                
                // Check shadowing: method cannot shadow field in superclass or this class
                if (superMembers.containsKey(memberName)) {
                    Type existing = superMembers.get(memberName);
                    // If it's a field (not a function), shadowing is illegal
                    if (!(existing instanceof TypeFunction)) {
                        throw new SemanticErrorException(funcDec.line);
                    }
                }
                
                // Check for method overloading in this class
                if (definedMembers.containsKey(memberName)) {
                    Type existing = definedMembers.get(memberName);
                    if (existing instanceof TypeFunction) {
                        // Method overloading is illegal
                        throw new SemanticErrorException(funcDec.line);
                    } else {
                        // Method shadowing field is illegal
                        throw new SemanticErrorException(funcDec.line);
                    }
                }
                
                // Create just the signature (without processing body)
                TypeFunction funcType = funcDec.createSignature();
                
                // Check method overriding: if method exists in superclass, signatures must match
                if (superMembers.containsKey(memberName)) {
                    Type existing = superMembers.get(memberName);
                    if (existing instanceof TypeFunction) {
                        TypeFunction superFunc = (TypeFunction) existing;
                        
                        // Check return type matches
                        if ((funcType.returnType == null && superFunc.returnType != null) ||
                            (funcType.returnType != null && superFunc.returnType == null) ||
                            (funcType.returnType != null && superFunc.returnType != null &&
                             !funcType.returnType.name.equals(superFunc.returnType.name))) {
                            throw new SemanticErrorException(funcDec.line);
                        }
                        
                        // Check parameter types match exactly
                        TypeList newParams = funcType.params;
                        TypeList superParams = superFunc.params;
                        
                        if (newParams == null && superParams == null) {
                            // Both have no parameters, OK
                        } else if (newParams == null || superParams == null) {
                            throw new SemanticErrorException(funcDec.line);
                        } else {
                            while (newParams != null && superParams != null) {
                                if (newParams.head == null || superParams.head == null ||
                                    !newParams.head.name.equals(superParams.head.name)) {
                                    throw new SemanticErrorException(funcDec.line);
                                }
                                newParams = newParams.tail;
                                superParams = superParams.tail;
                            }
                            if (newParams != null || superParams != null) {
                                throw new SemanticErrorException(funcDec.line);
                            }
                        }
                    }
                }
                
                // Add to defined members and collect type
                definedMembers.put(memberName, funcType);
                memberTypesList.add(funcType);
                
                // Save for Pass 2
                methodsToProcess.add(funcDec);
            }
        }
        
        // Build TypeList with all fields and method signatures
        dataMembers = null;
        for (int i = memberTypesList.size() - 1; i >= 0; i--) {
            dataMembers = new TypeList(memberTypesList.get(i), dataMembers);
        }
        t.dataMembers = dataMembers;
        
        // PASS 2: Now semanticize method bodies (all fields and method signatures are available)
        for (AstDecFunc method : methodsToProcess) {
            method.semanticizeBody();
        }

        /*****************/
        /* [6] Clear current class */
        /*****************/
        SymbolTable.getInstance().clearCurrentClass();

        /*****************/
        /* [7] End Scope */
        /*****************/
        SymbolTable.getInstance().endScope();

        /*********************************************************/
        /* [8] Class already entered earlier for self-reference */
        /* [9] Return value is irrelevant for class declarations */
        /*********************************************************/
        return null;		
    }

    public Temp irMe()
    {
        // Get the class type to access member information
        Type t = SymbolTable.getInstance().findTypeDefinition(name);
        TypeClass typeClass = null;
        if (t instanceof TypeClass) {
            typeClass = (TypeClass) t;
        }
        
        // Set current class for method generation
        SymbolTable.getInstance().setCurrentClass(typeClass);

        if (fields != null) {
            for (AstDec f : fields) {
                if (f instanceof AstDecFunc) {
                    AstDecFunc func = (AstDecFunc) f;
                    
                    // We need to ensure AstDecFunc.irMe can find the return type in the SymbolTable
                    // The function is currently known by 'originalName' inside the class scope (which is closed)
                    String originalName = func.name;
                    String mangledName = this.name + "_" + originalName;
                    
                    TypeFunction funcType = null;

                    // Retrieve the function signature from the TypeClass structure
                    if (typeClass != null && typeClass.dataMembers != null) {
                         for (TypeList it = typeClass.dataMembers; it != null; it = it.tail) {
                             if (it.head instanceof TypeFunction && it.head.name.equals(originalName)) {
                                 funcType = (TypeFunction) it.head;
                                 break;
                             }
                         }
                    }

                    if (funcType != null) {
                        SymbolTable.getInstance().enter(mangledName, funcType);
                    }
                    
                    // Temporarily rename the function so irMe generates Label_ClassName_MethodName
                    func.name = mangledName;
                    
                    // Generate IR for the method
                    func.irMe();
                    
                    // Restore original state name
                    func.name = originalName;
                }
            }
        }
        
        // Clear current class
        SymbolTable.getInstance().clearCurrentClass();
        
        return null;
    }
}