from lark import Lark, Transformer
from ClassTable import Classes, Class

class MyTransformer(Transformer):
    def __init__(self):
        self.classes = Classes()

    def INT(self, token):
        return 'int'
    def DOUBLE(self, token):
        return 'double'
    def DOUBLE_SCI(self, token):
        return 'double'
    def STRING(self, token):
        return 'str'
    def BOOL(self, token):
        return 'bool'
    def constant(self, value):
        if len(value) == 0:
            return 'null'
        return value

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

    def decl_class_decl(self, args):
        self.classes.addClass(args[0])
        return

    def class_decl(self, args):
        id = args[0].children[0]
        cls = Class(str(id))
        if args[1] != None:
            cls.father = args[1]
        variables = args[3]['variables']
        methods = args[3]['methods']
        for var in variables:
            if cls.doesVariableExist(var['name']):
                raise Exception(var['name'] + " is defined more than one time!")
            else:
                cls.addVariable(var)
        for method in methods:
            if cls.doesMethodExist(method['name']):
                raise Exception(method['name'] + " is defined more than one time!")
            else:
                cls.addMethod(method)
        return cls


    def class_decl_extend(self, args):
        if len(args) > 0:
            return args[0].children[0]
        else:
            return None

    def class_decl_fields(self, args):
        methods = []
        variables = []
        for arg in args:
            if arg['field'] == "variable":
                variables.append({'access_level': arg['access_level'], 'name': arg['name'], 'type': arg['type']})
            else:
                methods.append({'access_level': arg['access_level'], 'name': arg['name'], 'type': arg['type']})
        return {'variables': variables, 'methods': methods}

    def variable_field(self, args):
        return {'field': 'variable', 'access_level': args[0], 'name': args[1]['name'], 'type': args[1]['type']}

    def method_field(self, args):
        return {'field': 'method', "access_level": args[0], 'name': args[1]['name'], 'type': args[1]['type']}

    def func_decl(self, args):
        return {'type': args[0], 'name': args[1].children[0].value}

    def func_decl_data_type(self, args):
        return {'type': args[0].value, 'name': args[1].children[0].value}

    def function_void_decl(self, args):
        return {'type': 'void', 'name': args[0].children[0].value}

    def variable_decl(self, args):
        return args[0]

    def variable_type_primitive(self, args):
        return {'type': args[0], 'name': args[1].children[0][0]}

    def variable_type_class(self, args):
        return {'type': args[0].value , 'name': args[1].children[0][0]}

    def public_access(self, args):
        return "public"

    def protected_access(self, args):
        return "protected"

    def private_access(self, args):
        return "private"

    def default_access(self, args):
        return "public"

    def program(self, args):
        self.classes.Inheritance()
        return

