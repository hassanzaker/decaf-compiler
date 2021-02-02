from Parser import *
from SemanticAnalyser import *

text = """
int main() {
    a = 4 + 34;
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer().transform(tree)
print(a)