###############################################
# first-last_string CCB_edition
# compito del 7 Febbraio 2013
###############################################

####data####
.data

# prompt e stringhe varie da stampare 
prmpt1: .asciiz "Dammi quattro stringhe\n"
prmpt2: .asciiz "La prima stringa in ordine alfabetico e': "
prmpt3: .asciiz "\n"
prmpt4: .asciiz "L'ultima stringa in ordine alfabetico e': "
############

.text
.globl main

main:
# alloca 100 bytes sullo stack
addi $sp,$sp,-100 

# ora i 4 buffer sono agli indirizzi 0($sp), 25($sp), 50($sp) e 75($sp)
# ATTENZIONE: se $sp viene modificato, occorre tenerne conto!!!

# stampa prompt e input delel 4 stringhe
# ATTENZIONE: 25 caratteri nel buffer, quindi c'� spazio al max per 24 carattteri utili. 
# qualora fossero meno di 24, la syscall mette un NEWLINE alla fine, che non disturba le cose pi� di tanto
la $a0,prmpt1
li $v0,4
syscall

# prima stringa -> 0($sp)
move $a0,$sp
li $a1,24
li $v0,8
syscall

# seconda stringa -> 25($sp)
addi $a0,$sp,25
li $a1,24
li $v0,8
syscall

# terza stringa -> 50($sp)
addi $a0,$sp,50
li $a1,24
li $v0,8
syscall

# quarta stringa -> 75($sp)
addi $a0,$sp,75
li $a1,24
li $v0,8
syscall

# parametro (unico) in $a0 e chiamata a first_string
move $a0,$sp
jal first_string

# parametro (unico) in $a0 e chiamata a last_string
move $a0,$sp #ATTENZIONE: $a0 va ricaricato, le funzioni lo avrano sicuramente sporcato!
jal last_string

# fine (R.I.P.)
li $v0,10
syscall

##fine main###################################

#### funzione first_string ####################
first_string:
# ATTENZIONE: questa funzione non � FOGLIA. $ra va salvato sullo stack
# va salvato anche $s0 (anche le il main non lo usa!!!)
addi $sp,$sp,-8
#sw $s0,0($sp)
sw $ra,4($sp)
# RI-ATTENZIONE: ora le 4 stringhe si trovano a 8($sp), 33($sp), 58($sp) e 83($sp)

## nel registro $s0 c'e' il puntatore alla stringa piu piccola di tentativo (la prima)
# ATTENZIONE: non usare un tegistro $t, verrebbe sporcato da string_cmp
addiu $s0,$sp,8

# confronta $s0 (first corrente) con la stringa a 33($sp)
# parametri in $a0 e $a1 -> chiamata di string_cmp
move $a0, $s0
addi $a1,$sp,33
jal string_cmp
# se string_cmp ritorna in $v0 -1 (valore negativo), $s0 vince ancora (� precedente in ordine alfabetico)
# se no (valore positivo o nullo) , la prima in ordine alfabetico corrente � $a1 -> $s0
bltz $v0,next_string1
# aggiorna la first corrente
addi $s0,$sp,33

next_string1:
# confronta $s0 (first corrente) con la stringa a 58($sp)
# parametri in $a0 e $a1 -> chiamata di string_cmp
move $a0, $s0
addi $a1,$sp,58
jal string_cmp
# tutto come sopra
bltz $v0,next_string2
addi $s0,$sp,58

next_string2:
# confronta $s0 (first corrente) con la stringa a 83($sp)
# parametri in $a0 e $a1 -> chiamata di string_cmp
move $a0, $s0
addi $a1,$sp,83
jal string_cmp
bltz $v0,stampa_min
addi $s0,$sp,83

# in $s0 il puntatore alla stringa "vincente" (la prima in ordine alfabetico) - si stampa!
stampa_min:
la $a0,prmpt2
li $v0,4
syscall
la $a0,prmpt3  # stampa andata a capo
li $v0,4
syscall

move $a0,$s0
li $v0,4
syscall

# recupero di $ra e $s0 dallo stack, ripristino dello $sp e salto indietro
lw $s0,0($sp)
lw $ra,4($sp)
addi $sp,$sp,8
jr $ra
################ fine first_string #################

####funzione last_string ####################
## IMPORTANTE: basta copiare first_string, cambiare le label opportunamente e invertire il verso del confronto
## al ritorno da string_cmp
## NON riscriverla da zero!!!!!!
##
last_string:
# ATTENZIONE: questa funzione non � FOGLIA. $ra va salvato sullo stack
# va salvato anche $s0 (anche le il main non lo usa!!!)
addi $sp,$sp,-8
sw $s0,0($sp)
sw $ra,4($sp)
# RI-ATTENZIONE: ora le 4 stringhe si trovano a 8($sp), 33($sp), 58($sp) e 83($sp)

## nel registro $s0 c'e' il puntatore alla stringa piu grande di tentativo (la prima)
# ATTENZIONE: non usare un tegistro $t, verrebbe sporcato da string_cmp
addiu $s0,$sp,8

# confronta $s0 (last corrente) con la stringa a 33($sp)
# parametri in $a0 e $a1 -> chiamata di string_cmp
move $a0, $s0
addi $a1,$sp,33
jal string_cmp
# se string_cmp ritorna in $v0 1, $s0 vince ancora (�seguente in ordine alfabetico)
# se no (valore negativo o nullo, -1 o 0) , l'ultima in ordine alfabetico corrente � $a1 -> $s0
bgtz $v0,next_string3 # ora salta se � greater than zero!!! Questo era il punto da modificare!!!
# aggiorna la last corrente
addi $s0,$sp,33

next_string3:
# confronta $s0 (last corrente) con la stringa a 58($sp)
# parametri in $a0 e $a1 -> chiamata di string_cmp
move $a0, $s0
addi $a1,$sp,58
jal string_cmp
# tutto come sopra
bgtz $v0,next_string4   # solita modifica
addi $s0,$sp,58

next_string4:
# confronta $s0 (last corrente) con la stringa a 83($sp)
# parametri in $a0 e $a1 -> chiamata di string_cmp
move $a0, $s0
addi $a1,$sp,83
jal string_cmp
bgtz $v0,stampa_max    # solita modifica
addi $s0,$sp,83

# in $s0 il puntatore alla stringa "vincente" (l'ultima in ordine alfabetico) - si stampa!
stampa_max:
la $a0,prmpt4
li $v0,4
syscall
la $a0,prmpt3
li $v0,4
syscall

move $a0,$s0
li $v0,4
syscall

# recupero di $ra e $s0 dallo stack, ripristino dello $sp e salto indietro
lw $s0,0($sp)
lw $ra,4($sp)
addi $sp,$sp,8
jr $ra
################ fine last_string #################

### funzione string_cmp  ##########################
###################################
# CODICE C corrispondente:
# int string_cmp(char *s1, char *s2) {
#   while (*s1 == *s2) {
#     /* qui dentro i due caratteri sono uguali */
#     if (!*s1) return(0);
#     /* se uno e' zero, sono finite entrambe le stringhe e quindi sono tutte uguali */
#     s1++;
#     s2++;
#   }
#   /* qui e' stato trovato il primo carattere diverso; -1 se minore, +1 se maggiore */
#   if ((*s1 - *s2)<0)
#     return(-1);
#
#   return (1);
# }
####################################
# TRADURRE il C, non inventarsela in assembly!!!!
string_cmp:
# carica i due byte da confrontare
# ATTENZIONE: usare lbu, perch� un primo bit alto porta alla estensione del segno !!!
lbu $t1,0($a0)
lbu $t2,0($a1)
bne $t1,$t2,diversi
bnez $t1,non_finita
li $v0,0
jr $ra
non_finita:
addi $a0,$a0,1
addi $a1,$a1,1
j string_cmp
diversi:
ble $t1,$t2,minore
li $v0,1
jr $ra
minore:
li $v0,-1
jr $ra 

#### fine string_cmp
