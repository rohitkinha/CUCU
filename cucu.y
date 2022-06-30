%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#define YYSTYPE char*
	extern int yylex();
	extern FILE* yyin;
	extern FILE* yyout;
	extern void yyerror(char* msg);
%}

%token ID NUM TYPE IF WHILE RETURN ELSE REL_OP

%%
	PROGRAM:  		 VAR_DEC
	|                VAR_DEC_INI
	|                VAR_INI
	|				 FUN_DEC 
	|				 FUN_DEF
	|				 PROGRAM VAR_DEC
	|				 PROGRAM FUN_DEC
	|				 PROGRAM FUN_DEF
	|                PROGRAM  VAR_INI
	|                PROGRAM  VAR_DEC_INI
	;

	VAR_DEC :        TYPE ID ';'                                  {fprintf(stdout,"\nVARIABLE DECLARATION -> \t\t\t\t\t\t Data Type : %s | Variable : %s \n",$1,$2);}
	;
    VAR_DEC_INI :    TYPE ID '=' ASSI_STMT ';'                    {fprintf(stdout,"\nVARIABLE DECLARATION AND INITIALISATION -> \t\t Data Type : %s | Variable : %s | Operator : %s | ASSIGNED TO -- \n",$1,$2,$3);}
	;
	VAR_INI :        ID '=' ASSI_STMT ';'                         {fprintf(stdout,"\nVARIABLE INITIALISATION -> \t\t\t\t\t\t Variable : %s | Operator : %s | ASSIGNED TO -- \n",$1,$2);}
	;

	FUN_DEC :        TYPE ID '(' VAR_PASSED ')' ';'               {fprintf(stdout,"\nFUNCTION DECLARATION -> \t\t\t\t\t\t Function Type : %s | Function Name : %s | ARGUMENTS PASSED --   \n",$1,$2);}
	|                TYPE ID '(' ')' ';'                          {fprintf(stdout,"\nFUNCTION DECLARATION -> \t\t\t\t\t\t Function Type : %s | Function Name : %s | NO ARGUMENTS PASSED   \n",$1,$2);}
	;
	VAR_PASSED :     TYPE ID                                      {fprintf(stdout,"\tArguments Passed =  %s %s \n",$1,$2);}
	|                VAR_PASSED ',' TYPE ID                       {fprintf(stdout,"\tArguments Passed =  %s %s \n",$3,$4);}
	;
	FUN_DEF :        TYPE ID '(' VAR_PASSED ')' '{' '}'           {fprintf(stdout,"\nFUNCTION DEFINITION ->  \t\t\t\t\t\t Function Type : %s | Function Name : %s | ARGUMENTS PASSED -- | FUNCTION BODY IS EMPTY  \n",$1,$2);}
	|		         TYPE ID '(' VAR_PASSED ')' '{' STMT_BODY '}' {fprintf(stdout,"\nFUNCTION DEFINITION->   \t\t\t\t\t\t Function Type : %s | Function Name : %s | ARGUMENTS PASSED -- | FUNCTION BODY --  \n",$1,$2);}
	;

	STMT_BODY: 		STMT_PASSED                                   
	|				STMT_BODY STMT_PASSED            			  
	;

	STMT_PASSED:     VAR_DEC                                      
	|                VAR_INI
	|                VAR_DEC_INI
	|      			 FUN_CALL
	|                RETURN RET_STMT 
	|                IF_STMT
	|                WHILE_STMT
	;
	FUN_CALL:		 ID '(' ')' ';'                               {fprintf(stdout,"FUNCTION CALL WITH NO VARIABLE PASSED : %s \n",$1);}
	|				 ID '(' VARIABLES ')' ';'					  {fprintf(stdout,"FUNCTION CALL : %s | VARIABLE PASSED --  \n",$1);}
	;

	ASSI_STMT :      TERM
	|                ASSI_STMT '+' TERM                           {fprintf(stdout,"\t\tOperator In Use : %s\n",$2);}
	|                ASSI_STMT '-' TERM                           {fprintf(stdout,"\t\tOperator In Use : %s\n",$2);}
	;
	TERM :           FACTOR
	|                TERM '*' FACTOR                              {fprintf(stdout,"\t\tOperator In Use : %s\n",$2);}
	|                TERM '/' FACTOR                              {fprintf(stdout,"\t\tOperator In Use : %s\n",$2);}
	;
	FACTOR :         ID                                           {fprintf(stdout,"\t\tIdetifier : %s\n",$1);}
	|                NUM                                          {fprintf(stdout,"\t\tNumber : %s\n",$1);}
	|                '(' ASSI_STMT ')'
	;
	VARIABLES :      ID                                           {fprintf(stdout,"\tVariable passed : %s\n",$1);}
	|				 NUM                                          {fprintf(stdout,"\tNumber passed : %s\n",$1);}
	|				 VARIABLES ',' NUM                            {fprintf(stdout,"\tNumber passed : %s\n",$1);}
	|                VARIABLES ',' ID                             {fprintf(stdout,"\tVariable passed : %s\n",$1);}
	;
	RET_STMT :       FUN_CALL                                     {fprintf(stdout,"RETURN STATEMENT WITH FUNCTION -- \n");}
	|                ID ';'                                       {fprintf(stdout,"RETURN STATEMENT WITH A VARIABLE -- \n");}
	|                NUM ';'                                      {fprintf(stdout,"RETURN STATEMENT WITH A NUMBER-- \n");}
	|                ';'                                          {fprintf(stdout,"EMPTY RETURN STATEMENT \n");}
	;
	IF_STMT :        IF '(' CONDITION_STMT ')' '{' STMT_BODY '}'  ELSE '{' STMT_BODY '}'  {fprintf(stdout,"IF-ELSE STATEMENT -- \n");}
	|                IF '(' CONDITION_STMT ')' '{' STMT_BODY '}'                          {fprintf(stdout,"IF STATEMENT -- \n");}
	CONDITION_STMT : ASSI_STMT REL_OP ASSI_STMT                                           {fprintf(stdout,"RELATIONAL OPERATOR : %s\n",$2);}
	;
	WHILE_STMT :     WHILE '(' CONDITION_STMT ')' '{' STMT_BODY '}'                       {fprintf(stdout,"WHILE STATEMENT \n");}
	;
	                
%%
int main(int argc, char** argv){
	if(argc < 2){
		printf("Incorrect Format\n");
		return 1;
	}
	yyin = fopen(argv[1], "r");
	yyout = fopen("Lexer.txt", "w");
	stdout = fopen("Parser.txt", "w");
	yyparse();
}

void yyerror(char* msg){
	printf("%s\n", msg);
}
