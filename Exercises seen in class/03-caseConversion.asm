# Objective: Convert lowercase letters to uppercase
#     Input: Requests a character string from the user.
#    Output: Prints the input string in uppercase.
################### Data segment #####################
.data
name_prompt:	.asciiz		"Please type your name: "
out_msg:	.asciiz		"Your name in capitals is: "
in_name:	.space 31	# space for input string


################### Code segment #####################
.text
.globl	main
main:
	# print prompt string
	la    	$a0,name_prompt	
	li    	$v0,4
	syscall
	
	# read the input string
	la    	$a0,in_name	#in a0 carico la stringa del nome, dalla ram quindi la!!		
	li    	$a1,31		#in a1 carico la lung max della stringa (30+ terminatore)
	li    	$v0,8		#acquisisco la stringa
	syscall
	
	# write output message
	la    	$a0,out_msg      		
	li    	$v0,4
	syscall
	
	#carico dalla ram in t0 il numero di carattere della stringa
	la    	$t0,in_name
loop:
	lbu    	$t1,0($t0)	#in t1 carico COSAAAAAAAAAAAAAAAAAAAAAAAAAA
	beqz  	$t1,exit_loop    # se in t1 c'è 0, esco dal loop
	blt 	$t1,'a',no_change #se t1 è minore di a (lettera già maiuscola) non faccio nulla
	bgt	$t1,'z',no_change #se t1 è maggiore di z (lettera già maiuscola)
	addiu	$t1,$t1,-32      # 
	sb	$t1,($t0)
no_change:
	addiu	$t0,$t0,1       # incremento di 1 il numero di carattere della stringa
	j     loop		#vai a loop
	
exit_loop:
	#stampo la stringa risultante
	la    	$a0,in_name      	
	li      $v0,4
	syscall
	
	# exit
	li      $v0,10           		
	syscall
