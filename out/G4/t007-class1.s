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


# Constructor for Class : Person
Person_Constructor:
li $a0 , 12 # Size of Object ( including Vtable address at index 0 )
li $v0 , 9
syscall
la $t0 , Person_vtable # Loading Vtable Address of this Class
sw $t0 , 0($v0) # Storing Vtable pointer at index 0 of object
jr $ra

__Person_setName: # Start function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : name7
la $s6 , name7
sw $s6, 0($sp) # Push Address of 12 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Loading Address of ID : new_name2
la $s6 , new_name2
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
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
Person_setName_end:
jr $ra

__Person_setAge: # Start function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : age7
la $s6 , age7
sw $s6, 0($sp) # Push Address of 16 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Loading Address of ID : new_age4
la $s6 , new_age4
sw $s6, 0($sp) # Push Address of 4 to Stack
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
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
Person_setAge_end:
jr $ra

__Person_print: # Start function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# String Constant : "Name: "
la $t0 , str0
sw $t0 , 0($sp)
addi $sp , $sp , -4
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 4
syscall
# Loading Address of ID : name7
la $s6 , name7
sw $s6, 0($sp) # Push Address of 12 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 4
syscall
# String Constant : " Age: "
la $t0 , str1
sw $t0 , 0($sp)
addi $sp , $sp , -4
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 4
syscall
# Loading Address of ID : age7
la $s6 , age7
sw $s6, 0($sp) # Push Address of 16 to Stack
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
Person_print_end:
jr $ra

main: # main function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -12 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : name7
la $s6 , name7
sw $s6, 0($sp) # Push Address of 12 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Read Line : 
addi $sp , $sp , -8
sw $fp , 8($sp)
sw $ra , 4($sp)
jal ReadLine # Calling Read Line Function 
lw $fp , 8($sp)
lw $ra , 4($sp)
addi $sp , $sp , 4
sw $v0 , 4($sp)# Saving String Address ( Saved in Heap ) in Stack
# Assign Right Side to Left
lw $t0 , 8($sp)
lw $t1 , 4($sp)
sw $t1 , 0($t0)
sw $t1 , 8($sp)
addi $sp , $sp , 4
# End of Expression Optional
addi $sp , $sp 4
# Left Hand Side Assign
# Loading Address of ID : age7
la $s6 , age7
sw $s6, 0($sp) # Push Address of 16 to Stack
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
# Left Hand Side Assign
# Loading Address of ID : p7
la $s6 , p7
sw $s6, 0($sp) # Push Address of 8 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# new object of type : Person
sw $ra , 0($sp)
addi $sp , $sp , -4
jal Person_Constructor
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
# Calling Method of Object
# Object Expression
# Loading Address of ID : p7
la $s6 , p7
sw $s6, 0($sp) # Push Address of 8 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
lw $t0 , 4($sp)
lw $t0 , 0($t0) # Loading Vtable
addi $t0 , $t0 , 0# Adding offset of Method in Vtable
lw $t0 , 0($t0) # t0 now contains the address of function
sw $t0 , 0($sp) # Storing Function Address in Stack 
addi $sp , $sp , -4
# Storing Frame Pointer and Return Address Before Calling the object's method : setName
addi $sp , $sp , -12
sw $fp , 4($sp)
sw $ra , 8($sp)
sw $s5 , 12($sp)
# Method's Arguments 
# Loading Address of ID : name7
la $s6 , name7
sw $s6, 0($sp) # Push Address of 12 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
la $t1 , new_name2
lw $t0 , 4($sp)
sw $t0 , 0($t1)
lw $t0 , 24($sp) # Loading Object being called
sw $t0 , 0($sp) # Pushing object as "this" as first argument of method
addi $s4 , $t0 , 0
lw $t0 , 20($sp) # Loading Method of object
addi $sp , $sp , -4
jal __Person_setName # Calling Object's method
addi $sp , $sp , 8 # Pop Arguments of Method
# Load Back Frame Pointer and Return Address After Function call
lw $fp , 4($sp)
lw $ra , 8($sp)
lw $s5 , 12($sp)
addi $sp , $sp , 16
sw $v0 , 4($sp) # Push Return Value from Method to Stack
# End of Expression Optional
addi $sp , $sp 4
# Calling Method of Object
# Object Expression
# Loading Address of ID : p7
la $s6 , p7
sw $s6, 0($sp) # Push Address of 8 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
lw $t0 , 4($sp)
lw $t0 , 0($t0) # Loading Vtable
addi $t0 , $t0 , 4# Adding offset of Method in Vtable
lw $t0 , 0($t0) # t0 now contains the address of function
sw $t0 , 0($sp) # Storing Function Address in Stack 
addi $sp , $sp , -4
# Storing Frame Pointer and Return Address Before Calling the object's method : setAge
addi $sp , $sp , -12
sw $fp , 4($sp)
sw $ra , 8($sp)
sw $s5 , 12($sp)
# Method's Arguments 
# Loading Address of ID : age7
la $s6 , age7
sw $s6, 0($sp) # Push Address of 16 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
la $t1 , new_age4
lw $t0 , 4($sp)
sw $t0 , 0($t1)
lw $t0 , 24($sp) # Loading Object being called
sw $t0 , 0($sp) # Pushing object as "this" as first argument of method
addi $s4 , $t0 , 0
lw $t0 , 20($sp) # Loading Method of object
addi $sp , $sp , -4
jal __Person_setAge # Calling Object's method
addi $sp , $sp , 8 # Pop Arguments of Method
# Load Back Frame Pointer and Return Address After Function call
lw $fp , 4($sp)
lw $ra , 8($sp)
lw $s5 , 12($sp)
addi $sp , $sp , 16
sw $v0 , 4($sp) # Push Return Value from Method to Stack
# End of Expression Optional
addi $sp , $sp 4
# Calling Method of Object
# Object Expression
# Loading Address of ID : p7
la $s6 , p7
sw $s6, 0($sp) # Push Address of 8 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
lw $t0 , 4($sp)
lw $t0 , 0($t0) # Loading Vtable
addi $t0 , $t0 , 8# Adding offset of Method in Vtable
lw $t0 , 0($t0) # t0 now contains the address of function
sw $t0 , 0($sp) # Storing Function Address in Stack 
addi $sp , $sp , -4
# Storing Frame Pointer and Return Address Before Calling the object's method : print
addi $sp , $sp , -12
sw $fp , 4($sp)
sw $ra , 8($sp)
sw $s5 , 12($sp)
# Method's Arguments 
lw $t0 , 20($sp) # Loading Object being called
sw $t0 , 0($sp) # Pushing object as "this" as first argument of method
addi $s4 , $t0 , 0
lw $t0 , 16($sp) # Loading Method of object
addi $sp , $sp , -4
jal __Person_print # Calling Object's method
addi $sp , $sp , 4 # Pop Arguments of Method
# Load Back Frame Pointer and Return Address After Function call
lw $fp , 4($sp)
lw $ra , 8($sp)
lw $s5 , 12($sp)
addi $sp , $sp , 16
sw $v0 , 4($sp) # Push Return Value from Method to Stack
# End of Expression Optional
addi $sp , $sp 4
addi $sp , $sp , 12 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
lw $v0, 0($sp)
main_end:
jr $ra



.data
str0: .asciiz "Name: "
str1: .asciiz " Age: "
new_name2 : .word 0
new_age4 : .word 0
p7 : .word 0
name7 : .word 0
age7 : .word 0
Person_vtable:
	.word Person_setName
	.word Person_setAge
	.word Person_print
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
__result: .space 200
