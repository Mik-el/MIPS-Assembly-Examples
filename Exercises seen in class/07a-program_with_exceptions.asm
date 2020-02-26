# Title:	Simplest Exception Handler
# Filename:	07-exceptionHandler.asm
# Author:	Antonio Cuomo
# Date:
# Description:	Retrieved from http://www.cs.iastate.edu/~cs321/recitations/program_with_exceptions.s
#				See Lab 5 at: http://www.cs.iastate.edu/~cs321/recitations/lab5.html
#				This program generates exception number 7 by referring to an address
#    			which is out of range. 
# Implements:
#      sum = 0;
#      i = 9;
#   do {
#      sum = sum + A[9-i]
#      B[9-i] = sum;
#      i--;
#   until (i == 0)
        .data
sum:    .word   0
A:      .word   0, 1, 2, 3, 4, 5, 6, 7, 8, 9
B:      .word   10, 11, 12, 13, 14, 15, 16, 17, 18, 19
Four:   .word   4
Nine:   .word   9
Minus1: .word   -1
message:        .asciiz "\nThe value of sum is:  "

        .text
        .globl main
main:
        add     $t2, $0, $0     # sum = 0  (sum is in $t2)
        add     $t1, $0, $0     # Set $t1 to point to beginning of data,
                                #  that is, to sum
        lw      $t4, 84($t1)    # Constant 4 stored in $t4
        lw      $t0, 88($t1)    # Constant 9 stored in $t0 (i)
        lw      $t5, 92($t1)    # Constant -1 stored in $t5
        add     $t1, $t1,$t4    # A starts at 4 (move $t1 to point to A)
loop:
        lw      $t3, 0($t1)     # $t3 has A[i]
        add     $t2, $t2, $t3   # sum = sum + A[i]
        sw      $t2, 40($t1)    # B[i] = sum
        add     $t1, $t1, $t4   # update address pointer
        add     $t0, $t0, $t5   # i--
        beq     $t0, $0, done   # if i > 0 go to loop
        j       loop
done:
        add     $t1, $0,$0      # Set $t1 to point to beginning of data
        sw      $t2, 0($t1)     # sum is stored
        li      $v0, 4          # print_str
        la      $a0, message
        syscall
        li      $v0, 1          # print_int
        lw      $a0, sum
        syscall
        jr      $ra             # return to the main program