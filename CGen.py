import os
import re
from ClassTable import Classes, Class
from lark import Lark, Transformer


class Cgen(Transformer):
    def __init__(self, classes, symbol_table):
        self.scope = 0
        self.classes = classes
        self.symbol_table = symbol_table
        self.data_code = ''
        self.string_numbers = 0
        self.label_number = 0
        self.break_labels = 0
        self.continue_labels = 0
        self.builtin_functions = []
        self.stack = []
        self.last_class = 0

    def write_code_in_file(self, code):
        dirname = os.path.dirname(__file__)
        file = open(dirname + "/result.s", "w")
        file.write(code)
        file.close()

    def aexp(self, args):
        return args[0]

    def bexp(self, args):
        return args[0]

    def cexp(self, args):
        return args[0]

    def dexp(self, args):
        return args[0]

    def eexp(self, args):
        return args[0]

    def fexp(self, args):
        return args[0]
    ########### Arethmatic ###############

    def exp_plus_exp(self, args):
        value_type1 = args[0]['value_type']
        value_type2 = args[1]['value_type']
        code = "# Add Expression\n"
        if value_type1 == 'int' and value_type2 == value_type1:
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "add $t0 , $t0 , $t1\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type1 == 'double' and value_type2 == value_type1:
            code += "l.s $f0 , 8($sp)\n"
            code += "l.s $f1 , 4($sp)\n"
            code += "add.s $f0 , $f0 , $f1\n"
            code += "s.s $f0 , 8($sp)\n"
        elif value_type1 == 'string' and value_type2 == value_type1:
            self.builtin_functions.append('str_concat')
            code += "lw $a0 , 8($sp)\n"
            code += "lw $a1 , 4($sp)\n"
            code += "la $a2, __result\n"
            code += "addi $sp , $sp , -8\n"
            code += "sw $fp , 8($sp)\n"
            code += "sw $ra , 4($sp)\n"
            code += "jal strcat # Calling Function to concatenation of two Strings\n"
            code += "lw $fp , 8($sp)\n"
            code += "lw $ra , 4($sp)\n"
            code += "addi $sp , $sp , 8\n"
            code += "la $t0, __result\n"
            code += "sw $t0 , 8($sp) \n"
        elif value_type1[len(value_type1)-2:len(value_type1)] == '[]' and value_type2 == value_type1:
            self.builtin_functions.append('array_concat')
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "lw $s0 , 0($t0)\n"
            code += "lw $s1 , 0($t1)\n"
            code += "add $s3 , $s0 , $s1      #size of concat array\n  "
            code += "move $a0 , $t0\n"
            code += "move $a1 , $t1\n"
            code += "la $t2, __result\n"
            code += "sw $s3 , 0($t2)          #size \n"
            code += "addi $a2 , $t2, 4\n"
            code += "addi $sp , $sp , -8\n"
            code += "sw $fp , 8($sp)\n"
            code += "sw $ra , 4($sp)\n"
            code += "jal arraycat # Calling Function to concatenation of two Strings\n"
            code += "lw $fp , 8($sp)\n"
            code += "lw $ra , 4($sp)\n"
            code += "addi $sp , $sp , 8\n"
            code += "la $t0, __result\n"
            code += "sw $t0 , 8($sp) \n"
        else:
            raise Exception("Can Not Add " + value_type1 + " to " + value_type2 + "!")
        code += "addi $sp , $sp , 4\n"
        return {'code': args[0]['code'] + args[1]['code'] + code,
                'value_type': value_type1}

    def exp_minus_exp(self, args):
        value_type1 = args[0]['value_type']
        value_type2 = args[1]['value_type']
        code = "# minus Expression\n"
        if value_type1 == 'int' and value_type2 == value_type1:
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "sub $t0 , $t0 , $t1\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type1 == 'double' and value_type2 == value_type1:
            code += "l.s $f0 , 8($sp)\n"
            code += "l.s $f1 , 4($sp)\n"
            code += "sub.s $f0 , $f0 , $f1\n"
            code += "s.s $f0 , 8($sp)\n"
        else:
            raise Exception("Can Not Subtract " + value_type1 + " from " + value_type2 + "!")
        code += "addi $sp , $sp , 4\n"
        return {'code': args[0]['code'] + args[1]['code'] + code,
                'value_type': value_type1}

    def exp_mul_exp(self, args):
        value_type1 = args[0]['value_type']
        value_type2 = args[1]['value_type']
        code = "# div Expression\n"
        if value_type1 == 'int' and value_type2 == value_type1:
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "mul $t0 , $t0 , $t1\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type1 == 'double' and value_type2 == value_type1:
            code += "l.s $f0 , 8($sp)\n"
            code += "l.s $f1 , 4($sp)\n"
            code += "mul.s $f0 , $f0 , $f1\n"
            code += "s.s $f0 , 8($sp)\n"
        else:
            raise Exception("Can Not do Multiplication " + value_type1 + " with " + value_type2 + "!")
        code += "addi $sp , $sp , 4\n"
        return {'code': args[0]['code'] + args[1]['code'] + code,
                'value_type': value_type1}

    def exp_div_exp(self, args):
        value_type1 = args[0]['value_type']
        value_type2 = args[1]['value_type']
        code = "# div Expression\n"
        if value_type1 == 'int' and value_type2 == value_type1:
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "div $t0 , $t0 , $t1\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type1 == 'double' and value_type2 == value_type1:
            code += "l.s $f0 , 8($sp)\n"
            code += "l.s $f1 , 4($sp)\n"
            code += "div.s $f0 , $f0 , $f1\n"
            code += "s.s $f0 , 8($sp)\n"
        else:
            raise Exception("Can Not Divide " + value_type1 + " from " + value_type2 + "!")
        code += "addi $sp , $sp , 4\n"
        return {'code': args[0]['code'] + args[1]['code'] + code,
                'value_type': value_type1}

    def exp_mod_exp(self, args):
        value_type1 = args[0]['value_type']
        value_type2 = args[1]['value_type']
        code = "# mod Expression\n"
        if value_type1 == 'int' and value_type2 == value_type1:
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "div $t0 , $t1\n"
            code += "mfhi $t0\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type1 == 'double' and value_type2 == value_type1:  # TODO this is wrong
            code += "l.s $f0 , 8($sp)\n"
            code += "l.s $f1 , 4($sp)\n"
            code += "div.s $f0 , $f0 , $f1\n"
            code += "s.s $f0 , 8($sp)\n"
        else:
            raise Exception("this operator is just for int by int !")
        code += "addi $sp , $sp , 4\n"
        return {'code': args[0]['code'] + args[1]['code'] + code,
                'value_type': 'int'}

    def exp_negative(self, args):
        value_type = args[0]['value_type']
        code = '# Negative an expression\n'
        if value_type == 'int':
            code += "lw $t0 , 4($sp)\n"
            code += "neg $t0 , $t0\n"
            code += "sw $t0 , 4($sp)\n"
        elif value_type == 'double':
            code += "l.s $f0 , 4($sp)\n"
            code += "neg.s $f0 , $f0\n"
            code += "s.s $f0 , 4($sp)\n"
        else:
            raise Exception("can not negative " + value_type + " !")
        return {'code': args[0]['code'] + code,
                'value_type': value_type}

    ############ compare ################
    def exp_less_exp(self, args):
        value_type1 = args[0]['value_type']
        value_type2 = args[1]['value_type']
        code = "# less than Expression\n"
        if value_type1 == 'int' and value_type2 == value_type1:
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "slt $t0 , $t0 , $t1\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type1 == 'double' and value_type2 == value_type1:
            first_label = "label" + str(self.string_numbers)
            self.string_numbers += 1
            second_label = "label" + str(self.string_numbers)
            self.string_numbers += 1
            code += "l.s $f0 , 8($sp)\n"
            code += "l.s $f1 , 4($sp)\n"
            code += "c.lt.s $f0 , $f1\n"
            code += "bc1t " + first_label + " # if first is less than second\n"
            code += "li $t0 , 0\n"
            code += "j " + second_label + "\n"
            code += first_label + ":\n"
            code += "li $t0 , 1\n"
            code += second_label + ":\n"
            code += "sw $t0 , 8($sp)\n"
        else:
            raise Exception("Can Not compare " + value_type1 + " with " + value_type2 + "!")
        code += "addi $sp , $sp , 4\n"
        return {'code': args[0]['code'] + args[1]['code'] + code,
                'value_type': 'bool'}

    def exp_less_equal_exp(self, args):
        value_type1 = args[0]['value_type']
        value_type2 = args[1]['value_type']
        code = "# less equal than Expression\n"
        if value_type1 == 'int' and value_type2 == value_type1:
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "sle $t0 , $t0 , $t1\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type1 == 'double' and value_type2 == value_type1:
            first_label = "label" + str(self.string_numbers)
            self.string_numbers += 1
            second_label = "label" + str(self.string_numbers)
            self.string_numbers += 1
            code += "l.s $f0 , 8($sp)\n"
            code += "l.s $f1 , 4($sp)\n"
            code += "c.le.s $f0 , $f1\n"
            code += "bc1t " + first_label + "\n"
            code += "li $t0 , 0\n"
            code += "j " + second_label + "\n"
            code += first_label + ":\n"
            code += "li $t0 , 1\n"
            code += second_label + ":\n"
            code += "sw $t0 , 8($sp)\n"
        else:
            raise Exception("Can Not compare " + value_type1 + " with " + value_type2 + "!")
        code += "addi $sp , $sp , 4\n"
        return {'code': args[0]['code'] + args[1]['code'] + code,
                'value_type': 'bool'}

    def exp_greater_exp(self, args):
        value_type1 = args[0]['value_type']
        value_type2 = args[1]['value_type']
        code = "# greater than Expression\n"
        if value_type1 == 'int' and value_type2 == value_type1:
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "sgt $t0 , $t0 , $t1\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type1 == 'double' and value_type2 == value_type1:
            first_label = "label" + str(self.string_numbers)
            self.string_numbers += 1
            second_label = "label" + str(self.string_numbers)
            self.string_numbers += 1
            code += "l.s $f0 , 8($sp)\n"
            code += "l.s $f1 , 4($sp)\n"
            code += "c.lt.s $f1 , $f0\n"
            code += "bc1t " + first_label + "\n"
            code += "li $t0 , 0\n"
            code += "j " + second_label + "\n"
            code += first_label + ":\n"
            code += "li $t0 , 1\n"
            code += second_label + ":\n"
            code += "sw $t0 , 8($sp)\n"
        else:
            raise Exception("Can Not compare " + value_type1 + " with " + value_type2 + "!")
        code += "addi $sp , $sp , 4\n"
        return {'code': args[0]['code'] + args[1]['code'] + code,
                'value_type': 'bool'}

    def exp_greater_equal_exp(self, args):
        value_type1 = args[0]['value_type']
        value_type2 = args[1]['value_type']
        code = "# greater equal than Expression\n"
        if value_type1 == 'int' and value_type2 == value_type1:
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "sge $t0 , $t0 , $t1\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type1 == 'double' and value_type2 == value_type1:
            first_label = "label" + str(self.string_numbers)
            self.string_numbers += 1
            second_label = "label" + str(self.string_numbers)
            self.string_numbers += 1
            code += "l.s $f0 , 8($sp)\n"
            code += "l.s $f1 , 4($sp)\n"
            code += "c.le.s $f1 , $f0\n"
            code += "bc1t " + first_label + "\n"
            code += "li $t0 , 0\n"
            code += "j " + second_label + "\n"
            code += first_label + ":\n"
            code += "li $t0 , 1\n"
            code += second_label + ":\n"
            code += "sw $t0 , 8($sp)\n"
        else:
            raise Exception("Can Not compare " + value_type1 + " with " + value_type2 + "!")
        code += "addi $sp , $sp , 4\n"
        return {'code': args[0]['code'] + args[1]['code'] + code,
                'value_type': 'bool'}

    def exp_equal_exp(self, args):
        value_type1 = args[0]['value_type']
        value_type2 = args[1]['value_type']
        first_label = "label" + str(self.string_numbers)
        self.string_numbers += 1
        second_label = "label" + str(self.string_numbers)
        self.string_numbers += 1
        code = "#  equality of Expressions\n"
        if (value_type1 == 'int' or value_type1 == 'bool') and value_type2 == value_type1:
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "beq $t0 , $t1 , " + first_label + "\n"
            code += "li $t0, 0\n"
            code += "j " + second_label + "\n"
            code += first_label + " :\n"
            code += "li $t0 , 1\n"
            code += second_label + " :\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type1 == 'double' and value_type2 == value_type1:
            code += "l.s $f0 , 8($sp)\n"
            code += "l.s $f1 , 4($sp)\n"
            code += "c.eq.s $f1 , $f0\n"
            code += "bc1t " + first_label + "\n"
            code += "li $t0 , 0\n"
            code += "j " + second_label + "\n"
            code += first_label + ":\n"
            code += "li $t0 , 1\n"
            code += second_label + ":\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type1 == "string" and value_type2 == value_type1:
            self.builtin_functions.append('stringEquality')
            code += "lw $a0 , 8($sp)\n"
            code += "lw $a1 , 4($sp)\n"
            code += "addi $sp , $sp , -8\n"
            code += "sw $fp , 8($sp)\n"
            code += "sw $ra , 4($sp)\n"
            code += "jal StringsEquality # Calling Function to Check Equality of two Strings\n"
            code += "lw $fp , 8($sp)\n"
            code += "lw $ra , 4($sp)\n"
            code += "addi $sp , $sp , 8\n"
            code += "sw $v0 , 8($sp) # Saving Result of Equality of two Strings\n"
        elif value_type1 == value_type2:
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "beq $t0 , $t1 , " + first_label + "\n"
            code += "li $t0, 0\n"
            code += "j " + second_label + "\n"
            code += first_label + " :\n"
            code += "li $t0 , 1\n"
            code += second_label + " :\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type1 == 'null_type' or value_type2 == 'null_type':
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "beq $t0 , $t1 , " + first_label + "\n"
            code += "li $t0, 0\n"
            code += "j " + second_label + "\n"
            code += first_label + " :\n"
            code += "li $t0 , 1\n"
            code += second_label + " :\n"
            code += "sw $t0 , 8($sp)\n"
        else:
            raise Exception("Can Not compare " + value_type1 + " with " + value_type2 + "!")
        code += "addi $sp , $sp , 4\n"
        return {'code': args[0]['code'] + args[1]['code'] + code,
                'value_type': 'bool'}

    def exp_not_equal_exp(self, args):
        value_type1 = args[0]['value_type']
        value_type2 = args[1]['value_type']
        first_label = "label" + str(self.string_numbers)
        self.string_numbers += 1
        second_label = "label" + str(self.string_numbers)
        self.string_numbers += 1
        code = "#   inequality of Expressions\n"
        if (value_type1 == 'int' or value_type1 == 'bool') and value_type2 == value_type1:
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "bne $t0 , $t1 , " + first_label + "\n"
            code += "li $t0, 0\n"
            code += "j " + second_label + "\n"
            code += first_label + " :\n"
            code += "li $t0 , 1\n"
            code += second_label + " :\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type1 == 'double' and value_type2 == value_type1:
            code += "l.s $f0 , 8($sp)\n"
            code += "l.s $f1 , 4($sp)\n"
            code += "c.eq.s $f1 , $f0\n"
            code += "bc1t " + first_label + "\n"
            code += "li $t0 , 1\n"
            code += "j " + second_label + "\n"
            code += first_label + ":\n"
            code += "li $t0 , 0\n"
            code += second_label + ":\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type1 == "string" and value_type2 == value_type1:
            self.builtin_functions.append('StringInequality')
            self.builtin_functions.append('stringEquality')
            code += "lw $a0 , 8($sp)\n"
            code += "lw $a1 , 4($sp)\n"
            code += "addi $sp , $sp , -8\n"
            code += "sw $fp , 8($sp)\n"
            code += "sw $ra , 4($sp)\n"
            code += "jal StringsInequality # Calling Function to Check Inequality of two Strings\n"
            code += "lw $fp , 8($sp)\n"
            code += "lw $ra , 4($sp)\n"
            code += "addi $sp , $sp , 8\n"
            code += "sw $v0 , 8($sp) \n"
        elif value_type2 == value_type1:
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "bne $t0 , $t1 , " + first_label + "\n"
            code += "li $t0, 0\n"
            code += "j " + second_label + "\n"
            code += first_label + " :\n"
            code += "li $t0 , 1\n"
            code += second_label + " :\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type1 == 'null_type' or value_type2 == 'null_type':
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "bne $t0 , $t1 , " + first_label + "\n"
            code += "li $t0, 0\n"
            code += "j " + second_label + "\n"
            code += first_label + " :\n"
            code += "li $t0 , 1\n"
            code += second_label + " :\n"
            code += "sw $t0 , 8($sp)\n"
        else:
            raise Exception("Can Not compare " + value_type1 + " with " + value_type2 + "!")
        code += "addi $sp , $sp , 4\n"
        return {'code': args[0]['code'] + args[1]['code'] + code,
                'value_type': 'bool'}

    ########################## Logical ####################33
    def exp_and_exp(self, args):
        value_type1 = args[0]['value_type']
        value_type2 = args[1]['value_type']
        code = "# And Expression\n"
        if value_type1 == 'bool' and value_type2 == value_type1:
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "and $t0 , $t0 , $t1\n"
            code += "sw $t0 , 8($sp)\n"
        else:
            raise Exception(value_type1 + " and " + value_type2 + " should be bool!")
        code += "addi $sp , $sp , 4\n"
        return {'code': args[0]['code'] + args[1]['code'] + code,
                'value_type': value_type1}

    def exp_or_exp(self, args):
        value_type1 = args[0]['value_type']
        value_type2 = args[1]['value_type']
        code = "# And Expression\n"
        if value_type1 == 'bool' and value_type2 == value_type1:
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "or $t0 , $t0 , $t1\n"
            code += "sw $t0 , 8($sp)\n"
        else:
            raise Exception(value_type1 + " and " + value_type2 + " should be bool!")
        code += "addi $sp , $sp , 4\n"
        return {'code': args[0]['code'] + args[1]['code'] + code,
                'value_type': value_type1}

    def exp_not(self, args):
        first_label = "label" + str(self.string_numbers)
        self.string_numbers += 1
        second_label = "label" + str(self.string_numbers)
        self.string_numbers += 1
        value_type = args[0]['value_type']
        code = '# Negative an expression\n'
        if value_type == 'bool':
            code += "lw $t0 , 4($sp)\n"
            code += "beq $t0 , $zero , " + first_label + "\n"
            code += "li $t0, 0\n"
            code += "j " + second_label + "\n"
            code += first_label + ": \n"
            code += "li $t0 , 1\n"
            code += second_label + ": \n"
            code += "sw $t0 , 4($sp)\n"
        else:
            raise Exception(value_type + " should be bool !")
        return {'code': args[0]['code'] + code,
                'value_type': value_type}

    #######################################

    def exp_inside_parenthesis(self, args):
        return args[0]

    ####################### Type  ###########################
    def type_int(self, args):
        return "int"

    def type_double(self, args):
        return "double"

    def type_bool(self, args):
        return "bool"

    def type_string(self, args):
        return "string"

    def type_array(self, args):
        return args[0] + "[]"

    def type_id(self, args):
        return args[0].children[0]

    def formals(self, args):
        counter = 0
        for arg in args:
            counter += 1
            var = self.symbol_table.getVariable(arg['name'], self.scope)
            self.stack.append(var)
        return {'variable_count': counter}

    def formals_empty(self, args):
        return {'variable_count': 0}

    def variable_type_primitive(self, args):
        return {'type': args[0], 'name': args[1].children[0]}

    def variable_type_class(self, args):
        self.classes.searchClass(args[0].value)
        return {'type': args[0].value, 'name': args[1].children[0]}

    def variable_decl(self, args):
        return {"variable_count": 1}

    def global_variable(self, args):
        return {'code': ''}

    def lvalue_id(self, args):
        name = args[0].children[0].value
        var, address = self.symbol_table.getVariable(name, self.scope)
        code = "# Loading Address of ID : " + var.name + "\n"
        code += "li $s6 , 0\n"
        code += "addi $s6 , $s6 , " + str(address) + "\n"
        code += "add $s7 , $fp , $s6\n"
        code += 'sw $s7, 0($sp)' + ' # Push Address of ' + str(address) + ' to Stack\n'
        code += 'addi $sp, $sp, -4\n'
        return {'code': code,
                'name': var.name,
                'value_type': var.type}

    def get_class_variable(self, args):
        obj = args[0]
        variable = args[1].children[0]
        obj_type = obj['value_type']
        cls = self.classes.searchClass(obj_type)
        cls_var = cls.getVariable(variable)
        var_offset = cls.getVaribaleOffset(variable)
        if not ('this' in obj):
            if cls_var['access_level'] != 'public':
                raise Exception(str(variable) + " is not public!")
        code = "# Loading Variable of Object\n"
        code += obj['code']
        code += "lw $t0 , 4($sp)\n"
        code += "addi $t0 , $t0 , " + str(var_offset) + " # add offset of variable to object address\n"
        code += "sw $t0 , 4($sp)\n"
        return {'code': code, 'value_type': cls_var['type']}

    def get_array_item(self, args):
        base_arr = args[0]
        index = args[1]
        code = "# Get Array index\n"
        code += "# Base Address of Array\n"
        code += base_arr['code']
        code += "# Expression index of Array\n"
        code += index['code']
        code += "lw $t0 , 8($sp) # base Address of Array\n"
        code += "lw $t1 , 4($sp) # index of Array\n"
        code += "addi $sp , $sp , 4\n"
        code += "addi $t1 , $t1 , 1\n"
        code += "sll $t1 , $t1 , 2\n"
        code += "add $t0 , $t0 , $t1\n"
        code += "sw $t0 , 4($sp) # Pushing address of arr[index] result to Stack\n"
        return {'code': code, 'value_type': base_arr['value_type'][0:-2]}

    def lvalue(self, args):
        code = "# loading address of lvalue\n"
        code += "lw $t0, 4($sp)\n"
        code += "lw $t0 , 0($t0)\n"
        code += "sw $t0 , 4($sp)\n"
        args[0]['code'] += code
        return args[0]

    def expr_assign(self, args):

        if args[0]['value_type'] != args[1]['value_type']:
            raise Exception("can not assign " + args[1]['value_type'] + " to " + args[0]['value_type'] + "!")
        value_type = args[0]['value_type']
        code = "# Left Hand Side Assign\n"
        code += args[0]['code']
        code += "# Right Hand Side Assign\n"
        code += args[1]['code']
        code += "# Assign Right Side to Left\n"
        code += "lw $t0 , 8($sp)\n"
        if value_type == 'double':
            code += "l.s $f0 , 4($sp)\n"
            code += "s.s $f0 , 0($t0)\n"
            code += "s.s $f0 , 8($sp)\n"
        else:
            code += "lw $t1 , 4($sp)\n"
            code += "sw $t1 , 0($t0)\n"
            code += "sw $t1 , 8($sp)\n"
        code += "addi $sp , $sp , 4\n"
        return {'code': code,
                'value_type': value_type}

    def call_expr(self, args):
        return args[0]

    def new_ident_exp(self, args):
        id = args[0].children[0]
        code = "# new object of type : " + id + "\n"
        code += "sw $ra , 0($sp)\n"
        code += "addi $sp , $sp , -4\n"
        code += "jal " + id + "_Constructor\n"
        code += "lw $ra , 4($sp)\n"
        code += "sw $v0 , 4($sp) # Pushing address of object in Heap to Stack\n"
        return {'code': code, 'value_type': id}

    def expr_constant(self, args):
        return args[0]

    def this_exp(self, args):
        code = "# Loading Address of : this\n"
        code += "addi $s7 , $s4 , 0\n"
        code += "sw $s7 , 0($sp)\n"
        code += "addi $sp, $sp, -4\n"
        return {'code': code, 'value_type': self.classes.classes[self.last_class].name, "this": True}

    def stmt_expr(self, args):
        if len(args) > 0:
            print(args[0])
            code = args[0]['code']
            code += "# End of Expression Optional\n"
            code += "addi $sp , $sp 4\n"
            return {'code': code, "break_labels": [], 'continue_labels': []}
        else:
            return {'code': '', "break_labels": [], 'continue_labels': []}

    def new_array_exp(self, args):
        # if args[0]['value_type'] != 'int':
        #     raise Exception('first argument should be int!')
        code = "# Expression of Array Size\n"
        code += args[0]['code']
        code += "# NewArray of Type : " + args[1] + "\n"
        code += "lw $t0, 4($sp)\n"
        code += "addi $t0 , $t0 , 1 # Allocate space for Storing Array Length\n"
        code += "sll $a0 , $t0 , 2\n"
        code += "li $v0, 9\n"
        code += "syscall\n"
        code += "addi $t0 , $t0 , -1 # Array Size\n"
        code += "sw $t0 , 0($v0) # Storing Array size in index 0\n"
        code += "sw $v0, 4($sp)\n"
        return {'code': code,
                'value_type': args[1] + "[]"}

    def call_exp(self, args):
        return args[0]

    def call_global_func(self, args):
        id = args[0].children[0]
        func = self.symbol_table.getFunction(id)
        value_type = func.type
        actuals = args[1]
        if (len(actuals['actual_types']) != len(func.formals)):
            raise Exception('"function ' + str(id) + " has " + str(len(func.formals)) + " arguments!")
        size = len(func.formals)
        actual_types = actuals['actual_types']
        for i in range(size):
            if actual_types[i] != func.formals[i]:
                raise Exception('type for calling function is not true!')
        code = "# Storing Frame Pointer and Return Address Before Calling the function : " + id + "\n"
        code += "addi $sp , $sp , -12\n"
        code += "sw $fp , 4($sp)\n"
        code += "sw $ra , 8($sp)\n"
        code += "sw $s5 , 12($sp)\n"
        code += "# Function Arguments\n"
        code += actuals['code']
        code += "jal __" + str(id) + " # Calling Function\n"
        code += "# Pop Arguments of function\n"
        code += "addi $sp , $sp , " + str(actuals['variable_count'] * 4) + "\n"
        code += "# Load Back Frame Pointer and Return Address After Function call\n"
        code += "lw $fp , 4($sp)\n"
        code += "lw $ra , 8($sp)\n"
        code += "lw $s5 , 12($sp)\n"
        code += "addi $sp , $sp , 8\n"
        if value_type == 'double':
            code += "s.s $f0 , 4($sp) # Push Return Value from function to Stack\n"
        else:
            code += "sw $v0 , 4($sp) # Push Return Value from function to Stack\n"
        return {'code': code, 'value_type': value_type}

    def call_class_func(self, args):
        obj_expr = args[0]
        function_id = args[1].children[0]
        object_type = obj_expr['value_type']
        if object_type[len(object_type)-2:len(object_type)] == "[]" and function_id == 'length':
            code = "# Array Length\n"
            code += "# Array Expr\n"
            code += obj_expr['code']
            code += "lw $t0 , 4($sp)\n"
            code += "lw $t0 , 0($t0)\n"
            code += "sw $t0 , 4($sp) # Pushing length of array to stack\n"
            return {'code': code, 'value_type': 'int'}

        obj = self.classes.searchClass(object_type)
        func = func = obj.getMethods(function_id)
        flag = False
        while (obj.father is not None) and (func is None):
            obj = obj.father
            flag = True
            func = obj.getMethods(function_id, True)
            print(obj.name)
            print("2 -- >")
            print(func)
        if func is None:
            raise Exception('method ' + function_id + " does not exist in class " + object_type + "!")
        value_type = func['type']
        actuals = args[2]
        if (len(actuals['actual_types']) != len(func['formals'])):
            raise Exception('"function ' + str(function_id) + " has " + str(len(func['formals'])) + " arguments!")
        size = len(func['formals'])
        actual_types = actuals['actual_types']
        for i in range(size):
            if actual_types[i] != func['formals'][i]:
                raise Exception('type for calling function is not true!')
        if not('this' in obj_expr):
            if flag and (func['access_level'] == "private"):
                raise Exception('can not call this function due to access level!')
        methodOffset = obj.getMethodOffset(function_id)

        code = "# Calling Method of Object\n"
        code += "# Object Expression\n"
        code += obj_expr['code']
        code += "lw $t0 , 4($sp)\n"
        code += "lw $t0 , 0($t0) # Loading Vtable\n"
        code += "addi $t0 , $t0 , " + str(methodOffset) + "# Adding offset of Method in Vtable\n"
        code += "lw $t0 , 0($t0) # t0 now contains the address of function\n"
        code += "sw $t0 , 0($sp) # Storing Function Address in Stack \n"
        code += "addi $sp , $sp , -4\n"
        code += "# Storing Frame Pointer and Return Address Before Calling the object's method : " + function_id + "\n"
        code += "addi $sp , $sp , -12\n"
        code += "sw $fp , 4($sp)\n"
        code += "sw $ra , 8($sp)\n"
        code += "sw $s5 , 12($sp)\n"
        code += "# Method\'s Arguments \n"
        code += actuals['code']
        code += "lw $t0 , " + str(actuals['variable_count'] * 4 + 12 + 4 + 4) + "($sp) # Loading Object being called\n"
        code += "sw $t0 , 0($sp) # Pushing object as \"this\" as first argument of method\n"
        code += "addi $s4 , $t0 , 0\n"
        code += "lw $t0 , " + str(actuals['variable_count'] * 4 + 12 + 4) + "($sp) # Loading Method of object\n"
        code += "addi $sp , $sp , -4\n"
        print()
        code += "jal __" + str(obj.name) + "_" + str(function_id) + " # Calling Object's method\n"
        code += "addi $sp , $sp , " + str(actuals['variable_count'] * 4 + 4) + " # Pop Arguments of Method\n"
        code += "# Load Back Frame Pointer and Return Address After Function call\n"
        code += "lw $fp , 4($sp)\n"
        code += "lw $ra , 8($sp)\n"
        code += "lw $s5 , 12($sp)\n"
        code += "addi $sp , $sp , 16\n"
        if value_type == 'double':
            code += "s.s $f0 , 4($sp) # Push Return Value from Method to Stack\n"
        else:
            code += "sw $v0 , 4($sp) # Push Return Value from Method to Stack\n"
        return {'code': code, 'value_type': value_type}

    def actuals(self, args):
        code = ''
        value_types = []
        args = list(args)
        args.reverse()
        for arg in args:
            code += arg['code']
            value_types.append(arg['value_type'])
        return {'variable_count': len(args), 'code': code, 'actual_types': value_types}

    def actual_empty(self, args):
        return {'variable_count': 0, 'code': '', 'actual_types': []}

    def read_integer_exp(self, args):
        self.builtin_functions.append("readInteger")
        self.builtin_functions.append("readLine")
        code = "# Read Integer ( Decimal or Hexadecimal ) : \n"
        code += "# Read Line : \n"
        code += "addi $sp , $sp , -8\n"
        code += "sw $fp , 8($sp)\n"
        code += "sw $ra , 4($sp)\n"
        code += "jal ReadLine # Calling Read Line Function \n"
        code += "move $a0 , $v0 # Moving address of string to $a0\n"
        code += "jal readInteger # Read Integer Function\n"
        code += "lw $fp , 8($sp)\n"
        code += "lw $ra , 4($sp)\n"
        code += "addi $sp , $sp , 4\n"
        code += "sw $v0 , 4($sp) # Saving Result Read Integer to Stack\n"
        return {'code': code, 'value_type': 'int'}

    def read_line_exp(self, args):
        self.builtin_functions.append("readLine")
        code = "# Read Line : \n"
        code += "addi $sp , $sp , -8\n"
        code += "sw $fp , 8($sp)\n"
        code += "sw $ra , 4($sp)\n"
        code += "jal ReadLine # Calling Read Line Function \n"
        code += "lw $fp , 8($sp)\n"
        code += "lw $ra , 4($sp)\n"
        code += "addi $sp , $sp , 4\n"
        code += "sw $v0 , 4($sp)# Saving String Address ( Saved in Heap ) in Stack\n"
        return {'code': code, 'value_type': 'string'}

    def itod_exp(self, args):
        type = args[0]['value_type']
        if type != 'int':
            raise Exception('first argument should be int!')
        self.builtin_functions.append("itod")
        code = "# itod \n"
        code += "addi $sp , $sp , -8\n"
        code += "lw $t0 , 8($sp)\n"
        code += "sw $fp , 8($sp)\n"
        code += "sw $ra , 4($sp)\n"
        code += "jal itod # Calling itod Function \n"
        code += "lw $fp , 8($sp)\n"
        code += "lw $ra , 4($sp)\n"
        code += "addi $sp , $sp , 4\n"
        code += "s.s $f0 , 4($sp)\n"
        return {'code': code, 'value_type': 'double'}

    def dtoi_exp(self, args):
        type = args[0]['value_type']
        if type != 'double':
            raise Exception('first argument should be double!')
        self.builtin_functions.append("dtoi")
        code = "# dtoi \n"
        code += "addi $sp , $sp , -8\n"
        code += "l.s $f0 , 8($sp)\n"
        code += "sw $fp , 8($sp)\n"
        code += "sw $ra , 4($sp)\n"
        code += "jal dtoi # Calling dtoi Function \n"
        code += "lw $fp , 8($sp)\n"
        code += "lw $ra , 4($sp)\n"
        code += "addi $sp , $sp , 4\n"
        code += "sw $v0 , 4($sp)\n"
        return {'code': code, 'value_type': 'int'}

    def itob_exp(self, args):
        type = args[0]['value_type']
        if type != 'int':
            raise Exception('first argument should be int!')
        self.builtin_functions.append("itob")
        code = "# itob \n"
        code += "addi $sp , $sp , -8\n"
        code += "lw $t0 , 8($sp)\n"
        code += "sw $fp , 8($sp)\n"
        code += "sw $ra , 4($sp)\n"
        code += "jal itob # Calling itob Function \n"
        code += "lw $fp , 8($sp)\n"
        code += "lw $ra , 4($sp)\n"
        code += "addi $sp , $sp , 4\n"
        code += "sw $v0 , 4($sp)\n"
        return {'code': code, 'value_type': 'bool'}

    def btoi_exp(self, args):
        type = args[0]['value_type']
        if type != 'bool':
            raise Exception('first argument should be bool!')
        self.builtin_functions.append("btoi")
        code = "# btoi \n"
        code += "addi $sp , $sp , -8\n"
        code += "lw $t0 , 8($sp)\n"
        code += "sw $fp , 8($sp)\n"
        code += "sw $ra , 4($sp)\n"
        code += "jal btoi # Calling btoi Function \n"
        code += "lw $fp , 8($sp)\n"
        code += "lw $ra , 4($sp)\n"
        code += "addi $sp , $sp , 4\n"
        code += "sw $v0 , 4($sp)\n"
        return {'code': code, 'value_type': 'int'}

    def stmt_block(self, args):
        self.scope += 1
        variable_count = 0
        stmts = []
        return_types = []
        for arg in args:
            if 'variable_count' in arg:
                variable_count += arg['variable_count']
            else:
                if 'return_type' in arg:
                    return_types.append(arg['return_type'])
                stmts.append(arg)

        break_labels = []
        continue_labels = []
        code = "# Begin of Statement Block\n"
        code += "addi $sp , $sp , -" + str(
            variable_count * 4) + " # Allocate From Stack For Block Statement Variables\n"
        code += "addi $fp , $sp , 4\n"
        for stmt in stmts:
            code += stmt['code']
            break_labels.extend(stmt['break_labels'])
            continue_labels.extend(stmt['continue_labels'])

        code += "addi $sp , $sp , " + str(
            variable_count * 4) + " # UnAllocate Stack Area (Removing Block Statement Variables)\n"
        code += "addi $fp ,$sp , 4\n"
        code += "# End of Statement Block\n"
        self.symbol_table.removeFromScop(self.scope)
        return_types = list(set(return_types))
        return {'code': code, 'break_labels': break_labels, 'continue_labels': continue_labels,
                'return_type': return_types}

    def if_stmt(self, args):
        exp = args[0]
        if len(args) == 3:
            stmt_true = args[1]
            stmt_false = args[2]
            first_label = "label" + str(self.string_numbers)
            self.string_numbers += 1
            second_label = "label" + str(self.string_numbers)
            self.string_numbers += 1
            if exp['value_type'] == 'bool':
                code = exp['code']
                code += "addi $sp , $sp , 4\n"
                code += "lw $t0 , 0($sp)\n"
                code += "beq $t0 , $zero , " + first_label + "\n"
                code += stmt_true['code']
                code += "j " + second_label + "\n"
                code += first_label + " :\n"
                code += stmt_false['code']
                code += second_label + " :\n"
            else:
                raise Exception("condition should be bool type!")
            return {'code': code, 'break_labels': args[1]['break_labels'], 'continue_labels': args[1]['continue_labels']}
        else:
            stmt_true = args[1]

            first_label = "label" + str(self.string_numbers)
            self.string_numbers += 1

            if exp['value_type'] == 'bool':
                code = exp['code']
                code += "addi $sp , $sp , 4\n"
                code += "lw $t0 , 0($sp)\n"
                code += "beq $t0 , $zero , " + first_label + "\n"
                code += stmt_true['code']

                code += first_label + " :\n"


            else:
                raise Exception("condition should be bool type!")
            return {'code': code, 'break_labels': args[1]['break_labels'], 'continue_labels': args[1]['continue_labels']}

    def stmt_stmt_block(self, args):
        return args[0]

    def stmt_if_stmt(self, args):
        code = "#End of if statement\n"
        return {'code': args[0]['code'] + code, 'break_labels': args[0]['break_labels'],
                'continue_labels': args[0]['continue_labels']}

    def find_break_label(self, arr, name):
        for item in arr:
            if item['name'] == name:
                return item['count']
        raise Exception("no label found for " + name)

    def find_continue_label(self, arr, name):
        for item in arr:
            if item['name'] == name:
                return item['count']
        raise Exception("no label found for " + name)

    def while_stmt(self, args):
        exp = args[0]
        stmt = args[1]
        first_label = "label" + str(self.string_numbers)
        self.string_numbers += 1
        second_label = "label" + str(self.string_numbers)
        self.string_numbers += 1
        break_labels = stmt['break_labels']
        pattern = re.compile(r'@(break\d+)@')
        for break_label in re.findall(pattern, stmt['code']):
            count = self.find_break_label(break_labels, break_label)
            code_for_break = "addi $sp , $sp , " + str(count * 4) + " # Pop elements before\n"
            code_for_break += "addi $fp , $sp , 4 # Set Frame Pointer\n"
            code_for_break += "j " + second_label + " # Break from loop while\n"
            stmt['code'] = stmt['code'].replace("@" + break_label + "@", code_for_break)

        continue_labels = stmt["continue_labels"]
        pattern_c = re.compile(r'@(continue\d+)@')
        for continue_label in re.findall(pattern_c, stmt['code']):
            count_c = self.find_continue_label(continue_labels, continue_label)
            code_for_continue = "addi $sp , $sp , " + str(count_c * 4) + " # Pop elements before\n"
            code_for_continue += "addi $fp , $sp , 4 # Set Frame Pointer\n"
            code_for_continue += "j " + first_label + " # continue from loop while\n"
            stmt['code'] = stmt['code'].replace("@" + continue_label + "@", code_for_continue)

        if exp["value_type"] == "bool":
            code = first_label + ": # Starting While Loop Body\n"
            code += "# Calculating While Condition\n"
            code += exp['code']
            code += "# Loading While Condition Result\n"
            code += "addi $sp , $sp , 4\n"
            code += "lw $t0 , 0($sp)\n"
            code += "beqz $t0 , " + second_label + " # Jumping to end label if expression is false\n"
            code += stmt['code']
            code += "j " + first_label + " # Jumping to beggining of while loop\n"
            code += second_label + ":\n"
        else:
            raise Exception("condition should be bool type!")
        return {'code': code, 'break_labels': [], 'continue_labels': []}

    def stmt_while_stmt(self, args):
        code = "#End of while statement\n"
        return {'code': args[0]['code'] + code, 'break_labels': args[0]['break_labels'],
                'continue_labels': args[0]['continue_labels']}

    def for_stmt(self, args):
        initialize = args[0]
        condition = args[1]
        step = args[2]
        stmt = args[3]
        first_label = "label" + str(self.string_numbers)
        self.string_numbers += 1
        second_label = "label" + str(self.string_numbers)
        self.string_numbers += 1

        # Handling breaks ...
        break_labels = stmt['break_labels']
        pattern = re.compile(r'@(break\d+)@')
        for break_label in re.findall(pattern, stmt['code']):
            count = self.find_break_label(break_labels, break_label)
            code_for_break = "addi $sp , $sp , " + str(count * 4) + " # Pop elements before\n"
            code_for_break += "addi $fp , $sp , 4 # Set framepointer\n"
            code_for_break += "j " + second_label + " # Break from loop for\n"
            stmt['code'] = stmt['code'].replace("@" + break_label + "@", code_for_break)

        continue_labels = stmt["continue_labels"]
        pattern_c = re.compile(r'@(continue\d+)@')
        for continue_label in re.findall(pattern_c, stmt['code']):
            count_c = self.find_continue_label(continue_labels, continue_label)
            code_for_continue = "addi $sp , $sp , " + str(count_c * 4) + " # Pop elements before\n"
            code_for_continue += "addi $fp , $sp , 4 # Set Frame Pointer\n"
            code_for_continue += "j " + first_label + " # continue from loop while\n"
            stmt['code'] = stmt['code'].replace("@" + continue_label + "@", code_for_continue)


        code = "# Initialization Expression of Loop for\n"
        code += initialize['code']
        if initialize['code'] != '':
            code += "addi $sp , $sp , 4 # pop init expr of loop for\n"
        code += first_label + ": # Starting for Loop Body\n"
        code += "# Calculating For Loop Condition\n"
        code += condition['code']
        code += "# Loading For Loop Condition Result\n"
        code += "addi $sp , $sp , 4\n"
        code += "lw $t0 , 0($sp)\n"
        code += "beqz $t0 , " + second_label + " # Jumping to end label if Condition Expression of for loop is false\n"
        code += stmt['code']
        code += "# Step Expression of For loop \n"
        code += step['code']
        if step['code'] != '':
            code += "addi $sp , $sp , 4 # pop step expr of loop for\n"
        code += "j " + first_label + " # Jumping to beggining of while loop\n"
        code += second_label + ":\n"
        return {'code' : code , 'break_labels' : [] , 'continue_labels' :[]}

    def stmt_for_stmt(self, args):
        return args[0]

    def break_stmt(self, args):
        code = "@" + "break" + str(self.break_labels) + "@\n"
        self.break_labels += 1
        return {'code': code}

    def expr_opt(self, args):
        return args[0]

    def expr_opt_empty(self, args):
        return {'code': ''}

    def continue_stmt(self, args):
        code = "@" + "continue" + str(self.continue_labels) + "@\n"
        self.continue_labels += 1
        return {'code': code}

    def stmt_break_stmt(self, args):
        return {'code': args[0]['code'], 'continue_labels': [],
                'break_labels': [{'name': args[0]['code'][1:-2], 'count': 0}]}

    def stmt_continue_stmt(self, args):
        return {'code': args[0]['code'], 'break_labels': [],
                'continue_labels': [{'name': args[0]['code'][1:-2], 'count': 0}]}

    def stmt_return_stmt(self, args):
        args[0]['break_labels'] = []
        args[0]['continue_labels'] = []
        args[0]['return_type'] = args[0]['return_type']
        return args[0]

    def return_stmt(self, args):
        if len(args) > 0:
            expr = args[0]
            code = ''

            if expr['code'] != '':
                code = expr['code']
                if expr['value_type'] == 'double':
                    code += 'l.s $f0 , 4($sp) # Loading Return Value of function\n'
                else:
                    code += 'lw $v0 , 4($sp) # Loading Return Value of function\n'
                code += "addi $sp , $sp , 4\n"
            code += "move $sp , $s5\n"
            code += "jr $ra # Return Function\n"
            return {'code': code, 'return_type': expr['value_type']}
        else:
            code = "move $sp , $s5\n"
            code += "jr $ra # Return Function\n"
            return {'code': code, 'return_type': 'void'}

    def constant_int(self, args):
        val = int(args[0].value, 0)
        code = "# Int Constant : " + str(val) + "\n"
        code += "li $t0 , " + str(val) + "\n"
        code += 'sw $t0 , 0($sp)\n'
        code += 'addi $sp, $sp, -4\n'
        return {'code': code,
                'value_type': 'int'}

    ############### Double Constant ###############
    def constant_double(self, args):
        val = float(args[0].value)
        code = "# Double Constant : " + str(val) + "\n"
        code += "li.s $f0, " + str(val) + "\n"
        code += "s.s $f0, 0($sp)\n"
        code += "addi $sp, $sp, -4\n"
        return {'code': code,
                'value_type': 'double'}

    def constant_double2(self, args):
        parts = re.split(r"[Ee]", args[0])
        value = float(parts[0]) * (10 ** int(parts[1]))
        code = "# Double Constant : " + str(value) + "\n"
        code += "li.s $f0, " + str(value) + "\n"
        code += "s.s $f0, 0($sp)\n"
        code += "addi $sp, $sp, -4\n"
        return {'code': code,
                'value_type': 'double'}

    ############### Bool Constant ###############
    def constant_bool(self, args):
        code = "# Bool Constant : " + str(args[0].value) + "\n"
        if str(args[0].value) == 'true':
            code += 'li $t0 , 1\n'
        elif str(args[0].value) == 'false':
            code += 'li $t0, 0\n'
        code += 'sw $t0 , 0($sp)\n'
        code += 'addi $sp, $sp, -4\n'
        return {'code': code,
                'value_type': 'bool'}

    ############### String Constant ###############
    def constant_string(self, args):
        name = 'str' + str(self.string_numbers)
        self.string_numbers += 1
        code = "# String Constant : " + args[0].value + "\n"
        code += 'la $t0 , ' + name + '\n'
        code += 'sw $t0 , 0($sp)\n'
        code += 'addi $sp , $sp , -4\n'
        self.data_code += name + ': .asciiz ' + args[0].value + '\n'
        return {'code': code,
                'value_type': 'string'}

    ############### Null Constant ###############
    def constant_null(self, args):
        code = "la $t0 , obj_null # Null Object\n"
        code += "sw $t0 , 0($sp)\n"
        code += "addi $sp , $sp , -4\n"
        return {'code': code, 'value_type': 'null_type'}

    def func_decl(self, args):
        self.scope += 1
        returnType = args[0]
        functionName = args[1].children[0]
        formals = args[2]
        stmt_block = args[3]
        for type in stmt_block['return_type']:
            if type != returnType:
                raise Exception('this function can not return a ' + type + "!")
        label_end = functionName + "_end"
        if functionName == "main":
            code = functionName + ": # main function\n"
        else:
            code = "__" + functionName + ": # Start function\n"
        code += "addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5\n"
        code += "# Function Body :\n"
        code += stmt_block['code']
        code += 'lw $v0, 0($sp)\n'
        code += label_end + ":\n"
        code += "jr $ra\n\n"
        # self.stack.pop(formals['variable_count'])
        return {'code': code, 'name': functionName, 'value_type': returnType}

    def func_decl_data_type(self, args):
        self.scope += 1
        returnType = args[0]
        functionName = args[1].children[0]
        formals = args[2]
        stmt_block = args[3]
        for type in stmt_block['return_type']:
            if type != returnType:
                raise Exception('this function can not return an object of  ' + type + "!")
        label_end = functionName + "_end"
        code = "__" + functionName + ": # Start function\n"
        code += "addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5\n"
        code += "# Function Body :\n"
        code += stmt_block['code']
        code += label_end + ":\n"
        code += "jr $ra\n\n"
        # self.stack.pop(formals['variable_count'])
        return {'code': code, 'name': functionName, 'value_type': returnType}

    def function_void_decl(self, args):
        self.scope += 1
        returnType = 'void'
        functionName = args[0].children[0]
        formals = args[1]
        stmt_block = args[2]
        for type in stmt_block['return_type']:
            if type != returnType:
                raise Exception('this function can not return a ' + type + "!")
        label_end = functionName + "_end"
        code = "__" + functionName + ": # Start function\n"
        code += "addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5\n"
        code += "# Function Body :\n"
        code += stmt_block['code']
        code += label_end + ":\n"
        code += "jr $ra\n\n"
        # self.stack.pop(formals['variable_count'])
        return {'code': code, 'name': functionName, 'value_type': 'void'}

    def stmt_print_stmt(self, args):
        return {'code': args[0]['code'], 'break_labels': [], 'continue_labels': []}

    def print_stmt(self, args):
        code = ''
        for arg in args:
            expr = arg
            expr_type = expr['value_type']
            code += expr['code']
            code += "# Print expr : \n"
            code += "addi $sp , $sp , 4 # Pop Expression of Print\n"
            if expr_type == "string":
                code += "lw $a0 , 0($sp)\n"
                code += "li $v0 , 4\n"
            elif expr_type == "double":
                code += "l.s $f12 , 0($sp)\n"
                code += "li $v0 , 2\n"
            elif expr_type == "bool":
                code += "lw $a0 , 0($sp)\n"
                code += "la $t0 , str_bool\n"
                code += "sll $a0 , $a0 , 2\n"
                code += "add $a0 , $a0 , $t0\n"
                code += "lw $a0 , 0($a0)\n"
                code += "li $v0 , 4\n"
            else:
                code += "lw $a0 , 0($sp)\n"
                code += "li $v0 , 1\n"

            code += "syscall\n"

        code += "li $v0 , 4\n"
        code += "la $a0 , new_line\n"
        code += "syscall\n"
        return {'code': code}

    def decl_function_decl(self, args):
        return args[0]

    def method_field(self, args):
        cls = self.classes.getMethodByNameAndScope(args[1]['name'], self.last_class)
        prefix = cls.name
        args[1]['code'] = args[1]['code'].replace("li $s6 , 0" , "li $s6 , 4")
        args[1]['code'] = args[1]['code'].replace(args[1]['name'] + "_end:", prefix + "_" + args[1]['name'] + "_end:")
        args[1]['code'] = args[1]['code'].replace(args[1]['name'] + ":", prefix + "_" + args[1]['name'] + ":")
        return args[1]

    def class_decl(self, args):
        self.last_class += 1
        return args[3]

    def class_decl_fields(self, args):
        code = ''
        for arg in args:
            code += arg['code']
        return {'code': code}

    def variable_field(self, args):
        return {'code': ''}

    # def class_decl_extend(self, args):
    #
    def decl_class_decl(self, args):
        return args[0]

    def program(self, args):
        dirname = os.path.dirname(__file__)
        temp = set(self.builtin_functions)
        default_functions = ''
        for func in temp:
            file = open(dirname + "/built-in_functions/" + func + ".txt", "r")
            default_functions += file.read()
            default_functions += "\n"
            file.close()
        code = '.text\n'
        code += '.globl main\n'
        code += default_functions
        code += "\n"
        code += self.classes.getConstructor()
        for arg in args:
            code += arg['code']
        self.data_code += self.symbol_table.getData()
        self.data_code += self.classes.getVtables()
        self.data_code += "str_false : .asciiz \"false\" \n"
        self.data_code += "str_true : .asciiz \"true\" \n"
        self.data_code += "new_line : .asciiz \"\n\" \n"
        self.data_code += "str_bool : .word str_false , str_true\n"
        self.data_code += "obj_null : .word 61235\n"
        self.data_code += "__result: .space 200\n"
        self.write_code_in_file(code + "\n\n.data\n" + self.data_code)
        return args
