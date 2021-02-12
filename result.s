.text
.globl main
itod:
	lw $t0 , 4($sp)
#	lw $a0 , 4($sp)
#	li $v0 , 1
#	syscall
#	li $v0 , 4
 #   la $a0 , new_line
#    syscall
    mtc1 $t0, $f12
    cvt.s.w $f12, $f12
    mov.s $f0 , $f12
 #   li $v0 , 2
#    syscall
#    li $v0 , 4
 #   la $a0 , new_line
  #  syscall
	jr $ra

# Constructor for Class : ali
ali_Constructor:
li $a0 , 8 # Size of Object ( including Vtable address at index 0 )
li $v0 , 9
syscall
la $t0 , ali_vtable # Loading Vtable Address of this Class
sw $t0 , 0($v0) # Storing Vtable pointer at index 0 of object
jr $ra

main: # Start function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -8 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Left Hand Side Assign
# Loading Address of ID : a
addi $s7 , $fp , 0
sw $s7, 0($sp) # Push Address of 0 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# Int Constant : 5
li $t0 , 5
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
# Loading Address of ID : d
addi $s7 , $fp , 4
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# itod 
addi $sp , $sp , -8
sw $fp , 8($sp)
sw $ra , 4($sp)
jal itod # Calling itod Function 
lw $fp , 8($sp)
lw $ra , 4($sp)
addi $sp , $sp , 4
sw $v0 , 4($sp)
# Assign Right Side to Left
lw $t0 , 8($sp)
l.s $f0 , 4($sp)
s.s $f0 , 0($t0)
s.s $f0 , 8($sp)
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
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 1
syscall
li $v0 , 4
la $a0 , new_line
syscall
# Loading Address of ID : d
addi $s7 , $fp , 4
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
l.s $f12 , 0($sp)
li $v0 , 2
syscall
li $v0 , 4
la $a0 , new_line
syscall
addi $sp , $sp , 8 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
main_end:
jr $ra



.data
d1 : .float 0.0
ali_vtable:
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
