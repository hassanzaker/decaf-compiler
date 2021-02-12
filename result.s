.text
.globl main
strcat:
	push($ra)	# We will not need this for a while.

	push($a0)	# Save the parameters for first strlen call.
	push($a1)
	push($a2)
	jal strlen      # Get the length of the prefix string.
	push($v0)	# Save the length of the prefix string

	# If $a0 == $a2, we do not need to copy the first string!
	beq $a0, $a2, _strcat_copy_suffix

	# Else, we should copy $a0 into $a2!
	# I know this looks screwy, I am popping all those values from earlier
	# into different registers, and pushing them back in the same order.
	pop($a2)	# This is the saved prefix length
	pop($a0)	# This is the destination buffer
	pop($t0)	# Save the suffix string real quick.
	pop($a1)	# This is the source buffer
	push($a1)	# Save all those values again
	push($t0)
	push($a0)
	push($a2)
	addi $a2, $a2, 1	# strncpy needs to include the nul byte
	jal strncpy
_strcat_copy_suffix:
	# Increment the destination buffer to point to next open character.
	pop($t0)	# The number of chars in prefix
	pop($a2)	# Dest buffer
	pop($a1)	# Suffix string
	pop($a0)	# Prefix string
	add $a2, $a2, $t0
	push($a0)	# Prefix string
	push($a1)	# Suffix string
	push($a2)	# New dest addr

	# Get the length of the suffix string
	move $a0, $a1
	jal strlen

	# Now, use that length for strncpy from the suffix to the destination.
	move $a2, $v0
	pop($a0)
	pop($a1)
	push($a1)
	push($a0)
	addi $a2, $a2, 1	# strncpy needs to include the null byte
	jal strncpy

	# Finally, we can pop everything out and return.
	pop($t0)
	pop($t0)
	pop($t0)
	pop($ra)
	jr $ra


	# strncat: Append two strings into a single buffer.
	# Parameters:
	#	$a0: The address of the prefix string (null-terminated).
	#	$a1: The address of the suffix string (null-terminated).
	#	$a2: The address of the destination buffer.
	#	$a3: The maximum number of bytes to write to $a2.
	# Returns: nothing
	# Notes:
	#  - $a0 may be the same address as $a2.
	#  - $a0 may be the same address as $a1.
	#  - $a1 MAY NOT be the same address as $a2.
	#  - No other overlap between the buffers is allowed.
strncat:
	push($ra)	# We will not need this for a while.

	push($a0)	# Save the parameters for first strlen call.
	push($a1)
	push($a2)
	push($a3)
	jal strlen	# Get the length of the prefix string.
	push($v0)	# Save the length of the prefix string

	# If $a0 == $a2, we do not need to copy the first string!
	beq $a0, $a2, _strncat_copy_suffix

	# Else, we should copy $a0 into $a2!
	# I know this looks screwy, I am popping all those values from earlier
	# into different registers, and pushing them back in the same order.
	pop($a2)	# This is the saved prefix length
	pop($a3)	# N bytes in dest buffer
	pop($a0)	# This is the destination buffer
	pop($t0)	# Save the suffix string real quick.
	pop($a1)	# This is the source buffer
	push($a1)	# Save all those values again!!
	push($t0)
	push($a0)
	push($a3)
	push($a2)

	addi $a2, $a2, 1	# strncpy needs to include the nul byte

	# If the dest buffer has fewer bytes than the source, early return.
	bgt $a2, $a3, _strncat_early_return
	jal strncpy
_strncat_copy_suffix:
	pop($t0)	# The number of chars in prefix
	pop($a3)	# Dest buffer bytes
	pop($a2)	# Dest buffer
	pop($a1)	# Suffix string
	pop($a0)	# Prefix string
	# Increment the destination buffer to point to next open character.
	add $a2, $a2, $t0
	# Decrement the destination buffer bytes remaining.
	sub $a3, $a3, $t0
	push($a0)	# Prefix string
	push($a1)	# Suffix string
	push($a2)	# New dest addr
	push($a3)	# New dest buffer bytes

	# Get the length of the suffix string
	move $a0, $a1
	jal strlen

	# Now, use that length for strncpy from the suffix to the destination.
	move $a2, $v0
	pop($a3)
	pop($a0)
	pop($a1)
	push($a1)
	push($a0)
	push($a3)
	addi $a2, $a2, 1	# strncpy needs to include the nul byte

	# If the dest buffer has fewer bytes than source, early return
	bgt $a2, $a3, _strncat_early_return2
	jal strncpy

	# Finally, we can pop everything out and return.
	pop($t0)
	pop($t0)
	pop($t0)
	pop($t0)
	pop($ra)
	jr $ra

	# These early returns happen when the destination buffer has fewer bytes
	# than one of the source strings.
_strncat_early_return:
	# First string bigger than buffer.
	move $a2, $a3
	jal strncpy
	pop($t0)
	j _strncat_return
_strncat_early_return2:
	# Second string bigger than buffer.
	move $a2, $a3
	jal strncpy
_strncat_return:
	pop($t0)
	pop($t0)
	pop($t0)
	pop($t0)
	pop($ra)
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
# String Constant : "ali"
la $t0 , str0
sw $t0 , 0($sp)
addi $sp , $sp , -4
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
addi $s7 , $fp , 4
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# Right Hand Side Assign
# String Constant : " zaker"
la $t0 , str1
sw $t0 , 0($sp)
addi $sp , $sp , -4
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
# Loading Address of ID : b
addi $s7 , $fp , 4
sw $s7, 0($sp) # Push Address of 4 to Stack
addi $sp, $sp, -4
# loading address of lvalue
lw $t0, 4($sp)
lw $t0 , 0($t0)
sw $t0 , 4($sp)
# Add Expression
lw $a0 , 8($sp)
lw $a1 , 4($sp)
la $a2, __resultaddi $sp , $sp , -8
sw $fp , 8($sp)
sw $ra , 4($sp)
jal strcat # Calling Function to concatenation of two Strings
lw $fp , 8($sp)
lw $ra , 4($sp)
addi $sp , $sp , 8
la $t0, __result
sw $t0 , 8($sp) 
addi $sp , $sp , 4
# Print expr : 
addi $sp , $sp , 4 # Pop Expression of Print
lw $a0 , 0($sp)
li $v0 , 4
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
str0: .asciiz "ali"
str1: .asciiz " zaker"
b1 : .word 0
ali_vtable:
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
__result: .space 200
