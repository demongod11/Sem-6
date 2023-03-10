#include <bits/stdc++.h>

using namespace std;

char intToHexSingleDigit(int n){
    char c;
    if (n <= 9){
        c = '0' + n;
    }else{
        c = 'A' + (n - 10);
    }
    return c;
}

int hexToIntSingleChar(char c){
    int n;
    if ((c <= '9') && (c >= '0'))
    {
        n = c - '0';
    }
    else
    {
        n = c - 'A' + 10;
    }
    return n;
}

string intToHex(int n){
    string s = "";
    while (n != 0)
    {
        s = intToHexSingleDigit(n % 16) + s;
        n = n / 16;
    }
    while (s.length() < 6)
    {
        s = '0' + s;
    }
    return s;
}

string intToHexLen2(int n){
    string s = "";
    while (n != 0)
    {
        s = intToHexSingleDigit(n % 16) + s;
        n = n / 16;
    }
    while (s.length() < 2)
    {
        s = '0' + s;
    }
    return s;
}

int hexToInt(string s)
{
    reverse(s.begin(), s.end());
    int j = 1;
    int ans = 0;
    for (int i = 0; i < s.length(); i++)
    {
        ans += (hexToIntSingleChar(s[i]) * j);
        j = j * 16;
    }
    return ans;
}

int stringToInt(string s)
{
    reverse(s.begin(), s.end());
    int j = 1;
    int ans = 0;
    for (int i = 0; i < s.length(); i++)
    {
        ans += ((s[i] - '0') * j);
        j = j * 10;
    }
    return ans;
}

int bytelength(string s)
{
    int len = 0;
    if (s[0] == 'X')
    {
        len = (s.length() - 3) / 2;
    }
    else if (s[0] == 'C')
    {
        len = s.length() - 3;
    }
    return len;
}