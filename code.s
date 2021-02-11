.text
.globl main
#-------------------------------------------- Compiler Functions --------------------------------------------#
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

StringsEquality:
	move $t1 , $a0 # String 1
	move $t2 , $a1 # String 2
	li $t5 , 1
	loopCheckEquality:
		lb $t3 , 0($t1)
		lb $t4 , 0($t2)
		bne $t3 , $t4 , StringsNotEqualLabel
		beq $t3 , $zero , endLoopCheckEquality
		addi $t1 , $t1 , 1
		addi $t2 , $t2 , 1
		j loopCheckEquality
		StringsNotEqualLabel:
		li $t5 , 0
	endLoopCheckEquality:
	move $v0 , $t5
	jr $ra

StringsInequality:
	addi $sp , $sp , -4
	sw $ra , 4($sp)
	jal StringsEquality
	addi $sp , $sp , 4
	lw $ra , 0($sp)
	nor $v0 , $v0 , $v0
	addi $v0 , $v0 , 2 # All 1's from bit[1] to left becomes Zero
	jr $ra

readInteger:
    li $t3 , 10
    li $t1 , 0
    li $t4 , 120 # 'x'
    li $t5 , 88 # 'X'
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
    beq $t1 , $t5 , read_line_hexadecimal # if the second letter is X then its Hexadecimal
    beq $t1 , $t4 , read_line_hexadecimal # if the second letter is x then its Hexadecimal
    read_line_loop_decimal:
    lb $t1 , 0($a0)
    beq $t1 , $zero , read_line_end # if letter == '\0'
    addi $t1 , $t1 , -48 # letter - '0'
    mul $v0 , $v0 , $t3 # prev = prev * 10 + ( letter - '0' )
    add $v0 , $v0 , $t1
    addi $a0 , $a0 , 1
    j read_line_loop_decimal
    # ReadInteger For Hexadecimal
    read_line_hexadecimal:
    addi $a0 , $a0 , 1
    read_line_loop_hexadecimal:
    li $t1 , 0
    lb $t1 , 0($a0)
    beq $t1 , $zero , read_line_end # if letter == '\0'
    bge $t1 , 97 , read_line_hexadecimal_lowercase # if letter >= 'a'
    bge $t1 , 65 , read_line_hexadecimal_uppercase # if letter >= 'A'
    addi $t1 , $t1 , -48 # num = letter - '0'
    j read_line_hexadecimal_add
    read_line_hexadecimal_uppercase:
    addi $t1 , $t1 , -65 # letter - 'A'
    addi $t1 , $t1 , 10 # num = letter - 'A' + 10
    j read_line_hexadecimal_add
    read_line_hexadecimal_lowercase:
    addi $t1 , $t1 , -97 # letter - 'a'
    addi $t1 , $t1 , 10 # num = letter - 'a' + 10
    read_line_hexadecimal_add:
    sll $v0 , $v0 , 4
    add $v0 , $v0 , $t1 # Prev = Prev * 16 + num
    addi $a0 , $a0 , 1
    j read_line_loop_hexadecimal
    # End of Function
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

itod:
	lw $t0 , 4($sp)
    mtc1 $t0, $f12
    cvt.s.w $f12, $f12
    mov.s $f0 , $f12
	jr $ra

dtoi:
	l.s $f0 , 4($sp)
	cvt.w.s $f1,$f0
    mfc1 $v0 , $f1 # $v0 is floor of double
    # Convert $v0 to double
    mtc1 $v0 , $f1
    cvt.s.w $f1 , $f1
    # get decimal
    sub.s $f0 , $f0 , $f1
    li.s $f1 , 0.0
    c.lt.s $f0 , $f1
    bc1t conversion_dtoi_negative
    li.s $f1 , 0.5
    c.lt.s $f0 , $f1
    bc1t end_conversion_dtoi
    addi $v0 , $v0 , 1
    j end_conversion_dtoi
    conversion_dtoi_negative:
    li.s $f1 , -0.5
    c.lt.s $f0 , $f1
    bc1f end_conversion_dtoi
    addi $v0 , $v0 , -1
    end_conversion_dtoi:
	jr $ra

itob:
	lw $v0 , 4($sp)
	beqz $v0 , end_conversion_itob
	li $v0 , 1
	end_conversion_itob:
	jr $ra

btoi:
    lw $v0 , 4($sp)
	jr $ra
main: # Start function
addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5
# Function Body :
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Initialization Expression of Loop for
label0: # Starting for Loop Body
# Calculating For Loop Condition
# Int Constant : 4
li $t0 , 4
sw $t0 , 0($sp)
addi $sp, $sp, -4
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
beqz $t0 , label1 # Jumping to end label if Condition Expression of for loop is false
# Begin of Statement Block
addi $sp , $sp , -0 # Allocate From Stack For Block Statement Variables
addi $fp , $sp , 4
# Int Constant : 3
li $t0 , 3
sw $t0 , 0($sp)
addi $sp, $sp, -4
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
j label1 # Jumping to beggining of while loop
label1:
addi $sp , $sp , 0 # UnAllocate Stack Area (Removing Block Statement Variables)
addi $fp ,$sp , 4
# End of Statement Block
main_end:
jr $ra



.data
str_false : .asciiz "false" 
str_true : .asciiz "true" 
new_line : .asciiz "
" 
str_bool : .word str_false , str_true
obj_null : .word 61235
