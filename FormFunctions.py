from lark import Lark, Transformer, Tree

class FormFunctions(Transformer):
    def decl_function_decl(self, args):
        try:
            name = args[0].children[1].children[0].value
            return {'type': 'func', 'all': Tree('decl_function_decl', [args[0]]), 'name': name}
        except:
            return Tree('decl_function_decl', args)

    def program(self, args):
        lst = []
        temp = None
        for arg in args:
            try:
                if arg['name'] == 'main':
                    temp = arg['all']
                else:
                    lst.append(arg['all'])
            except:
                lst.append(arg)
        if temp is None:
            raise Exception("there should be one main function!")
        lst.append(temp)
        tree = Tree('program', lst)
        return tree