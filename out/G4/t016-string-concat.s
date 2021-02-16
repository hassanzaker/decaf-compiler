.text
.globl main
strcat:
    li $t0 , 0  #i
    li $t3 , 0 #k
strcat_loop1:
    add $s1 , $a0 , $t0
    lb $s2 , 0($s1)
    beq $s2 , $zero , strcat_loop2
    add $t1 , $a2 , $t0
    sb $s2 , 0($t1)
    addi $t0 , $t0 , 1
    j strcat_loop1

strcat_loop2:
    add $s1 , $a1 , $t3
    lb $s2 , 0($s1)
    beq $s2 , $zero , strcat_exit
    add $t4 , $t3 , $t0
    add $t1 , $a2 , $t4
    sb $s2 , 0($t1)
    addi $t3 , $t3 , 1
    j strcat_loop2

strcat_exit:
    add $t0 , $t0 , $t3
    add  $t1, $a2, $t0
    sb   $zero, 0($t1)
    jr   $ra



main: # main function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -8 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : a1
la $s6 , a1
sw $s6, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# String Constant : "hello "
la $t0 , str0
sw $t0 , 0($sp)
addi $sp , $sp , -4
# Assign Right Side to Left
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sw $t1 , 0($t0)
sw $t1 , 8($sp)
addi $sp , $sp , 4
# End of Expression Optional
addi $sp , $sp 4
# Left Hand Side Assign
# Loading Address of ID : b1
la $s6 , b1
sw $s6, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# String Constant : "world"
la $t0 , str1
sw $t0 , 0($sp)
addi $sp , $sp , -4
# Assign Right Side to Left
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sw $t1 , 0($t0)
sw $t1 , 8($sp)
addi $sp , $sp , 4
# End of Expression Optional
addi $sp , $sp 4
# Loading Address of ID : a1
la $s6 , a1
sw $s6, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Loading Address of ID : b1
la $s6 , b1
sw $s6, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Add Expression
lw $a0 , 8($sp)
lw $a1 , 4($sp)
la $a2, __result
addi $sp , $sp , -8
sw $fp , 8($sp)
sw $ra , 4($sp)
jal strcat # Calling Function to concatenation of two Strings
lw $fp , 8($sp)
lw $ra , 4($sp)
addi $sp , $sp , 8
la $t0, __result
sw $t0 , 8($sp) 
addi $sp , $sp , 4
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 4
syscall
li $v0 , 4
la $a0 , new_line
syscall
addi $sp , $sp , 8 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
lw $v0, 0($sp)
main_end:
jr $ra



.data
str0: .asciiz "hello "
str1: .asciiz "world"
a1 : .word 0
b1 : .word 0
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
__result: .space 200
