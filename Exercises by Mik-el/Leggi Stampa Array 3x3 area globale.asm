#creare un array 3x3 in area globale
#funzione riempi= accetta come parametro array e lo restituisce inizializz 
#funzione di stampa array = accetta come parametro array
#funzione per azzerare diagonale e elementi sopra di essa

.data
mioarr: .space 50 #array di 30 byte (9 elem*4 byte = 36)
pro1: .asciiz "Inserisci elemento arr["
chiusa: .asciiz "]"
aperta: .asciiz "["

.text
.globl main
main:
	
	
riempi_array:

	#carico il parametro/array
	la $a1, mioarr
	#primo indice array
	addi $t0, $t0, 1 
	#secondo indice array
	addi $t1, $t1, 1 
	
		loop_righe:
		#condiz arresto
		bgt  $t0, 3, esci
		
	 
		#stampa inserisci elem[
		li $v0, 4
		la $a0, pro1
		syscall
		#stampa indice righe
		li $v0, 1
		move $a0, $t0
		syscall 
		#stampa ]
		li $v0, 4
		la $a0, chiusa
		syscall
		#stampa [ 
		li $v0, 4
		la $a0, aperta
		syscall 
		#stampa indice colonne
		li $v0, 1
		move $a0, $t1
		syscall 
		#stampa ]
		li $v0, 4
		la $a0, chiusa
		syscall
	
		#acquisisco il numero e lo metto nell' array
		li $v0, 5
		syscall
		sw $v0, 0($a1)
		addi $a1, $a1, 4
		
		#incremento indice riga
		addi $t0, $t0, 1
		j loop_righe
		
			loop_colonne:
			#condiz arresto
			bgt $t1, 3, esci
		
			#riporto l' indice riga a 1
			li $t0, 1
			#incremento indice colonna
			addi $t1, $t1, 1 
		
			#rieseguo ciclo
			j loop_righe
		
	
	
esci:	
	#fine
	li $v0,10
	syscall
 
   
