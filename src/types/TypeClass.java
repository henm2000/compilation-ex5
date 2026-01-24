package types;

import java.util.HashMap;

public class TypeClass extends Type
{
	/*********************************************************************/
	/* If this class does not extend a father class this should be null  */
	/*********************************************************************/
	public TypeClass father;
	public static HashMap<String, TypeClass> classes = new HashMap<>();

	/**************************************************/
	/* Gather up all data members in one place        */
	/* Note that data members coming from the AST are */
	/* packed together with the class methods         */
	/**************************************************/
	public TypeList dataMembers;
	
	/****************/
	/* CTROR(S) ... */
	/****************/
	public TypeClass(TypeClass father, String name, TypeList dataMembers)
	{
		this.name = name;
		this.father = father;
		this.dataMembers = dataMembers; 
		this.classes.put(name, this);
	}
	
	/*************/
	/* isClass() */
	/*************/
	@Override
	public boolean isClass() { return true; }

    public int getClassSize() {
        int size = 0;
        if (father != null) {
            size += father.getClassSize();
        } else {
            size += 4; // vtable pointer logic
        }
        
        for (TypeList it = dataMembers; it != null; it = it.tail) {
            if (it.head instanceof TypeClassField) {
                size += 4;
            }
        }
        return size;
    }

    public int getFieldOffset(String fieldName) {
        // Check if defined in father hierarchy first
        if (father != null) {
            int fatherOffset = father.getFieldOffset(fieldName);
            if (fatherOffset != -1) return fatherOffset;
        }

        // Not in father. Must be in this class dataMembers.
        int currentOffset = 0;
        if (father != null) {
            currentOffset = father.getClassSize();
        } else {
            currentOffset = 4; // vtable
        }
        
        for (TypeList it = dataMembers; it != null; it = it.tail) {
            if (it.head instanceof TypeClassField) {
                if (it.head.name.equals(fieldName)) {
                    return currentOffset;
                }
                currentOffset += 4;
            }
        }
        
        return -1; // Not found
    }
}
