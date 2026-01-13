# Exercise 5 Completion Roadmap
# MIPS Code Generation with Register Allocation
# Due: March 15, 2026

---

## Overview
Transform the current AST→IR pipeline into a complete compiler that generates executable MIPS assembly code. The key missing component is **register allocation** using graph coloring, plus completing MIPS generation for all IR commands.

---

## PHASE 1: Register Allocation Infrastructure (CRITICAL - Week 1)
**Goal:** Implement simplification-based register allocation for $t0-$t9 (10 registers).

### 1.1 Extend Temp Class
**File:** `src/temp/Temp.java`

**Current state:** Only has serial number
**Need to add:**
- `private String physicalRegister;` // null if not allocated, or "$t0"-"$t9"
- `public void setPhysicalRegister(String reg)`
- `public String getPhysicalRegister()`
- `public boolean isAllocated()`

### 1.2 Create Liveness Analysis
**New file:** `src/regalloc/LivenessAnalyzer.java`

**Purpose:** Determine which temps are live at each IR command.

**Implementation questions for you:**
1. How should I represent the control flow graph (CFG)?
   - Should I build a separate CFG data structure or work directly on IR commands?
   - How do I identify basic blocks from the IR command list?

2. For liveness analysis:
   - Should I use the standard dataflow equations:
     - IN[n] = USE[n] ∪ (OUT[n] - DEF[n])
     - OUT[n] = ∪ IN[s] for all successors s
   - How many iterations of fixed-point computation are typically needed?

3. What should the output format be?
   - Map<IrCommand, Set<Temp>> for IN and OUT sets?
   - Or should I annotate each IR command with live temps?

**Interface needed:**
```java
public class LivenessAnalyzer {
    public LivenessAnalyzer(List<IrCommand> irCommands);
    public Set<Temp> getLiveTempsAtCommand(IrCommand cmd);
    public Map<IrCommand, Set<Temp>> getInSets();
    public Map<IrCommand, Set<Temp>> getOutSets();
}
```

### 1.3 Create Interference Graph Builder
**New file:** `src/regalloc/InterferenceGraph.java`

**Purpose:** Build graph where nodes are temps, edges connect temps that interfere (are simultaneously live).

**Implementation details:**
1. **Data structure:** Use adjacency list: `Map<Temp, Set<Temp>>`
   
2. **Build interference:** For each IR command, if temps t1 and t2 are both live simultaneously, add edge (t1, t2)
   - **No special handling for MOVE** (no coalescing needed per answer #2)

3. **Pre-colored nodes:** Not needed - we're only allocating temps, not dealing with pre-assigned physical registers

**Interface needed:**
```java
public class InterferenceGraph {
    public InterferenceGraph(List<IrCommand> irCommands, LivenessAnalyzer liveness);
    public void addNode(Temp t);
    public void addEdge(Temp t1, Temp t2);
    public Set<Temp> getNeighbors(Temp t);
    public int getDegree(Temp t);
    public void removeNode(Temp t);
    public Set<Temp> getAllNodes();
}
```

### 1.4 Create Register Allocator (Simplification-Based)
**New file:** `src/regalloc/RegisterAllocator.java`

**Purpose:** Perform graph coloring with K=10 colors ($t0-$t9).

**Implementation (CONFIRMED):**
1. **Simplification algorithm:**
   - Start with interference graph
   - Repeatedly remove nodes with degree < K (K=10) and push onto stack
   - **If ALL remaining nodes have degree >= K:** Allocation FAILS - return false immediately
   - Pop stack and assign colors, checking neighbors

2. **Coloring strategy:**
   - When popping from stack, try colors $t0, $t1, ..., $t9 in order
   - Choose first color not used by any neighbor
   - **If no color available:** Allocation FAILS - return false

3. **Failure detection:**
   - During simplification: if all nodes have degree >= K → FAIL
   - During coloring: if no color available for a node → FAIL
   - On failure, Main.java prints "Register Allocation Failed"

4. **Implementation scope:**
   - Just simplification (NO coalescing, NO spilling)
   - Return true/false for allocation success
   - On success: update Temp objects with physical register assignments

**Interface needed:**
```java
public class RegisterAllocator {
    public RegisterAllocator(List<IrCommand> irCommands);
    public boolean allocate(); // returns false if spilling needed
    // Side effect: updates Temp objects with physical register assignments
}
```

### 1.5 Update MipsGenerator to Use Physical Registers
**File:** `src/mips/MipsGenerator.java`

**Current:** Uses `Temp_123` notation
**Need:** Use actual register names `$t0`, `$t1`, etc.

**Changes needed:**
- Modify all methods (add, mul, li, load, store, etc.) to call `temp.getPhysicalRegister()` instead of `temp.getSerialNumber()`
- Example:
  ```java
  // OLD: fileWriter.format("\tadd Temp_%d,Temp_%d,Temp_%d\n", dst, op1, op2);
  // NEW: fileWriter.format("\tadd %s,%s,%s\n", dst.getPhysicalRegister(), op1.getPhysicalRegister(), op2.getPhysicalRegister());
  ```

---

## PHASE 2: Function Call Convention (Week 2)
**Goal:** Implement proper MIPS calling convention with stack frames.

### 2.1 Define Stack Frame Layout
**Reference:** See `examples/test_1.s` for the expected prologue/epilogue structure.

**Stack frame structure (from high to low address):**
```
... (caller's frame)
argument N
argument N-1
...
argument 2
argument 1        <- 8($fp) - first arg (beyond $ra and old $fp)
$ra               <- 4($fp)
old $fp           <- 0($fp) = current $fp
saved $t0         <- -4($fp)
saved $t1         <- -8($fp)
...
saved $t9         <- -40($fp)
local var 1       <- -44($fp)
local var 2       <- -48($fp)
...
local var N
... (space for outgoing args)
                  <- $sp
```

### 2.2 Function Prologue Generation
**New file or method:** Add to `MipsGenerator` or create `FunctionCodeGenerator`

**Tasks:**
1. Save $ra and $fp
2. Set new $fp
3. Save all $t0-$t9 (40 bytes)
4. Allocate space for local variables

**Implementation questions:**
1. How do I know how many local variables a function has?
   - Should I scan all IR commands for the function to find max temp number?
   - Or should AST pass this info during irMe()?

2. How much stack space for outgoing arguments?
   - Should I pre-calculate max arguments for any call in this function?
   - Or dynamically push/pop for each call?

**Code structure needed:**
```java
public void functionPrologue(String funcName, int numLocalVars) {
    fileWriter.format("%s:\n", funcName);
    fileWriter.format("subu $sp, $sp, 4\n");
    fileWriter.format("sw $ra 0($sp)\n");
    fileWriter.format("subu $sp, $sp, 4\n");
    fileWriter.format("sw $fp 0($sp)\n");
    fileWriter.format("move $fp, $sp\n");
    
    // Save all $t0-$t9
    for (int i = 0; i < 10; i++) {
        fileWriter.format("subu $sp, $sp, 4\n");
        fileWriter.format("sw $t%d, 0($sp)\n", i);
    }
    
    // Allocate local var space
    int localSpace = numLocalVars * 4;
    if (localSpace > 0) {
        fileWriter.format("subu $sp, $sp, %d\n", localSpace);
    }
}
```

### 2.3 Function Epilogue Generation
**Tasks:**
1. Restore $sp to $fp
2. Restore $t0-$t9
3. Restore $fp and $ra
4. Return to caller

### 2.4 Function Call Handling
**IR Command:** `IrCommandCall` (or similar - need to check what exists)

**Tasks:**
1. Evaluate arguments left-to-right
2. Push arguments onto stack (right-to-left)
3. `jal function_label`
4. Clean up stack (pop arguments)
5. Move result fr(CONFIRMED):**
- All arguments go on stack (no $a0-$a3 usage)
- Arguments pushed right-to-left
- Arguments evaluated left-to-right (important for side effects)
- After call, pop arguments from stack
- How are function arguments currently represented in IR?
- Should I create new IR commands for argument passing?

---

## PHASE 3: Complete MIPS Generation for All IR Commands (Week 2-3)

### 3.1 Arithmetic Operations (PARTIALLY DONE)
**Files:** `IrCommandBinop*.java`

#### IrCommandBinopAddIntegers ✓ (verify saturation)
**Task:** Add saturation check (-32768 to 32767)
```mips
add $t0, $t1, $t2       # compute sum
# Check overflow (need implementation)
li $t3, 32767
bgt $t0, $t3, saturate_high
li $t3, -32768
blt $t0, $t3, saturate_low
j done
saturate_high:
  li $t0, 32767
  j done
saturate_low:
  li $t0, -32768
done:
```

**Question:** Should I generate unique labels for each saturation check, or use a shared saturation routine?

#### IrCommandBinopSubIntegers (similar saturation)
#### IrCommandBinopMulIntegers (similar saturation)

#### IrCommandBinopDivIntegers (CRITICAL - needs division-by-zero check)
**Tasks:**
1. Check if divisor is zero
2. If zero: print "Illegal Division By Zero" and exit
3. Otherwise: perform division
4. Apply saturation to result

```mips
# Check division by zero
beqz $divisor, division_by_zero_error
div $result, $dividend, $divisor
# saturation check...
j continue

division_by_zero_error:
  la $a0, msg_div_zero
  li $v0, 4
  syscall
  li $v0, 10
  syscall
```

**Question:** Where should I define the error message strings in .data section?

### 3.2 Comparison Operations
#### IrCommandBinopLtIntegers ✓ (verify)
#### IrCommandBinopGtIntegers (similar)
#### IrCommandBinopEqIntegers (similar)

### 3.3 Memory Operations

#### IrCommandLoad ✓ (for global variables)

#### IrCommandStore ✓ (for global variables)

#### IrCommandLoadMemory (for field/array access)
**Current state:** Needs implementation
**Tasks:**
1. Load from memory address + offset
2. **Add null pointer check before access**

```mips
# $base contains address, $offset contains offset
# Check for null pointer
beqz $base, null_pointer_error
add $addr, $base, $offset
lw $result, 0($addr)
j continue

null_pointer_error:
  la $a0, msg_null_ptr
  li $v0, 4
  syscall
  li $v0, 10
  syscall
```

#### IrCommandStoreMemory (similar to LoadMemory)

### 3.4 Object/Array Allocation

#### IrCommandMalloc ✓ (verify)
**Current:** Calls syscall 9
**Verify:** Result stored in correct temp

#### IrCommandAllocate (for global variables)
**Current:** Uses `.dataCRITICAL - VTABLES REQUIRED!)
**Confirmed:** Objects need vtables for virtual dispatch (TEST_23 has method overriding)

**Object layout:** `[vtable_ptr | field1 | field2 | ... | fieldN]`

**Tasks:**
1. **Create vtable section in .data** for each class:
   ```mips
   # Example for Dog class with method go()
   vtable_Dog:
       .word Label_Dog_go
       # ... other methods
   
   # Example for SmallDog (overrides go())
   vtable_SmallDog:
       .word Label_SmallDog_go    # overridden
       # ... other methCONFIRMED)
**Array layout:** `[length | elem0 | elem1 | ... ]`
**Array pointer:** Points TO the length field (offset 0)

**Tasks:**
1. Calculate size: (length + 1) * 4  // +1 for length field
2. Call malloc syscall
3. Store length at offset 0
4. Initialize all elements to 0 (offsets 4, 8, 12, ...)
5. Return pointer to length field
   # obj.method() where method is at vtable offset X
   lw $t0, 0($obj)        # load vtable pointer
   lw $t1, X($t0)         # load method address from vtable
   jalr $t1               # jump to method
   ```nheritance for runtime dispatch?
- If yes, do I need vtable pointers in objects?
- What's the object memory layout?

#### Array Allocation (NEW?)
**Tasks:**
1. Calculate size: (length + 1) * 4  // +1 for length field
2. Call malloc
3. Store length at offset 0
4. Initialize elements to 0
5. Return pointer to length field (or elements?)

**Implementation question:**
- Array layout: [length | elem0 | elem1 | ... ]?
- Does array pointer point to length or elem0?

### 3.5 Array Access

#### Array Bounds Checking (CRITICAL)
**Tasks:**
1. Check if index < 0 → Access Violation
2. Check if index >= length → Access Violation
3. Calculate address: base + (index+1)*4  (if length is at offset 0)
4. Load/store value

```mips
# $base = array pointer, $index = index temp
# Check null pointer (points TO length), $index = index temp
# Check null pointer
beqz $base, null_pointer_error

# Load length (at offset 0)
lw $length, 0($base)

# Check index < 0
bltz $index, access_violation_error

# Check index >= length
bge $index, $length, access_violation_error

# Calculate address: base + (index+1)*4
# (index+1 because length is at offset 0, elem0 at offset 4)
sll $temp, $temp, 2    # multiply by 4
add $addr, $base, $temp
lw $result, 0($addr)
j continue

access_violation_error:
  la $a0, msg_access_violation
  li $v0, 4
  syscall
  li $v0, 10
  syscall
```

### 3.6 String Operations (NEW)

#### String Concatenation
**Tasks:**
1. Calculate lengths of both strings (find null terminator)
2. Allocate new string: length1 + length2 + 1
3. Copy string1
4. Copy string2
5. Add null terminator
Note:** Strings are null-terminated C-style (no length field)

**Approach:** Can implement as helper functions or inline - your choice

#### String Equality
**Tasks:**
1. Compare character by character until '\0'
2. Return 1 if equal, 0 otherwise

**Approach:** Can implement as helper function or inline - your choice
**Question:** Should this be a helper function?

### 3.7 Control Flow (VERIFY EXISTING)
#### IrCommandLabel ✓
#### IrCommandJump ✓
#### IrCommandJumpIfZero ✓ (verify implementation)
#### IrCommandJumpIfEqToZero ✓

### 3.8 Function Operations
#### IrCommandCall (NEEDS IMPLEMENTATION)
See Phase 2.4

#### IrCommandReturn
**Current state:** Check if complete
**Tasks:**
1. Move return value to $v0
2. Jump to epilogue label

### 3.9 Library Functions
#### IrCommandPrintInt ✓ (verify syscall 1)

#### PrintString (NEW?)
**Question:** Is there an IR command for PrintString, or handled differently?
**Tasks if separate:**
1. Load string address to $a0
2. li $v0, 4
3. syscall

---

## PHASE 4: Main.java Integration (Week 3)
**Goal:** Orchestrate the complete compilation pipeline.

### 4.1 Add Register Allocation Phase
**File:** `src/Main.java`

**Current flow:**
```java
ast.irMe();
for (IrCommand cmd : Ir.getInstance().getAllCommands()) {
    cmd.mipsMe();
}
```

**New flow:**
```java
ast.irMe();

// Get all IR commands
List<IrCommand> irCommands = Ir.getInstance().getAllCommands();

// Perform register allocation
RegisterAllocator allocator = new RegisterAllocator(irCommands);
if (!allocator.allocate()) {
    fileWriter.print("Register Allocation Failed");
    fileWriter.close();
    return;
}

// Generate MIPS (now temps have physical registers)
MipsGenerator.getInstance(outputFileName).printDotDataString();

for (IrCommand cmd : irCommands) {
    cmd.mipsMe();
}

MipsGenerator.getInstance(outputFileName).finalizeFile();
```

### 4.2 Error Message Strings in .data
**Add to MipsGenerator initialization:**
```java
public void printDotDataString() {
    fileWriter.print(".data\n");
    fileWriter.print("msg_div_zero: .asciiz \"Illegal Division By Zero\"\n");
    fileWriter.print("msg_null_ptr: .asciiz \"Invalid Pointer Dereference\"\n");
    fileWriter.print("msg_access_violation: .asciiz \"Access Violation\"\n");
    // ... global variables ...
}
```
Confirmed from test_1.s and test_2.s:** Uses "user_main" label for user's main function.

**Structure:**
```mips
main:
    # (optionally initialize globals here if needed)
    jal user_main
    li $v0, 10
    syscall

user_main:
    # user's main function code
    # ... prologue, body, epilogue
```

**Tasks:**
1. User's main function gets labeled "user_main" in IR
2. Generate stub "main" label that calls user_main and exits
1. Generate real "main" that initializes globals then calls "user_main"
2. Or rename user's main during IR generation?

---

## PHASE 5: Testing & Debugging (Week 3-4)
**Goal:** Ensure all test cases pass.

### 5.1 Unit Testing Strategy
**Test each phase independently:**

1. **Register Allocation Tests:**
   - Test with small IR programs (< 10 temps) → should succeed
   - Test with large IR programs (> 10 temps simultaneously live) → should fail gracefully
   - Test with no interference → each temp gets unique register
   - Test with high interference → simplification order matters

2. **MIPS Generation Tests:**
   - Test arithmetic with saturation edge cases
   - Test division by zero detection
   - Test null pointer detection
   - Test array bounds violations
   - Test string operations
   - Test function calls with various argument counts

### 5.2 Integration Testing
**Use provided test cases:**
- TEST_01 through TEST_26
- Compare output with expected_output/*.txt

### 5.3 SPIM Testing
**For each test:**
1. Generate MIPS assembly
2. Run in SPIM: `spim -file output.s`
3. Verify output matches expected

### 5.4 Edge Cases to Test
- Empty main function
- Recursive functions
- Nested function calls
- Global variable initialization order
- String edge cases (empty string, very long string)
- Array edge cases (size 0, size 1, large arrays)
- Class with many fields (> 10)

---

## PHASE 6: Optimization & Cleanup (Week 4)
**Goal:** Polish the implementation.

### 6.1 Code Review
- Remove debug print statements
- Ensure consistent formatting
- Add comments to complex algorithms

### 6.2 Performance (if time allows)
- Current requirement: No optimization needed
- But if register allocation is too slow:
  - Profile the graph coloring algorithm
  - Optimize interference graph construction

### 6.3 Error Messages
- Verify all error messages match exactly:
  - "Illegal Division By Zero"
  - "Invalid Pointer Dereference"
  - "Access Violation"
  - "Register Allocation Failed"
  - "ERROR" (lexical)
  - "ERROR(line)" (syntax/semantic)

---

## IMPLEMENTATION PRIORITY ORDER

### Week 1 (Critical Path):
1. **Day 1-2:** Liveness Analysis + Interference Graph
2. **Day 3-4:** Register Allocator (graph coloring)
3. **Day 5-7:** Update MipsGenerator to use physical registers + test

### Week 2:
1. **Day 1-3:** Function calling convention (prologue/epilogue/calls)
2. **Day 4-5:** Runtime checks (div-by-zero, null-ptr, array bounds)
3. **Day 6-7:** Arithmetic saturation

### Week 3:
1. **Day 1-2:** Array allocation and access
2. **Day 3-4:** String operations
3. **Day 5-7:** Testing with provided tests

### Week 4:
1. **Day 1-3:** Fix bugs found in testing
2. **Day 4-5:** Edge case handling
3. **Day 6-7:** Final testing + submission prep

---

## ANSWERED QUESTIONS

### Register Allocation Algorithm:
1. **✅ Simplification algorithm CONFIRMED:**
   - Build interference graph
   - Repeat: remove node with degree < K (where K=10), push to stack
   - If all nodes have degree >= K, fail with "Register Allocation Failed" (no spilling)
   - Pop stack, assign colors checking neighbors
   - If can't color any node, fail with "Register Allocation Failed"
   
2. **✅ Move instructions:** NO special treatment needed (no coalescing required)

### Memory Layout:
3. **✅ Object layout:** `[vtable_ptr | field1 | field2 | ... | fieldN]`
   - First word (offset 0) is vtable pointer for virtual dispatch
   - Fields start at offset 4

4. **✅ Array layout:** `[length | elem0 | elem1 | ... ]`
   - Array pointer points TO the length field
   - Elements are at offsets: 4, 8, 12, ... from array pointer

5. **✅ String layout:** Null-terminated C-style strings
   - No length field
   - Just character bytes ending with '\0'

### Function Calls:
6. **✅ Arguments:** ALL arguments on stack (don't use $a0-$a3 for arguments)
   - Push arguments right-to-left
   - Pop after call

7. **✅ Nested calls:** Evaluation order is LEFT-TO-RIGHT
   - In `f(g(x), h(y))`: evaluate g(x) first, then h(y), then f()

### IR Structure:
8. **✅ Function boundaries:** Just labels are sufficient
   - Function starts at label
   - Function ends at return or next function label

9. **✅ Virtual dispatch:** YES - L supports method overriding, vtables ARE required!
   - TEST_23 has `SmallDog extends Dog` and overrides `go()` method
   - Need vtable for each class with method pointers
   - Object allocation must set vtable pointer at offset 0
   - Method calls must use vtable lookup: `lw $t0, 0($obj)` then `lw $t1, offset($t0)` then `jalr $t1`

---

## NEW QUESTIONS (After implementing answers)

### VTable Implementation:
10. **Method offset calculation:** How should I order methods in the vtable?
    - In declaration order within each class?
    - Inherited methods first, then new methods?
    - Does the order need to match across parent/child classes for inherited methods?

11. **VTable generation:** When/where should vtables be generated?
    - During semantic analysis (add to TypeClass)?
    - During IR generation?
    - During MIPS generation (in .data section)?

12. **Method resolution:** How to find method offset in vtable?
    - Need to traverse class hierarchy to count methods?
    - Should I store method index in TypeFunction during semantic analysis?

### Field Access:
13. **Field offset calculation:** Similar to vtable - what's the offset for a field?
    - Inherited fields come first, then new fields?
    - Need to traverse parent classes to calculate offset?
    - Should offset be stored in Type during semantic analysis?

### IR Structure for Classes:
14. **Object instantiation in IR:** Is there already an IR command for `new ClassName`?
    - Or does it just use IrCommandMalloc?
    - Should I create IrCommandNewObject that handles vtable setup?

15. **Method calls in IR:** How are method calls represented?
    - Same as function calls (IrCommandCall)?
    - Or separate command for virtual dispatch?

### String Operations:
16. **String literals:** How are string literals like `"hello"` handled?
    - Already in .data section during IR?
    - Need to generate .data entries during MIPS generation?
    - How to avoid duplicate strings?

17. **String concat result:** Where does concatenated string go?
    - On heap (malloc)?
    - Should return pointer to new string?

### Global Variables:
18. **Global initialization order:** Ex5 instructions say globals initialized before main.
    - Are global variable initializers already in IR?
    - Or need to generate initialization code before calling user_main?
    - What if global init has function calls (like `int x := f()`)?

### Control Flow:
19. **CFG construction for liveness:** How do I build control flow from IR commands?
    - Labels start basic blocks
    - Jumps end basic blocks
    - How to handle fall-through vs explicit jumps?
    - What about function boundaries?

---

## SUCCESS CRITERIA
- [ ] Compiles without errors
- [ ] Runs `make` successfully
- [ ] All 26 test cases generate correct MIPS
- [ ] MIPS runs in SPIM without errors
- [ ] Output matches expected output exactly
- [ ] Register allocation fails gracefully when needed
- [ ] All runtime errors detected with correct messages
- [ ] Submission passes self-check.py

---

## NOTES
- Keep `ex4` directory intact as reference
- Commit frequently to track progress
- Test incrementally (don't wait until everything is done)
- Use SPIM to debug MIPS output
- Reference `examples/test_1.s` for correct MIPS structure
