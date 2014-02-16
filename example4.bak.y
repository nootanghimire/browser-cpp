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
    char html[100][100];
    char text[100][100];
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
    
    h.displayAll();
    return 0;
}

main()
{
    yyparse();
    yywrap();
}

%}

%token NUMBER LANGLE CLOSERANGLE RANGLE LANGLE_SLASH ANYTHING

/*%union
{
    int intVal;
    float floatVal;
    char *strVal;
    string *str;
}*/

{
#define YYSTYPE std::string
%}

%%

tag:    |   
        contents opening_tag contents closing_tag 
        {
          if($<str>2.substr(1) == $<str>4.substr(2)){
                //cout<<"\n[i] Tag Matches: "<<$<strVal>2;
                //cout <<"\n[!] The text: "<<$<strVal>3;
                h.storeHtml($<str>2, $<str>2);
                //Maybe concatenate
                //h.displayAll();
            } else {
                cout<<"\n[!] Tag Mismatch: "<<$<str>2<<" and "<<$<str>4<<endl;
            }
            $<str>$ = $<str>2 + $<str>3  + $<str>4; 
            //strcat($<strVal>$, $<strVal>3);
            //strcat($<strVal>$, $<strVal>4);

        }
        ;
contents:tag
        |anything
        ;
opening_tag:
        LANGLE ANYTHING RANGLE
        {
            //$<strVal>$ = $<strVal>2;
            $<str>$ = $<strVal>1 + $<strVal>2 + $<strVal>3; 
            //strcat($<strVal>$, $<strVal>3);
        }
        ;
anything:
        ANYTHING
        {
            $<str>$ = $<strVal>1;

        }
        ;
closing_tag:
        LANGLE_SLASH ANYTHING RANGLE
        {
            //$<strVal>$ = $<strVal>2;
            $<str>$ = $<strVal>1 + $<strVal>2 + $<strVal>3; 
            //strcat($<strVal>$, $<strVal>2);
            //strcat($<strVal>$, $<strVal>3);
        }        
%%