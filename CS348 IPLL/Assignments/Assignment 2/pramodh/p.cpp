#include "utility.h"
#include "utility.c"
#include "pass1.c"
#include "pass2.c"

void Optab() {
    for(int i=0; i<opcode.size(); i++){
        OPTAB[opcode[i]]=opvalue[i];
    }
    ofstream optab("optab.txt");
    for(auto i=OPTAB.begin(); i!=OPTAB.end(); i++){
        optab << i->first << "     " << i->second << endl;
    }
    optab.close();
}

bool readInputLine(ifstream *fin)
{
    string line;
    getline(*fin, line);
    LABEL = "";
    OPCODE = "";
    OPERAND = "";
    int pointer = 0;

    if (line[0] == '.')
    {
        LABEL = line;
        return true;
    }

    if (line[0] != ' ')
    {
        for (pointer = 0; pointer < line.length(); pointer++)
        {
            if (line[pointer] == ' ')
            {
                break;
            }
            else
            {
                LABEL += line[pointer];
            }
        }
    }

    while (line[pointer] == ' ')
    {
        pointer++;
    }

    for (; pointer < line.length(); pointer++)
    {
        if (line[pointer] == ' ')
        {
            break;
        }
        else
        {
            OPCODE += line[pointer];
        }
    }

    while (line[pointer] == ' ')
    {
        pointer++;
    }

    for (; pointer < line.length(); pointer++)
    {
        if (line[pointer] == ' ')
        {
            break;
        }
        else
        {
            OPERAND += line[pointer];
        }
    }

    return false;
}

bool readIntermediateLine(string *LOCCTR, ifstream *fin)
{
    string line;
    getline(*fin, line);

    *LOCCTR = "";
    LABEL = "";
    OPCODE = "";
    OPERAND = "";
    int pointer = 0;

    if (line[0] == '.')
    {
        LABEL = line;
        return true;
    }

    if (line[0] != ' ')
    {
        for (pointer = 0; pointer < line.length(); pointer++)
        {
            if (line[pointer] == ' ')
            {
                break;
            }
            else
            {
                *LOCCTR += line[pointer];
            }
        }
    }
    else
    {
        pointer += 4;
    }

    *LOCCTR = intToHex(hexToInt(*LOCCTR));

    pointer += 2;

    for (; pointer < line.length(); pointer++)
    {
        if (line[pointer] == ' ')
        {
            break;
        }
        else
        {
            LABEL += line[pointer];
        }
    }

    pointer += (15 - (LABEL.length()));

    for (; pointer < line.length(); pointer++)
    {
        if (line[pointer] == ' ')
        {
            break;
        }
        else
        {
            OPCODE += line[pointer];
        }
    }

    pointer += (8 - (OPCODE.length()));

    for (; pointer < line.length(); pointer++)
    {
        if (line[pointer] == ' ' || line[pointer] == ',')
        {
            break;
        }
        else
        {
            OPERAND += line[pointer];
        }
    }

    return false;
}

void writeIntermediateLine(string LOCCTR, ofstream *fout)
{
    if (OPCODE != "")
    {
        if (LOCCTR != "")
        {
            *fout << LOCCTR.substr(2) << "  " << LABEL;
            for (int i = 0; i < 15 - LABEL.length(); i++)
            {
                *fout << " ";
            }
            *fout << OPCODE;
            for (int i = 0; i < 8 - OPCODE.length(); i++)
            {
                *fout << " ";
            }
            *fout << OPERAND << endl;
        }
        else
        {
            *fout << "      " << LABEL;
            for (int i = 0; i < 15 - LABEL.length(); i++)
            {
                *fout << " ";
            }
            *fout << OPCODE;
            for (int i = 0; i < 8 - OPCODE.length(); i++)
            {
                *fout << " ";
            }
            *fout << OPERAND << endl;
        }
    }
    else
    {
        *fout << LOCCTR << endl;
    }
}

void writeObjectLine(string line, ofstream *fout)
{
    *fout << line << endl;
}

void incrLOCCTR(string *LOCCTR)
{
    if (OPTAB.find(OPCODE) != OPTAB.end())
    {
        *LOCCTR = intToHex(3 + hexToInt(*LOCCTR));
    }
    else if (OPCODE == "WORD")
    {
        *LOCCTR = intToHex(3 + hexToInt(*LOCCTR));
    }
    else if (OPCODE == "RESW")
    {
        *LOCCTR = intToHex((3 * stringToInt(OPERAND)) + hexToInt(*LOCCTR));
    }
    else if (OPCODE == "RESB")
    {
        *LOCCTR = intToHex(stringToInt(OPERAND) + hexToInt(*LOCCTR));
    }
    else if (OPCODE == "BYTE")
    {
        *LOCCTR = intToHex(bytelength(OPERAND) + hexToInt(*LOCCTR));
    }
    else
    {
        cout << "ERROR:INVALID OPCODE" << endl;
        exit(0);
    }
}

string assembleObjectCode(string OPERAND_ADDR)
{
    string ObjectCode = OPTAB.at(OPCODE);
    ObjectCode += OPERAND_ADDR.substr(2);
    return ObjectCode;
}


int main()
{
    Optab();
    pass1();
    pass2();
    return 0;
}