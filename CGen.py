import os
import re

from lark import Lark, Transformer


class Cgen(Transformer):
    def __init__(self):
        self.data_code = ''

    def log_code(self, code):
        dirname = os.path.dirname(__file__)
        file = open(dirname + "/code.s", "w")
        file.write(code)
        file.close()



    def exp_plus_exp(self, args):
        value_type = args[0]['value_type']
        code = "# Add Expression\n"
        if value_type == 'int':
            code += "lw $t0 , 8($sp)\n"
            code += "lw $t1 , 4($sp)\n"
            code += "add $t0 , $t0 , $t1\n"
            code += "sw $t0 , 8($sp)\n"
        elif value_type == 'double':
            code += "l.s $f0 , 8($sp)\n"
            code += "l.s $f1 , 4($sp)\n"
            code += "add.s $f0 , $f0 , $f1\n"
            code += "s.s $f0 , 8($sp)\n"
        else:
            raise Exception("Unhandled Type for Add !")
        code += "addi $sp , $sp , 4\n"
        return {'code': args[0]['code'] + args[1]['code'] + code,
                'value_type': value_type}
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
        name = self.data_name_generator()
        code = "# String Constant : " + args[0].value + "\n"
        code += 'la $t0 , ' + name + '\n'
        code += 'sw $t0 , 0($sp)\n'
        code += 'addi $sp , $sp , -4\n'
        self.data_code += name + ': .asciiz ' + args[0].value + '\n'
        return {'code': code,
                'value_type': 'string'}

    ############### String Constant ###############
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
        for arg in args:
            expr = arg
            expr_type = expr['value_type']
            code = expr['code']
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
        for arg in args:
            code += arg['code']
        self.data_code += "str_false : .asciiz \"false\" \n"
        self.data_code += "str_true : .asciiz \"true\" \n"
        self.data_code += "str_bool : .word str_false , str_true\n"
        self.data_code += "obj_null : .word 61235\n"
        self.log_code(code + "\n\n.data\n" + self.data_code)
        return args
