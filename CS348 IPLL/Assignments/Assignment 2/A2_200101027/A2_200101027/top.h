#ifndef assembler
#define assembler

#include<bits/stdc++.h>
using namespace std;

int LOCCTR = 0, programLength = 0, startAdd = 0;
map<string, int> SYMTAB; 
map<string, string> OPTAB; 

vector<string> op{"ADD","AND","COMP","DIV","J","JEQ","JGT","JLT","JSUB","LDA","LDCH","LDL","LDX",
"MUL","OR","RD","RSUB","STA","STCH","STL","STSW","STX","SUB","TD","TIX","WD"};

vector<string> opc{"18","40","28","24","3C","30","34","38","48","00","50","08","04","20","44","D8","4C",
"0C","54","14","E8","10","1C","E0","2C","DC"};

vector<string> splitLine(int index, string& data);
string constObjCode(string operand);
int byteOperandLength(string& s);

#endif