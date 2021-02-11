class Var:
    def __init__(self , id ,value, scope):
        self.id = id
        self.scope = scope
        self.value = value

    def setVal(self, value):
        self.value = value
