#include <stdio.h>

int main(void){
    printf("Enter the size of the array");
    int n;
    scanf("%d", &n);
    printf("Enter the values of the array");
    int arr[n];
    for(int i=0; i<n; i++){
        scanf("%d", &arr[i]);
    }
    int max=-2147483647;
    int min=2147483647;
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

    printf("Maximum and minimum elements are %d and %d\n", max, min);
    printf("Also they occur at positions %d and %d respectively", max_index, min_index);

    return 0;
}