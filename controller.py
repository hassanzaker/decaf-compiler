import sys

from Parser import *
from SemanticAnalyser import *
from CGen import *
from FormFunctions import *
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
 void f(int e){
  Print(this.x);
  Print(e);
 }
 void g(int g){
  Print(this.x);
  Print(g);
 }
 
 void h(int r){
  Print(this.x);
  Print(r);
 }
}

class Hassan{
 int x;
 void f(int e){
  Print(this.x);
  Print(e);
 }
 void g(int g){
  Print(this.x);
  Print(g);
 }
 
 void h(int r){
  Print(this.x);
  Print(r);
 }
}
int main() {
    Ali a;
    Hassan b;
    a = new Ali;
    b = new Hassan;
    a.x = 7;
    a.f(33);
    a.g(44);
    a.h(55);
    b.x = 13;
    b.f(3);
    b.g(4);
    b.h(5);
}
"""

def start(data):
    tree = parse_text(data)
    a = MyTransformer()
    if str(tree) == 'Syntax Error':
        print(tree)
    tree = FormFunctions().transform(tree)
    try:
        a.transform(tree)
        b = Cgen(a.classes, a.symbol_table).transform(tree)
        return b
    except:
        return semanticError


# text = """
# int main() {
#     int a;
#     int b;
#     int c;
#     int d;
#
#     int z;
#
#     a = 5;
#     b = -6;
#     c = 100;
#     d = 33;
#
#     z = a + b * c - d / a;
#
#     Print(z);
# }
# """
#
# def write_code_in_file(code):
#     dirname = os.path.dirname(__file__)
#     file = open(dirname + "/result.s", "w")
#     file.write(code)
#     file.close()
#
#
# tree = parse_text(text)
# print(tree)
# tree = FormFunctions().transform(tree)
# print(tree)
# a = MyTransformer()
# if str(tree) == 'Syntax Error':
#     print(tree)
#
# a.transform(tree)
# b = Cgen(a.classes, a.symbol_table).transform(tree)
# write_code_in_file(b)
#
#
