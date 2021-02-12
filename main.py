from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
class ali{
int x;
}
int main() {
    int a;
    bool b;
    b = true;
    a = btoi(b);
    print(a);
    print(b);
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
b = Cgen(a.classes, a.symbol_table).transform(tree)
print(b)

