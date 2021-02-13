.text
.globl main

main: # main function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -4 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : i
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Int Constant : 0
li $t0 , 0
sw $t0 , 0($sp)
addi $sp, $sp, -4
# Assign Right Side to Left
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sw $t1 , 0($t0)
sw $t1 , 8($sp)
addi $sp , $sp , 4
# End of Expression Optional
addi $sp , $sp 4
# Initialization Expression of Loop for
# Left Hand Side Assign
# Loading Address of ID : i
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Int Constant : 2
li $t0 , 2
sw $t0 , 0($sp)
addi $sp, $sp, -4
# Assign Right Side to Left
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sw $t1 , 0($t0)
sw $t1 , 8($sp)
addi $sp , $sp , 4
addi $sp , $sp , 4 # pop init expr of loop for
label4: # Starting for Loop Body
# Calculating For Loop Condition
# Loading Address of ID : i
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Int Constant : 5
li $t0 , 5
sw $t0 , 0($sp)
addi $sp, $sp, -4
# less than Expression
lw $t0 , 8($sp)
lw $t1 , 4($sp)
slt $t0 , $t0 , $t1
sw $t0 , 8($sp)
addi $sp , $sp , 4
# Loading For Loop Condition Result
addi $sp , $sp , 4
lw $t0 , 0($sp)
beqz $t0 , label5 # Jumping to end label if Condition Expression of for loop is false
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : i
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Loading Address of ID : i
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
# Add Expression
lw $t0 , 8($sp)
lw $t1 , 4($sp)
add $t0 , $t0 , $t1
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
# Loading Address of ID : i
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Int Constant : 4
li $t0 , 4
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
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
addi $sp , $sp , 0 # Pop elements before
addi $fp , $sp , 4 # Set Frame Pointer
j label4 # continue from loop while

addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
j label3
label2 :
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Loading Address of ID : i
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
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
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
label3 :
#End of if statement
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
# Step Expression of For loop 
# Left Hand Side Assign
# Loading Address of ID : i
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Loading Address of ID : i
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
# Add Expression
lw $t0 , 8($sp)
lw $t1 , 4($sp)
add $t0 , $t0 , $t1
sw $t0 , 8($sp)
addi $sp , $sp , 4
# Assign Right Side to Left
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sw $t1 , 0($t0)
sw $t1 , 8($sp)
addi $sp , $sp , 4
addi $sp , $sp , 4 # pop step expr of loop for
j label4 # Jumping to beggining of while loop
label5:
addi $sp , $sp , 4 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
lw $v0, 0($sp)
main_end:
jr $ra



.data
i4 : .word 0
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
__result: .space 200
