#include "hex.cpp"
#include "pass_one.cpp"
#include "pass_two.cpp"

using namespace std;

void GenerateOptab() {
    for(int i=0; i<op.size(); i++){
        OPTAB[op[i]]=opc[i];
    }
    ofstream optab("optab.txt");
    for(auto i=OPTAB.begin(); i!=OPTAB.end(); i++){
        string tmp = i->first;
        appendEnd(tmp, 5, ' ');
        if(i == OPTAB.begin()){
            optab << tmp << "     " << i->second;
        }else{
            optab << "\n" << tmp << "     " << i->second;
        }
    }
    optab.close();
}

vector<string> splitLine(int index, string& data) {
    int counter = 0;
    vector<string> res(3, "");
    if(data[0] == '.') {
        res[0] = ".";
        return res;
    }
    for(int i = index; i < data.size(); i++) {
        if(data[i] != ' ') {
            res[counter]+=(data[i]);
        }else {
            while(data[i] == ' '){
                i++;
                if(i == data.size()){
                    break;
                }
            }
            counter++;
            i--;
        }
    }
    return res;
}

string constObjCode(string operand) {
    string res = "";
    if((operand[0] == 'C' || operand[0] == 'c') && operand[1] == '\'') {
        for(int i = 2; i < operand.size(); i++) {
            if(operand[i] == '\'') {
                break;
            }
            res += intToHex(int(operand[i]));
        }
        return res;
    }
    if((operand[0] == 'X' || operand[0] == 'x') && operand[1] == '\'') {
        for(int i = 2; i < operand.size(); i++) {
            if(operand[i] == '\'') {
                break;
            }
            res += operand[i];
        }
        return res;
    }
    res = intToHex(convertToInt(operand));
    appendStart(res, 6, '0');
    return res;
}

int byteOperandLength(string& s) {
    int ans = 0;
    if((s[0] == 'x' || s[0] == 'X') && s[1] == '\'') {
        for(int i = 2; i < s.size(); i+=2) {
            if(s[i] == '\'') {
                break;
            }else{
                ans+=1;
            }
        }
    }else if((s[0] == 'c' || s[0] == 'C') && s[1] == '\'') {
        for(int i = 2; i < s.size(); i++) {
            if(s[i] == '\'') {
                break;
            }else{
                ans+=1;
            }
        }
    }
    return ans;
}

int main() {
    GenerateOptab();
    pass1();
    pass2();
}