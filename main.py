from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
int main() {
    int a;
    a = "str";    
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
b = Cgen(a.classes, a.symbol_table).transform(tree)
print(b)

