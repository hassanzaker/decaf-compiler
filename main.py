from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
class ali{
int x;
}
int main() {
    int[] a;
    a = NewArray(3, int);
    a[0] = 2;
    a[1] = 3;
    a[2] = 54;
    print(a);
    print(a[0]);
    print(a[1]);
    print(a[2]);
    
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
b = Cgen(a.classes, a.symbol_table).transform(tree)
print(b)

