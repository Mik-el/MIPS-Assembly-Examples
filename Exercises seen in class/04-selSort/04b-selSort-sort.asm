# Title: Selection Sort - Sort Procedure
# Filename: 04a-selSort-sort.asm
# Author: Antonio Cuomo
# Date:		
# Description: procedure to sort an array of integers
# Input:  $a0  =  pointer  to  first,  $a1  =  pointer  to  last
# Output:  array  is  sorted  in  place
##########################################################
.globl sort
sort: 	addiu  $sp,  $sp,  -4   #  allocate  one  word  on  stack
	sw     $ra,  0($sp)     #  save  return  address  on  stack
top:    jal    max             	#  call  max  procedure
	lw     $t0,  0($a1)     #  $t0  =  last  value
	sw     $t0,  0($v0)     #  swap  last  and  max  values
	sw     $v1,  0($a1)
	addiu  $a1,  $a1,  -4   #  decrement  pointer  to  last
	bne    $a0,  $a1,  top  #  more  elements  to  sort
	lw     $ra,  0($sp)     #  pop  return  address
	addiu  $sp,  $sp,  4
	jr     $ra              #  return  to  caller 
