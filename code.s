__Ali_setA: # Start function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Loading Address of ID : y
li $s6 , 4
addi $s6 , $s6 , 8
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
lw $v0, 0($sp)
Ali_setA_end:
jr $ra