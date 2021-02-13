from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
class ali{
int x;
int f(int a, int b){
return b;
}
}
int add(int s, int t){
return s + t;
}

int main() {
    ali a;
    int b;
    a = new ali;
    b = a.f(4, 9);
    print(b);

}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
b = Cgen(a.classes, a.symbol_table).transform(tree)

