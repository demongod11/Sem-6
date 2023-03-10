#include <bits/stdc++.h>
using namespace std;

int hexToInt(string operand) {
    int res = 0, power = 1;
    for(int i = operand.size() - 1; i >= 0; i--) {
        if(operand[i] >= '0' && operand[i] <= '9') {
            res += (power * (operand[i] - '0'));
        }else {
            res += (power * (operand[i] - 'A' + 10));
        }
        power *= 16;
    }
    return res;
}

string intToHex(int n) {
    string res = "";
    while(n) {
        int rem = n % 16;
        if(rem < 10) {
            res+=(rem + '0');
        }else {
            res+=(char(rem + 'A' - 10));
        }
        n /= 16;
    }
    reverse(res.begin(), res.end());
    return res;
}

int convertToInt(string& s) {
    int res = 0, power = 1;
    for(int i = s.size() - 1; i >= 0; --i) {
        res += (power * (s[i] - '0'));
        power *= 10;
    }
    return res;
}

void appendStart(string& s, int size, char waste) {
    reverse(s.begin(), s.end());
    while(s.size() < size){
        s.push_back(waste);
    }
    reverse(s.begin(), s.end());
    return;
}

void appendEnd(string& s, int size, char waste) {
    while(s.size() < size) {
        s.push_back(waste);
    }
    return;
}