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
    int[] a;
    int[] b;
    int[] c;
    int i;
    int size;
    a = NewArray(2, int);
    a[0] = 0;
    a[1] = 1;
    b = NewArray(3, int);
    b[0] = 2;
    b[1] = 3;
    b[2] = 4;
    c = a + b;
    size = c.length();
    Print("size: ", size);
    for(i=0 ; i < size ; i = i+1){
    Print(c[i]);
    }
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
