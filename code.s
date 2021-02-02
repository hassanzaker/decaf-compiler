.text
.globl main
#-------------------------------------------- Compiler Functions --------------------------------------------#

addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Int Constant : 32
li $t0 , 32
sw $t0 , 0($sp)
addi $sp, $sp, -4
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 1
syscall
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
main_end:
jr $ra



.data
str_false : .asciiz "false" 
str_true : .asciiz "true" 
str_bool : .word str_false , str_true
obj_null : .word 61235
