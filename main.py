from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
int main() {
    print(-33, -4.4);
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer().transform(tree)
print(a)
b = Cgen().transform(tree)
print(b)