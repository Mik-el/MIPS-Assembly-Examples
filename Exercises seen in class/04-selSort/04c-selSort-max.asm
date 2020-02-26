# Title: Selection Sort - Max Procedure
# Filename: 04a-selSort-max.asm
# Author: Antonio Cuomo
# Date:		
# Description: procedure to find max element value and position in an array of integers
# Input:  $a0  =  pointer  to  first,  $a1  =  pointer  to  last
# Output: $v0 = address of maximum element $v1= value of maximum element 
########################################################
.globl max
max:    move     $v0,  $a0              #  max  pointer  =  first  pointer
	lw       $v1,  0($v0)          	#  $v1  =  first  value
	beq      $a0,  $a1,  ret       	#  if  (first  ==  last)  return
	move     $t0,  $a0             	#  $t0  =  array  pointer
loop:  	addi     $t0,  $t0,  4          #  point  to  next  array  element
	lw       $t1,  0($t0)          	#  $t1  =  value  of  A[i]
	ble      $t1,  $v1,  skip       #  if  (A[i]  <=  max)  then  skip
	move     $v0,  $t0              #  found  new  maximum
	move     $v1,  $t1
skip:  	bne      $t0,  $a1,  loop       #  loop  back  if  more  elements
ret:    jr       $ra

