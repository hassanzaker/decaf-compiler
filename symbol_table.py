class Symbol:
    def __init__(self, scope, name, type):
        self.scope = scope
        self.name = name
        self.type = type
        self.size = 0

    def __str__(self):
        return str(self.scope) + " " + self.name + " " + self.type + "\n"


class Function:
    def __init__(self, scope, name, type, formals):
        self.scope = scope
        self.name = name
        self.type = type
        self.formals = formals


class Symbol_Table:
    def __init__(self):
        self.variables = []
        self.allVariables = []
        self.functions = []

    def addFunction(self, func):
        self.doesFunctionExistInThisScope(func.name, func.scope)
        self.functions.append(func)
        self.functions[-1].formals.reverse()

    def addVariable(self, symbol):
        self.doesExistInThisScope(symbol.name, symbol.scope)
        self.variables.append(symbol)

    def doesFunctionExistInThisScope(self, name, scope):
        for func in self.functions:
            if func.name == name and func.scope == scope:
                raise Exception('function ' + name + ' already exists!')
        else:
            return

    def doesExistInThisScope(self, name, scope):
        for var in self.variables:
            if var.name == name and var.scope == scope:
                raise Exception('variable ' + name + ' already exists!')
        else:
            return

    def removeFromScop(self, scope):
        self.allVariables = []
        for var in self.variables:
            self.allVariables.append(var)
            if var.scope == scope:
                self.variables.remove(var)

    def getFunction(self, name):
        for func in self.functions:
            if func.name == name:
                return func
        raise Exception('function does not exist!')

    def getVariable(self, name, scope):
        counter = 0
        for var in self.variables:
            if var.scope == scope:
                counter += 1
                if var.name == name and var.scope == scope:
                    return (var, counter * 4)
        counter = 0
        for var in self.variables:
            if var.name == name and var.scope > scope:
                return (var, counter * 4)
            counter += 1
        counter = 0
        for var in self.variables:
            if var.scope == -1 and var.name == name:
                return (var, counter * 4)
            counter += 1
        else:
            raise Exception('variable ' + name + ' not defined!')

    def getData(self):
        code = ''
        for var in self.allVariables:
            code += var.name + str(var.scope) + " : "
            if var.type == 'double':
                code += ".float 0.0"
            else:
                code += ".word 0"
            code += '\n'
        return code

    def __str__(self):
        string = ''
        for var in self.variables:
            string += var.__str__()
        return string
