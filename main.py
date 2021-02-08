from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
int main() {
    print(false && false, false && true, true && false, true && true);
    print(false || false, false || true, true || false, true || true);
    print(!false, !true);
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer().transform(tree)
print(a)
b = Cgen().transform(tree)
print(b)