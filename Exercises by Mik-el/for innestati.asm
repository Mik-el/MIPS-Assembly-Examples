#for innestati

#for (int i=0; i<100; i++) {  
#  for (int j=0; j<200; j++) {  
#  }  
#}


.data
prova: .asciiz "prova"
stampo_i: .asciiz "stampo i "
stampo_j: .asciiz "stampo j "

.text
.globl main
main:

li $v0, 4
la $a0, prova
syscall

jal ciclo
j esci

ciclo:
	li $t0, 0        # inizio i
	li $t1, 4      # fine i

	li $t2, 0        # inizio j
  	li $t3, 4      # fine j
	
	ciclo_i:  
  	beq $t0, $t1, fine_ciclo_i  #se finisce "i" termina il ciclo i
			
	
		ciclo_j:  
  			beq $t2, $t3, fine_ciclo_j  # se finisce j termina il ciclo j
  			
  			la $a0, stampo_j
			li $v0,4
			syscall
			
  			addi $t2, $t2, 1    # j++
  			b ciclo_j  
	
	
			
	addi $t0, $t0, 1    # i++  
  	b ciclo_i  
 

  
fine_ciclo_i:
		jr $ra  
fine_ciclo_j:
		jr $ra
	
esci:
	li $v0, 10
	syscall		