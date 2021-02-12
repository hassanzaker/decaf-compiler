.text
.globl main

# Constructor for Class : ali
ali_Constructor:
li $a0 , 16 # Size of Object ( including Vtable address at index 0 )
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
# Loading Address of ID : a
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Int Constant : 0
li $t0 , 0
sw $t0 , 0($sp)
addi $sp, $sp, -4
#  equality of Expressions
lw $t0 , 8($sp)
lw $t1 , 4($sp)
beq $t0 , $t1 , label0
li $t0, 0
j label1
label0 :
li $t0 , 1
label1 :
sw $t0 , 8($sp)
addi $sp , $sp , 4
addi $sp , $sp , 4
lw $t0 , 0($sp)
beq $t0 , $zero , label2
# Int Constant : 1
li $t0 , 1
sw $t0 , 0($sp)
addi $sp, $sp, -4
lw $v0 , 4($sp) # Loading Return Value of function
addi $sp , $sp , 4
move $sp , $s5
jr $ra # Return Function
j label3
label2 :
# Loading Address of ID : a
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Storing Frame Pointer and Return Address Before Calling the function : f
addi $sp , $sp , -12
sw $fp , 4($sp)
sw $ra , 8($sp)
sw $s5 , 12($sp)
# Function Arguments
# Loading Address of ID : a
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Int Constant : 1
li $t0 , 1
sw $t0 , 0($sp)
addi $sp, $sp, -4
# minus Expression
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sub $t0 , $t0 , $t1
sw $t0 , 8($sp)
addi $sp , $sp , 4
jal f # Calling Function
# Pop Arguments of function
addi $sp , $sp , 4
# Load Back Frame Pointer and Return Address After Function call
lw $fp , 4($sp)
lw $ra , 8($sp)
lw $s5 , 12($sp)
addi $sp , $sp , 8
sw $v0 , 4($sp) # Push Return Value from function to Stack
# div Expression
lw $t0 , 8($sp)
lw $t1 , 4($sp)
mul $t0 , $t0 , $t1
sw $t0 , 8($sp)
addi $sp , $sp , 4
lw $v0 , 4($sp) # Loading Return Value of function
addi $sp , $sp , 4
move $sp , $s5
jr $ra # Return Function
label3 :
#End of if statement
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
lw $v0, 0($sp)
f_end:
jr $ra

h: # Start function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Loading Address of ID : a
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Int Constant : 0
li $t0 , 0
sw $t0 , 0($sp)
addi $sp, $sp, -4
#  equality of Expressions
lw $t0 , 8($sp)
lw $t1 , 4($sp)
beq $t0 , $t1 , label4
li $t0, 0
j label5
label4 :
li $t0 , 1
label5 :
sw $t0 , 8($sp)
addi $sp , $sp , 4
addi $sp , $sp , 4
lw $t0 , 0($sp)
beq $t0 , $zero , label6
# Int Constant : 0
li $t0 , 0
sw $t0 , 0($sp)
addi $sp, $sp, -4
lw $v0 , 4($sp) # Loading Return Value of function
addi $sp , $sp , 4
move $sp , $s5
jr $ra # Return Function
j label7
label6 :
# Loading Address of ID : a
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Storing Frame Pointer and Return Address Before Calling the function : f
addi $sp , $sp , -12
sw $fp , 4($sp)
sw $ra , 8($sp)
sw $s5 , 12($sp)
# Function Arguments
# Loading Address of ID : a
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Int Constant : 1
li $t0 , 1
sw $t0 , 0($sp)
addi $sp, $sp, -4
# minus Expression
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sub $t0 , $t0 , $t1
sw $t0 , 8($sp)
addi $sp , $sp , 4
jal f # Calling Function
# Pop Arguments of function
addi $sp , $sp , 4
# Load Back Frame Pointer and Return Address After Function call
lw $fp , 4($sp)
lw $ra , 8($sp)
lw $s5 , 12($sp)
addi $sp , $sp , 8
sw $v0 , 4($sp) # Push Return Value from function to Stack
# div Expression
lw $t0 , 8($sp)
lw $t1 , 4($sp)
mul $t0 , $t0 , $t1
sw $t0 , 8($sp)
addi $sp , $sp , 4
lw $v0 , 4($sp) # Loading Return Value of function
addi $sp , $sp , 4
move $sp , $s5
jr $ra # Return Function
label7 :
#End of if statement
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
lw $v0, 0($sp)
h_end:
jr $ra

main: # Start function
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
# Int Constant : 10
li $t0 , 10
sw $t0 , 0($sp)
addi $sp, $sp, -4
jal f # Calling Function
# Pop Arguments of function
addi $sp , $sp , 4
# Load Back Frame Pointer and Return Address After Function call
lw $fp , 4($sp)
lw $ra , 8($sp)
lw $s5 , 12($sp)
addi $sp , $sp , 8
sw $v0 , 4($sp) # Push Return Value from function to Stack
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 1
syscall
li $v0 , 4
la $a0 , new_line
syscall
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
lw $v0, 0($sp)
main_end:
jr $ra



.data
a4 : .word 0
ali_vtable:
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
__result: .space 200
