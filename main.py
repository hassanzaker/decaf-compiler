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
 int q;

    
 public void changeA(int a){
    this.q = a * a;
    Print(this.q);
 }
 int setA(int x, int y){
    Print(y);
    }
}
// class Baba extends Ali{}
int main() {
    Ali ali;
    ali = New Ali;
        ali.setA(5, 7);

    ali.changeA(1);
    Print(ali.q);
    
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
