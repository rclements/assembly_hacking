##### PART 1 - OVERVIEW #####
  Control Unit - Retrieves / Decode Instructions, Retrieves / Store data in memory
  Execution Unit - Actual execution of instruction happens here
    When a cpu is executing instructions it actually requires some internal memory locations in order to do those calculations ( registers )
  Registers - Internal memory locations used as "variables"
    The value of these registers keep changing depending on what the cpu is doing right now
  Flags - Used to indicate various "event" when execution is happening
    Finally we have the flags which are used to indicate various events when the execution happens

  General Purpose Registers
    Approximately 8 GPR's are used during various calculations inside the cpu
      EAX - Accumulator Register - used for storing operands and result data
      EBX - Base Register - Pointer to Data
      ECX - Counter Register - Loop operations
      EDX - Data Register - I/O Pointer
      ESI - Data Pointer Registers for memory operations
      EDI - Data Pointer Registers for memory operations
      ESP - Stack Pointer Register
      EBP - Stack Data Pointer Register

  I just mentioned all these registers so you have a complete idea of all of them.
  In a 32 bit architecture are 32 bits so...

  It is possible to access the first 16 bits of EAX as AX
  It is possible to access the first 7 bits and the next 7 bits as AH(A high) and AL(A low)

  So for EBX you would have BH and BL, 
  with ECS you would have CH and CL,
  and with EDX you would have DH and DL,

  I know this is confusing but you will see more about what I'm talking about a little later.

  Virtual Memory Model
    Every process is laid out in the same virtual memory space regardless of the actual physical memory location.
    Every process feels like it is in the system alone and no other processes exist.A

  Program Memory
    So now we get into the program memory, a process is laid out like this:

  Stack         - Used for storing function arguments and local variables
   - The stack is a LIFO (Last in, First out) data structureA
     It is laid from High memory to Low memory, ESP points to the top of the stack
     The stack supports only 2 operations, Push (pushes a value onto the stack), Pop (Removes the topmost value from the stack)
     You would the fix ESP so it points to the top of the stack.
  Unused Memory
  Heap          - Dynamic Memory - malloc()
  .bss          - Unitialized Data
  .data         - Initialized Data
  .text         - Program Code

  Segment Registers
    Generally pointers used for other segments
    CS
    DS
    SS
    ES
    FS
    GS

  Intruction Pointer Register
    Points to the instruction which the cpu is executing 
    EIP

  Control Registers
    Internal to the cpu for various calculations
    CR0
    CR1
    CR2
    CR3
    CR4

 
##### Part 2 - GDB ##### 
  # Show basic C adding program
  as -gstabs -o SimpleDemo.o SimpleDemo.s
  ld -o SimpleDemo SimpleDemo.o
  ./SimpleDemo

  #GDB
    gdb ./SimpleDemo
    run 10 20
    breakpoint 8
    delete breakpoints



###### PART 3 - BASIC ASM FILE STRUCTURE ######

  .data
    - All initialized statically allocated read-write data
      Hello World String declared here
  .bss
    - All uninitialized statically allocated read-write data
  .text
    - program instructions
      _start: 
        Main() routine
        - This is where the program instructions are written, the executable code.  When
  you  write these instructions there needs to be place or label where the
  assembler knows this is the start of the program.
        If you had a library you would export those libraries here so they can be
        called.

  Syscalls arguments
    EAX - system call number
    EBX - first argument
    ECX - second argument
    EDX - third argument
    ESI - fourth argument
    EDI - fifth argument

  exit() - to gracefully exit program
    movl $1, %eax - puts the number one in eax
    movl $0, %ebx - "status" is lets say "0" - EBX must be loaded with "0"
    Raise the software interrupt $0x80
   
    movl $1, %eax
    movl $0, %ebx
    int $0x80


  # Write the Just Exit File
  as -o JustExit.o JustExit.s
  ld -o JustExit JustExit.o
  ./JustExit

  Next lets write our first hello world program

  In order to do this we need to know what function we call to write our Hello
  World string.  To find out what commands we have available for our
  architecture we can look in 

  The write() syscall is defined so taht it requires 3 arguments - to print "Hello World"
    1 fd = 1 STDOUT (in EBX) - file descriptor for linux
    2 Buf = pointer to memory containing "Hello World" string (in ECX)
    3 Count = string length (in EDX)

    # ssize_t write(int fd, const void *buf, size_t count);
    I have to store the system call for write in EAX but I don't know the sys call number for write()
    so how do I find that out?

    Well if you open /usr/include/asm/unistd_32.h it will show you all of
    the system calls and shows that the syscall for write() is 4.


  # Write the Hello World File

  as -gstabs -o HelloWorld.o HelloWorld.s
  ld -o HelloWorld HelloWorld.o
  ./HelloWorld



# DataTypes which I may not get to cover
  .byte = 1 byte
  .ascii = string
  .asciz = Null terminated string
  .int = 32 bit integer
  .short = 16 bit integer
  .float = Single precision floading point number
  .double = Double precision floading point number

  .comm - delcares common memory area
  .lcomm - declares local common memory area


  as -gstabs -o VariableDemo.o VariableDemo.s
  ld -o VariableDemo VariableDemo.o



