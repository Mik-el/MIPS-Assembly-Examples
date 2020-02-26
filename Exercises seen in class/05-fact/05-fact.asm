# Title:	Factorial - fact Procedure
# Filename:	05a-factMain.asm
# Author:	Antonio Cuomo
# Date:
# Description:	Recursively computes the factorial of the given integer argument
# Input:		$a0 = integer argument 
# Output:		$v0 = factorial of integer argument
.globl fact 
fact:	slti	$t0,$a0,2	# (n<2)?
		beq 	$t0,$0,else	# if false branch to else
		li $v0,1		# $v0 = 1
		jr $ra			# return to caller
else:
		addiu $sp,$sp,-8	# allocate 2 words on stack
		sw $a0,4($sp)		# save argument n
		sw $ra,0($sp)		# save return address
		addiu $a0,$a0,-1	# argument = n-1
		jal fact		# call fact(n-1)
		lw $a0,4($sp)		# restore argument
		mul $v0,$a0,$v0		# $v0 = n*fact(n-1)
		lw $ra,0($sp)		# restore return address
		addi $sp,$sp,8		# free stack frame
		jr $ra			# return to caller
