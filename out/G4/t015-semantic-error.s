.text
.globl main

main: # main function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -8 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : n1
li $s6 , 0
addi $s6 , $s6 , 4
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# String Constant : "1"
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
# Loading Address of ID : a1
li $s6 , 0
addi $s6 , $s6 , 0
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Expression of Array Size
# Int Constant : 10
li $t0 , 10
sw $t0 , 0($sp)
addi $sp, $sp, -4
# NewArray of Type : int
lw $t0, 4($sp)
addi $t0 , $t0 , 1 # Allocate space for Storing Array Length
sll $a0 , $t0 , 2
li $v0, 9
syscall
addi $t0 , $t0 , -1 # Array Size
sw $t0 , 0($v0) # Storing Array size in index 0
sw $v0, 4($sp)
# Assign Right Side to Left
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sw $t1 , 0($t0)
sw $t1 , 8($sp)
addi $sp , $sp , 4
# End of Expression Optional
addi $sp , $sp 4
# Get Array index
# Base Address of Array
# Loading Address of ID : a1
li $s6 , 0
addi $s6 , $s6 , 0
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Expression index of Array
# Loading Address of ID : n1
li $s6 , 0
addi $s6 , $s6 , 4
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
lw $t0 , 8($sp) # base Address of Array
lw $t1 , 4($sp) # index of Array
addi $sp , $sp , 4
addi $t1 , $t1 , 1
sll $t1 , $t1 , 2
add $t0 , $t0 , $t1
sw $t0 , 4($sp) # Pushing address of arr[index] result to Stack
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 1
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
str0: .asciiz "1"
a1 : .word 0
n1 : .word 0
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
__result: .space 200
