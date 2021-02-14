from Parser import *
from SemanticAnalyser import *
from CGen import *
semanticError = """
.text
.globl main

main:
la $a0 , errorMsg
addi $v0 , $zero, 4
syscall
jr $ra

.data
errorMsg: .asciiz "Semantic Error"
"""

text = """
int main() {
    int a;
    int b;
    int c;
    int d;
    a = ReadInteger();
    b = ReadInteger();
    c = ReadInteger();
    d = ReadInteger();
    
    Print(a, " ", b, " " , c, " " , d);
    
    
    
}
"""



tree = parse_text(text)
print(tree)
a = MyTransformer()
a.transform(tree)
b = Cgen(a.classes, a.symbol_table).transform(tree)

# try:
#     a.transform(tree)
#     b = Cgen(a.classes, a.symbol_table).transform(tree)
# except:
#     dirname = os.path.dirname(__file__)
#     file = open(dirname + "/result.s", "w")
#     file.write(semanticError)
#     file.close()
#
