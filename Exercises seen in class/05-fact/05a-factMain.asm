# Title:	Factorial - Main Procedure
# Filename:	05a-factMain.asm
# Author:	Antonio Cuomo
# Date:
# Description:	Invokes the factorial procedure -defined elsewhere- to compute 
#				the factorial of 5. Prints result on screen.
# Input:		No input needed
# Output:		Prints the factorial of 5
################# Data segment #####################
.data
#data goes here
################# Code segment #####################
.text
.globl main
main:
# main program entry
addiu $a0, $zero, 5
jal fact
add $a0, $v0, $zero
li  $v0, 1
syscall
li $v0, 10
# Exit program
syscall
