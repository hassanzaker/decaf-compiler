from lark import Lark
from SemanticAnalyser import MyTransformer
import pprint


def create_parser():
    parser = Lark("""
        program : (decl)+ -> program
        decl : variable_decl 
            | function_decl -> decl_function_decl
            | class_decl | interface_decl
        variable_decl : variable ";"
        variable : type ident | ident_type ident
        type: "int" -> type_int
            | "double" -> type_double
            | "bool" -> type_bool
            | "string" -> type_string
            | type "[]" -> type_array
        ident_type : ident -> type_id
        function_decl : type ident "(" formals ")" stmt_block -> func_decl
            | "void" ident "(" formals ")" stmt_block
        formals : variable ("," variable)* 
            |  -> formals_empty
        class_decl : "class" ident ("extends" ident)?  ("implements" ident ("," ident)*)?  "{" (field)* "}"
        field : access_mode variable_decl | access_mode function_decl
        access_mode : "private" | "protected" | "public" | 
        interface_decl : "interface" ident "{" (prototype)* "}"
        prototype : type ident "(" formals ")" ";" | "void" ident "(" formals ")" ";"
        stmt_block : "{" (variable_decl)* (stmt)* "}" -> stmt_block
        stmt : (expr)? ";" -> stmt_expr
            | if_stmt | while_stmt | for_stmt | break_stmt | continue_stmt | return_stmt 
            | print_stmt -> stmt_print_stmt
            | stmt_block
        if_stmt : "if" "(" expr ")" stmt ("else" stmt)?
        while_stmt : "while" "(" expr ")" stmt
        for_stmt: "for" "(" (expr)? ";" expr ";" (expr)? ")" stmt
        return_stmt : "return" (expr)? ";"
        break_stmt : "break;"
        continue_stmt : "continue;"
        print_stmt : "print" "(" expr (","expr)* ")" ";" -> print_stmt
        expr : l_value "=" expr -> expr_assign
            | constant -> expr_constant
            | l_value 
            | "this" 
            | call 
            | "(" expr ")" -> exp_inside_parenthesis
            | expr "+" expr -> exp_plus_exp
            | expr "-" expr -> exp_minus_exp
            | expr "*" expr -> exp_mul_exp
            | expr "/" expr -> exp_div_exp
            | expr "%" expr -> exp_mod_exp
            | "-" expr -> exp_negative
            | expr "<" expr -> exp_less_exp 
            | expr "<=" expr -> exp_less_equal_exp
            | expr ">" expr -> exp_greater_exp
            | expr ">=" expr -> exp_greater_equal_exp
            | expr "==" expr -> exp_equal_exp
            | expr "!=" expr -> exp_not_equal_exp 
            | expr "&&" expr -> exp_and_exp
            | expr "||" expr -> exp_or_exp
            | "!" expr -> exp_not
            | "ReadInteger" "(" ")" 
            |"readLine" "(" ")" 
            | "new" ident 
            | "NewArray" "(" expr "," type ")" 
            | "itod" "(" expr ")" 
            | "dtoi" "(" expr ")" 
            | "itob" "(" expr ")" 
            | "btoi" "(" expr ")"
            
        l_value : ident | expr "." ident | expr "[" expr "]"
        call : ident "(" actuals ")" | expr "." ident "(" actuals ")"
        actuals : expr ("," expr)* | 
        constant : INT -> constant_int
        | DOUBLE -> constant_double
        | DOUBLE_SCI 
        | BOOL -> constant_bool
        |  STRING -> constant_string
        | "null" -> constant_null

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
