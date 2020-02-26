#creare un array 3x3 in area globale
#funzione riempi= accetta come parametro array e lo restituisce inizializz 
#funzione di stampa array = accetta come parametro array
#funzione per azzerare diagonale e elementi sopra di essa
# 11 12 13
# 21 22 23
# 31 32 33
.data
.align 2
mioarr: .space 36 
#mioarr: .word 0:36 #array di 30 byte (9 elem*4 byte = 36) ij t mett e man nguoll
pro1: .asciiz "Inserisci elemento arr["
chiusa: .asciiz "]"
aperta: .asciiz "["
prova: .asciiz "fine ciclo colonne, passo a ciclo righe \n"
entra_stampa: .asciiz "entro nella stampa\n"
a_capo: .asciiz " \n"


.text
.globl main
main:
	la $a1, mioarr # la traccia dice che la funz deve ricevere il param, quindi glielo devo passare nel corpo
	jal riempi_array 
	
	la $a1, mioarr
	jal stampa_array
	
	
	
	esci:	
	#fine
	li $v0,10
	syscall
 
riempi_array:
	#copio il contenuto del parametro a1 in t3 
	move $t3, $a1
	
	#t0= indice righe array
	li $t0, 1 
	#t1= indice colonne array
	li $t1, 1 
	
		loop_colonne:
		#condiz arresto (colonne>3)
		bgt  $t1, 3, loop_righe
		
	 
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
		 
		li $v0, 11
		li $a0, 32
		syscall
		
		
	
		#acquisisco il numero e lo metto nell' array
		li $v0, 5
		syscall
		sw $v0, 0($t3)
		#incremento colonna (offset+indice)
		addi $t3, $t3, 4
		addi $t1, $t1, 1
		
		j loop_colonne
		
			
			loop_righe:
			
			
			#condiz arresto (righe >3)
			#se faccio bgt  $t0, 2, esci non entrerà mai nella stampa
			bgt $t0, 2, esci_jr
			#ripristino colonna a 1
			li $t1,1
			
			#incremento riga (offset + indice)
			#addi $t3, $t3, 4
			addi $t0, $t0, 1 
			#rieseguo ciclo
			j loop_colonne
			
			esci_jr:
			jr $ra
		

#-------------------------------------------------------------------------------------	
stampa_array:
	#copio il contenuto del parametro in t3
	move $t3, $a1
	
	li $v0, 4
	la $a0, entra_stampa
	syscall
	
	
	li $t0, 1	#indice righe
	li $t1, 1    #indice colonne
	

	loop_array_colonne:
		bgt $t1, 3, loop_array_righe
		
		#stampa intero contenuto in t3 (lw o move?)
		lw $t4, ($t3)
		li $v0, 1
		move $a0, $t4
		syscall
		
		#stampa spazio
		li $v0, 11
		li $a0, 32
		syscall
		
		#incremento
		addi $t1, $t1, 1
		addi $t3, $t3, 4
		
		j loop_array_colonne
	
			
			loop_array_righe:
			
				bgt $t0, 2 , esci_jr
				#stampo andata a capo
				li $v0, 4
				la $a0, a_capo
				syscall
	
				#stampo l' intero contenuto in t3, NON DOVREBBE ESSERE 0($t3)?
				#lw $t4, ($t3)
				#li $v0, 1
				#move $a0, $t4
				#syscall
		
				#stampo il carattere " "
				#li $v0, 11
				#li $a0, 32
				#syscall
			
				#ripristino colonna a 1
				li $t1,1
		
				addi $t0, $t0, 1	#incremento indice righe
				#addi $t3, $t3, 4	#incremento posizione array
				j loop_array_colonne
		
	    
   
