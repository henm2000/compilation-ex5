/***********/
/* PACKAGE */
/***********/
package temp;

/*******************/
/* GENERAL IMPORTS */
/*******************/

/*******************/
/* PROJECT IMPORTS */
/*******************/

public class Temp
{
	private int serial=0;
	
	/******************************************/
	/* Physical register assigned to this temp */
	/* null = not yet allocated                */
	/* "$t0"-"$t9" = allocated register        */
	/******************************************/
	private String physicalRegister = null;
	
	public Temp(int serial)
	{
		this.serial = serial;
	}
	
	public int getSerialNumber()
	{
		return serial;
	}
	
	/******************************************/
	/* Register allocation methods             */
	/******************************************/
	
	/**
	 * Assign a physical register to this temp.
	 * @param reg Physical register name (e.g., "$t0", "$t1", ...)
	 */
	public void setPhysicalRegister(String reg)
	{
		this.physicalRegister = reg;
	}
	
	/**
	 * Get the physical register assigned to this temp.
	 * @return Register name (e.g., "$t0") or null if not allocated
	 */
	public String getPhysicalRegister()
	{
		return physicalRegister;
	}
	
	/**
	 * Check if this temp has been assigned a physical register.
	 * @return true if allocated, false otherwise
	 */
	public boolean isAllocated()
	{
		return physicalRegister != null;
	}
}
