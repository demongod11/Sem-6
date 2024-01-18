#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <string.h>

double kmeans(double** data, double** centroids, int m, double a, int no_iter, int rows, int cols){
    double min_dist,dist;
    int* labels = (int*)malloc(rows*sizeof(int));
    int* counts = (int*)malloc(m*sizeof(int));
    double d_old=0, d_new=0;

    for (int i = 0; i < rows; i++) {
        min_dist = INFINITY;
        for (int j = 0; j < m; j++) {
            dist=0;
            for(int k=0; k<cols; k++){
                dist=dist+(data[i][k]-centroids[j][k])*(data[i][k]-centroids[j][k]);
            }
            if (dist < min_dist){
                min_dist = dist;
                labels[i] = j;
            }
        }
        d_old+=min_dist;
    }

    for (int iter = 0; iter < no_iter; iter++) {
        for (int j = 0; j < m; j++) {
            counts[j] = 0;
            for(int i=0; i<cols; i++){
                centroids[j][i]=0;
            }
            for (int i = 0; i < rows; i++) {
                if (labels[i] == j) {
                    for(int k=0; k<cols; k++){
                        centroids[j][k]+=(data[i][k]);
                    }
                    counts[j]++;
                }
            }
            if (counts[j] > 0) {
                for(int k=0; k<cols; k++){
                    centroids[j][k] = centroids[j][k]/counts[j];
                }
            }
        }

        for (int i = 0; i < rows; i++) {
            min_dist = INFINITY;
            for (int j = 0; j < m; j++) {
                dist=0;
                for(int k=0; k<cols; k++){
                    dist=dist+(data[i][k]-centroids[j][k])*(data[i][k]-centroids[j][k]);
                }
                if (dist < min_dist){
                    min_dist = dist;
                    labels[i] = j;
                }
            }
            d_new+=min_dist;
        }

        double temp = (d_old - d_new)/d_new;
        d_old=d_new;
        d_new=0;
        if(temp < a){
            printf("Converging after %d iterations ", iter+1);
            break;
        }
        if(iter == no_iter-1){
            printf("All k-means iterations have been completed ");
        }
    }
    return d_old;
}

void split(double** centroids, double e, double cols, int m){
    for(int i=m-1; i>-1; i--){
        double* p1 = (double*)malloc(cols*sizeof(double));
        for(int j=0; j<cols; j++){
            p1[j] = centroids[i][j];
            centroids[2*i][j] = p1[j]*(1+e);
            centroids[2*i+1][j] = p1[j]*(1-e);
        }
    }
}

int main(){
    double min_dist, dist;
    FILE* fp = fopen("universe.txt", "r");
    char buf[1024];
    int cols=0,rows=0;
    char* tmp;

    fgets(buf,1024,fp);
    tmp = strtok(buf, "  ");
    while(tmp!=NULL){
        cols++;
        tmp=strtok(NULL,"  ");
    } 
    fseek(fp, 0, SEEK_SET);
    while(fgets(buf,1024,fp)){
        rows++;
    }
    fseek(fp, 0, SEEK_SET);

    cols--;

    double** data = (double**)malloc(rows * sizeof(double*));
    for(int i = 0; i < rows; i++){
        data[i] = (double*)malloc(cols * sizeof(double));
    }
    int i=0;
    int j=0;
    while(fgets(buf, 1024, fp)){
        j=0;
        tmp = strtok(buf, "  ");
        while(tmp!=NULL){
            data[i][j] = atof(tmp);
            j++;
            tmp=strtok(NULL,"  ");
        }
        i++;
    }

    fclose(fp);

    double e,a;
    int no_iter,M,lgb_iter;
    printf("Enter the desired size of codebook(M):\n");
    scanf("%d", &M);
    printf("Enter the splitting factor(epsilon):\n");
    scanf("%lf", &e);
    printf("Enter the convergence factor(alpha):\n");
    scanf("%lf", &a);
    printf("Enter the number of iterations for k-means:\n");
    scanf("%d", &no_iter);
    printf("Enter the number of iterations for LGB:\n");
    scanf("%d", &lgb_iter);    
    printf("\n");

    srand(time(NULL));

    double distortion=INFINITY;
    int index=-1;
    for(int u=0; u<lgb_iter; u++){
        printf("\n");
        int m=1;
        double** centroids = (double**)malloc((2*M-2)*sizeof(double*));
        for(int i=0; i<(2*M-2); i++){
            centroids[i] = (double*)malloc((cols)*sizeof(double));
        }
        srand(rand());
        int t1=rand()%rows;
        printf("STARTING ITERATION %d:\n", u+1);
        printf("Intial Starting Random Centroid is:\n");
        for(int i=0; i<cols; i++){
            centroids[0][i] = data[t1][i];
        }

        for(int i=0; i<cols; i++){
            printf("%lf ", centroids[0][i]);
        }
        printf("\n\n");

        double temp_distortion=INFINITY;
        double t2;
        while(m<M){
            split(centroids,e,cols,m);
            m=m*2;          
            temp_distortion = kmeans(data,centroids,m,a,no_iter,rows,cols);
            printf("with an intermediate distortion of %lf\n", temp_distortion);
        }
        printf("\n");

        if(temp_distortion < distortion){
            index = u+1;
            distortion = temp_distortion;
        }

        printf("The final codebook after ITERATION %d is as follows with the final distortion of %lf:\n", u+1, temp_distortion);
        printf("Index   Codeword\n");
        for(int i=0; i<m; i++){
            printf("%d      ",i+1);
            for(int j=0; j<cols; j++){
                printf("%lf ",centroids[i][j]);
            }
            printf("\n");
        }
        printf("\n");
    }

    printf("The BEST CODEBOOK among all these codebooks based on DISTORTION CRITERIA is the CODEBOOK AFTER ITERATION %d\n\n\n\n", index);
}