# CUCU
HOW TO RUN:


Run the following commands in terminal:

lex cucu.l

yacc -d cucu.y 

gcc lex.yy.c y.tab.c -lfl

./a.out Sample1.cu/Sample2.cu


AFTER EXECUTION:


After Execution of the above commands following files are generated:

1>Parser.txt :
    It contains the structure of the source code according to our programming language.
    Output in the parser.txt is reccursive in nature according to how our parse tree is implemented.
    
2> Lexer.txt :
    It contains all the tokens present in our source code.
    
3>a.out file

4>lex.yy.c

5>y.tab.c

6>y.tab.h

ASSUMPTIONS :

    1> Only whole numbers are allowed.
    
    2> Other tokens are : IF,ELSE,WHILE,TYPE,ID,NUM,REL_OP,RETURN.
    
    3> Only two data type are used : int and char *.
    
    4> Arithemetic operations allowed are : +,-,*,/.
    
    5> Compound Statements allowed are : IF and WHILE.
    
    6> Increament and Decreament operator are not allowed.
    
    7> Use of bitwise operators is not allowed.
    
    8> If and else Statements are valid only if they start and end with curly brackets.
    
    9> Modulo operator is not allowed.
    
    10> In case of any syntax error, syntax error is printed in parser.txt and the lexer.txt amd parser.txt will print the correct structure till error.
    
    11> Double slash(//) comments are not allowed.
    
    12> Boolean operations are not allowed in function calls.



1>cucu.l
    This is the lex file to generate lexical analyzers.
    
    It contains allowable souce code syntax for our language.
    
    All the tokens we are using in this language are defined using regex in this file.
    
    
2>cucu.y

    This is the yacc file used to generate source code parsers.
    
    It contains formal declaration for how our programming language is defined.
    

3>Sample1.cu
    It is a file containing a sample code of our programming language.
    
    It is used to chech how our lexer analyzer and parser working on a code.
    
    It is correctly coded file.


4>Sample2.cu
    It is a file containing a sample code of our programming language.
    
    It is used to chech how our lexer analyzer and parser working on a code.
    
    It is correctly coded file.

