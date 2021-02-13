from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """

int main() {
    int i;
    i = 0;
    for(;4<5;)
    {
    if (i == 5){
    continue;
    }
    else{
    print(2);
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

