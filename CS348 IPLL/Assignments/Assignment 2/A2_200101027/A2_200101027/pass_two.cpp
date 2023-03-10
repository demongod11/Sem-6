#include "top.h"

void pass2() {
    cout << "Started Pass 2" << endl;

    ifstream intermediate("intermediate.txt");
    ofstream final("final.txt");
    ofstream outputObj("output.o");
    ofstream readableFile("readable_output.txt");

    string data, textRecord = "", startLoc = "";
    string readableHeader = " ^     ^ ", readableLine = readableHeader;
  
    while(getline(intermediate, data)) {  
        if(data[0] == '.') {
            final << data << endl;
            continue;
        }
        string objectCode = "";
        string label, opcode, operand, locCounter;
        locCounter = data.substr(0, 4);
        vector<string> ans = splitLine(7, data);
        label = ans[0];
        opcode = ans[1];
        operand = ans[2];
        
        if(opcode == "START") {
            final << data << endl;
            appendEnd(label, 6, ' ');
            appendStart(operand, 6, '0');
            string length = intToHex(programLength);
            appendStart(length, 6, '0');
            outputObj << "H" << label << operand << length << endl;
            readableFile << "H" << label << operand << length << endl;
            readableFile << " ^     ^     ^" << endl;
            startLoc = operand;
            continue;
        }

        if(opcode == "END") {
            final << data << endl;
            if(textRecord.size()) {
                appendStart(startLoc, 6, '0');
                string hexSize = intToHex(textRecord.size() / 2);
                appendStart(hexSize, 2, '0');
                textRecord = "T" + startLoc + hexSize + textRecord;
                outputObj << textRecord << endl;
                readableFile << textRecord << endl;
                readableFile << readableLine << endl;
            }
            string end = intToHex(startAdd);
            appendStart(end, 6, '0');
            textRecord = "E" + end;
            outputObj << textRecord << endl;
            readableFile << textRecord << endl;
            readableFile << " ^" << endl;
            break;
        }

        if(OPTAB.find(opcode) != OPTAB.end()) {
            if(SYMTAB.find(operand) != SYMTAB.end()) {
                objectCode = OPTAB[opcode] + intToHex(SYMTAB[operand]);
            }else if((operand[operand.size()-1] == 'X') && (operand[operand.size()-2] == ',')) {
                operand.pop_back();
                operand.pop_back();
                objectCode = OPTAB[opcode] + intToHex(SYMTAB[operand] + hexToInt("8000"));
            }else{
                objectCode = OPTAB[opcode];
                appendEnd(objectCode, 6, '0');
            }
        }else if(opcode == "BYTE" || opcode == "WORD") {
            objectCode = constObjCode(operand);
        }

        appendEnd(data, 35, ' ');
        data += objectCode;
        final << data << endl;
        if(startLoc == "" && objectCode != "") {
            startLoc = locCounter;
        }

        if((objectCode.size() == 0) || (textRecord.size() + objectCode.size() > 60)) {
            if(textRecord.size() == 0) continue;
            appendStart(startLoc, 6, '0');
            string hexSize = intToHex(textRecord.size() / 2);
            appendStart(hexSize, 2, '0');
            textRecord = "T" + startLoc + hexSize + textRecord;
            outputObj << textRecord << endl;
            readableFile << textRecord << endl;
            readableFile << readableLine << endl;
            textRecord = objectCode;
            readableLine = readableHeader;
            startLoc = "";
            if(objectCode.size() != 0) {
                startLoc = locCounter;
                readableLine = readableHeader;
                readableLine.push_back('^');
                appendEnd(readableLine, readableLine.size() + objectCode.size() - 1, ' ');
            }
        }else if(objectCode.size()) {
            textRecord += objectCode;
            readableLine.push_back('^');
            appendEnd(readableLine, readableLine.size() + objectCode.size() - 1, ' ');
        }
    }

    intermediate.close();
    final.close();
    outputObj.close();
    readableFile.close();
    cout << "Completed Pass 2" << endl;
}