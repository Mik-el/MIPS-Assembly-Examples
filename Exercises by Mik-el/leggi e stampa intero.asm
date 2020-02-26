#leggi e stampa intero senza spostare l' intero dal registro v0 ad a0
.data
.text
.globl main
main:
	#leggo l' intero
	li $v0, 5 
	syscall
	#stampo l' intero, per farlo però la syscall che stampa l' intero richiede che l' intero si trovi nel registro a0, quindi devo spostarlo lì	
	#li $v0, 1
	#syscall
	
	move $a0, $v0
	syscall
	
	li $a0, 1
	syscall
	#esco programma
	li $v0, 10
	syscall
	
	 
	 
