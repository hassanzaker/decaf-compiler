.text
.globl main

# Constructor for Class : ali
ali_Constructor:
li $a0 , 8 # Size of Object ( including Vtable address at index 0 )
li $v0 , 9
syscall
la $t0 , ali_vtable # Loading Vtable Address of this Class
sw $t0 , 0($v0) # Storing Vtable pointer at index 0 of object
jr $ra

f: # Start function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Variable of Object
# Loading Address of ID : a
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
lw $t0 , 4($sp)
addi $t0 , $t0 , 0 # add offset of variable to object address
sw $t0 , 4($sp)
# Right Hand Side Assign
# Loading Address of ID : b
addi $s7 , $fp , 4
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Loading Address of ID : c
addi $s7 , $fp , 8
sw $s7, 0($sp) # Push Address of 8 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# div Expression
lw $t0 , 8($sp)
lw $t1 , 4($sp)
mul $t0 , $t0 , $t1
sw $t0 , 8($sp)
addi $sp , $sp , 4
# Assign Right Side to Left
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sw $t1 , 0($t0)
sw $t1 , 8($sp)
addi $sp , $sp , 4
# End of Expression Optional
addi $sp , $sp 4
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
f_end:
jr $ra

main: # Start function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -4 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : a
addi $s7 , $fp , 4
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# new object of type : ali
sw $ra , 0($sp)
addi $sp , $sp , -4
jal ali_Constructor
lw $ra , 4($sp)
sw $v0 , 4($sp) # Pushing address of object in Heap to Stack
# Assign Right Side to Left
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sw $t1 , 0($t0)
sw $t1 , 8($sp)
addi $sp , $sp , 4
# End of Expression Optional
addi $sp , $sp 4
# Storing Frame Pointer and Return Address Before Calling the function : f
addi $sp , $sp , -12
sw $fp , 4($sp)
sw $ra , 8($sp)
sw $s5 , 12($sp)
# Function Arguments
# Int Constant : 3
li $t0 , 3
sw $t0 , 0($sp)
addi $sp, $sp, -4
# Int Constant : 9
li $t0 , 9
sw $t0 , 0($sp)
addi $sp, $sp, -4
# Loading Address of ID : a
addi $s7 , $fp , 4
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
jal f # Calling Function
# Pop Arguments of function
addi $sp , $sp , 12
# Load Back Frame Pointer and Return Address After Function call
lw $fp , 4($sp)
lw $ra , 8($sp)
lw $s5 , 12($sp)
addi $sp , $sp , 8
sw $v0 , 4($sp) # Push Return Value from function to Stack
# End of Expression Optional
addi $sp , $sp 4
# Loading Variable of Object
# Loading Address of ID : a
addi $s7 , $fp , 4
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
lw $t0 , 4($sp)
addi $t0 , $t0 , 0 # add offset of variable to object address
sw $t0 , 4($sp)
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
addi $sp , $sp , 4 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
lw $v0, 0($sp)
main_end:
jr $ra



.data
b1 : .word 0
ali_vtable:
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
__result: .space 200
