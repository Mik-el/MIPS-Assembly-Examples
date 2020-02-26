.data
msg1:	.asciiz "Dammi una stringa (max 40 caratteri): \n"
msg2:	.asciiz "\nNumero di vocali presenti nella stringa: "
msg3:	.asciiz "Errore! La stringa inserita supera i 40 caratteri!\n"

.align 2
str:	.space 100

.text
.globl main

main:
	j riempimento
	
riempimento:
	la $a0, msg1
	li $v0, 4
	syscall
	
	la $a0, str
	li $a1, 100
	li $v0, 8
	syscall
	
	li $t1, 0
	
	jal controlla
	
	la $a0, str
	li $t3, 0
	
	jal conta_accentate
	
	la $a0, msg2
	li $v0, 4
	syscall
	
	move $a0, $t3
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
controlla:
	lb $t0, 0($a0)
	
	beq $t0, '\n', fine_controllo
	
	addi $t1, $t1, 1
	addi $a0, $a0, 1
	
	j controlla
	
fine_controllo:
	bgt $t1, 40, errore
	
	jr $ra
	
errore:	
	la $a0, msg3
	li $v0, 4
	syscall
	
	j riempimento
	
conta_accentate:
	lbu $t4, 0($a0)
	
	beq $t4, '\n', exit
	beq $t4, 224, incrementa
	beq $t4, 232, incrementa
	beq $t4, 233, incrementa
	beq $t4, 236, incrementa
	beq $t4, 242, incrementa
	beq $t4, 249, incrementa
	
	addi $a0, $a0, 1
	
	j conta_accentate
	
incrementa:
	addi $t3, $t3, 1
	addi $a0, $a0, 1
	
	j conta_accentate
	
exit:
	jr $ra