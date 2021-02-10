from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """



int main() {
    for(;4<5;){
    print(false);
    }
    
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
print(a.classes.getVtables())
print("sla")
b = Cgen().transform(tree)
print(b)
print("c")
