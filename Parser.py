from lark import Lark
from SemanticAnalyser import MyTransformer
import pprint

def create_parser():
    parser = Lark("""
        program : (decl)+
        decl : variable_decl | function_decl | class_decl | interface_decl
        variable_decl : variable ";"
        variable : type ident | ident_type ident
        type : "int" | "double" | "bool" | "string" | type "[" "]"
        ident_type : ident
        function_decl : type ident "(" formals ")" stmt_block | "void" ident "(" formals ")" stmt_block
        formals : variable ("," variable)* |  
        class_decl : "class" ident ("extends" ident)?  ("implements" ident ("," ident)*)?  "{" (field)* "}"
        field : access_mode variable_decl | access_mode function_decl
        access_mode : "private" | "protected" | "public" | 
        interface_decl : "interface" ident "{" (prototype)* "}"
        prototype : type ident "(" formals ")" ";" | "void" ident "(" formals ")" ";"
        stmt_block : "{" (variable_decl)* (stmt)* "}"
        stmt : (expr)? ";" | if_stmt | while_stmt | for_stmt | break_stmt | continue_stmt | return_stmt | print_stmt | stmt_block
        if_stmt : "if" "(" expr ")" stmt ("else" stmt)?
        while_stmt : "while" "(" expr ")" stmt
        for_stmt: "for" "(" (expr)? ";" expr ";" (expr)? ")" stmt
        return_stmt : "return" (expr)? ";"
        break_stmt : "break;"
        continue_stmt : "continue;"
        print_stmt : "print" "(" expr (","expr)* ")" ";" 
        expr : l_value "=" expr 
        | constant -> f 
        | l_value | "this" | call | "(" expr ")" 
        | expr "+" expr -> exp_plus_exp
        | expr "-" expr | expr "*" expr | expr "/" expr | expr "%" expr | "-" expr | expr "<" expr | expr "<=" expr | expr ">" expr | expr ">=" expr | expr "==" expr | expr "!=" expr | expr "&&" expr | expr "||" expr | "!" expr | "ReadInteger" "(" ")" |"readLine" "(" ")" | "new" ident | "NewArray" "(" expr "," type ")" | "itod" "(" expr ")" | "dtoi" "(" expr ")" | "itob" "(" expr ")" | "btoi" "(" expr ")"
        l_value : ident | expr "." ident | expr "[" expr "]"
        call : ident "(" actuals ")" | expr "." ident "(" actuals ")"
        actuals : expr ("," expr)* | 
        constant : INT | DOUBLE | DOUBLE_SCI | BOOL |  STRING | "null"

        NEW : "new"
        DOUBLE.2 : /(\\d)+\\.(\\d)*/
        DOUBLE_SCI.3 : /(\\d)+\\.(\\d)*[Ee][+-]?(\\d)+/
        INT: /0[xX][a-fA-F0-9]+/ | /[0-9]+/
        BOOL.2 : "true" | "false"
        STRING : /"[^"\\n]*"/
        ident: /[a-zA-Z][a-zA-Z0-9_]{,50}/ 
        INLINE_COMMENT : "//" /[^\\n]*/ "\\n"
        MULTILINE_COMMENT : "/*" /.*?/ "*/"
        %import common.WS -> WHITESPACE
        %ignore WHITESPACE
        %ignore INLINE_COMMENT
        %ignore MULTILINE_COMMENT
        """, start="program", parser="lalr", lexer="standard")
    return parser


def parse_text(text):
    parser = create_parser()
    try:
        tree = parser.parse(text)
        return tree
    except:
        return "Syntax Error"