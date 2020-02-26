# Sum of three integers
#
# Objective: Computes the sum of three integers. 
#     Input: Requests three numbers.
#    Output: Outputs the sum.
################### Data segment ###################
.data
prompt:	.asciiz	"Please enter three numbers: \n"
sum_msg:.asciiz"The sum is: "
################### Code segment ###################
.text
.globl main
main:
#stampa il prompt
la    	$a0,prompt #carico il prompt dalla ram all' indirizzo a0							
li		$v0,4 #legge la stringa contenuta in a0	
syscall

#acquisice l 'intero e lo memorizza in v0
li		$v0,5	
syscall
	#sposto l' intero da v0 a t0 
	move	$t0,$v0

#acquisisce l 'intero e lo memorizza in v0 
li		$v0,5								
syscall
	#sposto l' intero da v0 a t1
	move  	$t1,$v0

#acquisisce l 'intero e lo memorizza in v0
li		$v0,5								
syscall
	#sposto l' intero da v0 a t2
	move  	$t2,$v0


#t0+t1+t2 diventa t0+t1 che aggiorno t0 oppure t1 a cui poi aggiungo t2 e aggiorno t2 oppure t0
addu	$t0,$t0,$t1							
addu	$t0,$t0,$t2

#mostra messaggio somma
la   	$a0,sum_msg							
li		$v0,4
syscall


#stampa il risultato finale, devo spostarlo in a0
move 	$a0,$t0								
li		$v0,1
syscall

#esci
li		$v0,10								
syscall