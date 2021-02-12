from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
void f(ali a, int b, int c){
a.x = b * c;
}
class ali{
int x;
}
int main() {
    ali a;
    a = new ali;
    f(a, 9, 3);
    print(a.x);
    
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
print(a.symbol_table)
b = Cgen(a.classes, a.symbol_table).transform(tree)
print(b)

