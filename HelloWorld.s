# My first assembly program
.data

  HelloWorldString:
    .ascii "Hello World...\n"

  RobbyString:
    .ascii "Robby is learning assembly!\n"


.text

  .globl _start

  _start:
    # Load all the arguments for write()
    # ssize_t write(int fd, const void *buf, size_t count);

    # Store sys call number 4 for write() to EAX
    movl $4, %eax

    # Store File Descriptor for STDOUT to EBX
    movl $1, %ebx
    
    # Store our pointer to the memory location containing our "Hello World"
    # string in ECX
    movl $HelloWorldString, %ecx

    # Store the length of the string in EDX
    movl $15, %edx

    # Then call our system interupt
    int $0x80

    movl $4, %eax
    movl $1, %ebx
    movl $RobbyString, %ecx
    movl $28, %edx
    int $0x80


    # Exit syscall to exit the program
    movl $1, %eax
    movl $0, %ebx
    int $0x80


