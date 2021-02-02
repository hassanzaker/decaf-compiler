from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
int main() {
    print(4 + 7777, 32);
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer().transform(tree)
print(a)
b = Cgen().transform(tree)
print(b)