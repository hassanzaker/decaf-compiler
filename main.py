from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
class mamd {
public int s;
protected void make(){}
}
class ali extends mamd{
public ali x;
protected int c;
string add(){}
void mul(){}
ali sub(){}
private int make(){}
}


int main() {
    if (33 >= 8 * 4) 
    print(1);
    else 
    print(2);
    
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
print(a.classes.getVtables())
# b = Cgen().transform(tree)
# print(b)