#BUBBLE SORT
.data
arr: .word 0:20 #5 elementi
ins: .asciiz "Inserisci elemento numero "
spazio: .asciiz " "

.text
.globl main
main:
	la $a1, arr 
	jal inser
	
	j exit

inser:
	li $t0, 1 #indice per l' inserimento =0
	move $t1, $a1
	
	loop_inser:
		bgt $t0, 5, ritorna
		
		li $v0, 4		#inserisci elemento
		la $a0, ins
		syscall
	
		li $v0, 1		#stampa indice
		move $a0, $t0
		syscall
		
		li $v0,4		#stampa spazio
		la $a0, spazio
		syscall

		li $v0, 5		#acquisisci intero
		syscall
	
		sw $v0, ($t1)
		
		addi $t1, $t1, 4 
		addi $t0, $t0, 1
		j loop_inser

ritorna:
jr $ra		

exit:
	li $v0, 10
	syscall
