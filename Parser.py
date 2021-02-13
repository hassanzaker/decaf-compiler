
from lark import Lark
from SemanticAnalyser import MyTransformer
import pprint


def create_parser():
    parser = Lark("""
        program : (decl)+ -> program
        decl : variable_decl -> global_variable
            | function_decl -> decl_function_decl
            | class_decl -> decl_class_decl
            | interface_decl
        variable_decl : variable ";" -> variable_decl
        variable : type ident -> variable_type_primitive
            | ident_type ident -> variable_type_class
            
        type: "int" -> type_int
            | "double" -> type_double
            | "bool" -> type_bool
            | "string" -> type_string
            | type "[]" -> type_array
            
        ident_type : ident -> type_id
        
        function_decl : type ident "(" formals ")" stmt_block -> func_decl
            | ident_type ident "(" formals ")" stmt_block -> func_decl_data_type
            | "void" ident "(" formals ")" stmt_block -> function_void_decl
            
        formals : variable ("," variable)* -> formals
            |  -> formals_empty
            
        class_decl : "class" ident class_extend  class_implement class_fields -> class_decl
        class_extend : ("extends" ident)? -> class_decl_extend
        class_implement : ("implements" ident ("," ident)*)?
        class_fields : "{" (field)* "}" -> class_decl_fields
        field : access_mode variable_decl -> variable_field
            | access_mode function_decl -> method_field
        access_mode : "private" -> private_access
            | "protected" -> protected_access
            | "public" -> public_access
            |  -> default_access
        interface_decl : "interface" ident "{" (prototype)* "}"
        prototype : type ident "(" formals ")" ";" | "void" ident "(" formals ")" ";"
        stmt_block : "{" (variable_decl)* (stmt)* "}" -> stmt_block
        stmt : (expr)? ";" -> stmt_expr
            | if_stmt -> stmt_if_stmt
            | while_stmt -> stmt_while_stmt
            | for_stmt -> stmt_for_stmt
            | break_stmt -> stmt_break_stmt
            | continue_stmt -> stmt_continue_stmt
            | return_stmt -> stmt_return_stmt
            | print_stmt -> stmt_print_stmt
            | stmt_block -> stmt_stmt_block
        expr_opt : expr -> expr_opt 
         | ->expr_opt_empty
        if_stmt : "if" "(" expr ")" stmt ("else" stmt)? -> if_stmt
        while_stmt : "while" "(" expr ")" stmt -> while_stmt
        for_stmt: "for" "(" expr_opt ";" expr ";" expr_opt ")" stmt ->for_stmt
        return_stmt : "return" (expr)? ";" -> return_stmt
        break_stmt : "break" ";" -> break_stmt
        continue_stmt : "continue" ";" -> continue_stmt
        print_stmt : "Print" "(" expr (","expr)* ")" ";" -> print_stmt
        expr : l_value "=" expr -> expr_assign
            | constant -> expr_constant
            | l_value -> lvalue
            | "this"  -> this_exp
            | call -> call_expr
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
            | "ReadInteger" "(" ")" -> read_integer_exp
            | "ReadLine" "(" ")" -> read_line_exp
            | "new" ident -> new_ident_exp
            | "NewArray" "(" expr "," type ")"  -> new_array_exp
            | "itod" "(" expr ")" -> itod_exp
            | "dtoi" "(" expr ")" -> dtoi_exp
            | "itob" "(" expr ")" -> itob_exp
            | "btoi" "(" expr ")" -> btoi_exp
            
        l_value : ident -> lvalue_id
            | expr "." ident -> get_class_variable
            | expr "[" expr "]" -> get_array_item
        call : ident "(" actuals ")" -> call_global_func
            | expr "." ident "(" actuals ")" -> call_class_func
        actuals : expr ("," expr)* -> actuals
            | -> actual_empty
        
        constant : INT -> constant_int
            | DOUBLE -> constant_double
            | DOUBLE_SCI -> constant_double2
            | BOOL -> constant_bool
            |  STRING -> constant_string
            | "null" -> constant_null

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
