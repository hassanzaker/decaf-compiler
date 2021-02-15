.text
.globl main

# Constructor for Class : Ali
Ali_Constructor:
li $a0 , 8 # Size of Object ( including Vtable address at index 0 )
li $v0 , 9
syscall
la $t0 , Ali_vtable # Loading Vtable Address of this Class
sw $t0 , 0($v0) # Storing Vtable pointer at index 0 of object
jr $ra

# Constructor for Class : Hassan
Hassan_Constructor:
li $a0 , 8 # Size of Object ( including Vtable address at index 0 )
li $v0 , 9
syscall
la $t0 , Hassan_vtable # Loading Vtable Address of this Class
sw $t0 , 0($v0) # Storing Vtable pointer at index 0 of object
jr $ra

__Ali_f: # Start function
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
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 1
syscall
li $v0 , 4
la $a0 , new_line
syscall
# Loading Address of ID : e2
li $s6 , 4
add $s7 , $fp , $s6
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
# Loading Address of ID : f2
li $s6 , 4
add $s7 , $fp , $s6
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
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
Ali_f_end:
jr $ra

__Ali_g: # Start function
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
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 1
syscall
li $v0 , 4
la $a0 , new_line
syscall
# Loading Address of ID : g4
li $s6 , 4
add $s7 , $fp , $s6
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
li $v0 , 4
la $a0 , new_line
syscall
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
Ali_g_end:
jr $ra

__Ali_h: # Start function
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
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 1
syscall
li $v0 , 4
la $a0 , new_line
syscall
# Loading Address of ID : r6
li $s6 , 4
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 12 to Stack
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
Ali_h_end:
jr $ra

__Hassan_f: # Start function
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
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 1
syscall
li $v0 , 4
la $a0 , new_line
syscall
# Loading Address of ID : e8
li $s6 , 4
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
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
Hassan_f_end:
jr $ra

__Hassan_g: # Start function
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
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 1
syscall
li $v0 , 4
la $a0 , new_line
syscall
# Loading Address of ID : g10
li $s6 , 4
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 20 to Stack
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
Hassan_g_end:
jr $ra

__Hassan_h: # Start function
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
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 1
syscall
li $v0 , 4
la $a0 , new_line
syscall
# Loading Address of ID : r12
li $s6 , 4
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 24 to Stack
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
Hassan_h_end:
jr $ra

main: # main function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -8 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : a13
li $s6 , 0
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 28 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# new object of type : Ali
sw $ra , 0($sp)
addi $sp , $sp , -4
jal Ali_Constructor
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
# Loading Address of ID : b13
li $s6 , 0
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 32 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# new object of type : Hassan
sw $ra , 0($sp)
addi $sp , $sp , -4
jal Hassan_Constructor
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
# Loading Variable of Object
# Loading Address of ID : a13
li $s6 , 0
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 28 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
lw $t0 , 4($sp)
addi $t0 , $t0 , 0 # add offset of variable to object address
sw $t0 , 4($sp)
# Right Hand Side Assign
# Int Constant : 7
li $t0 , 7
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
# Calling Method of Object
# Object Expression
# Loading Address of ID : a13
li $s6 , 0
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 28 to Stack
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
# Storing Frame Pointer and Return Address Before Calling the object's method : f
addi $sp , $sp , -12
sw $fp , 4($sp)
sw $ra , 8($sp)
sw $s5 , 12($sp)
# Method's Arguments 
# Int Constant : 2
li $t0 , 2
sw $t0 , 0($sp)
addi $sp, $sp, -4
# Int Constant : 33
li $t0 , 33
sw $t0 , 0($sp)
addi $sp, $sp, -4
lw $t0 , 28($sp) # Loading Object being called
sw $t0 , 0($sp) # Pushing object as "this" as first argument of method
addi $s4 , $t0 , 0
lw $t0 , 24($sp) # Loading Method of object
addi $sp , $sp , -4
jal __Ali_f # Calling Object's method
addi $sp , $sp , 12 # Pop Arguments of Method
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
# Loading Address of ID : a13
li $s6 , 0
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 28 to Stack
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
# Storing Frame Pointer and Return Address Before Calling the object's method : g
addi $sp , $sp , -12
sw $fp , 4($sp)
sw $ra , 8($sp)
sw $s5 , 12($sp)
# Method's Arguments 
# Int Constant : 44
li $t0 , 44
sw $t0 , 0($sp)
addi $sp, $sp, -4
lw $t0 , 24($sp) # Loading Object being called
sw $t0 , 0($sp) # Pushing object as "this" as first argument of method
addi $s4 , $t0 , 0
lw $t0 , 20($sp) # Loading Method of object
addi $sp , $sp , -4
jal __Ali_g # Calling Object's method
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
# Loading Address of ID : a13
li $s6 , 0
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 28 to Stack
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
# Storing Frame Pointer and Return Address Before Calling the object's method : h
addi $sp , $sp , -12
sw $fp , 4($sp)
sw $ra , 8($sp)
sw $s5 , 12($sp)
# Method's Arguments 
# Int Constant : 55
li $t0 , 55
sw $t0 , 0($sp)
addi $sp, $sp, -4
lw $t0 , 24($sp) # Loading Object being called
sw $t0 , 0($sp) # Pushing object as "this" as first argument of method
addi $s4 , $t0 , 0
lw $t0 , 20($sp) # Loading Method of object
addi $sp , $sp , -4
jal __Ali_h # Calling Object's method
addi $sp , $sp , 8 # Pop Arguments of Method
# Load Back Frame Pointer and Return Address After Function call
lw $fp , 4($sp)
lw $ra , 8($sp)
lw $s5 , 12($sp)
addi $sp , $sp , 16
sw $v0 , 4($sp) # Push Return Value from Method to Stack
# End of Expression Optional
addi $sp , $sp 4
# Left Hand Side Assign
# Loading Variable of Object
# Loading Address of ID : b13
li $s6 , 0
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 32 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
lw $t0 , 4($sp)
addi $t0 , $t0 , 0 # add offset of variable to object address
sw $t0 , 4($sp)
# Right Hand Side Assign
# Int Constant : 13
li $t0 , 13
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
# Calling Method of Object
# Object Expression
# Loading Address of ID : b13
li $s6 , 0
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 32 to Stack
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
# Storing Frame Pointer and Return Address Before Calling the object's method : f
addi $sp , $sp , -12
sw $fp , 4($sp)
sw $ra , 8($sp)
sw $s5 , 12($sp)
# Method's Arguments 
# Int Constant : 3
li $t0 , 3
sw $t0 , 0($sp)
addi $sp, $sp, -4
lw $t0 , 24($sp) # Loading Object being called
sw $t0 , 0($sp) # Pushing object as "this" as first argument of method
addi $s4 , $t0 , 0
lw $t0 , 20($sp) # Loading Method of object
addi $sp , $sp , -4
jal __Hassan_f # Calling Object's method
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
# Loading Address of ID : b13
li $s6 , 0
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 32 to Stack
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
# Storing Frame Pointer and Return Address Before Calling the object's method : g
addi $sp , $sp , -12
sw $fp , 4($sp)
sw $ra , 8($sp)
sw $s5 , 12($sp)
# Method's Arguments 
# Int Constant : 4
li $t0 , 4
sw $t0 , 0($sp)
addi $sp, $sp, -4
lw $t0 , 24($sp) # Loading Object being called
sw $t0 , 0($sp) # Pushing object as "this" as first argument of method
addi $s4 , $t0 , 0
lw $t0 , 20($sp) # Loading Method of object
addi $sp , $sp , -4
jal __Hassan_g # Calling Object's method
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
# Loading Address of ID : b13
li $s6 , 0
add $s7 , $fp , $s6
sw $s7, 0($sp) # Push Address of 32 to Stack
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
# Storing Frame Pointer and Return Address Before Calling the object's method : h
addi $sp , $sp , -12
sw $fp , 4($sp)
sw $ra , 8($sp)
sw $s5 , 12($sp)
# Method's Arguments 
# Int Constant : 5
li $t0 , 5
sw $t0 , 0($sp)
addi $sp, $sp, -4
lw $t0 , 24($sp) # Loading Object being called
sw $t0 , 0($sp) # Pushing object as "this" as first argument of method
addi $s4 , $t0 , 0
lw $t0 , 20($sp) # Loading Method of object
addi $sp , $sp , -4
jal __Hassan_h # Calling Object's method
addi $sp , $sp , 8 # Pop Arguments of Method
# Load Back Frame Pointer and Return Address After Function call
lw $fp , 4($sp)
lw $ra , 8($sp)
lw $s5 , 12($sp)
addi $sp , $sp , 16
sw $v0 , 4($sp) # Push Return Value from Method to Stack
# End of Expression Optional
addi $sp , $sp 4
addi $sp , $sp , 8 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
lw $v0, 0($sp)
main_end:
jr $ra



.data
e2 : .word 0
f2 : .word 0
g4 : .word 0
r6 : .word 0
e8 : .word 0
g10 : .word 0
r12 : .word 0
a13 : .word 0
b13 : .word 0
Ali_vtable:
	.word Ali_f
	.word Ali_g
	.word Ali_h
Hassan_vtable:
	.word Hassan_f
	.word Hassan_g
	.word Hassan_h
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
__result: .space 200
