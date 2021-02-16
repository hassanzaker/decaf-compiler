.text
.globl main
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
    li $s3 , 9
    sgt $s2 , $t1 , $s3
    beq $s2 , 1 , read_line_zero
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
    read_line_zero:
    li $v0, 0
    jr $ra


__sort: # Start function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -12 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : n2
la $s6 , n2
sw $s6, 0($sp) # Push Address of 12 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Array Length
# Array Expr
# Loading Address of ID : items3
la $s6 , items3
sw $s6, 0($sp) # Push Address of 16 to Stack
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
# Initialization Expression of Loop for
# Left Hand Side Assign
# Loading Address of ID : i2
la $s6 , i2
sw $s6, 0($sp) # Push Address of 4 to Stack
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
label3: # Starting for Loop Body
# Calculating For Loop Condition
# Loading Address of ID : i2
la $s6 , i2
sw $s6, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Loading Address of ID : n2
la $s6 , n2
sw $s6, 0($sp) # Push Address of 12 to Stack
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
# less than Expression
lw $t0 , 8($sp)
lw $t1 , 4($sp)
slt $t0 , $t0 , $t1
sw $t0 , 8($sp)
addi $sp , $sp , 4
# Loading For Loop Condition Result
addi $sp , $sp , 4
lw $t0 , 0($sp)
beqz $t0 , label4 # Jumping to end label if Condition Expression of for loop is false
# Initialization Expression of Loop for
# Left Hand Side Assign
# Loading Address of ID : j2
la $s6 , j2
sw $s6, 0($sp) # Push Address of 8 to Stack
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
# Loading Address of ID : j2
la $s6 , j2
sw $s6, 0($sp) # Push Address of 8 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Loading Address of ID : n2
la $s6 , n2
sw $s6, 0($sp) # Push Address of 12 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Loading Address of ID : i2
la $s6 , i2
sw $s6, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# minus Expression
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sub $t0 , $t0 , $t1
sw $t0 , 8($sp)
addi $sp , $sp , 4
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
# Get Array index
# Base Address of Array
# Loading Address of ID : items3
la $s6 , items3
sw $s6, 0($sp) # Push Address of 16 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Expression index of Array
# Loading Address of ID : j2
la $s6 , j2
sw $s6, 0($sp) # Push Address of 8 to Stack
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
# Get Array index
# Base Address of Array
# Loading Address of ID : items3
la $s6 , items3
sw $s6, 0($sp) # Push Address of 16 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Expression index of Array
# Loading Address of ID : j2
la $s6 , j2
sw $s6, 0($sp) # Push Address of 8 to Stack
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
# greater than Expression
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sgt $t0 , $t0 , $t1
sw $t0 , 8($sp)
addi $sp , $sp , 4
addi $sp , $sp , 4
lw $t0 , 0($sp)
beq $t0 , $zero , label0
# Begin of Statement Block
addi $sp , $sp , -4 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : t1
la $s6 , t1
sw $s6, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Get Array index
# Base Address of Array
# Loading Address of ID : items3
la $s6 , items3
sw $s6, 0($sp) # Push Address of 16 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Expression index of Array
# Loading Address of ID : j2
la $s6 , j2
sw $s6, 0($sp) # Push Address of 8 to Stack
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
# Loading Address of ID : items3
la $s6 , items3
sw $s6, 0($sp) # Push Address of 16 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Expression index of Array
# Loading Address of ID : j2
la $s6 , j2
sw $s6, 0($sp) # Push Address of 8 to Stack
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
# Right Hand Side Assign
# Get Array index
# Base Address of Array
# Loading Address of ID : items3
la $s6 , items3
sw $s6, 0($sp) # Push Address of 16 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Expression index of Array
# Loading Address of ID : j2
la $s6 , j2
sw $s6, 0($sp) # Push Address of 8 to Stack
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
# Loading Address of ID : items3
la $s6 , items3
sw $s6, 0($sp) # Push Address of 16 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Expression index of Array
# Loading Address of ID : j2
la $s6 , j2
sw $s6, 0($sp) # Push Address of 8 to Stack
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
lw $t0 , 8($sp) # base Address of Array
lw $t1 , 4($sp) # index of Array
addi $sp , $sp , 4
addi $t1 , $t1 , 1
sll $t1 , $t1 , 2
add $t0 , $t0 , $t1
sw $t0 , 4($sp) # Pushing address of arr[index] result to Stack
# Right Hand Side Assign
# Loading Address of ID : t1
la $s6 , t1
sw $s6, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Assign Right Side to Left
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sw $t1 , 0($t0)
sw $t1 , 8($sp)
addi $sp , $sp , 4
# End of Expression Optional
addi $sp , $sp 4
addi $sp , $sp , 4 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
label0 :
#End of if statement
# Step Expression of For loop 
# Left Hand Side Assign
# Loading Address of ID : j2
la $s6 , j2
sw $s6, 0($sp) # Push Address of 8 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Loading Address of ID : j2
la $s6 , j2
sw $s6, 0($sp) # Push Address of 8 to Stack
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
# Step Expression of For loop 
# Left Hand Side Assign
# Loading Address of ID : i2
la $s6 , i2
sw $s6, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Loading Address of ID : i2
la $s6 , i2
sw $s6, 0($sp) # Push Address of 4 to Stack
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
addi $sp , $sp , 12 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
sort_end:
jr $ra

main: # main function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -16 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# String Constant : "Please enter the numbers (max count: 100, enter -1 to end sooner): "
la $t0 , str5
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
# Loading Address of ID : rawitems7
la $s6 , rawitems7
sw $s6, 0($sp) # Push Address of 32 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Expression of Array Size
# Int Constant : 100
li $t0 , 100
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
# Initialization Expression of Loop for
# Left Hand Side Assign
# Loading Address of ID : i7
la $s6 , i7
sw $s6, 0($sp) # Push Address of 24 to Stack
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
label9: # Starting for Loop Body
# Calculating For Loop Condition
# Loading Address of ID : i7
la $s6 , i7
sw $s6, 0($sp) # Push Address of 24 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Int Constant : 100
li $t0 , 100
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
beqz $t0 , label10 # Jumping to end label if Condition Expression of for loop is false
# Begin of Statement Block
addi $sp , $sp , -4 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : x4
la $s6 , x4
sw $s6, 0($sp) # Push Address of 20 to Stack
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
# Loading Address of ID : x4
la $s6 , x4
sw $s6, 0($sp) # Push Address of 20 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Int Constant : 1
li $t0 , 1
sw $t0 , 0($sp)
addi $sp, $sp, -4
# Negative an expression
lw $t0 , 4($sp)
neg $t0 , $t0
sw $t0 , 4($sp)
#  equality of Expressions
lw $t0 , 8($sp)
lw $t1 , 4($sp)
beq $t0 , $t1 , label6
li $t0, 0
j label7
label6 :
li $t0 , 1
label7 :
sw $t0 , 8($sp)
addi $sp , $sp , 4
addi $sp , $sp , 4
lw $t0 , 0($sp)
beq $t0 , $zero , label8
addi $sp , $sp , 0 # Pop elements before
addi $fp , $sp , 4 # Set framepointer
j label10 # Break from loop for

label8 :
#End of if statement
# Left Hand Side Assign
# Get Array index
# Base Address of Array
# Loading Address of ID : rawitems7
la $s6 , rawitems7
sw $s6, 0($sp) # Push Address of 32 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Expression index of Array
# Loading Address of ID : i7
la $s6 , i7
sw $s6, 0($sp) # Push Address of 24 to Stack
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
# Right Hand Side Assign
# Loading Address of ID : x4
la $s6 , x4
sw $s6, 0($sp) # Push Address of 20 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Assign Right Side to Left
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sw $t1 , 0($t0)
sw $t1 , 8($sp)
addi $sp , $sp , 4
# End of Expression Optional
addi $sp , $sp 4
addi $sp , $sp , 4 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
# Step Expression of For loop 
# Left Hand Side Assign
# Loading Address of ID : i7
la $s6 , i7
sw $s6, 0($sp) # Push Address of 24 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Loading Address of ID : i7
la $s6 , i7
sw $s6, 0($sp) # Push Address of 24 to Stack
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
j label9 # Jumping to beggining of while loop
label10:
# Left Hand Side Assign
# Loading Address of ID : items7
la $s6 , items7
sw $s6, 0($sp) # Push Address of 36 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Expression of Array Size
# Loading Address of ID : i7
la $s6 , i7
sw $s6, 0($sp) # Push Address of 24 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
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
# Initialization Expression of Loop for
# Left Hand Side Assign
# Loading Address of ID : j7
la $s6 , j7
sw $s6, 0($sp) # Push Address of 28 to Stack
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
label11: # Starting for Loop Body
# Calculating For Loop Condition
# Loading Address of ID : j7
la $s6 , j7
sw $s6, 0($sp) # Push Address of 28 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Loading Address of ID : i7
la $s6 , i7
sw $s6, 0($sp) # Push Address of 24 to Stack
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
beqz $t0 , label12 # Jumping to end label if Condition Expression of for loop is false
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Get Array index
# Base Address of Array
# Loading Address of ID : items7
la $s6 , items7
sw $s6, 0($sp) # Push Address of 36 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Expression index of Array
# Loading Address of ID : j7
la $s6 , j7
sw $s6, 0($sp) # Push Address of 28 to Stack
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
# Right Hand Side Assign
# Get Array index
# Base Address of Array
# Loading Address of ID : rawitems7
la $s6 , rawitems7
sw $s6, 0($sp) # Push Address of 32 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Expression index of Array
# Loading Address of ID : j7
la $s6 , j7
sw $s6, 0($sp) # Push Address of 28 to Stack
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
# Loading Address of ID : j7
la $s6 , j7
sw $s6, 0($sp) # Push Address of 28 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Loading Address of ID : j7
la $s6 , j7
sw $s6, 0($sp) # Push Address of 28 to Stack
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
j label11 # Jumping to beggining of while loop
label12:
# Storing Frame Pointer and Return Address Before Calling the function : sort
addi $sp , $sp , -12
sw $fp , 4($sp)
sw $ra , 8($sp)
sw $s5 , 12($sp)
# Function Arguments
# Loading Address of ID : items7
la $s6 , items7
sw $s6, 0($sp) # Push Address of 36 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
la $t1 , items3
lw $t0 , 4($sp)
sw $t0 , 0($t1)
jal __sort # Calling Function
# Pop Arguments of function
addi $sp , $sp , 4
# Load Back Frame Pointer and Return Address After Function call
lw $fp , 4($sp)
lw $ra , 8($sp)
lw $s5 , 12($sp)
addi $sp , $sp , 8
sw $v0 , 4($sp) # Push Return Value from function to Stack
# End of Expression Optional
addi $sp , $sp 4
# String Constant : "After sort: "
la $t0 , str13
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
# Initialization Expression of Loop for
# Left Hand Side Assign
# Loading Address of ID : i7
la $s6 , i7
sw $s6, 0($sp) # Push Address of 24 to Stack
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
label14: # Starting for Loop Body
# Calculating For Loop Condition
# Loading Address of ID : i7
la $s6 , i7
sw $s6, 0($sp) # Push Address of 24 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Array Length
# Array Expr
# Loading Address of ID : items7
la $s6 , items7
sw $s6, 0($sp) # Push Address of 36 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
lw $t0 , 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp) # Pushing length of array to stack
# less than Expression
lw $t0 , 8($sp)
lw $t1 , 4($sp)
slt $t0 , $t0 , $t1
sw $t0 , 8($sp)
addi $sp , $sp , 4
# Loading For Loop Condition Result
addi $sp , $sp , 4
lw $t0 , 0($sp)
beqz $t0 , label15 # Jumping to end label if Condition Expression of for loop is false
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Get Array index
# Base Address of Array
# Loading Address of ID : items7
la $s6 , items7
sw $s6, 0($sp) # Push Address of 36 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Expression index of Array
# Loading Address of ID : i7
la $s6 , i7
sw $s6, 0($sp) # Push Address of 24 to Stack
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
# Loading Address of ID : i7
la $s6 , i7
sw $s6, 0($sp) # Push Address of 24 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Loading Address of ID : i7
la $s6 , i7
sw $s6, 0($sp) # Push Address of 24 to Stack
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
j label14 # Jumping to beggining of while loop
label15:
addi $sp , $sp , 16 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
lw $v0, 0($sp)
main_end:
jr $ra



.data
str5: .asciiz "Please enter the numbers (max count: 100, enter -1 to end sooner): "
str13: .asciiz "After sort: "
t1 : .word 0
i2 : .word 0
j2 : .word 0
n2 : .word 0
items3 : .word 0
x4 : .word 0
i7 : .word 0
j7 : .word 0
rawitems7 : .word 0
items7 : .word 0
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
__result: .space 200
