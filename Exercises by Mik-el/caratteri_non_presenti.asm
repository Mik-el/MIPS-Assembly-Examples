#stampa tutti i caratteri non presenti in una stringa

.data
ins: .asciiz "Inserisci stringa: "
cont : .asciiz "La stringa non contiene i seguenti caratteri: "
prova: .asciiz "p"



.text
.globl main
main:
	
	
	#alloco stringa sulla quale dovrò andare a memorizzare tutti i caratteri
	addi $sp, $sp 128 #32 caratter
	
	#copio la stringa dallo stack in t7
	move $t7, $sp

jal riempi_arr_car
li $t0, 0
jal stampa_arr_car
j exit

riempi_arr_car:
	li $t0, 65 #indice partenza
		#li $t1, 90 #infice fine
	li $t1, 97 #indice partenza
		#li $t3, 122 #indice fine
	
	loop_riempi:
		bge $t0, 90, loop_riempi_2
		
				
		#carico il carattere 97 nella prima pos dell' array
		sb $t0, 0($t7)
		
		
		#condiz incremento
		addi $t7, $t7, 1
		addi $t0, $t0, 1
		
	
		j loop_riempi
	
	loop_riempi_2:
		bge $t1, 122, ritorna# riempi_arr_car
		sb $t1, 0($t7)
		
		addi $t7, $t7, 1
		addi $t1, $t1, 1
		
		j loop_riempi_2
	
	
	
		
ritorna:
jr $ra	

stampa_arr_car:
	bgt $t0, 50, ritorna
	
	lb $t1, ($t7)
	
	move $a0, $t1
	li $v0, 11
	syscall
	
	addi $t7, $t7, 1
	addi $t0, $t0, 1
	j stampa_arr_car
	
	
#acquisisci_stringa:
	
	#alloco stringa sullo stack
	#addi $sp, $sp, 256
	#la copio in un registro t
	#move $t6, $sp
	
	#li $v0, 4
	#la $a0, ins
	#syscall
	
	#li $v0,8
	#li $a0, 256
	#move $a1, $t6
	#syscall
	
#confronto: #for innestati
	
 	

	 	 	 	
	 	 	 		 	 	 		 	 	 	
	
exit:
li $v0, 10
syscall