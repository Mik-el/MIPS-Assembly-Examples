.data

msg1: .asciiz "Inserisci stringa:\n"
stringa: .space 50

.text
.globl main
main:
	#"inserisci stringa"
	la $a0,msg1
	li $v0,4
	syscall
	
	#la acquisisco
	la $a0, stringa
	la $a1, 50
	li $v0,8
	syscall
	
	#carico in a0 la variabile stringa dalla ram che si è riempita
	#con l' operazione precedente 
	la $a0, stringa
	jal sostituisci
	
	#stampa la stringa risultante
	la $a0,stringa
	li $v0,4
	syscall

esci: 
	#fine programma
	li $v0,10
	syscall
	
	
#sostituisci: #carico l' indirizzo di memoria di a0(stringa) in t0
	     #che senso ha??????
	#la $t0, ($a0)
	
loop_sostituisci: 
	lb $t1, 0($a0) #carico in t1 il primo byte della stringa
	beqz $t1,esci #se t1 è uguale a zero esco
	
	beq $t1, 'a', metti_asterisco #se in t1 c'è 'a' vado a metti aserisco
	beq $t1, 'e', metti_asterisco
	beq $t1, 'i', metti_asterisco
	beq $t1, 'o', metti_asterisco
	beq $t1, 'u', metti_asterisco
	beq $t1, 'A', metti_asterisco
	beq $t1, 'E', metti_asterisco
	beq $t1, 'I', metti_asterisco
	beq $t1, 'O', metti_asterisco
	beq $t1, 'U', metti_asterisco
	
	addi $a0,$a0,1			#incremento t0 di 1
	j loop_sostituisci		#ritorno al loop
	
	
	
metti_asterisco:
	li $t2,'*'   #carico il carattere asterisco in t2
	sb $t2, 0($a0) #memorizzo t2 nel primo bye di t0
	addi $a0,$a0,1 #incremento posiz char stringa di 1
	j loop_sostituisci #vado a loop sostituisci
	
#esci:
	jr $ra #torno all' invocazione