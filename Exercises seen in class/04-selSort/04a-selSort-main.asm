# Title: Selection Sort - Main Procedure
# Filename: 04a-selSort-main.asm
# Author: Antonio Cuomo
# Date:		
# Description: Invokes the sort function -defined elsewhere- on a static array of 7 elements
# Input:	Array (allocated and initialized statically)
# Output:	Sorted Array (sorted in-place and printed on screen)
.a
.data
.align 2
a: 	.word 	36, 20, 27, 15, 1, 62, 41
space: .asciiz " "
.text
.globl main
main:
	la $a0, a
	la $a1, a
	addiu $a1, $a1, 24
	jal sort
	la $a1, a
	la $a2, a
	addiu $a2, $a2, 28
printloop:
	li $v0, 1
	lw $a0, 0($a1)
	syscall
	li $v0, 4
	la $a0, space
	syscall
	addiu $a1, $a1, 4 
	bne   $a1,  $a2,  printloop        
	li $v0, 10			# Exit program
	syscall 
