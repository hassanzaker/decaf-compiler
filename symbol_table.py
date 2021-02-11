class Symbol:
    def __init__(self, scope, name, type):
        self.scope = scope
        self.name = name
        self.type = type

    def __str__(self):
        return str(self.scope) + " " + self.name + " " + self.type + "\n"

class Symbol_Table:
    def __init__(self):
        self.variables = []

    def addVariable(self, symbol):
        self.doesExistInThisScope(symbol.name, symbol.scope)
        self.variables.append(symbol)


    def doesExistInThisScope(self, name, scope):
        for var in self.variables:
            if var.name == name and var.scope == scope:
                raise Exception('variable ' + name + ' already exists!')
        else:
            return

    def removeFromScop(self, scope):
        for var in self.variables:
            if var.scope == scope:
                self.variables.remove(var)


    def getVariable(self, name, scope):
        counter = 0
        for var in self.variables:
            if var.name == name and var.scope == scope:
                return (var, counter * 4)
            counter += 1
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
            raise Exception('variable not defined!')


    def getData(self):
        code = ''
        for var in self.variables:
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


