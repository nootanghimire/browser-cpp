/******************************************************************************
 * @author      Nootan Ghimire <nootan.ghimire@gmail.com>
 * @project     Web Browser in C++ using Bison/Flex 
 *
 * @team        Nootan Ghimire - Nishan Bajracharya - Shashi Khanal
 *
 * @desc        This is a lexer file which defines tokens.
 *
 ******************************************************************************
 */

/* The first section: Includes
 * Here we include required things
 */ 
%{
#define YYSTYPE std::string
#include <iostream>
#include <cstring>
#include <string>
/* ^^ For Win-doge users. :P */
using namespace std;
#define YY_DECL extern "C" int yylex()
#include "example4.tab.h" 
%}
/* While compiling yacc. do bison -d example4.y so it generates example4.tab.h */

/* Here's where we define things. i.e., rules*/

%%
[<]                     return LANGLE;
"/>"				    return CLOSERANGLE;
[>]						return RANGLE;
"</"					return LANGLE_SLASH;
[]|[a-zA-Z0-9]*			yylval=strdup(yytext); return ANYTHING;
\n                      /* ignore end of line */;
[ \t]+                  /* ignore whitespace */;
"<!--".*"-->"           /* ignore html comment */

%%