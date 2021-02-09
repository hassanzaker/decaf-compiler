from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
int main() {
    if (33 >= 8 * 4) 
    print(1);
    else 
    print(2);
    
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer().transform(tree)
print(a)
b = Cgen().transform(tree)
print(b)