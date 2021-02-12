from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
class ali{
int x;
}
int main() {
    int a;
    double d;
    a = 5;
    d = itod(a);
    print(a);
    print(d);
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
b = Cgen(a.classes, a.symbol_table).transform(tree)
print(b)

