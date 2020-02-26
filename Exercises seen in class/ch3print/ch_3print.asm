# Stampa del codice ASCII di un carattere in decimale, binario, esadecimale
#
# Legge un carattere da testiera e lo stampa su video in decimale, binario, esadecimale
# usando tre funzioni print_decimal, print_binary, print_hex
#
# Input:    1 carattere da tastiera
# Output: codice Ascii  su video in decimale, binario, esadecimale
# 
####################################################################################
#
# DATA SEGMENT
	.data
prompt:
	.asciiz 	"\n\nInserisci un carattere: "
output_msg:
	.asciiz		"\nIl codice ASCII del carattere ? "
spec_out1:
	.asciiz		" (dec) - "	
spec_out2:
	.asciiz		" (bin) - "	
spec_out3:
	.asciiz		" (hex) \n"	
ch:
	.space		2
ascii_string:
	.space		9
	
# CODE SEGMENT
	.text
	.globl		main
main:
	# stampa prompt
	la		$a0, prompt
	li		$v0, 4
	syscall
	
	# leggi carattere input 
	la		$a0, ch
	li		$a1, 2   # NB: il carattere ? letto come una stringa carattere+terminatore null (lunga 2)
	li		$v0, 8
	syscall
	
	# stampa output message
	la		$a0, output_msg
	li		$v0, 4
	syscall

	# chiama le tre funzioni di stampa
	lbu		$a0, ch  # parametro di input 
	jal		print_decimal
	
	la		$a0, spec_out1
	li		$v0, 4
	syscall

	lbu		$a0, ch
	jal		print_binary
	
	la		$a0, spec_out2
	li		$v0, 4
	syscall
	
	lbu		$a0, ch
	jal		print_hex
	
	la		$a0, spec_out3
	li		$v0, 4
	syscall

	# terminazione del processo
	li		$v0, 10
	syscall
	
#################################################
print_decimal:
#
#Non fa quasi nulla, non chiama altre funzioni, sporca solo $v0
#################################################
	# NB: $a0 ? gi? carico!!!
	li		$v0, 1
	syscall
	jr 		$ra

###############################################################
print_binary:				
#
# Trova la stringa corrispondente al carattere in binario
# Non non chiama altre funzioni, sporca solo i reg. temp.
# t0 - carattere letto in input
# t1 - puntatore alla stringa che contiene il codice Ascii del carattere in binario
# t2 - byte di maschera per l'accesso ai singoli bit del carattere
################################################################
	move		$t0, $a0
	la		$t1, ascii_string
	li		$t2, 0x80
	li		$t4, '0'
	li		$t5, '1'
	
loop:
	and		$t3, $t0, $t2
	beqz		$t3, zero
	sb		$t5, ($t1)
	b 		rotate
zero:
	sb		$t4, ($t1)
rotate:
	srl		$t2, $t2, 1
	addu		$t1, $t1, 1
	bnez		$t2, loop
	
	sb 		$0, ($t1) # aggiunge il null di fine stringa
	la		$a0, ascii_string
	li		$v0, 4
	syscall
	jr		$ra
	
#################################################################
print_hex:
#
# Trova la stringa corrispondente al carattere in binario
# Non non chiama altre funzioni, sporca solo i reg. temp.
# t0 - carattere letto in input
# t1 - puntatore alla stringa che contiene il codice Ascii del carattere in hex
################################################################
	move		$t0, $a0
	la		$t1, ascii_string

# calcolo prima cifra esadecimale
	andi		$t0, 0xF0
	srl		$t0, $t0, 4
		
	ble		$t0, 9, digit1
	addi		$t0, $t0, 55   # 55='A'-10
	b		load_dig1
digit1:
	addi		$t0, $t0, '0'
load_dig1:	
	sb		$t0, ($t1)
	addu		$t1, $t1, 1
	
# calcolo seconda cifra esadecimale
	move		$t0, $a0
	andi		$t0, 0x0F
	ble		$t0, 9, digit2
	addi		$t0, $t0, 55
	b		load_dig2
digit2:
	addi		$t0, $t0, '0'
load_dig2:	
	sb		$t0, ($t1)
	addu		$t1, $t1, 1
	
	sb 		$0, ($t1) # aggiunge il null di fine stringa
	la		$a0, ascii_string
	li		$v0, 4
	syscall
	
	jr		$ra

