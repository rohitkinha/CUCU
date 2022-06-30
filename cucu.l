%{
    #include<stdio.h>
    #include <string.h>
    #define YYSTYPE char*
    #include "y.tab.h"
%}

%%
([ ]+)                  {}
(\/\*(.|\n)*\*\/)       {}
(if)                    {yylval=strdup(yytext);fprintf(yyout,"IF_STATEMENT\n");return IF;}
(else)                  {yylval=strdup(yytext);fprintf(yyout,"ELSE_STATEMENT\n");return ELSE;}
(while)                 {yylval=strdup(yytext);fprintf(yyout,"WHILE_STATEMENT\n");return WHILE;}

(int)                   {yylval=strdup(yytext);fprintf(yyout,"TYPE : %s\n",yytext);return TYPE;}
(char)                  {yylval=strdup(yytext);fprintf(yyout,"TYPE : %s\n",yytext);return TYPE;}
(char[ \t]*\*)          {yylval=strdup(yytext);fprintf(yyout,"TYPE %s\n",yytext);return TYPE;}
(return)                {yylval=strdup(yytext);fprintf(yyout,"TYPE : %s\n",yytext);return RETURN;}

([A-Za-z][A-Za-z0-9_]*) {yylval=strdup(yytext);fprintf(yyout,"ID : %s\n",yytext);return ID;}
([0-9]*)                {yylval=strdup(yytext);fprintf(yyout,"NUM : %s\n",yytext);return NUM;}


([<>!=]=|<|>)           {yylval=strdup(yytext);fprintf(yyout,"RELATIONAL_OPERATOR : %s\n",yytext); return REL_OP;}

([\+])                  {yylval=strdup(yytext);fprintf(yyout,"ADDITION_OPERATOR : +\n");return yytext[0];}
([\-])                  {yylval=strdup(yytext);fprintf(yyout,"SUBTRACTION_OPERATOR : -\n");return yytext[0];}
([\*])                  {yylval=strdup(yytext);fprintf(yyout,"PRODUCT_OPERAATOR : *\n");return yytext[0];}
([\/])                  {yylval=strdup(yytext);fprintf(yyout,"DIVISION_OPERATOR : /\n");return yytext[0];}
(=)                     {yylval=strdup(yytext);fprintf(yyout,"ASSIGNMENT_OPERATOR : =\n");return yytext[0];}
(,)                     {yylval=strdup(yytext);fprintf(yyout,"COMMA_OPERATOR : =\n");return yytext[0];}

(;)                     {yylval=strdup(yytext);fprintf(yyout,"SEMICOLON : ;\n");return yytext[0];}
(\()                    {yylval=strdup(yytext);fprintf(yyout,"LEFT_PARENTHESES : (\n");return yytext[0];}
(\))                    {yylval=strdup(yytext);fprintf(yyout,"RIGHT_PARENTHESES : )\n");return yytext[0];}
(\{)                    {yylval=strdup(yytext);fprintf(yyout,"LEFT_CURLY_BRACKET : {\n");return yytext[0];}
(\})                    {yylval=strdup(yytext);fprintf(yyout,"RIGHT_CURLY_BRACKET : }\n");return yytext[0];}
(\[)                    {yylval=strdup(yytext);fprintf(yyout,"LEFT_SQUARE_BRACKET :  [\n");return yytext[0];}
(\])                    {yylval=strdup(yytext);fprintf(yyout,"RIGHT_SQUARE_BRACKET : ]\n");return yytext[0];}

%%