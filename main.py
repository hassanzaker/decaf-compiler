from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
int main() {
    print(4 * 3 + 2);
    print(3.2 * 2.5);
    print(6 / 4);
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer().transform(tree)
print(a)
b = Cgen().transform(tree)
print(b)