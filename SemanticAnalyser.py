from lark import Lark, Transformer

class MyTransformer(Transformer):
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



    def f(self, values):
        return values[0]

