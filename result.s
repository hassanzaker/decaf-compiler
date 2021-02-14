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

__ali_changeX: # Start function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Variable of Object
# Loading Address of : this
addi $s7 , $s4 , 0
sw $s7 , 0($sp)
addi $sp, $sp, -4
lw $t0 , 4($sp)
addi $t0 , $t0 , 0 # add offset of variable to object address
sw $t0 , 4($sp)
# Right Hand Side Assign
# Loading Address of ID : a
li $s6 , 4
addi $s6 , $s6 , 0
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Loading Address of ID : b
li $s6 , 4
addi $s6 , $s6 , 4
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 4 to Stack
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
ali_changeX_end:
jr $ra

__ali_getX: # Start function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Loading Variable of Object
# Loading Address of : this
addi $s7 , $s4 , 0
sw $s7 , 0($sp)
addi $sp, $sp, -4
lw $t0 , 4($sp)
addi $t0 , $t0 , 0 # add offset of variable to object address
sw $t0 , 4($sp)
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
lw $v0 , 4($sp) # Loading Return Value of function
addi $sp , $sp , 4
move $sp , $s5
jr $ra # Return Function
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
lw $v0, 0($sp)
ali_getX_end:
jr $ra

main: # main function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -4 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
addi $sp , $sp , 4 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
lw $v0, 0($sp)
main_end:
jr $ra



.data
a2 : .word 0
b2 : .word 0
has5 : .word 0
ali_vtable:
	.word ali_changeX
	.word ali_getX
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
__result: .space 200
