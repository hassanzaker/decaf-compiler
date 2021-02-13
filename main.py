from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """

int main() {
    int i;
    i = 0;
    for(i=2;i < 5;i = i +1)
    {
    i = i + 1;
    if (i == 4){
    continue;
    }
    else{
    print(i);
    }
    }
    
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
print(a.symbol_table)
b = Cgen(a.classes, a.symbol_table).transform(tree)
print(b)

