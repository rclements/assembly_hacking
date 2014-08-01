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
    movl $4, %eax
    movl $1, %ebx
    movl $HelloWorldString, %ecx
    movl $15, %edx
    int $0x80

    movl $4, %eax
    movl $1, %ebx
    movl $RobbyString, %ecx
    movl $28, %edx
    int $0x80


    movl $1, %eax
    movl $0, %ebx
    int $0x80


