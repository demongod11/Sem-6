#include "utility.h"

void pass2()
{
    ifstream fin;
    fin.open("intermediate.txt");

    ofstream fout;
    fout.open("object.txt");

    bool ifcomment = false;

    string LOCCTR = intToHex(0);
    string START_ADDR = intToHex(0);

    ifcomment = readIntermediateLine(&LOCCTR, &fin);

    string prevLABEL = LABEL;
    string prevOPERAND = OPERAND;

    if (OPCODE == "START")
    {
        START_ADDR = (intToHex(hexToInt(OPERAND)));
        ifcomment = readIntermediateLine(&LOCCTR, &fin);
    }

    string HEADER = "H";
    HEADER += prevLABEL;
    for (int i = 0; i < 6 - prevLABEL.length(); i++)
    {
        HEADER += " ";
    }
    HEADER += LOCCTR;
    HEADER += PROG_LEN;
    writeObjectLine(HEADER, &fout);

    string TEXT = "T";
    TEXT += LOCCTR;
    TEXT += "  ";

    string OPERAND_ADDR;
    string OBJECT_CODE;

    while (OPCODE != "END")
    {
        if (ifcomment == false)
        {
            if (OPTAB.find(OPCODE) != OPTAB.end())
            {
                if (OPERAND != "")
                {
                    if (SYMTAB.find(OPERAND) != SYMTAB.end())
                    {
                        OPERAND_ADDR = SYMTAB[OPERAND];
                        if (OPCODE == "LDCH" || OPCODE == "STCH")
                        {
                            OPERAND_ADDR = intToHex(hexToInt("008000") + hexToInt(OPERAND_ADDR));
                        }
                    }
                    else
                    {
                        OPERAND_ADDR = intToHex(0);
                        cout << "ERROR:UNDEFINED SYMBOL" << endl;
                        exit(0);
                    }
                }
                else
                {   
                    OPERAND_ADDR = intToHex(0);
                }
                OBJECT_CODE = assembleObjectCode(OPERAND_ADDR);
            }
            else if (OPCODE == "BYTE" || OPCODE == "WORD")
            {
                if (OPCODE == "WORD")
                {
                    OBJECT_CODE = intToHex(stringToInt(OPERAND));
                }
                else
                {
                    if (OPERAND[0] == 'C')
                    {
                        OBJECT_CODE = "";
                        for (int i = 2; i < OPERAND.length() - 1; i++)
                        {
                            OBJECT_CODE += intToHexLen2(OPERAND[i]);
                        }
                    }
                    else
                    {
                        OBJECT_CODE = "";
                        for (int i = 2; i < OPERAND.length() - 1; i++)
                        {
                            OBJECT_CODE += OPERAND[i];
                        }
                    }
                }
            }

            if (OBJECT_CODE.length() + TEXT.length() > TEXT_RECORD_LEN || ((OPCODE == "RESW" || OPCODE == "RESB") && TEXT.length() > 9))
            {
                string len = intToHexLen2((TEXT.length() - 9) / 2);
                TEXT[7] = len[0];
                TEXT[8] = len[1];
                writeObjectLine(TEXT, &fout);
                TEXT = "T";
                TEXT += LOCCTR;
                TEXT += "  ";
            }

            if (TEXT.length() == 9)
            {
                TEXT = "T";
                TEXT += LOCCTR;
                TEXT += "  ";
            }

            if (OPCODE != "RESW" && OPCODE != "RESB")
            {
                TEXT += OBJECT_CODE;
            }
        }
        ifcomment = readIntermediateLine(&LOCCTR, &fin);
    }

    string len = intToHexLen2((TEXT.length() - 9) / 2);
    TEXT[7] = len[0];
    TEXT[8] = len[1];
    writeObjectLine(TEXT, &fout);
    string endRecord = "E";
    endRecord += START_ADDR;
    writeObjectLine(endRecord, &fout);

    fout.close();
    fin.close();
}