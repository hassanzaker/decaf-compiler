from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
int f(int a){
if (a == 0)
    return 1;
else
    return a * f(a - 1);
}
int h(int a){
if (a == 0)
    return 0;
else
    return a * f(a - 1);
}
class ali{
int x;
int a;
int b;
}
int main() {
    print(f(10));
    
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
print(a.symbol_table)
b = Cgen(a.classes, a.symbol_table).transform(tree)
print(b)

