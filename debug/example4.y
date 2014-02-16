/******************************************************************************
 * @author      Nootan Ghimire <nootan.ghimire@gmail.com>
 * @project     Web Browser in C++ using Bison/Flex 
 *
 * @team        Nootan Ghimire - Nishan Bajracharya - Shashi Khanal
 *
 * @desc        This is a parser file which parses things and does real action
 *
 ******************************************************************************
 */


%{
#define YYSTYPE std::string
#include <iostream>
#include <cstring>
#include <string>
using namespace std;

extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;

void yyerror(const char *str)
{
    cout<<"Error: "<<str<<"\n";
}

class htmlobj{
private:
    string html[100];
    string text[100];
    int size;
public:
    htmlobj():size(0){}
    void storeHtml(string html_code, string text_code){
        html[size] = html_code;
        text[size] = text_code;
        size++;

    }

   /* void addContentToCurrent(char* content){
            strcat(text[size-1], content);
    }*/
    void displayAll(){
        for(int i=0;i<size;i++){
            cout<<"[i] Tag: "<<html[i]<<endl;
            cout<<"[i] Text: "<<text[i]<<endl<<endl;
        }
    }
};
htmlobj h;
int yywrap()
{
    
    //h.displayAll();
    return 0;
}

main()
{
    yyparse();
    yywrap();
}

%}

%token LANGLE CLOSERANGLE RANGLE LANGLE_SLASH ANYTHING

/*%union
{
    int intVal;
    float floatVal;
    char *strVal;
    string *str;
}*/

%%

tag:    |   
        contents opening_tag contents closing_tag 
        {
            //cout<<$2.substr(1)<<endl;
            //cout<<$4.substr(2)<<endl;
          if($2.substr(1) == $4.substr(2)){
                cout<<"\n[i] Tag Matches: "<<$2;
                cout <<"\n[!] The text: "<<$3;
                cout <<"\n[!] The $1 here: "<<$1;
                cout<<"\n";
                h.storeHtml($2, $3);
                //Maybe concatenate
                //h.displayAll();
            } else {
                cout<<"\n[!] Tag Mismatch: "<<$2<<" and "<<$4<<endl;
            }
            $$ = $1 + $2 + $3 + $4;
            //strcat($$, $3);
            //strcat($$, $4);

        }
        ;
contents:tag
        |anything
        ;
opening_tag:
        LANGLE ANYTHING RANGLE
        {
            //$$ = $2;
            $$ = "<" + $2 + ">"; 
            //strcat($$, $3);
        }
        ;
anything:
        ANYTHING
        {
                $$ = $1;
        }
        ;
closing_tag:
        LANGLE_SLASH ANYTHING RANGLE
        {
            //$$ = $2;
            $$ = "</" + $2 + ">"; 
            //strcat($$, $2);
            //strcat($$, $3);
        }        
%%