from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
int main() {
    for(;4 < 5;){
    print(3);
    }
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
b = Cgen().transform(tree)
print(b)

