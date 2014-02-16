##Run this as:

```
cd debug
./parse.sh example4
cat example.html | ./example4 > example4.output
```

##If ye want harder

On the debug folder

```
bison -d example4.y
flex example4.l
g++ example4.tab.c lex.yy.c -lfl -o <output_file>
cat example4.html 
cat example4.html | ./<output_file>
```

##Team

@nootanghimire
WebBrowser Team
w/ @Nishan13 and @shashikhanal

