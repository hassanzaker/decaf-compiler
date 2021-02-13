class Class:
    def __init__(self, name):
        self.name = name
        self.variables = []
        self.methods = []
        self.father = None
        self.isDone = False

    def addMethod(self, method, scope, formals):
        method['scope'] = scope
        method['formals'] = formals
        self.methods.append(method)


    def addVariable(self, variable):
        variable['scope'] = self.name
        self.variables.append(variable)

    def doesVariableExist(self, varName, inside = False):
        for var in self.variables:
            if varName == var['name'] and ((not inside) or (var['access_level'] == 'protected') or (var['access_level'] == 'public') ):
                return True
        else:
            return False

    def doesMethodExist(self, methodName, inside = False):
        for method in self.methods:
            if methodName == method['name'] and ((not inside) or (method['access_level'] == 'protected') or (method['access_level'] == 'public')):
                return True
        else:
            return False

    def getVaribaleOffset(self, varName):
        for i in range(len(self.variables)):
            if self.variables[i]['name'] == varName:
                return 4 * i
        raise Exception("Variable ( " + varName + " ) fot found !!!")

    def getMethodOffset(self, methodName):
        for i in range(len(self.methods)):
            if self.methods[i]['name'] == methodName:
                return 4 * i
        raise Exception("Method ( " + methodName + " ) fot found !!!")

    def getVariable(self, varName):
        for var in self.variables:
            if var['name'] == varName:
                return var
        raise Exception("Variable ( " + varName + " ) fot found !!!")

    def getMethods(self, methodName):
        for method in self.methods:
            if method['name'] == methodName:
                return method
        raise Exception("Method ( " + methodName + " ) fot found !!!")

    def extendClass(self):
        if not self.isDone:
            if self.father.isDone == True:
                self.extendVariables(self.father)
                self.extendMethods(self.father)
            else:
                self.father.extendClass()
        return


    def extendMethods(self, father):
        methods = []
        for method in father.methods:
            if method['access_level'] == 'protected' or method['access_level'] == 'public':
                methods.append(method.copy())
        temp = self.methods
        self.methods = methods
        for method in temp:
            if not self.doesMethodExist(method['name']):
                self.methods.append(method.copy())
            else:
                self.overrideMethod(method)

    def extendVariables(self, father):
        variables = []
        for var in father.variables:
            if var['access_level'] == "protected" or var['access_level'] == 'public':
                variables.append(var.copy())
        temp = self.variables
        self.variables = variables
        for var in temp:
            if not self.doesVariableExist(var['name']):
                self.variables.append(var.copy())
            else:
                if self.getVariable(var['name'])['access_level'] != var['access_level']:
                    self.getVariable(var['name'])['access_level'] = var['access_level']

    def overrideMethod(self, methodName):
        for method in self.methods:
            if method['name'] == methodName['name'] and (method['access_level'] == 'protected' or method['access_level'] == 'public'):
                method['scope'] = self.name
                method['access_level'] = methodName['access_level']
                return
        raise Exception("Method ( " + methodName['name'] + " ) not found to override !!!")

    def getVtable(self):
        code = ''
        code += self.name + "_vtable:\n"
        for method in self.methods:
            code += "\t.word " + self.name + "_" + method['name'] + "\n"
        return code



class Classes:
    def __init__(self):
        self.classes = []

    def addClass(self, class_type):
        self.classes.append(class_type)

    # should be call after all classes have been defined and added to Classe list
    def Inheritance(self):
        for cls in self.classes:
            father = cls.father
            if father != None:
                obj = self.searchClass(father)
                cls.father = obj
            else:
                cls.isDone = True

        self.extendClass()

    def getMethodByNameAndScope(self, name, scope):
        for cls in self.classes:
            for method in cls.methods:
                if method['name'] == name and method['scope'] == scope:
                    return cls
        else:
            raise Exception('method not found!')

    def extendClass(self):
        for cls in self.classes:
            cls.extendClass()


    def doesClassExist(self, className):
        for cls in self.classes:
            if cls['name'] == className:
                return True
        else:
            return False

    def searchClass(self, className):
        for cls in self.classes:
            if cls.name == className:
                return cls
        else:
            raise Exception("Class with name " + str(className) + " does not exist!")


    def getVtables(self):
        code = ''
        for cls in self.classes:
            code += cls.getVtable()
        return code

    def isChildOf(self, child, father):
        if child.father != None:
            if child.father.name == father.name:
                return True
            else:
                self.isChildOf(child.father, father)
        else:
            return False

    def isConvertable(self, first, second):
        if first.name == second.name:
            return True
        else:
            return self.isChildOf(first, second)

    def getConstructor(self):
        code = ''
        for cls in self.classes:
            size = (len(cls.variables) + 1) * 4;
            code += "# Constructor for Class : " + cls.name + "\n"
            code += cls.name + "_Constructor:\n"
            code += "li $a0 , " + str(size) + " # Size of Object ( including Vtable address at index 0 )\n"
            code += "li $v0 , 9\n"
            code += "syscall\n"
            code += "la $t0 , " + cls.name + "_vtable # Loading Vtable Address of this Class\n"
            code += "sw $t0 , 0($v0) # Storing Vtable pointer at index 0 of object\n"
            code += "jr $ra\n\n"
        return code