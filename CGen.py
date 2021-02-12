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

    def log_code(self, code):
        dirname = os.path.dirname(__file__)
        file = open(dirname + "/result.s", "w")
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
        # TODO --> append two string (or array) when we want to add them
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

    def formals_empty(self, args):
        return {'variable_count': 0}

    def variable_type_primitive(self, args):
        return {'type': args[0], 'name': args[1].children[0]}

    def variable_type_class(self, args):
        return {'type': args[0].value, 'name': args[1].children[0]}


    def variable_decl(self, args):
        return {"variable_count": 1}

    def global_variable(self, args):
        return {'code': ''}

    def lvalue_id(self, args):
        name = args[0].children[0].value
        var, address = self.symbol_table.getVariable(name, self.scope)
        code = "# Loading Address of ID : " + var.name + "\n"
        code += "addi $s7 , $fp , " + str(address) + "\n"
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
        if cls_var['access_level'] == 'public':
            var_offset = cls.getVaribaleOffset(variable)
        else:
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
        pass

    def stmt_expr(self, args):
        if len(args) > 0:
            code = args[0]['code']
            code += "# End of Expression Optional\n"
            code += "addi $sp , $sp 4\n"
            return {'code': code, "break_labels": []}
        else:
            return {'code': '', "break_labels": []}

    def new_array_exp(self, args):
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

    def stmt_block(self, args):
        self.scope += 1
        variable_count = 0
        stmts = []
        for arg in args:
            if 'variable_count' in arg:
                variable_count += arg['variable_count']
            else:
                stmts.append(arg)

        break_labels = []
        code = "# Begin of Statement Block\n"
        code += "addi $sp , $sp , -" + str(
            variable_count * 4) + " # Allocate From Stack For Block Statement Variables\n"
        code += "addi $fp , $sp , 4\n"
        for stmt in stmts:
            code += stmt['code']
            break_labels.extend(stmt['break_labels'])
        code += "addi $sp , $sp , " + str(
            variable_count * 4) + " # UnAllocate Stack Area (Removing Block Statement Variables)\n"
        code += "addi $fp ,$sp , 4\n"
        code += "# End of Statement Block\n"
        self.symbol_table.removeFromScop(self.scope)
        return {'code': code, 'break_labels': break_labels}

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
        return {'code': code, 'break_labels': args[1]['break_labels']}


    def stmt_stmt_block(self, args):
        return args[0]

    def stmt_if_stmt(self, args):
        code = "#End of if statement\n"
        return {'code': args[0]['code'] + code, 'break_labels': args[0]['break_labels']}

    def find_break_label(self , arr , name):
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
            count = self.find_break_label(break_labels , break_label)
            code_for_break = "addi $sp , $sp , " + str(count * 4) + " # Pop elements before\n"
            code_for_break += "addi $fp , $sp , 4 # Set Frame Pointer\n"
            code_for_break += "j " + second_label + " # Break from loop while\n"
            stmt['code'] = stmt['code'].replace("@" + break_label + "@" , code_for_break)

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
        return {'code' : code , 'break_labels': []}

    def stmt_while_stmt(self, args):
        code = "#End of while statement\n"
        return  {'code': args[0]['code'] + code, 'break_labels': args[0]['break_labels']}

    def for_stmt(self, args):
        number_of_elem = len(args)
        stmt = args[number_of_elem - 1]
        first_label = "label" + str(self.string_numbers)
        self.string_numbers += 1
        second_label = "label" + str(self.string_numbers)
        self.string_numbers += 1

        break_labels = stmt['break_labels']
        pattern = re.compile(r'@(break\d+)@')
        for break_label in re.findall(pattern, stmt['code']):
            count = self.find_break_label(break_labels, break_label)
            code_for_break = "addi $sp , $sp , " + str(count * 4) + " # Pop elements before\n"
            code_for_break += "addi $fp , $sp , 4 # Set framepointer\n"
            code_for_break += "j " + second_label + " # Break from loop for\n"
            stmt['code'] = stmt['code'].replace("@" + break_label + "@", code_for_break)

        if number_of_elem == 4:
            initialize = args[0]
            condition = args[1]
            step = args[2]
        else:
            if number_of_elem == 2:
                condition = args[0]
            else:
                pass
        code = "# Initialization Expression of Loop for\n"
        code += ''  #should add initialize term
        # if expr_initialization['code'] != '':
        #     code += "addi $sp , $sp , 4 # pop init expr of loop for\n"
        code += first_label + ": # Starting for Loop Body\n"
        code += "# Calculating For Loop Condition\n"
        code += condition['code']
        code += "# Loading For Loop Condition Result\n"
        code += "addi $sp , $sp , 4\n"
        code += "lw $t0 , 0($sp)\n"
        code += "beqz $t0 , " + second_label + " # Jumping to end label if Condition Expression of for loop is false\n"
        code += stmt['code']
        code += "# Step Expression of For loop \n"
        code += '' #should add step
        # if expr_step['code'] != '':
        #     code += "addi $sp , $sp , 4 # pop step expr of loop for\n"
        code += "j " + second_label + " # Jumping to beggining of while loop\n"
        code += second_label + ":\n"
        return {'code' : code , 'break_labels' : []}

    def stmt_for_stmt(self, args):
        return args[0]

    def break_stmt(self,args):
        code = "@" + "break" + str(self.break_labels) + "@\n"
        self.break_labels += 1
        return {'code' : code}

    def continue_stmt(self, args):
        code = "@" + "continue" + str(self.continue_labels) + "@\n"
        self.continue_labels += 1
        return {'code' : code}

    def stmt_break_stmt(self , args):
        return {'code' : args[0]['code'], 'break_labels': [{'name' : args[0]['code'][1:-2] , 'count' : 0}]}

    def stmt_continue_stmt(self,args):
        return {'code' : args[0]['code'], 'continue': [{'name' : args[0]['code'][1:-2] , 'count' : 0}]}




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
        return {'code': args[0]['code'], 'break_labels': []}

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

    # def method_field(self, args):
    #     scope = "func" + str(self.scope)
    #     args[0]['code'] = args[0]['code'].replace(args[0]['name'] + "_end:", scope + "_" + args[0]['name'] + "_end:")
    #     args[0]['code'] = args[0]['code'].replace(args[0]['name'] + ":", scope + "_" + args[0]['name'] + ":")
    #     return args[0]
    #
    def class_decl(self, args):
        return {'code': ''}
    # def class_decl_fields(self, args):
    #
    # def class_decl_extend(self, args):
    #
    def decl_class_decl(self, args):
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
        code += self.classes.getConstructor()
        for arg in args:
            print(arg)
            code += arg['code']
        self.data_code += self.symbol_table.getData()
        self.data_code += self.classes.getVtables()
        self.data_code += "str_false : .asciiz \"false\" \n"
        self.data_code += "str_true : .asciiz \"true\" \n"
        self.data_code += "new_line : .asciiz \"\n\" \n"
        self.data_code += "str_bool : .word str_false , str_true\n"
        self.data_code += "obj_null : .word 61235\n"
        self.log_code(code + "\n\n.data\n" + self.data_code)
        return args
