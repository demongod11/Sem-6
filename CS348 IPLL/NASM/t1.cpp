#include <bits/stdc++.h>

using namespace std;

int main(){
    cout << "Enter the size of the array" << endl;
    int n;
    cin>>n;
    cout << "Enter the values of the array" << endl;
    int arr[n];
    for(int i=0; i<n; i++){
        cin>>arr[i];
    }
    int max=INT_MIN;
    int min=INT_MAX;
    int max_index=-1;
    int min_index=-1;
    for(int i=0; i<n; i++){
        if(arr[i]>max){
            max=arr[i];
            max_index=i;
        }
        if(arr[i]<min){
            min=arr[i];
            min_index=i;
        }
    }

    cout << "Maximum and minimum elements are " << max << " and " << min <<end;
    cout << "Also they occur at positions " << max_index << " and " << min_index << " respectively";
}