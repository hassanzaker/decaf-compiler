from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """

int main() {
    int a;
    int b;
    int i;

    b = 0;
    for(i = 1; true; i = i + 1) {
        print("Please enter the #", i, " number:");
        a = readInteger();
        if (a < 0){
            break;
            }
            
            b = a + b;
           
       
    }

    print("Sum of ", i, " items is: ", b);
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
print(a.symbol_table)
b = Cgen(a.classes, a.symbol_table).transform(tree)
print(b)

