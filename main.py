from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
class ali{
int x;
}
int main() {
    string a;
    string b;
    a = "ali";
    b = " zaker";
    print(a + b);
}
"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
b = Cgen(a.classes, a.symbol_table).transform(tree)
print(b)

