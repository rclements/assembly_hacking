.section .text
.global main
main:
  movl $inputWord, %esi
  movl $outputMorse, %edi
  movl $0, %eax

encode_loop:
  movb (%esi), %al
  incl %esi
  
  testb %al, %al
  jz finished

  subb $'A, %al

  movl $MorseTable, %ecx

  lookup:
    movb (%ecx, %eax, 8), %bl

    cmpb $' , %bl
    je lookup_done

    movb %bl, (%edi)
    incl %edi

    incl %ecx
    jmp lookup

lookup_done:
  movb $' , (%edi)
  incl %edi
  movb $' , (%edi)
  incl %edi
  movb $' , (%edi)
  incl %edi

  jmp encode_loop

finished:
  movb $0x00, (%edi)
  incl %edi

  pushl $outputMorse
  call puts
  addl $4, %esp

  movl $0, %eax
  ret

.section .rodata
  MorseTable:
    .ascii ".-      ", "-...    ", "-.-.    ", "-..     " # A, B, C, D
    .ascii ".       ", "..-.    ", "--.     ", "....    " # E, F, G, H
    .ascii "..      ", ".---    ", "-.-     ", ".-..    " # I, J, K, L
    .ascii "--      ", "-.      ", "---     ", ".--.    " # M, N, O, P
    .ascii "--.-    ", ".-.     ", "...     ", "-       " # Q, R, S, T
    .ascii "..-     ", "...-    ", ".--     ", "-..-    " # U, V, W, X
    .ascii "-.--    ", "--..    "                         # Y, Z

.section .data
  # Input Word Storage
  inputWord: .ascii "HELLO\0"

.section .bss
  # Output Morse Code Storage
  .comm outputMorse, 64
 
