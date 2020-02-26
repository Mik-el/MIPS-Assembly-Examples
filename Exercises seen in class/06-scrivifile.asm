# Title:	Write file 
# Filename:	06-writeFile.asm
# Author:	Antonio Cuomo
# Date:
# Description:	Shows usage of system calls to handle files.
# Input:		No input needed
# Output:		Prints into file "testout.txt" in the current directory the string 
#				""The quick brown fox jumps over the lazy dog." 
################# Data segment #####################
.data
fout: .asciiz "testout.txt" # filename for output
buffer: .asciiz "The quick brown fox jumps over the lazy dog."

################# Code segment #####################
.text
# open file (for writing) a file that does not exist
li $v0, 13
la $a0, fout
li $a1, 1		#Change to 9 to append
li $a2, 0 
syscall
move $s6, $v0	#attenzione: qui appendice riporta a0 ma ci vuole v0
# system call for open file into $v0
# output file name
# Open for writing (flags are 0: read, 1: write) # mode is ignored
# open a file (file descriptor returned in $v0) # save the file descriptor for later use
# write to file just opened
li $v0, 15 
move $a0, $s6 
la $a1, buffer 
li $a2, 44 
syscall
# close file
li $v0, 16
move $a0, $s6 
syscall
# system call for write to file into $v0
# file descriptor
# address of buffer from which to write # hardcoded buffer length
# write to file
# system call for close file into $v0
# put file descriptor back into $a0 to close file # close file
