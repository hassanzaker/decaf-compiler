from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
class ali{
int x;
int f(){
return 3;
}
}
int main() {
    ali a;
    int b;
    a = new ali;
    b = a.f();
    print(b);
    
}
"""
tree = parse_text(text)
a = MyTransformer()
a.transform(tree)
print(a.symbol_table)
b = Cgen(a.classes, a.symbol_table).transform(tree)

