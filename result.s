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

ali_f: # Start function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Int Constant : 3
li $t0 , 3
sw $t0 , 0($sp)
addi $sp, $sp, -4
lw $v0 , 4($sp) # Loading Return Value of function
addi $sp , $sp , 4
move $sp , $s5
jr $ra # Return Function
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
lw $v0, 0($sp)
ali_f_end:
jr $ra

main: # Start function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -8 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : a
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
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
# Left Hand Side Assign
# Loading Address of ID : b
addi $s7 , $fp , 4
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Calling Method of Object
# Object Expression
# Loading Address of ID : a
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
lw $t0 , 4($sp)
lw $t0 , 0($t0) # Loading Vtable
addi $t0 , $t0 , 0 # Adding offset of Method in Vtable
lw $t0 , 0($t0) # t0 now contains the address of function
sw $t0 , 0($sp) # Storing Function Address in Stack 
addi $sp , $sp , -4
# Storing Frame Pointer and Return Address Before Calling the object's method : f
addi $sp , $sp , -12
sw $fp , 4($sp)
sw $ra , 8($sp)
sw $s5 , 12($sp)
# Method's Arguments 
lw $t0 , 20($sp) # Loading Object being called
sw $t0 , 0($sp) # Pushing object as "this" as first argument of method
lw $t0 , 16($sp) # Loading Method of object
addi $sp , $sp , -4
jal $t0 # Calling Object's method
addi $sp , $sp , 4 # Pop Arguments of Method
# Load Back Frame Pointer and Return Address After Function call
lw $fp , 4($sp)
lw $ra , 8($sp)
lw $s5 , 12($sp)
addi $sp , $sp , 16
sw $v0 , 4($sp) # Push Return Value from Method to Stack
# Assign Right Side to Left
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sw $t1 , 0($t0)
sw $t1 , 8($sp)
addi $sp , $sp , 4
# End of Expression Optional
addi $sp , $sp 4
# Loading Address of ID : b
addi $s7 , $fp , 4
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
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
b3 : .word 0
ali_vtable:
	.word ali_f
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
__result: .space 200
