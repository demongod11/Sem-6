#include "top.h"

void pass1() {
    cout << "Started Pass 1" << endl;
    ifstream input("input.txt");
    ofstream intermediate("intermediate.txt");
    ofstream symtab("symtab.txt");
    string data;

    while(getline(input, data)) {
        string label, opcode, operand;
        vector<string> ans = splitLine(0, data);
        label = ans[0];
        opcode = ans[1];
        operand = ans[2];

        if(label == ".") {
            intermediate << data << endl;
            continue;
        }

        if(opcode == "START") {
            LOCCTR = hexToInt(operand);
            programLength = LOCCTR;
            startAdd = LOCCTR;
            appendEnd(operand, 7, ' ');
            operand += data;
            intermediate << operand << endl;
            if(label != "") {
                SYMTAB[label] = LOCCTR;
            }
            continue;
        }

        if(opcode == "END") {
            intermediate << "       " << data << endl;
            break;
        }

        if(label != "") {
            if(SYMTAB.find(label) != SYMTAB.end()) {
                cout << "Dupicate Label!!!" << endl;
                cout << label << endl;
                break;
            } else {
                SYMTAB[label] = LOCCTR;
            }
        }

        string res = intToHex(LOCCTR);
        appendEnd(res, 7, ' ');
        res += data;
        intermediate << res << endl;

        if(OPTAB.find(opcode) != OPTAB.end()) {
            LOCCTR += 3;
        } else if(opcode == "WORD") {
            LOCCTR += 3;
        } else if(opcode == "RESW") {
            LOCCTR += (3 * convertToInt(operand));
        } else if(opcode == "RESB") {
            LOCCTR += convertToInt(operand);
        } else if(opcode == "BYTE") {
            LOCCTR += byteOperandLength(operand);
        } else {
            cout << "Wrong Value of OPCODE!!!" << endl;
            break;
        }
    }

    programLength = LOCCTR - programLength;

    for(auto i=SYMTAB.begin(); i!=SYMTAB.end(); i++){
        string tmp = i->first;
        appendEnd(tmp, 10, ' ');
        if(i == SYMTAB.begin()){
            symtab << tmp << "     " << intToHex(i->second);
        }else{
            symtab << "\n" << tmp << "     " << intToHex(i->second);          
        }
    }

    input.close();
    intermediate.close();
    symtab.close();
    cout << "Completed Pass 1" << endl;
}