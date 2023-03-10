#include "utility.h"

void pass1()
{
    ifstream fin;
    fin.open("input.txt");

    ofstream fout;
    fout.open("intermediate.txt");

    ofstream symtab("symtab.txt");

    bool ifcomment = false;
    string LOCCTR;
    string START_ADDR;
    ifcomment = readInputLine(&fin);

    if (OPCODE == "START")
    {
        START_ADDR = (intToHex(hexToInt(OPERAND)));
        LOCCTR = (intToHex(hexToInt(OPERAND)));
        writeIntermediateLine(LOCCTR, &fout);
        ifcomment = readInputLine(&fin);
    }
    else
    {
        LOCCTR = intToHex(0);
        START_ADDR = intToHex(0);
    }

    while (OPCODE != "END")
    {
        if (ifcomment == false)
        {
            if (LABEL != "")
            {
                if (SYMTAB.find(LABEL) != SYMTAB.end())
                {
                    cout << "ERROR:DUPLICATE SYMBOL" << endl;
                    exit(0);
                }
                else
                {
                    SYMTAB[LABEL] = LOCCTR;
                }
            }
            writeIntermediateLine(LOCCTR, &fout);
            incrLOCCTR(&LOCCTR);
        }
        else
        {
            string comment = LABEL;
            LABEL = "";
            writeIntermediateLine(comment, &fout);
        }
        ifcomment = readInputLine(&fin);
    }

    writeIntermediateLine("", &fout);
    PROG_LEN = intToHex(hexToInt(LOCCTR) - hexToInt(START_ADDR));

    for(auto i=SYMTAB.begin(); i!=SYMTAB.end(); i++){
        symtab << i->first << "     " << (i->second).substr(2,4) << endl; 
    }

    symtab.close();
    fout.close();
    fin.close();
}
