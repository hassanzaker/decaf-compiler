from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
class ali{
private int x;
void changeX(int a, int b){
this.x = a * b;
}
int getX(){
    return this.x;
}
}

int main() {
    ali a;
    a = new ali;
    a.changeX(4 , 5);
    Print(a.getX());
}

"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
print(a.symbol_table)
b = Cgen(a.classes, a.symbol_table).transform(tree)
print(b)

