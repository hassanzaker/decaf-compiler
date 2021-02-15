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
class Ali{
 int x;
 void f(){
  Print(this.x);
 }
 void g(){
  Print(this.x);
 }
}
int main() {
    Ali a;
    a = New Ali;
    a.x = 7;
    a.f();
    a.g();
    
    
    
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
