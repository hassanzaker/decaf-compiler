import os
import re
from ClassTable import Classes, Class
from lark import Lark, Transformer


class Cgen(Transformer):
    def __init__(self, classes):
        self.classes = classes
        self.data_code = ''
        self.string_numbers = 0
        self.label_number = 0

    def log_code(self, code):
        dirname = os.path.dirname(__file__)
        file = open(dirname + "/code.s", "w")
        file.write(code)
        file.close()


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
        #TODO --> append two string (or array) when we want to add them
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
        return args[0];



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

    def formals_empty(self, args):
        return {'variable_count': 0}

    def expr_assign(self, args):
        if args[0]['value_type'] != args[1]['value_type']:
            raise Exception("Types of Right Hand Side of Assign is not the same as Left Side")
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

    def expr_constant(self, args):
        return args[0]

    def stmt_expr(self, args):
        if len(args) > 0:
            code = args[0]['code']
            code += "# End of Expression Optional\n"
            code += "addi $sp , $sp 4\n"
            return {'code': code}
        else:
            return {'code': ''}

    def stmt_block(self, args):
        variable_count = 0
        stmts = []
        for arg in args:
            if 'variable_count' in arg:
                variable_count += arg['variable_count']
            else:
                stmts.append(arg)
        code = "# Begin of Statement Block\n"
        code += "addi $sp , $sp , -" + str(
           variable_count * 4) + " # Allocate From Stack For Block Statement Variables\n"
        code += "addi $fp , $sp , 4\n"
        for stmt in stmts:
            code += stmt['code']
        code += "addi $sp , $sp , " + str(
           variable_count * 4) + " # UnAllocate Stack Area (Removing Block Statement Variables)\n"
        code += "addi $fp ,$sp , 4\n"
        code += "# End of Statement Block\n"

        return {'code': code}

    def if_stmt(self, args):
        exp = args[0]
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
        return {'code': code}

    def stmt_if_stmt(self, args):
        code = "#End of if statement\n"
        return {'code' : args[0]['code'] + code}


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
        print(value)
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
        returnType = args[0]
        functionName = args[1].children[0]
        formals = args[2]
        stmt_block = args[3]
        label_end = functionName + "_end"
        code = functionName + ": # Start function\n"
        code += "addi $s5 , $sp , 0 # Storing $sp of function at beginning in $s5\n"
        code += "# Function Body :\n"
        code += stmt_block['code']
        code += label_end + ":\n"
        code += "jr $ra\n\n"
        return {'code': code, 'name': functionName}

    def stmt_print_stmt(self, args):
        args[0]['break_labels'] = []
        return args[0]

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

    def program(self, args):
        dirname = os.path.dirname(__file__)
        file = open(dirname + "/default_functions.txt", "r")
        default_functions = file.read()
        file.close()
        code = '.text\n'
        code += '.globl main\n'
        code += default_functions
        code += "\n"
        for arg in args:
            code += arg['code']
        self.data_code += "str_false : .asciiz \"false\" \n"
        self.data_code += "str_true : .asciiz \"true\" \n"
        self.data_code += "new_line : .asciiz \"\n\" \n"
        self.data_code += "str_bool : .word str_false , str_true\n"
        self.data_code += "obj_null : .word 61235\n"
        self.log_code(code + "\n\n.data\n" + self.data_code)
        return args
