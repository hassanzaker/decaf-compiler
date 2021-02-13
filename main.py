from Parser import *
from SemanticAnalyser import *
from CGen import *

text = """
int test(int a, int b) {
    return a * b;
}

int main() {
    int a;
    int b;

    a = ReadInteger();
    b = ReadInteger();

    Print(test(a, b));
}

"""
tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
print(a.symbol_table)
b = Cgen(a.classes, a.symbol_table).transform(tree)
print(b)

