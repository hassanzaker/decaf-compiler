from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
void f(ali a){
a.x = 4;
}
class ali{
int x;
}
int main() {
    ali a;
    a = new ali;
    f(a);
    print(a.x);
    
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
b = Cgen(a.classes, a.symbol_table).transform(tree)
print(b)

