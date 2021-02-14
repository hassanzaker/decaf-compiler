.text
.globl main
arraycat:
    li $t0 , 4
    lw $t2 , 0($a0)
    mul $t2 , $t2 , $t0
    lw $t3 , 0($a1)
    mul $t3 , $t3 , $t0
    addi $a0 , $a0 , 4
    addi $a1 , $a1 , 4
    li $t0 , 0
    li $t1 , 0
arraycat_loop1:
    add $s1 , $a0 , $t0
    lw $s2 , 0($s1)
    beq $t0 , $t2 , arraycat_loop2
    add $s3 , $a2 , $t0
    sw $s2 , 0($s3)
    addi $t0 , $t0 , 4
    j arraycat_loop1

arraycat_loop2:
    add $s1 , $a1 , $t1
    lw $s2 , 0($s1)
    beq $t1 , $t3 , arraycat_exit
    add $t4 , $t1 , $t0
    add $s3 , $a2 , $t4
    sw $s2 , 0($s3)
    addi $t1 , $t1 , 4
    j arraycat_loop2

arraycat_exit:
    add $t0 , $t0 , $t1
    add  $t1, $a2, $t0
    sw   $zero, 0($t1)
    jr   $ra



main: # main function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -20 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : a
li $s6 , 0
addi $s6 , $s6 , 0
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Expression of Array Size
# Int Constant : 2
li $t0 , 2
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
# Left Hand Side Assign
# Get Array index
# Base Address of Array
# Loading Address of ID : a
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
# Int Constant : 0
li $t0 , 0
sw $t0 , 0($sp)
addi $sp, $sp, -4
lw $t0 , 8($sp) # base Address of Array
lw $t1 , 4($sp) # index of Array
addi $sp , $sp , 4
addi $t1 , $t1 , 1
sll $t1 , $t1 , 2
add $t0 , $t0 , $t1
sw $t0 , 4($sp) # Pushing address of arr[index] result to Stack
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
# Left Hand Side Assign
# Get Array index
# Base Address of Array
# Loading Address of ID : a
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
# Int Constant : 1
li $t0 , 1
sw $t0 , 0($sp)
addi $sp, $sp, -4
lw $t0 , 8($sp) # base Address of Array
lw $t1 , 4($sp) # index of Array
addi $sp , $sp , 4
addi $t1 , $t1 , 1
sll $t1 , $t1 , 2
add $t0 , $t0 , $t1
sw $t0 , 4($sp) # Pushing address of arr[index] result to Stack
# Right Hand Side Assign
# Int Constant : 1
li $t0 , 1
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
# Left Hand Side Assign
# Loading Address of ID : b
li $s6 , 0
addi $s6 , $s6 , 4
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Expression of Array Size
# Int Constant : 3
li $t0 , 3
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
# Left Hand Side Assign
# Get Array index
# Base Address of Array
# Loading Address of ID : b
li $s6 , 0
addi $s6 , $s6 , 4
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Expression index of Array
# Int Constant : 0
li $t0 , 0
sw $t0 , 0($sp)
addi $sp, $sp, -4
lw $t0 , 8($sp) # base Address of Array
lw $t1 , 4($sp) # index of Array
addi $sp , $sp , 4
addi $t1 , $t1 , 1
sll $t1 , $t1 , 2
add $t0 , $t0 , $t1
sw $t0 , 4($sp) # Pushing address of arr[index] result to Stack
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
# End of Expression Optional
addi $sp , $sp 4
# Left Hand Side Assign
# Get Array index
# Base Address of Array
# Loading Address of ID : b
li $s6 , 0
addi $s6 , $s6 , 4
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Expression index of Array
# Int Constant : 1
li $t0 , 1
sw $t0 , 0($sp)
addi $sp, $sp, -4
lw $t0 , 8($sp) # base Address of Array
lw $t1 , 4($sp) # index of Array
addi $sp , $sp , 4
addi $t1 , $t1 , 1
sll $t1 , $t1 , 2
add $t0 , $t0 , $t1
sw $t0 , 4($sp) # Pushing address of arr[index] result to Stack
# Right Hand Side Assign
# Int Constant : 3
li $t0 , 3
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
# Left Hand Side Assign
# Get Array index
# Base Address of Array
# Loading Address of ID : b
li $s6 , 0
addi $s6 , $s6 , 4
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Expression index of Array
# Int Constant : 2
li $t0 , 2
sw $t0 , 0($sp)
addi $sp, $sp, -4
lw $t0 , 8($sp) # base Address of Array
lw $t1 , 4($sp) # index of Array
addi $sp , $sp , 4
addi $t1 , $t1 , 1
sll $t1 , $t1 , 2
add $t0 , $t0 , $t1
sw $t0 , 4($sp) # Pushing address of arr[index] result to Stack
# Right Hand Side Assign
# Int Constant : 4
li $t0 , 4
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
# Left Hand Side Assign
# Loading Address of ID : c
li $s6 , 0
addi $s6 , $s6 , 8
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 8 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Loading Address of ID : a
li $s6 , 0
addi $s6 , $s6 , 0
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Loading Address of ID : b
li $s6 , 0
addi $s6 , $s6 , 4
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Add Expression
lw $t0 , 8($sp)
lw $t1 , 4($sp)
lw $s0 , 0($t0)
lw $s1 , 0($t1)
add $s3 , $s0 , $s1      #size of concat array
  move $a0 , $t0
move $a1 , $t1
la $t2, __result
sw $s3 , 0($t2)          #size 
addi $a2 , $t2, 4
addi $sp , $sp , -8
sw $fp , 8($sp)
sw $ra , 4($sp)
jal arraycat # Calling Function to concatenation of two Strings
lw $fp , 8($sp)
lw $ra , 4($sp)
addi $sp , $sp , 8
la $t0, __result
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
# Left Hand Side Assign
# Loading Address of ID : size
li $s6 , 0
addi $s6 , $s6 , 16
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 16 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Array Length
# Array Expr
# Loading Address of ID : c
li $s6 , 0
addi $s6 , $s6 , 8
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 8 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
lw $t0 , 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp) # Pushing length of array to stack
# Assign Right Side to Left
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sw $t1 , 0($t0)
sw $t1 , 8($sp)
addi $sp , $sp , 4
# End of Expression Optional
addi $sp , $sp 4
# String Constant : "size: "
la $t0 , str0
sw $t0 , 0($sp)
addi $sp , $sp , -4
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 4
syscall
# Loading Address of ID : size
li $s6 , 0
addi $s6 , $s6 , 16
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 16 to Stack
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
# Initialization Expression of Loop for
# Left Hand Side Assign
# Loading Address of ID : i
li $s6 , 0
addi $s6 , $s6 , 12
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 12 to Stack
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
addi $sp , $sp , 4 # pop init expr of loop for
label1: # Starting for Loop Body
# Calculating For Loop Condition
# Loading Address of ID : i
li $s6 , 0
addi $s6 , $s6 , 12
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 12 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Loading Address of ID : size
li $s6 , 0
addi $s6 , $s6 , 16
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 16 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# less than Expression
lw $t0 , 8($sp)
lw $t1 , 4($sp)
slt $t0 , $t0 , $t1
sw $t0 , 8($sp)
addi $sp , $sp , 4
# Loading For Loop Condition Result
addi $sp , $sp , 4
lw $t0 , 0($sp)
beqz $t0 , label2 # Jumping to end label if Condition Expression of for loop is false
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Get Array index
# Base Address of Array
# Loading Address of ID : c
li $s6 , 0
addi $s6 , $s6 , 8
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 8 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Expression index of Array
# Loading Address of ID : i
li $s6 , 0
addi $s6 , $s6 , 12
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 12 to Stack
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
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
# Step Expression of For loop 
# Left Hand Side Assign
# Loading Address of ID : i
li $s6 , 0
addi $s6 , $s6 , 12
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 12 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Loading Address of ID : i
li $s6 , 0
addi $s6 , $s6 , 12
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 12 to Stack
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
j label1 # Jumping to beggining of while loop
label2:
addi $sp , $sp , 20 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
lw $v0, 0($sp)
main_end:
jr $ra



.data
str0: .asciiz "size: "
a2 : .word 0
c2 : .word 0
size2 : .word 0
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
__result: .space 200
