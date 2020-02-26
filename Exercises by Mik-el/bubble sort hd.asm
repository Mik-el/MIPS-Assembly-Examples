#bubble sort

#		n = arr.size()
#		for (int i=0; i<n .; i++) {  
#  				for (int j=0; j< n -1 ; j++) {
#					if ( array[j] > array[j+1] )
#						scambio i 2 elementi  
#  				}  
#		}




.data
a_capo: .asciiz "\n"
spazio: .asciiz " "
stampo_i: .asciiz "stampo i "
stampo_j: .asciiz "stampo j "
array: .word  60,50,40,20,10

.text
.globl main
main:


la $a0, array
jal stampa

li $v0, 4
la $a0, a_capo
syscall

la $a0, array
jal ordina

la $a0, array
jal stampa

j esci
#------------------------



ordina:
	
	move $t0, $a0 #array
	
	li $t1, 0        # i= 0
	li $t2,0	    #j=0
	
	li $t3, 5      # lunghezza array
	addi $t4, $t3, -1 #lunghezza array -1
	
	ciclo_i:  
  	beq  $t1, $t3,  fine_ciclo_i  #se finisce "i" termina il ciclo i
			
	
		ciclo_j:  
  			beq $t2, $t4, fine_ciclo_j  # se finisce j termina il ciclo j
  			
  			
  			lw $t5, 0($t0) #carico elemento arr [n]
  			lw $t6, 4($t0) #carico elemento arr [n+1]
			blt $t5, $t6, swap_non_necess 
			
			
				move $t7, $t5	#temp = arr [n]
				move $t5, $t6	#arr[n] = arr[n+1]
				move $t6, $t7	#arr[n+1] =temp
				sw $t5,0($t0) #!!
				sw $t6,4($t0) #!!
			
			
			
			
				swap_non_necess:
				
			addi $t0, $t0, 4   #pos array ++
  			addi $t2, $t2, 1    # j++
  			j ciclo_j  
	
	
	
 

  
fine_ciclo_i:
		jr $ra  
fine_ciclo_j:
				
	addi $t1, $t1, 1    # i++  
	li $t2,0		    #azzero j 
	move $t0,$a0
  	j ciclo_i  

	

#---------			
	
stampa:
	move $t0, $a0
	li $t1,0 #indice
	
		stampa_loop:
			#beqz $t2, ritorna
			beq $t1, 5, ritorna
			
			lw $a0, ($t0)		
			li $v0, 1
			syscall	
				
				
			la $a0, spazio
			li $v0, 4
			syscall		
			
			addi $t0, $t0, 4
			addi $t1, $t1, 1
			j stampa_loop
	
ritorna:
 jr $ra	
	


		
		
esci:
	li $v0, 10
	syscall		 
