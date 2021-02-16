.text
.globl main

# Constructor for Class : A
A_Constructor:
li $a0 , 4 # Size of Object ( including Vtable address at index 0 )
li $v0 , 9
syscall
la $t0 , A_vtable # Loading Vtable Address of this Class
sw $t0 , 0($v0) # Storing Vtable pointer at index 0 of object
jr $ra

# Constructor for Class : B
B_Constructor:
li $a0 , 4 # Size of Object ( including Vtable address at index 0 )
li $v0 , 9
syscall
la $t0 , B_vtable # Loading Vtable Address of this Class
sw $t0 , 0($v0) # Storing Vtable pointer at index 0 of object
jr $ra

# Constructor for Class : C
C_Constructor:
li $a0 , 4 # Size of Object ( including Vtable address at index 0 )
li $v0 , 9
syscall
la $t0 , C_vtable # Loading Vtable Address of this Class
sw $t0 , 0($v0) # Storing Vtable pointer at index 0 of object
jr $ra

__f: # Start function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
f_end:
jr $ra

main: # main function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Storing Frame Pointer and Return Address Before Calling the function : f
addi $sp , $sp , -12
sw $fp , 4($sp)
sw $ra , 8($sp)
sw $s5 , 12($sp)
# Function Arguments
# new object of type : C
sw $ra , 0($sp)
addi $sp , $sp , -4
jal C_Constructor
lw $ra , 4($sp)
sw $v0 , 4($sp) # Pushing address of object in Heap to Stack
# new object of type : B
sw $ra , 0($sp)
addi $sp , $sp , -4
jal B_Constructor
lw $ra , 4($sp)
sw $v0 , 4($sp) # Pushing address of object in Heap to Stack
# new object of type : C
sw $ra , 0($sp)
addi $sp , $sp , -4
jal C_Constructor
lw $ra , 4($sp)
sw $v0 , 4($sp) # Pushing address of object in Heap to Stack
# Int Constant : 4
li $t0 , 4
sw $t0 , 0($sp)
addi $sp, $sp, -4
la $t1 , c2
lw $t0 , 16($sp)
sw $t0 , 0($t1)
la $t1 , b2
lw $t0 , 12($sp)
sw $t0 , 0($t1)
la $t1 , a2
lw $t0 , 8($sp)
sw $t0 , 0($t1)
la $t1 , i2
lw $t0 , 4($sp)
sw $t0 , 0($t1)
jal __f # Calling Function
# Pop Arguments of function
addi $sp , $sp , 16
# Load Back Frame Pointer and Return Address After Function call
lw $fp , 4($sp)
lw $ra , 8($sp)
lw $s5 , 12($sp)
addi $sp , $sp , 8
sw $v0 , 4($sp) # Push Return Value from function to Stack
# End of Expression Optional
addi $sp , $sp 4
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
lw $v0, 0($sp)
main_end:
jr $ra



.data
i2 : .word 0
a2 : .word 0
b2 : .word 0
c2 : .word 0
A_vtable:
B_vtable:
C_vtable:
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
__result: .space 200
