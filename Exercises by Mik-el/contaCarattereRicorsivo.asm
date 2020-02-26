#conta carattere ricorsivo
.data 
dammi_str: .asciiz "Inserisci stringa "
dammi_car: .asciiz "Inserisci carattere "
num: .asciiz "\n Il carattere è presente nella stringa "
volte: .asciiz " volte"
stringa: .space 20 
prova: .asciiz ""

.text
.globl main
	
	

main:
#inserisci stringa
	li $v0, 4
	la $a0, dammi_str
	syscall
	
	li $v0, 8
	la $a0, stringa
	la $a1, 20
	syscall
	  
	#inserisci carattere
	li $v0, 4
	la $a0, dammi_car
	syscall
	
	li $v0, 12
	syscall
	
	#preparo i parametri della funzione ricorsiva
	la $a0, stringa
	move $a1, $v0
	
	jal funz_ricors
	
	move $s7, $v0
	
	#carattere presente nella stringa
	li $v0, 4
	la $a0, num
	syscall
	
	#copio il numero di caratteri trovati 
	li $v0, 1
	move $a0, $s7
	syscall
	
	#volte
	li $v0, 4
	la $a0, volte
	syscall


	
esci:
	li $v0, 10
	syscall	

funz_ricors:

		#copio la stringa da parametro a s0
		move $s0,  $a0
		#carico il primo carattere  della stringa in t0
		lb $t0, 0($s0)
		
		#alloco 2 posizioni sullo stack, nella prima metto il return register, nella seconda la stringa
		addi $sp, $sp, -8
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		
		
		
		#condiz arresto
		bnez $t0, str_non_finita
		li $v0,0
		j esci_ricors
		
		str_non_finita:
		
		bne $s0, $a1 ricorsione
			
		addi $s3, $s3, 1
		j ricorsione
		
		
		
		ricorsione:
		addi $s0, $s0, 1
		move $a0, $s0
		jal funz_ricors
		
		esci_ricors:
		lw $s0, 4($sp)
		lw $ra, 0($sp)
		addi $sp, $sp, 8
		move $v0, $s7
		jr $ra
