.text
.globl main
readInteger:
    li $t3 , 10
    li $t1 , 0
    li $t6 , 43 # '+'
    li $t7 , 45 # '-'
    li $t8 , 1
    # Start Calculations
    start_calculations_read_integer:
    li $v0 , 0 # Initialization of answer
    lb $v0 , 0($a0) # loading first digit
    beq $v0 , $t6 , read_integer_positive_sign
    beq $v0 , $t7 , read_integer_negative_sign
    addi $v0 , $v0 , -48 # letter - '0'
    addi $a0 , $a0 , 1
    lb $t1 , 0($a0)
    read_line_loop_decimal:
    lb $t1 , 0($a0)
    beq $t1 , $zero , read_line_end # if letter == '\0'
    addi $t1 , $t1 , -48 # letter - '0'
    mul $v0 , $v0 , $t3 # prev = prev * 10 + ( letter - '0' )
    add $v0 , $v0 , $t1
    addi $a0 , $a0 , 1
    j read_line_loop_decimal

    read_line_end:
    mul $v0 , $v0 , $t8
    jr $ra
    read_integer_positive_sign:
    addi $a0 , $a0 , 1
    j start_calculations_read_integer
    read_integer_negative_sign:
    li $t8 , -1
    addi $a0 , $a0 , 1
    j start_calculations_read_integer

    li $v0, 0
    jr $ra

ReadLine:
        li $t0 , 0
        li $t1 , 10 # '\n'
        loopReadLine:
            li $v0 , 12
            syscall
            addi $t0 , $t0 , 1
            addi $sp , $sp , -1
            beq $v0 , $t1 , endLoopReadLine
            sb $v0 , 1($sp)
            j loopReadLine
            endLoopReadLine:
            sb $zero , 1($sp)
        # Allocating Space in Heap
        li $v0 , 9
        addi $a0 , $t0 , 0
        syscall
        move $t1 , $v0 # $t1 Holds the address of String in Heap
        # Moving String from stack to Heap
        addi $t0 , $t0 , -1 # $t0 is the offset of char in Heap ( from the end of allocated area )
        loopMoveString:
            add $t2 , $t1 , $t0 # $t2 is Char address in Heap
            lb $t3 , 1($sp)
            sb $t3 , 0($t2)
            beq $t0 , $zero , endLoopMoveString
            addi $sp , $sp , 1
            addi $t0 , $t0 , -1
            j loopMoveString
        endLoopMoveString:
        addi $sp , $sp , 1
        # Here $v0 Contains the string address allocated in Heap
        jr $ra

main: # main function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -12 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : b
addi $s7 , $fp , 4
sw $s7, 0($sp) # Push Address of 4 to Stack
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
addi $s7 , $fp , 8
sw $s7, 0($sp) # Push Address of 8 to Stack
addi $sp, $sp, -4
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
addi $sp , $sp , 4 # pop init expr of loop for
label3: # Starting for Loop Body
# Calculating For Loop Condition
# Bool Constant : true
li $t0 , 1
sw $t0 , 0($sp)
addi $sp, $sp, -4
# Loading For Loop Condition Result
addi $sp , $sp , 4
lw $t0 , 0($sp)
beqz $t0 , label4 # Jumping to end label if Condition Expression of for loop is false
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# String Constant : "Please enter the #"
la $t0 , str0
sw $t0 , 0($sp)
addi $sp , $sp , -4
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 4
syscall
# Loading Address of ID : i
addi $s7 , $fp , 8
sw $s7, 0($sp) # Push Address of 8 to Stack
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
# String Constant : " number:"
la $t0 , str1
sw $t0 , 0($sp)
addi $sp , $sp , -4
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 4
syscall
li $v0 , 4
la $a0 , new_line
syscall
# Left Hand Side Assign
# Loading Address of ID : a
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Read Integer ( Decimal or Hexadecimal ) : 
# Read Line : 
addi $sp , $sp , -8
sw $fp , 8($sp)
sw $ra , 4($sp)
jal ReadLine # Calling Read Line Function 
move $a0 , $v0 # Moving address of string to $a0
jal readInteger # Read Integer Function
lw $fp , 8($sp)
lw $ra , 4($sp)
addi $sp , $sp , 4
sw $v0 , 4($sp) # Saving Result Read Integer to Stack
# Assign Right Side to Left
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sw $t1 , 0($t0)
sw $t1 , 8($sp)
addi $sp , $sp , 4
# End of Expression Optional
addi $sp , $sp 4
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
# less than Expression
lw $t0 , 8($sp)
lw $t1 , 4($sp)
slt $t0 , $t0 , $t1
sw $t0 , 8($sp)
addi $sp , $sp , 4
addi $sp , $sp , 4
lw $t0 , 0($sp)
beq $t0 , $zero , label2
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
addi $sp , $sp , 0 # Pop elements before
addi $fp , $sp , 4 # Set framepointer
j label4 # Break from loop for

addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
label2 :
#End of if statement
# Left Hand Side Assign
# Loading Address of ID : b
addi $s7 , $fp , 4
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Loading Address of ID : a
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Loading Address of ID : b
addi $s7 , $fp , 4
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
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
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
# Step Expression of For loop 
# Left Hand Side Assign
# Loading Address of ID : i
addi $s7 , $fp , 8
sw $s7, 0($sp) # Push Address of 8 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Loading Address of ID : i
addi $s7 , $fp , 8
sw $s7, 0($sp) # Push Address of 8 to Stack
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
j label3 # Jumping to beggining of while loop
label4:
# String Constant : "Sum of "
la $t0 , str5
sw $t0 , 0($sp)
addi $sp , $sp , -4
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 4
syscall
# Loading Address of ID : i
addi $s7 , $fp , 8
sw $s7, 0($sp) # Push Address of 8 to Stack
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
# String Constant : " items is: "
la $t0 , str6
sw $t0 , 0($sp)
addi $sp , $sp , -4
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 4
syscall
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
addi $sp , $sp , 12 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
lw $v0, 0($sp)
main_end:
jr $ra



.data
str0: .asciiz "Please enter the #"
str1: .asciiz " number:"
str5: .asciiz "Sum of "
str6: .asciiz " items is: "
a3 : .word 0
i3 : .word 0
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
__result: .space 200
