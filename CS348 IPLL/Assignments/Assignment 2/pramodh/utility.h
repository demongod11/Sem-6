#ifndef utility
#define utility

#include<bits/stdc++.h>
using namespace std;

string PROG_LEN;

const int TEXT_RECORD_LEN = 69;

vector<string> opcode{"ADD","AND","COMP","DIV","J","JEQ","JGT","JLT","JSUB","LDA","LDCH","LDL","LDX",
"MUL","OR","RD","RSUB","STA","STCH","STL","STSW","STX","SUB","TD","TIX","WD"};

vector<string> opvalue{"18","40","28","24","3C","30","34","38","48","00","50","08","04","20","44","D8","4C",
"0C","54","14","E8","10","1C","E0","2C","DC"};

unordered_map<string, string> OPTAB;
unordered_map<string, string> SYMTAB;

string LABEL;
string OPCODE;
string OPERAND;

bool readInputLine(ifstream *fin);
bool readIntermediateLine(string *LOCCTR, ifstream *fin);
void writeIntermediateLine(string LOCCTR, ofstream *fout);
void writeObjectLine(string line, ofstream *fout);
void incrLOCCTR(string *LOCCTR);
string assembleObjectCode(string OPERAND_ADDR);

#endif